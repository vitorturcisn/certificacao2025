with 
    sales_order_header as (
        select *
        from {{ ref('stg_sales_order_header') }}
    ),

    order_details_ as (
        select *
        from {{ ref('int_order_details') }}
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

            -- Metric: Gross total order value (without currency rate)
            order_details_.ORDER_QTY * order_details_.UNIT_PRICE as gross_total,

            -- Metric: Net total order value after discount (without currency rate)
            order_details_.ORDER_QTY * order_details_.UNIT_PRICE * (1 - order_details_.UNIT_PRICE_DISCOUNT) as net_total,
            
            -- Metric: Lead time between order date and ship date
            datediff(day, sales_order_header.ORDER_DATE, sales_order_header.SHIP_DATE) as lead_time_shipping,
            
            -- Metric: Order delayed status
            case 
                when sales_order_header.SHIP_DATE > sales_order_header.DUE_DATE then true 
                else false 
            end as order_delayed,

            -- Metric: Discount applied flag
            case
                when order_details_.UNIT_PRICE_DISCOUNT > 0 then true
                else false
            end as discount_applied
        from sales_order_header
        left join order_details_
            on sales_order_header.PK_SALES_ORDER = order_details_.PK_SALES_ORDER
    )

select *
from joined

