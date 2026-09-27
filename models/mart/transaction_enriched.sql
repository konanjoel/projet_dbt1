
SELECT 
    {{ majuscule('t.hash') }} AS hash,
    t.block_number,
    t.date,
    t.from_address,
    t.to_address,
    t.value,
    t.receipt_contract_address,
    t.input
FROM {{source('donne_brute','TRANSACTIONS')}} t 