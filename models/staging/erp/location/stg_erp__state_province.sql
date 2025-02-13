with
    source_state_province as (
        select *
        from {{ source('erp_ADVENTURE_WORKS', 'STATEPROVINCE') }}
    )

    , renaming as (
        select
            cast(STATEPROVINCEID as int) as pk_state_province,
            cast(TERRITORYID as int) as fk_territory,
            cast(COUNTRYREGIONCODE as varchar) as fk_country_region,
            cast(STATEPROVINCECODE as varchar) as state_province_code,
            cast(ISONLYSTATEPROVINCEFLAG as boolean) as is_only_state_province,
            cast(NAME as varchar) as state_province_name,

        from source_state_province
    )

select *
from renaming
