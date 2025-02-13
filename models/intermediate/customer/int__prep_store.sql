WITH 
    store AS (
        SELECT *
        FROM {{ ref('stg_erp__store') }}
    ),

    business_address AS (
        SELECT *
        FROM {{ ref('stg_erp__business_address') }}
    ),

    enriched_store AS (
        SELECT
            store.BUSINESS_ENTITY_ID,
            store.STORE_NAME,
            business_address.ADDRESS_ID
            
        FROM store
        LEFT JOIN business_address
            ON store.BUSINESS_ENTITY_ID = business_address.BUSINESS_ENTITY_ID
    )

SELECT *
FROM enriched_store
