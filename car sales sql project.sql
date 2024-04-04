create schema cars;
use cars;
-- READING DATA -- 
select * from car_sales;
desc car_sales;
-- Total Cars -- 
select count(*) 
as Total_Cars 
from car_sales;

-- How many Cars  available in year 2023 ? --
select count(*) 
as No_of_cars_in_2023 
from car_sales 
where year = '2023';

-- How many cars availabe in years 2020,2021,2022 ?--
select count(*) 
as No_of_cars_in_20t023,year
from car_sales 
where year IN('2020','2021','2022')
group by year;

-- Total cars by year -- 
select year,
count(*) as No_of_Cars
from car_sales 
group by year  
order by year asc;

-- How many Diesel Cars in the year 2020 ? --
select count(*) as Diesel_cars_in_2020 
from car_sales 
where fuel = 'Diesel' and year = '2020';

-- How many petrol cars in the year 2020 ? --
select count(*) as Diesel_cars_in_2020 
from car_sales 
where fuel = 'Petrol' and year = '2020';

-- How many CNG cars in the year 2023 ? --
select count(*) as Diesel_cars_in_2023 
from car_sales 
where fuel = 'CNG' and year = '2023';

-- To print All the fuel cars (petrol,diesel, and CNG ) come by all year -- 
SELECT y.year, p.petrol_cars, d.diesel_cars, c.cng_cars
FROM
  (SELECT DISTINCT year FROM car_sales) AS y
LEFT JOIN
  (SELECT year, COUNT(*) AS petrol_cars
   FROM car_sales
   WHERE fuel = 'petrol'
   GROUP BY year) AS p ON y.year = p.year
LEFT JOIN
  (SELECT year, COUNT(*) AS diesel_cars
   FROM car_sales
   WHERE fuel = 'diesel'
   GROUP BY year) AS d ON y.year = d.year
LEFT JOIN
  (SELECT year, COUNT(*) AS cng_cars
   FROM car_sales
   WHERE fuel = 'CNG'
   GROUP BY year) AS c ON y.year = c.year;
   
-- Total Number of caes between year 2015 and  2023 -- 
SELECT count(*) as No_of_cars_in_yr_15to23 
FROM car_sales 
where year between 2015 and 2023 ; 

-- Total deatails of all cars between year 2015 to 2023 -- 
SELECT *
FROM car_sales 
where year between 2015 and 2023 ; 

-- Name of the car which have Highest selling_price in its category and its price -- 
select Name,max(selling_price) as Highest_price
 from car_sales 
 group by Name
 order by Highest_price desc;
 
-- Highest priced car and its names -- 
select Name,selling_price 
from car_sales
order by selling_price desc
limit 1 ;

-- What is the average selling price of each car model in the dataset?
select Name,avg(selling_price) as avg_selling_price 
from car_sales 
group by Name 
order by avg_selling_price desc; 

-- What is the average selling price of cars in the dataset?--
select avg(selling_price) as avg_selling_price 
from car_sales;

-- Which car has the highest mileage?--
select Name, mileage as Highest_mileage 
from car_sales 
order by Highest_mileage desc limit 1;

-- How many cars are listed for each fuel type? -- 
select fuel,count(*) 
from car_sales 
group  by fuel ; 

-- What is the distribution of car sellers (individuals vs. dealers) in the dataset--
select seller_type, count(*) 
from car_sales 
where seller_type in('Individual','Dealer')
group by seller_type;

-- Which car has the highest horsepower (max_power)? -- 
select Name, max_power 
from car_sales 
order by max_power desc 
limit 1;

-- How many cars have automatic transmission versus manual transmission? --
select transmission, count(*) 
from car_sales 
where transmission in('automatic','manual') 
group by transmission ;

-- What is the average number of kilometers driven for each fuel type?-- 
select fuel, avg(km_driven)  
as avg_km 
from car_sales 
group by fuel
order by  avg_km desc;

-- How many cars have had multiple owners? -- 
select owner, count(*) as no_of_cars 
from car_sales 
where trim(owner)<>'First Owner' 
group by owner 
order by no_of_cars desc ;

-- Which car has the highest engine displacement? -- 
select Name , engine 
from car_sales 
order by engine desc 
limit 1;

-- What is the average number of seats in the cars listed?-- 
select round(avg(seats),0) as avg_seats
from car_sales ;

-- What is the most common mileage for used cars? -- 
select mileage, count(*) as frequency 
from car_sales 
group by mileage 
order by frequency desc 
limit 1;

-- What is average milage of used cars -- 
select avg(mileage) as avg_mileage_of_used_cars 
from car_sales 
where owner<>'First Owner ';

-- What is the most common engine size for used cars? -- 
select engine , count(*) as frequency
from car_sales
group by engine
order by frequency desc
limit 1 ;

-- What is the average number of seats for used cars by fuel type? -- 
select fuel,avg(seats) as avg_seats
from car_sales
group by fuel
order by avg_seats desc;

-- What is the relationship between the year of a used car and its selling price? -- 
select year , avg(selling_price) as avg_selling_price 
from car_sales
group by year
order by avg_selling_price desc;

-- What is the relationship between the mileage of a used car and its selling price? -- 
select owner, avg(mileage) as avg_mileage,
avg(selling_price) as avg_selling_price 
from car_sales 
where trim(owner)<>'First Owner' 
group by owner 
order by avg_mileage desc ;

-- What is the moving average of selling price for used cars over the past 3 years? 
SELECT year, selling_price, 
AVG(selling_price) OVER (PARTITION BY year ORDER BY year ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_average_selling_price
FROM car_sales;

-- What is the moving average of km_driven for used cars by fuel type over the past 3 years?
select fuel , km_driven,
avg(km_driven) over(partition by fuel order by fuel rows between 2 preceding and current row) as moving_avg_km_driven
from car_sales ;

-- What is the cumulative sum of selling price for used cars by year?
select year , selling_price, sum(selling_price) over (partition by year order by year ) as cumulative_sum 
from car_sales;

-- What is the rank of selling price for used cars? -- 
select selling_price, dense_rank() over(order by selling_price desc) as selling_price_rank 
from car_sales;

--  Find the average selling price of used cars by fuel type, and only include fuel types with an average selling price greater than 20,000.
select fuel,avg(selling_price) as avg_selling_price 
from car_sales 
group by fuel 
having avg_selling_price > 20000 ;

-- Find the number of used cars sold by each seller type, and only include seller types with more than 50 cars sold.
select seller_type,count(*) as number_of_cars_sold 
from car_sales 
group by seller_type 
having number_of_cars_sold  > 50 ; 

--  Find the average km_driven for used cars by transmission type, and only include transmission types with an average km_driven greater than 50,000.
SELECT transmission, AVG(km_driven) AS avg_km_driven
FROM car_sales
GROUP BY transmission
HAVING avg_km_driven > 50000;


-- Find the average mileage for used cars by owner type, and only include owner types with an average mileage less than 25 kmpl.
SELECT owner, AVG(mileage) AS avg_mileage
FROM car_sales
GROUP BY owner
HAVING avg_mileage < 25;

-- What are the most popular car models in each fuel type?
SELECT fuel, Name, COUNT(*) AS popularity
FROM car_sales
GROUP BY fuel, Name
ORDER BY fuel, popularity DESC;


-- What is the relationship between selling price and owner type?
SELECT owner, AVG(selling_price) AS avg_selling_price
FROM car_sales
GROUP BY owner
ORDER BY avg_selling_price DESC;

 -- END --






