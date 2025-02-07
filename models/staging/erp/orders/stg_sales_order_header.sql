with  
    sales_order_header as (
        select *
        from {{ source('erp_ADVENTURE_WORKS', 'SALESORDERHEADER') }}
    )

    , renaming as (
        select
            cast(SALESORDERID as int) as pk_sales_order,
            cast(ORDERDATE as date) as order_date,
            cast(DUEDATE as date) as due_date,
            cast(SHIPDATE as date) as ship_date,

            case
                when cast(STATUS as int) = 1 then 'Pending order'
                when cast(STATUS as int) = 2 then 'Order approved'
                when cast(STATUS as int) = 3 then 'Order in shipping process'
                when cast(STATUS as int) = 4 then 'Order shipped'
                when cast(STATUS as int) = 5 then 'Order completed'
                else 'Unknown status'
            end as status,
            cast(ONLINEORDERFLAG as boolean) as online_order,
            cast(CUSTOMERID as int) as customer_id,
            cast(SALESPERSONID as int) as salesperson_id,
            cast(TERRITORYID as int) as territory_id,
            cast(BILLTOADDRESSID as int) as bill_to_address_id,
            cast(SHIPTOADDRESSID as int) as ship_to_address_id,
            cast(SHIPMETHODID as int) as ship_method_id,
            cast(CREDITCARDID as int) as credit_card_id,
            cast(CURRENCYRATEID as int) as currency_rate_id,
            cast(SUBTOTAL as decimal) as subtotal,

        from sales_order_header
    )

select *
from renaming


