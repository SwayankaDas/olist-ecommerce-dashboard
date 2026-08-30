 with payments as (

    select *
    from {{ ref('stg_order_payments') }}

),

aggregated as (

    select
        order_id,
        sum(payment_value) as total_payment_value,
        count(*) as payment_count,
        max(payment_installments) as max_payment_installments

    from payments

    group by order_id

)

select *
from aggregated