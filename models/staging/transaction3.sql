

{{config(materialized= 'incremental',unique_key ='hash',incremental_strategy ='merge',on_schema_change = 'sync_all_columns')}}

select
t.hash,
t.block_number,
t.date,
t.from_address,
t.to_address,
t.value,
t.receipt_contract_address,
t.input,
tt.token_transfer_count,

case
    when t.receipt_contract_address != '' then 'contract_creation'
    when tt.transaction_hash is not null then 'token_transfer'
    when t.input = '0x' and t.value > 0 then 'plain_eth_transfer'
    else 'other'
end as transaction_category,
10 AS number

from {{ source('donne_brute','TRANSACTIONS')}} t

left join (

	select
	transaction_hash,
	count(*) as token_transfer_count
	from {{ source('donne_brute','TOKEN_TRANSFERS')}}
	group by transaction_hash
	) tt

on t.hash = tt.transaction_hash

{% if is_incremental() %}

    where date >= (select max(date) from {{this}})
{% endif %}


