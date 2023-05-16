/*accident rate based on the type of intersection*/
select 
type_of_intersection_name,
count (consecutive_number) as number_of_crash
from (select
 		consecutive_number,
 		type_of_intersection_name,
	  	case
			when state_name in('North Carolina','Florida','Vermont','Delaware','Michigan','Minnesota','Washington','Montana',
							   'Arizona','Georgia','Utah','Louisiana','Missouri') then timestamp_of_crash at time zone 'CST'
			when state_name in('New York','South Carolina','Maryland','Pennsylvania','Wyoming','New Hampshire','North Dakota',
							   'Nebraska','Maine','California','Tennessee','Kansas','Oregon','Texas','Idaho','Alaska','Alabama',
							   'West Virginia') then timestamp_of_crash at time zone 'EST'
			when state_name in('Illinois','Virginia') then timestamp_of_crash at time zone 'HST'
			when state_name in('Oklahoma','Colorado','Mississippi','New Jersey','Connecticut','South Dakota','District of Columbia',
							   'Indiana','Iowa','Rhode Island','Kentucky','Wisconsin') then timestamp_of_crash at time zone 'MST'
			when state_name in('Nevada','Hawaii','New Mexico','Arkansas','Massachusetts','Ohio') then timestamp_of_crash at time zone 'PST'
		end time_zone,
		case 
			when type_of_intersection_name = 'Not Reported' then 'missing value'
			when type_of_intersection_name = 'Reported as Unknown' then 'missing value'
			else 'OK'
		end Validasi
 	  from crash) as x
where x.Validasi = 'OK' and x.time_zone >= '2021-01-01' and x.time_zone <='2021-12-31'
group by x.type_of_intersection_name 
order  by number_of_crash desc


/*Accident rate based on lighting conditions*/
select 
light_condition_name,
count (consecutive_number) as number_of_crash
from (select
 		consecutive_number,
 		light_condition_name,
	  	case
			when state_name in('North Carolina','Florida','Vermont','Delaware','Michigan','Minnesota','Washington','Montana',
							   'Arizona','Georgia','Utah','Louisiana','Missouri') then timestamp_of_crash at time zone 'CST'
			when state_name in('New York','South Carolina','Maryland','Pennsylvania','Wyoming','New Hampshire','North Dakota',
							   'Nebraska','Maine','California','Tennessee','Kansas','Oregon','Texas','Idaho','Alaska','Alabama',
							   'West Virginia') then timestamp_of_crash at time zone 'EST'
			when state_name in('Illinois','Virginia') then timestamp_of_crash at time zone 'HST'
			when state_name in('Oklahoma','Colorado','Mississippi','New Jersey','Connecticut','South Dakota','District of Columbia',
							   'Indiana','Iowa','Rhode Island','Kentucky','Wisconsin') then timestamp_of_crash at time zone 'MST'
			when state_name in('Nevada','Hawaii','New Mexico','Arkansas','Massachusetts','Ohio') then timestamp_of_crash at time zone 'PST'
		end time_zone,
		case 
			when light_condition_name = 'Not Reported' then 'missing value'
			when light_condition_name = 'Reported as Unknown' then 'missing value'
			else 'OK'
		end Validasi
 	  from crash) as x
where x.Validasi = 'OK' and x.time_zone >= '2021-01-01' and x.time_zone <='2021-12-31'
group by x.light_condition_name 
order  by number_of_crash desc

