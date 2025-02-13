WITH 
    person AS (
        SELECT *
        FROM {{ ref('stg_erp__person') }}
    ),

    business_address AS (
        SELECT *
        FROM {{ ref('stg_erp__business_address') }}
    ),

    enriched_person AS (
        SELECT
            person.BUSINESS_ENTITY_ID,
            person.FULL_NAME,
            person.EMAIL_PROMOTION,
            business_address.ADDRESS_ID
            
        FROM person
        LEFT JOIN business_address
            ON person.BUSINESS_ENTITY_ID = business_address.BUSINESS_ENTITY_ID
    )

SELECT *
FROM enriched_person
