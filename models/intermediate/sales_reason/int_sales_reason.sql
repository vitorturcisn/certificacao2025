WITH  
    sales_order_header_sales_reason AS (
        SELECT *
        FROM {{ ref('stg_erp__sales_header_reason') }}
    ),

    sales_reason AS (
        SELECT *
        FROM {{ ref('stg_erp__sales_reason') }}
    ),

    enriched_sales_reason AS (
        SELECT
            sales_order_header_sales_reason.pk_sales_order,
            sales_reason.reason_name,
            sales_reason.reason_type
        FROM sales_order_header_sales_reason
        LEFT JOIN sales_reason 
            ON sales_order_header_sales_reason.pk_sales_reason = sales_reason.pk_sales_reason
    )

SELECT *
FROM enriched_sales_reason
