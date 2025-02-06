with 
    -- Chamada das tabelas necessárias
    address as (
        select *
        from {{ ref('stg_erp__address') }}
    )

    , enriched_state_province as (
        select *
        from {{ ref('int_prep_location') }}
    )

    , enriched_address as (
        select
            enriched_state_province.pk_state_province,
            enriched_state_province.state_province_name,
            enriched_state_province.pk_territory as territory_id,
            enriched_state_province.territory_name,
            enriched_state_province.country_region_name,
            address.PK_ADDRESS,
            address.CITY

        from enriched_state_province
        left join address
            on enriched_state_province.pk_state_province = address.fk_state_province
    )

select *
from enriched_address
