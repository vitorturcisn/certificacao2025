with 
    order_details as (
        select *
        from {{ source('erp_ADVENTURE_WORKS', 'SALESORDERDETAIL') }}
    )

    , renaming as (
        select
            cast(SALESORDERID as int) as pk_sales_order,
            cast(SALESORDERDETAILID as int) as pk_sales_order_detail,
            cast(PRODUCTID as int) as fk_product,
            cast(SPECIALOFFERID as int) as fk_special_offer,
            cast(ORDERQTY as int) as order_qty,
            cast(UNITPRICE as decimal) as unit_price,
            cast(UNITPRICEDISCOUNT as decimal) as unit_price_discount,

        from order_details
    )

select *
from renaming


