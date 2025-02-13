WITH 
    person AS (
        SELECT *
        FROM {{ ref('stg_erp__person') }}
    ),

    sales_person AS (
        SELECT *
        FROM {{ ref('stg_sales_person') }}
    ),

    enriched_sales_person AS (
        SELECT
            sales_person.BUSINESS_ENTITY_ID as sales_person_id,
            person.FULL_NAME,
            sales_person.SALES_QUOTA,
            person.EMAIL_PROMOTION
        FROM sales_person
        LEFT JOIN person
            ON sales_person.BUSINESS_ENTITY_ID = person.BUSINESS_ENTITY_ID
    )

SELECT *
FROM enriched_sales_person
