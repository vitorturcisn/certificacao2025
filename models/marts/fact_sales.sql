with
    int_sales as (
        select *
        from {{ ref('int_sales_metrics') }}
    )

    , dim_sales_reason as (
        select *
        from {{ ref('dim_sales_reason') }}
    )

    , dim_customer as (
        select *
        from {{ ref('dim_customer') }}
    )

    , dim_credit_card as (
        select *
        from {{ ref('dim_credit_card') }}
    )

    , dim_address as (
        select *
        from {{ ref('dim_address') }}
    )

select *
from int_sales