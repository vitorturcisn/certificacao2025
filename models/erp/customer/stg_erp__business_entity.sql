with
    -- Tabela de loja
    business_entity as (
        select *
        from {{ source('erp_ADVENTURE_WORKS', 'BUSINESSENTITY') }}
    ),

    -- Renomeando as colunas
    renaming as (
        select
            cast(BUSINESSENTITYID as int) as business_entity_id,
        from business_entity  
    )

select *
from renaming
