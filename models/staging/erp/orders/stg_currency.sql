with 
    currency as (
        select *
        from {{ source('erp_ADVENTURE_WORKS', 'CURRENCY') }}
    )

    , currency_renaming as (
        select
            cast(CURRENCYCODE as varchar) as currency_code,
            cast(NAME as varchar) as currency_name
        from currency
    )

select *
from currency_renaming

