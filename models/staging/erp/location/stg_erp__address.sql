with
    source_address as (
        select *
        from {{ source('erp_ADVENTURE_WORKS', 'ADDRESS') }}
    )

    , renaming as (
        select
            cast(ADDRESSID as int) as pk_address,
            cast(STATEPROVINCEID as int) as fk_state_province,
            cast(ADDRESSLINE1 as varchar) as address_line1,
            cast(ADDRESSLINE2 as varchar) as address_line2,
            cast(CITY as varchar) as city,
        from source_address
    )

select *
from renaming

