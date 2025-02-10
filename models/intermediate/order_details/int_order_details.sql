WITH 
    product_data AS (
        SELECT *
        FROM {{ ref('int__prep_products') }}
    ),

    order_details_ AS (
        SELECT *
        FROM {{ ref('stg_erp__order_details') }}
    ),

    enriched_order_details_ AS (
        SELECT
            -- Informações do pedido
            order_details_.PK_SALES_ORDER,
            product_data.PRODUCT_NAME,
            product_data.CATEGORY_NAME,
            product_data.SUB_CATEGORY_NAME,
            order_details_.ORDER_QTY,
            order_details_.UNIT_PRICE,
            order_details_.UNIT_PRICE_DISCOUNT
        FROM order_details_
        LEFT JOIN product_data
            ON order_details_.FK_PRODUCT = product_data.PK_PRODUCT
    )

SELECT *
FROM enriched_order_details_
