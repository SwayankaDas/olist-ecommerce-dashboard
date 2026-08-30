 with date_spine as (

    select
        generate_series(
            date '2016-01-01',
            date '2018-12-31',
            interval '1 day'
        )::date as date_day

),

final as (

    select
        date_day,

        extract(year from date_day)::integer as year,

        extract(quarter from date_day)::integer as quarter,

        extract(month from date_day)::integer as month,

        to_char(date_day, 'Month') as month_name,

        extract(day from date_day)::integer as day,

        extract(dow from date_day)::integer as day_of_week,

        to_char(date_day, 'Day') as day_name,

        case
            when extract(isodow from date_day) in (6, 7)
                then true
            else false
        end as is_weekend

    from date_spine

)

select *
from final