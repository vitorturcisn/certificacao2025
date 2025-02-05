with

    customer as (
        select *
        from {{ source('erp_ADVENTURE_WORKS', 'CUSTOMER') }}
    ),

    renaming as (
        select
            cast(CUSTOMERID as int) as customer_id,
            cast(PERSONID as int) as person_id,
            cast(STOREID as int) as store_id,
            cast(TERRITORYID as int) as territory_id,
            cast(ROWGUID as varchar) as row_guid,
            cast(MODIFIEDDATE as date) as modification_date
        from customer
    )

select *
from renaming

