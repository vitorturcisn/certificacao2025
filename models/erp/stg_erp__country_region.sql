with
    source_country_region as (
        select *
        from {{ source('erp_ADVENTURE_WORKS', 'COUNTRYREGION') }}
    )

    , renaming as (
        select
            cast(COUNTRYREGIONCODE as varchar) as pk_country_region,
            cast(NAME as varchar) as country_region_name,
            cast(MODIFIEDDATE as date) as country_region_modified_date
        from source_country_region
    )

select *
from renaming
