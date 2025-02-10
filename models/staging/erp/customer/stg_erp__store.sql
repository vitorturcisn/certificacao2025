WITH
    store AS (
        SELECT *
        FROM {{ source('erp_ADVENTURE_WORKS', 'STORE') }}
    ),

    renaming AS (
        SELECT
            CAST(BUSINESSENTITYID AS INT) AS business_entity_id,
            CAST(NAME AS VARCHAR) AS store_name,
            CAST(SALESPERSONID AS INT) AS salesperson_id,
            ROW_NUMBER() OVER (PARTITION BY NAME ORDER BY BUSINESSENTITYID) AS row_num
        FROM store  
    )

SELECT
    business_entity_id,
    CASE
        WHEN row_num > 1 THEN CONCAT(store_name, ' ', row_num)
        ELSE store_name
    END AS store_name,
    salesperson_id
FROM renaming
