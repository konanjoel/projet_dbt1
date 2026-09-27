
{{config(materialized = 'view')}}

SELECT * FROM {{source('donne_brute','CONTRACTS')}}