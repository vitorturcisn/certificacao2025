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
            sales_reason.reason_name,
            sales_reason.reason_type
            
        from sales_order_header_sales_reason
        left join sales_reason 
            on sales_order_header_sales_reason.pk_sales_reason = sales_reason.pk_sales_reason
    )

select *
from enriched_sales_reason
