{{config(materialized='ephemeral')}}

select
	transaction_hash,
	count(*) as token_transfer_count
	from {{ source('donne_brute','TOKEN_TRANSFERS')}}
	group by transaction_hash
	