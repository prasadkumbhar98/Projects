select * from PROJECT.dbo.Sheet1$
select max([Ep# No#])from PROJECT.dbo.Sheet1$
select count(distinct [Ep# No#]) from PROJECT.dbo.Sheet1$
--Pitches

select count(distinct Brand) from PROJECT.dbo.Sheet1$

--pitches converted
select cast(sum(a. converted)as float) / cast(count (*) as float) from(
select [Amount Invested lakhs] , case when [Amount Invested lakhs]> 0 then 1 else 0 end as converted from PROJECT.dbo.Sheet1$)a

---total male

select sum (male) from PROJECT.dbo.Sheet1$

-- total female 

select sum (female) from PROJECT.dbo.Sheet1$


--- Gender ratio

select sum(female)/sum(male)*100 from PROJECT.dbo.Sheet1$


---Total invested amount
select sum([Amount Invested lakhs])from PROJECT.dbo.Sheet1$

---average equity taken
select avg(a.[Equity Taken %])from 
(select * from PROJECT.dbo.Sheet1$ where [Equity Taken %] > 0) a 


--- highest deal taken 

select max([Amount Invested lakhs]) from PROJECT.dbo.Sheet1$

---Highest Equity Taken
select max([Equity Taken %]) from PROJECT.dbo.Sheet1$


---startups having atleast women
select sum (a.Female_count) from (
select Female, case when Female > 0 then 1 else 0 end as Female_count from PROJECT.dbo.Sheet1$) a


---Pitches converted having atleast one women 

select sum(b.female_count) from(
select case when a.female>0 then 1 else 0 end as female_count ,a.*from(
(select * from PROJECT.dbo.Sheet1$ where deal!='no deal'))a)b


-- Avg team members

select avg([Team members])
from PROJECT.dbo.Sheet1$

-- Amount invested per deal 



select avg(a.
[Amount invested lakhs]) amount_invested_per_deal from(
select * from PROJECT.dbo.Sheet1$ where deal!= 'No Deal') a


-- Average age group of member



select [Avg age], count([Avg age]) cnt from  PROJECT.dbo.Sheet1$ group by [Avg age] order by cnt desc



--- Location group of contestants

select [Location] , count([Location]) cnt from PROJECT.dbo.Sheet1$ group by [Location] order by cnt desc


--- Secstor group of contestants

select [Sector] , count([Sector]) cnt from PROJECT.dbo.Sheet1$ group by [Sector] order by cnt desc


--- Partner deals 

select partners,count(partners) cnt from  PROJECT.dbo.Sheet1$ where partners!='-'  group by partners order by cnt desc


-- making the metrix 

select 'Ashneer' as keyy, count([Ashneer Amount invested]) from PROJECT.dbo.Sheet1$ where [Ashneer Amount invested] is not null



select 'Ashneer' as keyy, count([Ashneer Amount invested]) from PROJECT.dbo.Sheet1$ where [Ashneer Amount invested] is not null and [Ashneer Amount invested]!=0


select 'Ashneer' as keyy, sum([Ashneer Amount invested]), avg([Ashneer Amount invested]) from 
(select *  from PROJECT.dbo.Sheet1$ where [Ashneer Amount invested]!=0 and [Ashneer Amount invested] is not null) c 


select m.keyy,m.total_deals_present,m.total_deals,n.total_amount_invested,n.avg_equity_taken from
(select a.keyy,a.total_deals_present,b.total_deals from(



select 'Ashneer' as keyy, count([Ashneer Amount invested]) total_deals_present from PROJECT.dbo.Sheet1$ where [Ashneer Amount invested] is not null) a


inner join(
select 'Ashneer' as keyy, count([Ashneer Amount invested]) total_deals from PROJECT.dbo.Sheet1$ where [Ashneer Amount invested] is not null and [Ashneer Amount invested]!=0) b

on a.keyy=b.keyy) m

inner  join

(select 'Ashneer' as keyy, sum(c.[Ashneer Amount invested])total_amount_invested, avg(c.[Ashneer Amount invested]) avg_equity_taken from 
(select *  from PROJECT.dbo.Sheet1$ where [Ashneer Amount invested]!=0 and [Ashneer Amount invested] is not null) c ) n

on m.keyy=n.keyy

---which is the startups in which the highest amount has been invested in each sector

select c.* from
(select [Brand], Sector, [Amount Invested lakhs], rank () over(partition by Sector order by  [Amount Invested lakhs] desc)rnk from PROJECT.dbo.Sheet1$) c
where c.rnk=1