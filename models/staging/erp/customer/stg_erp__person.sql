WITH store AS (
    SELECT *
    FROM {{ source('erp_ADVENTURE_WORKS', 'PERSON') }}
),

renaming AS (
    SELECT
        CAST(BUSINESSENTITYID AS INT) AS business_entity_id,

        CONCAT(
            COALESCE(TITLE || ' ', ''), 
            COALESCE(FIRSTNAME || ' ', ''), 
            COALESCE(MIDDLENAME || ' ', ''), 
            COALESCE(LASTNAME || ' ', ''), 
            COALESCE(SUFFIX, '')
        ) AS full_name,

        EMAILPROMOTION AS email_promotion
    FROM store  
)

SELECT *
FROM renaming
