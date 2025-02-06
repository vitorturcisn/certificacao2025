with 
    currency_rate as (
        select *
        from {{ source('erp_ADVENTURE_WORKS', 'CURRENCYRATE') }}
    )

    , currency_rate_renaming as (
        select
            cast(CURRENCYRATEID as int) as pk_currency_rate,
            cast(CURRENCYRATEDATE as date) as currency_rate_date,
            cast(FROMCURRENCYCODE as varchar) as from_currency_code,
            cast(TOCURRENCYCODE as varchar) as to_currency_code,
            cast(AVERAGERATE as decimal(18, 4)) as average_rate,
            cast(ENDOFDAYRATE as decimal(18, 4)) as end_of_day_rate,
            cast(MODIFIEDDATE as date) as modified_date
        from currency_rate
    )

select *
from currency_rate_renaming