/*Accident rates based on weather conditions*/
select 
atmospheric_conditions_1_name,
count (consecutive_number) as number_of_crash
from (select
 		consecutive_number,
 		atmospheric_conditions_1_name,
	  	case
			when state_name in('North Carolina','Florida','Vermont','Delaware','Michigan','Minnesota','Washington','Montana',
							   'Arizona','Georgia','Utah','Louisiana','Missouri') then timestamp_of_crash at time zone 'CST'
			when state_name in('New York','South Carolina','Maryland','Pennsylvania','Wyoming','New Hampshire','North Dakota',
							   'Nebraska','Maine','California','Tennessee','Kansas','Oregon','Texas','Idaho','Alaska','Alabama',
							   'West Virginia') then timestamp_of_crash at time zone 'EST'
			when state_name in('Illinois','Virginia') then timestamp_of_crash at time zone 'HST'
			when state_name in('Oklahoma','Colorado','Mississippi','New Jersey','Connecticut','South Dakota','District of Columbia',
							   'Indiana','Iowa','Rhode Island','Kentucky','Wisconsin') then timestamp_of_crash at time zone 'MST'
			when state_name in('Nevada','Hawaii','New Mexico','Arkansas','Massachusetts','Ohio') then timestamp_of_crash at time zone 'PST'
		end time_zone,
		case 
			when atmospheric_conditions_1_name = 'Not Reported' then 'missing value'
			when atmospheric_conditions_1_name = 'Reported as Unknown' then 'missing value'
			else 'OK'
		end Validasi
 	  from crash) as x
where x.Validasi = 'OK' and x.time_zone >= '2021-01-01' and x.time_zone <='2021-12-31'
group by x.atmospheric_conditions_1_name 
order  by number_of_crash desc



/*with percentage of driver conditions*/
select 
x.driver_condition,
count (consecutive_number) as number_of_crash,
COUNT(*) / SUM(COUNT(*)) OVER () persentase_pengemudi_mabuk
from (select
 		consecutive_number,
	  	case
			when state_name in('North Carolina','Florida','Vermont','Delaware','Michigan','Minnesota','Washington','Montana',
							   'Arizona','Georgia','Utah','Louisiana','Missouri') then timestamp_of_crash at time zone 'CST'
			when state_name in('New York','South Carolina','Maryland','Pennsylvania','Wyoming','New Hampshire','North Dakota',
							   'Nebraska','Maine','California','Tennessee','Kansas','Oregon','Texas','Idaho','Alaska','Alabama',
							   'West Virginia') then timestamp_of_crash at time zone 'EST'
			when state_name in('Illinois','Virginia') then timestamp_of_crash at time zone 'HST'
			when state_name in('Oklahoma','Colorado','Mississippi','New Jersey','Connecticut','South Dakota','District of Columbia',
							   'Indiana','Iowa','Rhode Island','Kentucky','Wisconsin') then timestamp_of_crash at time zone 'MST'
			when state_name in('Nevada','Hawaii','New Mexico','Arkansas','Massachusetts','Ohio') then timestamp_of_crash at time zone 'PST'
		end time_zone,
 		case
			 when number_of_drunk_drivers > 0
			 then 'with drunk drivers'
			 else 'without drunk driver'
 		end driver_condition
 	  from crash) as x
where x.time_zone >= '2021-01-01' and x.time_zone <='2021-12-31'
group by x.driver_condition
order  by number_of_crash desc

/*10 BIGGEST TOTAL ACCIDENT COUNTRIES*/
select state_name states, count (consecutive_number) number_of_accident
from crash
where timestamp_of_crash >='2021-01-01' and timestamp_of_crash <='2021-12-31'
group by 1
order by number_of_accident desc
limit 10

/*AVERAGE ACCIDENT PER DAY BY HOURS*/
SELECT
extract(hour from time_zone ) as hour,
sum (number_of_accident) /365 avg_of_accident
from
(select count(consecutive_number) number_of_accident,
 CASE
when state_name in('North Carolina','Florida','Vermont','Delaware','Michigan','Minnesota','Washington','Montana',
					   'Arizona','Georgia','Utah','Louisiana','Missouri') then timestamp_of_crash at time zone 'CST'
	when state_name in('New York','South Carolina','Maryland','Pennsylvania','Wyoming','New Hampshire','North Dakota',
					   'Nebraska','Maine','California','Tennessee','Kansas','Oregon','Texas','Idaho','Alaska','Alabama',
					   'West Virginia') then timestamp_of_crash at time zone 'EST'
	when state_name in('Illinois','Virginia') then timestamp_of_crash at time zone 'HST'
	when state_name in('Oklahoma','Colorado','Mississippi','New Jersey','Connecticut','South Dakota','District of Columbia',
					   'Indiana','Iowa','Rhode Island','Kentucky','Wisconsin') then timestamp_of_crash at time zone 'MST'
	when state_name in('Nevada','Hawaii','New Mexico','Arkansas','Massachusetts','Ohio') then timestamp_of_crash at time zone 'PST'
end time_zone
  from crash
 group by 2
)x
where time_zone >='2021-01-01' and time_zone <='2021-12-31'
group by 1
order by hour

