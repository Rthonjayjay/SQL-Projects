#DATA EXPLORATION OF SALES COMPANY
# How many staff do we have in the company?
SELECT COUNT(*) AS Number_of_Staff
FROM stafftable;

# How many staff are younger than 30 years?
SELECT COUNT(*) AS Staff_below_30
FROM stafftable
WHERE Age < 30;

 #3 How many staff are between 30 and 25 years?
 SELECT COUNT(*) AS Staff_between_30_AND_25
 FROM stafftable
 WHERE Age BETWEEN 25 AND 30;
 
# Select all the female staff and sort their age in descending order (from the oldest to the youngest)
SELECT *
FROM stafftable
WHERE StaffSex = 'FEMALE'
ORDER BY Age DESC;

# What is the Average age of Peter and Nina?
SELECT StaffName, AVG(Age) AS Average_Age
FROM stafftable
GROUP BY StaffName;

#CUSTOMER TABLE QUESTIONS
# How many customers do we have?
SELECT COUNT(DISTINCT CustomerCode) AS Number_of_Customers
FROM customertable;

# How many customers are from Cameroon?
SELECT COUNT(DISTINCT CustomerCode) AS Cameroon_Customers
FROM customertable
WHERE CustomerCountry = 'Cameroon';

# How many customers are from Cameroon and are Males?
SELECT COUNT(DISTINCT CustomerCode) AS Male_Cameroon_Customers
FROM customertable
WHERE CustomerCountry = 'Cameroon' AND CustomerSex = 'Male';

# What are the First names and Last names of customers who come from Togo and USA?
SELECT CustomerFirstName, CustomerLastName
FROM customertable
WHERE CustomerCountry IN ('Togo','USA');

# Show the first 5 oldest customers and arrange the list in decreasing order of Age (Oldest to youngest)
SELECT *
FROM customertable
ORDER BY Age Desc
LIMIT 5;

# What is the average age of customers per country?
SELECT CustomerCountry, AVG(Age) AS Avg_Age
FROM customertable
GROUP BY CustomerCountry
ORDER BY Avg_Age DESC;

#JOINING TABLE QUESTIONS
# What is the total profit we made?salestable
SELECT SUM(Profit) AS Total_Profit
FROM salestable;

# What is the total cost we incurred for these 03 countries "Cameroon","USA","Togo"?
SELECT CustomerCountry, SUM(Cost) AS Total_cost
FROM customertable
RIGHT JOIN salestable ON customertable.CustomerCode = salestable.CustomerCode
GROUP BY CustomerCountry
ORDER BY Total_cost DESC;

# What is the total profit we made per country?
SELECT CustomerCountry, SUM(Profit) AS Total_profit
FROM Customertable
RIGHT JOIN salestable ON customertable.CustomerCode = salestable.CustomerCode
GROUP BY CustomerCountry
ORDER BY Total_profit DESC;

# What is the average profit we made per country?
SELECT CustomerCountry, AVG(Profit) AS AVG_profit
FROM customertable
RIGHT JOIN salestable ON customertable.CustomerCode = salestable.CustomerCode
GROUP BY CustomerCountry
ORDER BY AVG_profit DESC;

# What is the total revenue per Staff?
SELECT StaffName, SUM(Revenue) AS Total_Revenue
FROM stafftable
RIGHT JOIN salestable ON stafftable.MatriculeNo = salestable.StaffCode
GROUP BY  StaffName
ORDER BY Total_Revenue DESC; 

# Which countries made more than 100 sales transactions? Sort them in decreasing order (from biggest to smallest)
SELECT CustomerCountry, COUNT(Staffcode) AS Sales
FROM salestable
RIGHT JOIN customertable ON salestable.CustomerCode = customertable.CustomerCode
GROUP BY CustomerCountry
HAVING Sales > 100
ORDER BY Sales DESC;

# What is the total profit made per country by the following staff "Emelda","Anita","Cynthia"?
SELECT StaffName, CustomerCountry, SUM(Profit) AS Profit_per_Staff
FROM salestable
LEFT JOIN customertable ON salestable.CustomerCode = customertable.CustomerCode
LEFT JOIN stafftable ON salestable.StaffCode = stafftable.MatriculeNo
WHERE StaffName IN ("Emelda","Anita","Cynthia")
GROUP BY StaffName, CustomerCountry
ORDER BY CustomerCountry