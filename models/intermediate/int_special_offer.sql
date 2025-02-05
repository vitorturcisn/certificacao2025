with 
    -- Chamada das tabelas necessárias
    special_offer_product as (
        select *
        from {{ ref('stg_erp__special_offer_product') }}
    ),

    special_offer as (
        select *
        from {{ ref('stg_erp__specialoffer') }}
    ),

    enriched_special_offer_product as (
        select
            special_offer.PK_SPECIAL_OFFER,
            special_offer.DESCRIPTION,
            special_offer.DISCOUNT_PCT,
            special_offer.TYPE,
            special_offer.CATEGORY,
            special_offer.START_DATE,
            special_offer.END_DATE,
            special_offer.MIN_QTY,
            special_offer.MAX_QTY,
            special_offer_product.PK_PRODUCT
        from special_offer_product
        left join special_offer
            on special_offer_product.PK_SPECIAL_OFFER = special_offer.PK_SPECIAL_OFFER
    )

select *
from enriched_special_offer_product
