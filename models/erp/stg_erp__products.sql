with 
    product as (
        select *
        from {{ source('erp_ADVENTURE_WORKS', 'PRODUCT') }}
    )

    , renaming as (
        select
            cast(PRODUCTID as int) as pk_product,
            cast(NAME as varchar) as product_name,
            cast(PRODUCTNUMBER as varchar) as product_number,
            cast(MAKEFLAG as boolean) as make_flag,
            cast(FINISHEDGOODSFLAG as boolean) as finished_goods_flag,
            cast(COLOR as varchar) as color,
            cast(SAFETYSTOCKLEVEL as int) as safety_stock_level,
            cast(REORDERPOINT as int) as reorder_point,
            cast(STANDARDCOST as decimal) as standard_cost,
            cast(LISTPRICE as decimal) as list_price,
            cast(SIZEUNITMEASURECODE as varchar) as size_unit_measure_code,
            cast(WEIGHTUNITMEASURECODE as varchar) as weight_unit_measure_code,
            cast(WEIGHT as decimal) as weight,
            cast(DAYSTOMANUFACTURE as int) as days_to_manufacture,
            cast(PRODUCTLINE as varchar) as product_line,
            cast(CLASS as varchar) as product_class,
            cast(STYLE as varchar) as product_style,
            cast(PRODUCTSUBCATEGORYID as int) as fk_product_subcategory,
            cast(PRODUCTMODELID as int) as fk_product_model,
            cast(SELLSTARTDATE as date) as sell_start_date,
            cast(SELLENDDATE as date) as sell_end_date,
            cast(ROWGUID as varchar) as row_guid,
            cast(MODIFIEDDATE as date) as modification_date
        from product
    )

select *
from renaming
