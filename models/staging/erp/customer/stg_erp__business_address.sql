WITH
    customer AS (
        SELECT *
        FROM {{ source('erp_ADVENTURE_WORKS', 'BUSINESSENTITYADDRESS') }}
    ),

    renaming AS (
        SELECT
            CAST(BUSINESSENTITYID AS INT) AS business_entity_id,
            CAST(ADDRESSID AS INT) AS address_id
        FROM customer
    )

SELECT *
FROM renaming
