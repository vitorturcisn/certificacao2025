with
    source_country_region as (
        select *
        from {{ source('erp_ADVENTURE_WORKS', 'COUNTRYREGION') }}
    )

    , renaming as (
        select
            cast(COUNTRYREGIONCODE as varchar) as pk_country_region,
            cast(NAME as varchar) as country_region_name,
        from source_country_region
    )

select *
from renaming
