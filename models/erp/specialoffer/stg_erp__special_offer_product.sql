with 
    product as (
        select *
        from {{ source('erp_ADVENTURE_WORKS', 'SPECIALOFFERPRODUCT') }}
    )

    , renaming as (
        select
            cast(SPECIALOFFERID as int) as pk_special_offer,
            cast(PRODUCTID as int) as pk_product
        from product
    )

select *
from renaming
