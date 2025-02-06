with 
    credit_card as (
        select *
        from {{ source('erp_ADVENTURE_WORKS', 'CREDITCARD') }}
    )

    , renaming as (
        select
            cast(CREDITCARDID as int) as pk_credit_card,
            cast(CARDTYPE as varchar) as card_type,
            cast(CARDNUMBER as varchar) as card_number,

        from credit_card
    )

select *
from renaming
