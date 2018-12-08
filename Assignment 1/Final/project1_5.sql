
/*We, Abdul Rehman and Imran Qureshi, declare that the attached assignment is
 our own work in accordance with the Seneca Academic Policy.
 No part of this assignment has been copied manually or electronically from
any other source (including web sites) or distributed to other students.*/
update movie
set movie_year = 2008
where movie_num = 1245;

update movie
set price_code = 3
where movie_genre ='ACTION';

update price
set price_rentfee = price_rentfee + 0.5;


select movie_title,movie_year,movie_genre
from movie;

select movie_year,movie_title,movie_cost
from movie
order by 1 desc;

Select MOVIE_TITLE "Movie Title", MOVIE_YEAR "Movie Year", MOVIE_GENRE "Movie Genre"
From MOVIE 
Order By MOVIE_GENRE, MOVIE_YEAR DESC;


Select MOVIE_NUM "Movie Number", MOVIE_TITLE "Movie Title", PRICE_CODE "Price Code"
From MOVIE
Where MOVIE_TITLE LIKE 'R%';

Select MOVIE_TITLE "Movie Title", MOVIE_YEAR "Movie Year", MOVIE_COST "Movie Cost"
From Movie
Where MOVIE_TITLE LIKE '%hope%'
Order By MOVIE_TITLE;

Select Movie_Title "Movie Title",MOVIE_YEAR "Movie Year",MOVIE_GENRE "Movie Genre"
From Movie
Where MOVIE_GENRE = 'ACTION';

Select Movie_Num "Movie Number", MOVIE_TITLE "Movie Title",MOVIE_COST "Movie Cost"
from movie
where movie_cost > 40;

Select Movie_Num "Movie Number", Movie_Title "Movie Title",MOVIE_Cost "Movie Cost",MOVIE_GENRE "Movie Genre"
From Movie
Where MOVIE_GENRE IN ('ACTION','COMEDY') and movie_cost < 50
order by Movie_Genre;

Select Movie_Num "Movie Number", Movie_Title ||' '||'('||Movie_Year||')'||' '|| Movie_Genre "Movie Description"
From Movie;

Select Movie_Genre "Movie Genre", Count(*) "Number of Movies"
from Movie
Group by Movie_Genre
Order by Movie_Genre;

Select Avg(Movie_Cost) "Average movie cost"
from movie;

select m.movie_title, m.movie_genre, p.price_description, p.price_rentfee
from movie m, price p
where m.price_code = p.price_code;

select movie_genre, avg(price_rentfee) "Average Rental Fee"
from movie m, price p
where m.price_code = p.price_code
group by movie_genre;

select movie_title,movie_year, round(movie_cost/price_rentfee,2) "Breakeven Rentals"
from movie m, price p
where m.price_code = p.price_code;

select movie_title, movie_year
from movie
where price_code is NOT NULL;

select movie_title, movie_year, movie_cost
from movie
where movie_cost BETWEEN 44.99 AND 49.99;

select movie_title, movie_year, price_description, p.price_rentfee, movie_genre
from movie JOIN price p
using(price_code)
where movie_genre IN ('FAMILY','COMEDY','DRAMA');

select movie_num, m.movie_title, m.movie_year
from movie m LEFT JOIN video v
using (movie_num)
where vid_num IS NULL;

select distinct mem_num, m.mem_fname, m.mem_lname, m.mem_balance
from membership m left JOIN rental r
using(mem_num)
where r.rent_num is NOT NULL
order by 1;

select min(mem_balance) "Minimum Balance" , max(mem_balance) "Maximum Balance", round(avg(mem_balance),2) "Average Balance"
from membership m join rental r
using(mem_num)
where rent_num is NOT NULL;

select trim(mem_fname) ||' ' || trim(mem_lname) "Membership Name", trim(mem_street) || ' ' || trim(mem_city) || ' ' || trim(mem_zip) "Membership Address"
from membership;

SELECT R.RENT_NUM, R.RENT_DATE, D.VID_NUM, M.MOVIE_TITLE, D.DETAIL_DUEDATE, D.DETAIL_RETURNDATE
From rental r,detailrental d,video v,movie m
where (r.rent_num = d.rent_num) and (d.vid_num = v.vid_num) and (v.movie_num = m.movie_num)
and D.Detail_ReturnDate > D.DETAIL_DUEDATE
order by r.rent_num,m.movie_title;

SELECT R.RENT_NUM, R.RENT_DATE, D.VID_NUM, M.MOVIE_TITLE, D.DETAIL_DUEDATE, D.DETAIL_RETURNDATE, D.DETAIL_FEE, (D.DETAIL_RETURNDATE-D.DETAIL_DUEDATE)  "Days Past Due"
from rental r,detailrental d,video v, movie m
where (r.rent_num = d.rent_num) and (d.vid_num = v.vid_num) and (v.movie_num = m.movie_num)
and D.Detail_ReturnDate > D.DETAIL_DUEDATE
order by r.rent_num,m.movie_title;

Select r.RENT_NUM,r.RENT_DATE,m.MOVIE_TITLE,d.DETAIL_FEE
FROM RENTAL R JOIN DETAILRENTAL D
ON R.RENT_NUM = D.RENT_NUM
JOIN VIDEO V
ON D.VID_NUM = V.VID_NUM
JOIN MOVIE M
ON V.MOVIE_NUM = M.MOVIE_NUM
WHERE D.Detail_ReturnDate <= D.DETAIL_DUEDATE
order by r.rent_num,m.movie_title;

Select m.mem_num, m.mem_lname,sum(d.detail_fee) "Total Rental Fee"
from membership m, rental r, detailrental d
where (m.mem_num = r.mem_num) and (r.rent_num = d.rent_num)
group by m.mem_num,m.mem_lname
order by m.mem_num;


SELECT m.MOVIE_NUM, m.MOVIE_GENRE, AVG(e.MOVIE_COST) "AVERAGE MOVIE COST",
e.MOVIE_COST, ((m.MOVIE_COST - AVG(m.MOVIE_COST))/AVG(e.MOVIE_COST))*100 "PERECENT DIFFERENCE"
FROM MOVIE m, MOVIE e
where m.movie_num = e.movie_num
GROUP BY m.MOVIE_GENRE,m.MOVIE_NUM, m.MOVIE_COST
order by m.movie_num;
