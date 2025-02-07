with 
    sales_order_header_sales_reason as (
        select *
        from {{ source('erp_ADVENTURE_WORKS', 'SALESORDERHEADERSALESREASON') }}
    )

    , renaming as (
        select
            cast(SALESORDERID as int) as pk_sales_order,
            cast(SALESREASONID as int) as pk_sales_reason,

        from sales_order_header_sales_reason
    )

select *
from renaming



