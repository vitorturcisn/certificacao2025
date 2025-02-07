with  
    sales_order_header_sales_reason as (
        select *
        from {{ ref('stg_erp__sales_header_reason') }}
    )

    , sales_reason as (
        select *
        from {{ ref('stg_erp__sales_reason') }}
    )

    , enriched_sales_reason as (
        select
            sales_order_header_sales_reason.pk_sales_order,
            LISTAGG(sales_reason.reason_name, ', ') 
                WITHIN GROUP (ORDER BY sales_reason.reason_name) AS reason_names,
            LISTAGG(sales_reason.reason_type, ', ') 
                WITHIN GROUP (ORDER BY sales_reason.reason_type) AS reason_types
        from sales_order_header_sales_reason
        left join sales_reason 
            on sales_order_header_sales_reason.pk_sales_reason = sales_reason.pk_sales_reason
        group by sales_order_header_sales_reason.pk_sales_order
    )

select *
from enriched_sales_reason

