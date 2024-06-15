select * from swiggy

-- How Many Resturants have a Rating Greater than 4.5 !


select count (distinct[restaurant_no])as  High_Rated_Resturants 
from swiggy 
where [rating] > 4.5


-- Which is the top 1 city with highest number of resturants !

select top 1 city, count(distinct [restaurant_name])  as highest_number
from swiggy 
group by city
order by highest_number desc

-- how many Resturants  have the word "pizza" in thier name !

select count(distinct restaurant_name) as words_pizza
from swiggy
where restaurant_name like '%pizza%'

-- what is the most common cuisine among the resturants in the dataset !

select top 1[cuisine] ,count(*) as cuisin_count
from swiggy
group by [cuisine]
order by cuisin_count desc

-- what is the average rating of resturants in each city !  

select [city] ,round(avg([rating]),3) as average_rating
from swiggy
group by city 
order by average_rating desc

-- what is the highest price of item under the 'recommended' menu category for each resturants !

select distinct [restaurant_name] ,[menu_category],max([price])as highest_price
from swiggy
where menu_category = 'recommended'
group by [restaurant_name],menu_category
order by highest_price desc

--find the top 5 most expensive resturants that offer cuisine other than indian cuisine !

select distinct top 5 restaurant_name,cost_per_person
from swiggy
where cuisine != 'indian'
order by cost_per_person desc

-- find the resturants that have an average cost which is higher  than the total average  
-- cost of all resturants together!

select distinct [restaurant_name],[cost_per_person]
from swiggy 
where cost_per_person >(select avg(cost_per_person) from swiggy)


--retrive the deatails of resturants that have the same name but are located in differents cities!

select distinct a1.[restaurant_name],a1.city , a2.city
from swiggy a1 join swiggy a2
on  a1.[restaurant_name] = a2.[restaurant_name]
and a1.city!= a2.city


-- which resturants offers the most number of iteams in the 'main course' category !

select distinct restaurant_name ,[menu_category],count([item]) as the_most_items
from swiggy
where menu_category = 'main course'
group by  restaurant_name, menu_category
order by the_most_items desc

-- list the names of the resturants that are 100% vegetarian 
-- in alphabetical order of resturants name!


select distinct [restaurant_name] ,
(count (case 
		when [veg_or_non-veg]= 'veg' then 1 end)*100/count(*)) as veg_percentage
from  swiggy 
group by  [restaurant_name]
order by restaurant_name


-- which is the resturants providing the lowest average price for all times !

select distinct top 1 restaurant_name , round(avg([price]),2) as avg_price
from swiggy 
group by restaurant_name
order by avg_price

		

-- which top 5 resturants offers highest number of catagories !

select distinct top 5 restaurant_name , count(distinct[menu_category] ) as no_of_categories
from swiggy 
group by restaurant_name
order by no_of_categories desc


-- which resturants provides the highest percentage of non vegetarian food !

select distinct top 1 [restaurant_name] ,
(count (case 
		when [veg_or_non-veg]= 'non-veg' then 1 end)*100/count(*)) as non_veg_percentage
from  swiggy 
group by  [restaurant_name]
order by non_veg_percentage desc
