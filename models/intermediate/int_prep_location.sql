with 
    -- Chamada das tabelas necessárias
    state_province as (
        select*
        from {{ ref('stg_erp__state_province') }}
    )

    , sales_territory as (
        select*
        from {{ ref('stg_erp__sales_territory') }}
    )

    , country_region as (
        select*
        from {{ ref('stg_erp__country_region') }}
    )

    , enriched_state_province as (
        select
            state_province.pk_state_province,
            state_province.state_province_code,
            state_province.state_province_name,
            sales_territory.pk_territory,
            sales_territory.territory_name,
            sales_territory.sales_year_to_date,
            sales_territory.sales_last_year,
            sales_territory.cost_year_to_date,
            sales_territory.cost_last_year,
            country_region.pk_country_region,
            country_region.country_region_name,

        from state_province
        left join sales_territory
            on state_province.fk_territory = sales_territory.pk_territory
        left join country_region
            on state_province.fk_country_region = country_region.pk_country_region
    )

select *
from enriched_state_province
