with 
    product as (
        select *
        from {{ source('erp_ADVENTURE_WORKS', 'SPECIALOFFER') }}
    )

    , renaming as (
        select
            cast(SPECIALOFFERID as int) as pk_special_offer,
            cast(DESCRIPTION as varchar) as description,
            cast(DISCOUNTPCT as decimal) as discount_pct,
            cast(TYPE as varchar) as type,
            cast(CATEGORY as varchar) as category,
            cast(STARTDATE as date) as start_date,
            cast(ENDDATE as date) as end_date,
            cast(MINQTY as int) as min_qty,
            cast(MAXQTY as int) as max_qty,
            
        from product
    )

select *
from renaming

