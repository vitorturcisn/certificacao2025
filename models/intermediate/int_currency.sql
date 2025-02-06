with  
    currency_rate as (
        select *
        from {{ ref('stg_currency_rate') }}
    )

    , currency as (
        select *
        from {{ ref('stg_currency') }}
    )

    , enriched_currency as (
        select
            currency_rate.pk_currency_rate,
            currency_rate.currency_rate_date,
            currency_rate.from_currency_code,
            currency_rate.to_currency_code,
            currency_rate.average_rate,
            currency_rate.end_of_day_rate,
            currency_rate.modified_date,
            currency.currency_code,
            currency.currency_name
        from currency_rate
        left join currency
            on currency_rate.to_currency_code = currency.currency_code
    )

select *
from enriched_currency
