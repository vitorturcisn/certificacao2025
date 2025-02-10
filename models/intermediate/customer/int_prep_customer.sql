WITH 
    customer AS (
        SELECT *
        FROM {{ ref('stg_erp__customer') }}
    ),

    store AS (
        SELECT *
        FROM {{ ref('int__prep_store') }}
    ),

    person AS (
        SELECT *
        FROM {{ ref('int__prep_person') }}
    ),

    enriched_customer AS (
        SELECT
            customer.CUSTOMER_ID,
            store.STORE_NAME,
            person.FULL_NAME,
            person.EMAIL_PROMOTION,
            store.ADDRESS_ID AS store_address_id,
            person.ADDRESS_ID AS person_address_id,
            ROW_NUMBER() OVER (
                PARTITION BY customer.CUSTOMER_ID
                ORDER BY GREATEST(store.ADDRESS_ID, person.ADDRESS_ID) DESC
            ) AS rn
        FROM customer
        LEFT JOIN store
            ON customer.STORE_ID = store.BUSINESS_ENTITY_ID
        LEFT JOIN person
            ON customer.PERSON_ID = person.BUSINESS_ENTITY_ID
    )

SELECT
    CUSTOMER_ID,
    STORE_NAME,
    FULL_NAME,
    COALESCE(store_address_id, person_address_id) AS ADDRESS_ID,
    EMAIL_PROMOTION
FROM enriched_customer
WHERE rn = 1
