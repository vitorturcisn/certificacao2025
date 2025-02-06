with 
    dim_address as (
        select*
        from {{ ref('int_prep_address') }}
    )
    
select*
from dim_address