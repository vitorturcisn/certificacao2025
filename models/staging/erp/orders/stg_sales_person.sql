WITH 
    sales_person AS (
        SELECT *
        FROM {{ source('erp_ADVENTURE_WORKS', 'SALESPERSON') }}
    ),

    renaming AS (
        SELECT
            CAST(BUSINESSENTITYID AS INT) AS business_entity_id,
            CAST(SALESQUOTA AS DECIMAL) AS sales_quota,
            CAST(BONUS AS DECIMAL) AS bonus,
            CAST(COMMISSIONPCT AS DECIMAL) AS commission_pct,
        FROM sales_person
    )

SELECT *
FROM renaming
