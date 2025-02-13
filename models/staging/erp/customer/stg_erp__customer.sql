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
        from customer
    )

select *
from renaming

