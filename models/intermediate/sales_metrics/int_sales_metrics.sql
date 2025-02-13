WITH 
    sales_order_header AS (
        SELECT *
        FROM {{ ref('stg_sales_order_header') }}
    ),

    order_details_ AS (
        SELECT *
        FROM {{ ref('int_order_details') }}
    ),

    joined AS (
        SELECT
            order_details_.PK_SALES_ORDER AS SALES_ORDER,
            order_details_.PRODUCT_NAME,
            order_details_.CATEGORY_NAME,
            order_details_.SUB_CATEGORY_NAME,
            order_details_.ORDER_QTY,
            order_details_.UNIT_PRICE,
            order_details_.UNIT_PRICE_DISCOUNT,
            sales_order_header.ORDER_DATE,
            sales_order_header.DUE_DATE,
            sales_order_header.SHIP_DATE,
            sales_order_header.STATUS,
            -- Transforming ONLINE_ORDER column to ORDER_TYPE
            CASE 
                WHEN sales_order_header.ONLINE_ORDER = TRUE THEN 'Online'
                ELSE 'Salesperson'
            END AS ORDER_TYPE,
            sales_order_header.CUSTOMER_ID,
            sales_order_header.SALESPERSON_ID,
            sales_order_header.CREDIT_CARD_ID,

            -- Metric: Gross total order value (without currency rate)
            (order_details_.ORDER_QTY * order_details_.UNIT_PRICE) AS gross_total,

            -- Metric: Net total order value after discount (without currency rate)
            (order_details_.ORDER_QTY * order_details_.UNIT_PRICE * (1 - order_details_.UNIT_PRICE_DISCOUNT)) AS net_total,
            
            -- Metric: Lead time between order date and ship date
            DATEDIFF(day, sales_order_header.ORDER_DATE, sales_order_header.SHIP_DATE) AS lead_time_shipping,
            
            -- Metric: Order delayed status
            CASE 
                WHEN sales_order_header.SHIP_DATE > sales_order_header.DUE_DATE THEN TRUE 
                ELSE FALSE 
            END AS order_delayed,

            -- Metric: Discount applied flag
            CASE
                WHEN order_details_.UNIT_PRICE_DISCOUNT > 0 THEN TRUE
                ELSE FALSE
            END AS discount_applied
        FROM sales_order_header
        LEFT JOIN order_details_
            ON sales_order_header.PK_SALES_ORDER = order_details_.PK_SALES_ORDER
    )

SELECT *
FROM joined
