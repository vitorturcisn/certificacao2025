with 
    -- Chamada das tabelas necessárias
    address as (
        select*
        from {{ ref('stg_erp__address') }}
    )

    , enriched_state_province as (
        select*
        from {{ ref('int_prep_location') }}
    )

    , enriched_address as (
        select
            enriched_state_province.pk_state_province,
            enriched_state_province.state_province_code,
            enriched_state_province.state_province_name,
            enriched_state_province.pk_territory,
            enriched_state_province.territory_name,
            enriched_state_province.sales_year_to_date,
            enriched_state_province.sales_last_year,
            enriched_state_province.cost_year_to_date,
            enriched_state_province.cost_last_year,
            enriched_state_province.pk_country_region,
            enriched_state_province.country_region_name,
            address.PK_ADDRESS,
            address.FK_STATE_PROVINCE,
            address.ADDRESS_LINE1,
            address.ADDRESS_LINE2,
            address.CITY,
            address.POSTAL_CODE,
            address.SPATIAL_LOCATION,
            address.ROW_GUID,
            address.MODIFICATION_DATE

        from enriched_state_province
        left join address
            on enriched_state_province.pk_state_province = address.fk_state_province
    )

select *
from enriched_address
