with order_items as (

    select *
    from {{ ref('stg_order_items') }}

),

orders as (

    select *
    from {{ ref('stg_orders') }}

),

products as (

    select *
    from {{ ref('stg_products') }}

),

sellers as (

    select *
    from {{ ref('stg_sellers') }}

),

payments as (

    select *
    from {{ ref('int_order_payments') }}

),

customers as (

    select *
    from {{ ref('stg_customers') }}

),

joined as (

    select
        oi.order_id,
        oi.order_item_id,

        -- Product
        oi.product_id,
        p.product_category_name,
        p.product_name_length,
        p.product_description_length,
        p.product_photos_qty,
        p.product_weight_g,
        p.product_length_cm,
        p.product_height_cm,
        p.product_width_cm,

        -- Seller
        oi.seller_id,
        s.seller_city,
        s.seller_state,

        -- Order
        o.customer_id,
        c.customer_unique_id,
        o.order_status,
        o.order_purchase_timestamp,
        o.order_approved_at,
        o.order_delivered_carrier_date,
        o.order_delivered_customer_date,
        o.order_estimated_delivery_date,

        -- Sales
        oi.shipping_limit_date,
        oi.price,
        oi.freight_value,

        -- Payments
        pay.total_payment_value,
        pay.payment_count,
        pay.max_payment_installments

    from order_items oi

    left join orders o
        on oi.order_id = o.order_id

    left join customers c
        on o.customer_id = c.customer_id

    left join products p
        on oi.product_id = p.product_id

    left join sellers s
        on oi.seller_id = s.seller_id

    left join payments pay
        on oi.order_id = pay.order_id


)

select *
from joined