with 
    order_details as (
        select*
        from {{ ref('int_order_details') }}
    )
    
select*
from order_details