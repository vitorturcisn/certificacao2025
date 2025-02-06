/*
    This test ensures that the 2011 gross sales match
    the audited accounting value of $12,646,112.16
*/

with
    sales_in_2011 as (
        select sum(gross_total) as total_gross_sales
        from {{ ref('int_sales_metrics') }}
        where order_date between '2011-01-01' and '2011-12-31'
    )

select total_gross_sales,
       total_gross_sales - 12646112.00 as difference
from sales_in_2011
where total_gross_sales not between 12646112.00 and 12646112.16
