with 
    -- Chamada das tabelas necessárias
    customer as (
        select *
        from {{ ref('stg_erp__customer') }}
    ),

    store as (
        select *
        from {{ ref('stg_erp__store') }}
    ),

    enriched_customer as (
        select
            customer.CUSTOMER_ID,
            store.STORE_NAME,
            store.SALESPERSON_ID,
            customer.PERSON_ID,
            customer.TERRITORY_ID
        from store
        left join customer
            on store.BUSINESS_ENTITY_ID = customer.STORE_ID
    )

select *
from enriched_customer
