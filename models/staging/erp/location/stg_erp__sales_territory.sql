with
    source_sales_territory as (
        select *
        from {{ source('erp_ADVENTURE_WORKS', 'SALESTERRITORY') }}
    )

    , renaming as (
        select
            cast(TERRITORYID as int) as pk_territory,
            cast(COUNTRYREGIONCODE as varchar) as fk_country_region,
            cast(NAME as varchar) as territory_name,
            cast(SALESYTD as decimal) as sales_year_to_date,
            cast(SALESLASTYEAR as decimal) as sales_last_year,
            cast(COSTYTD as decimal) as cost_year_to_date,
            cast(COSTLASTYEAR as decimal) as cost_last_year,

        from source_sales_territory
    )

select *
from renaming
