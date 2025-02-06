with 
    -- Chamada das tabelas necessárias
    sales_order_header as (
        select *
        from {{ ref('stg_sales_order_header') }}
    ),

    order_details_ as (
        select *
        from {{ ref('int_order_details') }}
    ),

    currency_details as (
        select *
        from {{ ref('int_currency') }}  
    ),

    joined as (
        select
            order_details_.PK_PRODUCT,
            order_details_.PK_SALES_ORDER,
            order_details_.PRODUCT_NAME,
            order_details_.PRODUCT_NUMBER,
            order_details_.ORDER_QTY,
            order_details_.UNIT_PRICE,
            order_details_.UNIT_PRICE_DISCOUNT,
            sales_order_header.ORDER_DATE,
            sales_order_header.DUE_DATE,
            sales_order_header.SHIP_DATE,
            sales_order_header.STATUS,
            sales_order_header.ONLINE_ORDER,
            sales_order_header.CUSTOMER_ID,
            sales_order_header.SALESPERSON_ID,
            sales_order_header.TERRITORY_ID,
            sales_order_header.BILL_TO_ADDRESS_ID,
            sales_order_header.SHIP_TO_ADDRESS_ID,
            sales_order_header.CREDIT_CARD_ID,
            sales_order_header.currency_rate_id,
            currency_details.END_OF_DAY_RATE
        from sales_order_header
        left join order_details_
            on sales_order_header.PK_SALES_ORDER = order_details_.PK_SALES_ORDER
        left join currency_details
            on sales_order_header.currency_rate_id = currency_details.pk_currency_rate
    )

select *
from joined
