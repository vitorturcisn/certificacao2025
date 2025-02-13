WITH 
    product_category AS (
        SELECT *
        FROM {{ source('erp_ADVENTURE_WORKS', 'PRODUCTCATEGORY') }}
    ),

    renaming AS (
        SELECT
            CAST(PRODUCTCATEGORYID AS INT) AS pk_product_category,
            CAST(NAME AS VARCHAR) AS category_name
        FROM product_category
    )

SELECT *
FROM renaming
