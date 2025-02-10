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
            person.FULL_NAME AS customer_name, 
            person.EMAIL_PROMOTION,
            store.ADDRESS_ID AS store_address_id,
            person.ADDRESS_ID AS person_address_id,
            ROW_NUMBER() OVER (
                PARTITION BY person.FULL_NAME
                ORDER BY GREATEST(store.ADDRESS_ID, person.ADDRESS_ID) DESC
            ) AS rn_person,
            ROW_NUMBER() OVER (
                PARTITION BY store.STORE_NAME
                ORDER BY store.ADDRESS_ID DESC
            ) AS rn_store
        FROM customer
        LEFT JOIN store
            ON customer.STORE_ID = store.BUSINESS_ENTITY_ID
        LEFT JOIN person
            ON customer.PERSON_ID = person.BUSINESS_ENTITY_ID
    )

SELECT
    CUSTOMER_ID,
    CASE 
        WHEN rn_store > 1 THEN CONCAT(STORE_NAME, ' 2')
        ELSE STORE_NAME  
    END AS STORE_NAME,

    CASE 
        WHEN rn_person > 1 THEN CONCAT(customer_name, ' 2') 
        ELSE customer_name  
    END AS customer_name,  

    COALESCE(store_address_id, person_address_id) AS ADDRESS_ID,
    EMAIL_PROMOTION
FROM enriched_customer
WHERE rn_person = 1
