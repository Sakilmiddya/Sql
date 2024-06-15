select * from [dbo].[burger name]
select * from [dbo].[burger runner]
select * from [dbo].[burger runner_orders]
select * from [dbo].[customer_orders]

-- how many burgers were ordered ?

select count(*)as total_orders from [dbo].[burger runner_orders]


-- how many unique customer orders were made ?

select count(distinct order_id)as unique_orders from [dbo].[customer_orders]


-- how many successful orders were delivered by each runner ?

select runner_id,count(distinct order_id) as succesful_orders
from [dbo].[burger runner_orders]
--where cancellation is null
group by runner_id
order by succesful_orders desc

-- how many of each type of burger were delivered ?

select p.burger_name , count (c.burger_id) as delivered_burger
from [dbo].[customer_orders] as c
join [dbo].[burger runner_orders] as r
on c.order_id = r.order_id
join [dbo].[burger name] as p
on c.burger_id = p.burger_id
group by p.burger_name


-- how many vegetarian and meatlovers were ordered by each customer ?

select c.customer_id , p.burger_name,count(p.burger_name)as order_count
from [dbo].[customer_orders] as c
join [dbo].[burger name] as  p
on c.burger_id = p.burger_id
group by  c.customer_id ,p.burger_name
order by order_count 


-- what was the maximum number of burgers delivered in a single order ?

with burger_count as (select c.order_id , count(c.burger_id) as burger_per_order
from [dbo].[customer_orders] as c
join [dbo].[burger runner_orders] as r
on c.order_id = r.order_id
group by c.order_id)
select max(burger_per_order) as burger_order
from burger_count


-- for each customer , how many delivered burgers had at least 1 change and 
-- how many had no changes ?

select customer_id, sum (case
when c.exclusions<> ' ' or c.extras<>' '
then 1
else 0
end)as atleast_1_change ,
sum( case 
when c.exclusions = ' ' and c.extras = ' '
then 1
else 0
end)as atleast_0_change
from [dbo].[customer_orders] as c
join [dbo].[burger runner_orders] as r
on c.order_id = r.order_id
group by c.customer_id
order by c.customer_id


-- what was the total volume of burgers ordered for each hour of the day ?

select extract ( hour from order_time) as hour_of_day
count(order_id) as burger_count
from [dbo].[customer_orders]
group by extract(hour from  order_time)

-- how many runners signed up for each 1 week period ?

select extract(week from registration_date) as registration_week ,
count(runner_id) as runner_signup
from [dbo].[burger runner]
group by extract(week from registration_date)




-- what was the average distance travelled for each customer ?

select c.customer_id, avg(r.distance) as avg_distance
from [dbo].[customer_orders] as c
join [dbo].[burger runner_orders] as r
on c.order_id = r.order_id
--where r.duration!=0
group by c.customer_id

alter table [dbo].[burger runner_orders]
alter column distance  int
