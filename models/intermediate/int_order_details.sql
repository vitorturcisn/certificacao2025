with 
    -- Chamada das tabelas necessárias
    product_data as (
        select*
        from {{ ref('stg_erp__products') }}
    )

    , order_details_ as (
        select*
        from {{ ref('stg_erp__order_details') }}
    )

        , enriched_order_details_ as (
        select
            product_data.pk_product,
            order_details_.pk_sales_order,
            order_details_.fk_special_offer,
            product_data.SAFETY_STOCK_LEVEL
            product_data.product_name,
            product_data.product_number,
            order_details_.order_qty,
            order_details_.unit_price,
            order_details_.unit_price_discount
        from order_details_
        left join product_data
            on order_details_.fk_product = product_data.pk_product
    )

select *
from enriched_order_details_