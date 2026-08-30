 with customers as (

    select *
    from {{ ref('int_customers') }}

)

select
    customer_unique_id,
    customer_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state

from customers