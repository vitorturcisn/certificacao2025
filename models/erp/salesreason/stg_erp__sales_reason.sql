with 
    sales_reason as (
        select *
        from {{ source('erp_ADVENTURE_WORKS', 'SALESREASON') }}
    )

    , renaming as (
        select
            cast(SALESREASONID as int) as pk_sales_reason,
            cast(NAME as varchar) as reason_name,
            cast(REASONTYPE as varchar) as reason_type,
        from sales_reason
    )

select *
from renaming



