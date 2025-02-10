WITH 
    product_category AS (
        SELECT *
        FROM {{ ref('stg_erp__product_category') }}
    ),

    product_sub_category AS (
        SELECT *
        FROM {{ ref('stg_erp__product_sub_category') }}
    ),

    products AS (
        SELECT *
        FROM {{ ref('stg_erp__products') }}
    ),

    enriched_products_category AS (
        SELECT
            product_sub_category.PK_PRODUCT_SUBCATEGORY,           
            product_category.CATEGORY_NAME,
            product_sub_category.PRODUCT_NAME AS sub_category_name
        FROM product_sub_category
        LEFT JOIN product_category
            ON product_sub_category.FK_PRODUCT_CATEGORY = product_category.PK_PRODUCT_CATEGORY
    ),

    enriched_products AS (
        SELECT
            products.PK_PRODUCT,
            products.PRODUCT_NAME,
            enriched_products_category.CATEGORY_NAME,
            enriched_products_category.sub_category_name
        FROM products
        LEFT JOIN enriched_products_category
            ON products.FK_PRODUCT_SUBCATEGORY = enriched_products_category.PK_PRODUCT_SUBCATEGORY
    )

SELECT *
FROM enriched_products
