 with order_items as (

    select *
    from {{ ref('int_order_items') }}

),

final as (

    select

        -- Keys
        oi.order_id,
        oi.order_item_id,
        oi.product_id,
        oi.seller_id,
        oi.customer_unique_id,

        -- Date
        oi.order_purchase_timestamp::date as order_date,

        -- Order
        oi.order_status,

        -- Sales measures
        oi.price,
        oi.freight_value,

        -- Payment measures
        oi.total_payment_value,
        oi.payment_count,
        oi.max_payment_installments

    from order_items oi

)

select *
from final