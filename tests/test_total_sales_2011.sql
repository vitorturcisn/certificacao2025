/*  
    This test ensures that the gross sales for 2011 are
    correct according to the audited accounting value:
    $12,646,112.16


with
    sales_in_2011 as (
        select sum(gross_total) as total_gross_sum
        from {{ ref('int_sales__sales_metrics') }}
        where order_date between '2011-01-01' and '2011-12-31'
    )

select total_gross_sum
from sales_in_2011
where total_gross_sum not between 12646112.00 and 12646113.00
