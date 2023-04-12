Answer these questions using the data available using SQL queries. You should query the dbt generated (staging) tables you have just created. For these short answer questions/queries create a separate readme file in your repo with your answers.

How many users do we have?
130

SQL:
select count(distinct USER_ID) 
FROM DEV_DB.DBT_ZACHARYSHAPIRORAPID7COM.STAGING_USERS

On average, how many orders do we receive per hour?
7.52

SQL:
select avg(count_order_id)

FROM
    (select count(order_id) as count_order_id, date_trunc(hour, created_at) as date_part_hour
        
    FROM DEV_DB.DBT_ZACHARYSHAPIRORAPID7COM.STAGING_ORDERS
    
    GROUP BY 2
)

On average, how long does an order take from being placed to being delivered?
3.89 days

SQL:
SELECT avg(days_to_deliver)
FROM (
SELECT order_id, created_at, delivered_at, datediff('days',created_at, delivered_at) as days_to_deliver
FROM DEV_DB.DBT_ZACHARYSHAPIRORAPID7COM.STAGING_ORDERS
WHERE status = 'delivered'
)

How many users have only made one purchase? Two purchases? Three+ purchases?
One purchase: 25
Two purchases: 28
Three purchases: 34

SQL:
SELECT count(distinct user_id), number_of_orders
FROM (

SELECT count(distinct order_id) as number_of_orders, user_id 
FROM DEV_DB.DBT_ZACHARYSHAPIRORAPID7COM.STAGING_ORDERS

GROUP BY 2
)
GROUP BY 2
ORDER BY 2

On average, how many unique sessions do we have per hour?
16.32

SQL:
SELECT avg(num_sessions)

FROM (

SELECT count(distinct session_id) as num_sessions, date_trunc(hour,created_at) as hour_session 
FROM DEV_DB.DBT_ZACHARYSHAPIRORAPID7COM.STAGING_EVENTS
GROUP BY 2
)