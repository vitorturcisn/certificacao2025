    with  
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
            address.PK_ADDRESS,
            address.CITY,         
            enriched_state_province.state_province_name, 
            enriched_state_province.territory_name,      
            enriched_state_province.country_region_name, 
            enriched_state_province.pk_state_province as state_province_id,
            enriched_state_province.pk_territory as territory_id

        from address
        left join enriched_state_province
            on enriched_state_province.pk_state_province = address.fk_state_province
    )

select *
from enriched_address
