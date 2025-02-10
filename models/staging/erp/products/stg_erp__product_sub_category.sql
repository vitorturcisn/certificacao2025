WITH 
    product_subcategory AS (
        SELECT *
        FROM {{ source('erp_ADVENTURE_WORKS', 'PRODUCTSUBCATEGORY') }}
    ),

    renaming AS (
        SELECT
            CAST(PRODUCTSUBCATEGORYID AS INT) AS pk_product_subcategory,
            CAST(PRODUCTCATEGORYID AS INT) AS fk_product_category,
            CAST(NAME AS VARCHAR) AS product_name
        FROM product_subcategory
    )

SELECT *
FROM renaming