/*percentage of drunk drivers*/
select x.driver_condition,
count (consecutive_number),
COUNT(*) / SUM(COUNT(*)) OVER () percentage_of_drunk_driver
from 
(select consecutive_number,
case
when number_of_drunk_drivers>0
then 'with drunk driver'
else 'without drunk driver'
 end driver_condition
from crash
where timestamp_of_crash >='2021-01-01' and timestamp_of_crash <='2021-12-31')as x
group by 1

/*the percentage of accidents in rural and urban areas*/
select x.*
from
(select land_use_name,
count (consecutive_number) number_of_crash,
COUNT(*) / SUM(COUNT(*)) OVER () percentage_of_accident_area
from crash
  where timestamp_of_crash >='2021-01-01' and timestamp_of_crash <='2021-12-31'
group by 1)x
where land_use_name in ('Rural', 'Urban')

/*number of accidents by day*/
select to_char(x.time_zone,'day') as day,
count (x.consecutive_number) as number_of_accident
from 
(select consecutive_number,
 CASE
when state_name in('North Carolina','Florida','Vermont','Delaware','Michigan','Minnesota','Washington','Montana',
					   'Arizona','Georgia','Utah','Louisiana','Missouri') then timestamp_of_crash at time zone 'CST'
	when state_name in('New York','South Carolina','Maryland','Pennsylvania','Wyoming','New Hampshire','North Dakota',
					   'Nebraska','Maine','California','Tennessee','Kansas','Oregon','Texas','Idaho','Alaska','Alabama',
					   'West Virginia') then timestamp_of_crash at time zone 'EST'
	when state_name in('Illinois','Virginia') then timestamp_of_crash at time zone 'HST'
	when state_name in('Oklahoma','Colorado','Mississippi','New Jersey','Connecticut','South Dakota','District of Columbia',
					   'Indiana','Iowa','Rhode Island','Kentucky','Wisconsin') then timestamp_of_crash at time zone 'MST'
	when state_name in('Nevada','Hawaii','New Mexico','Arkansas','Massachusetts','Ohio') then timestamp_of_crash at time zone 'PST'
end time_zone
  from crash
)x
where time_zone >='2021-01-01' and time_zone <='2021-12-31'
group by 1
order by day


select to_char(x.time_zone,'month') as month,
count (x.consecutive_number) as number_of_accident
from 
(select consecutive_number,
 CASE
when state_name in('North Carolina','Florida','Vermont','Delaware','Michigan','Minnesota','Washington','Montana',
					   'Arizona','Georgia','Utah','Louisiana','Missouri') then timestamp_of_crash at time zone 'CST'
	when state_name in('New York','South Carolina','Maryland','Pennsylvania','Wyoming','New Hampshire','North Dakota',
					   'Nebraska','Maine','California','Tennessee','Kansas','Oregon','Texas','Idaho','Alaska','Alabama',
					   'West Virginia') then timestamp_of_crash at time zone 'EST'
	when state_name in('Illinois','Virginia') then timestamp_of_crash at time zone 'HST'
	when state_name in('Oklahoma','Colorado','Mississippi','New Jersey','Connecticut','South Dakota','District of Columbia',
					   'Indiana','Iowa','Rhode Island','Kentucky','Wisconsin') then timestamp_of_crash at time zone 'MST'
	when state_name in('Nevada','Hawaii','New Mexico','Arkansas','Massachusetts','Ohio') then timestamp_of_crash at time zone 'PST'
end time_zone
  from crash
)x
where time_zone >='2021-01-01' and time_zone <='2021-12-31'
group by 1
order by month desc



