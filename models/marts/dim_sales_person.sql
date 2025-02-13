with 
    sales_person as (
        select*
        from {{ ref('int__prep_sales_person') }}
    )
    
select*
from sales_person