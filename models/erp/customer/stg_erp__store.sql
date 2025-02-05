with
    -- Tabela de loja
    store as (
        select *
        from {{ source('erp_ADVENTURE_WORKS', 'STORE') }}
    ),

    -- Renomeando as colunas
    renaming as (
        select
            cast(BUSINESSENTITYID as int) as business_entity_id,
            cast(NAME as varchar) as store_name,
            cast(SALESPERSONID as int) as salesperson_id
        from store  
    )

select *
from renaming
