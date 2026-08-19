CREATE DATABASE hr_analytics;

USE hr_analytics;

CREATE TABLE hr1 (
    Age INT,
    Attrition VARCHAR(10),
    BusinessTravel VARCHAR(30),
    DailyRate INT,
    Department VARCHAR(50),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(50),
    EducationCount int,
    EmployeeNumber INT PRIMARY KEY,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(10),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(50),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(20)
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\HR\\HR_1.csv'
INTO TABLE hr1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM hr1;


CREATE TABLE hr2 (
    EmployeeID INT PRIMARY KEY,
    MonthlyIncome INT,
    MonthlyRate INT,
    NumCompaniesWorked INT,
    Over18 CHAR(1),
    OverTime VARCHAR(5),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\HR\\HR_2.csv'
INTO TABLE hr2
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from  hr1;
select count(age) from hr1;


SELECT *
FROM hr1 h1
JOIN hr2 h2
ON h1.EmployeeNumber = h2.EmployeeID;

----- ATTRITION RATE KPI 1 ---------
SELECT 
ROUND(
    (SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100,2
) AS Attrition_Rate
FROM hr1;


------- Total Employees --------
SELECT COUNT(*) AS Total_Employees
FROM hr1;

-------- Attrition by Department ------
SELECT 
Department,
COUNT(CASE WHEN Attrition='Yes' THEN 1 END) AS Attrition_Count
FROM hr1
GROUP BY Department;

--------- Attrition by Gender ------
SELECT 
Gender,
COUNT(CASE WHEN Attrition='Yes' THEN 1 END) AS Attrition_Count
FROM hr1
GROUP BY Gender;


------- Attrition vs Years Since Last Promotion --------------
SELECT 
h2.YearsSinceLastPromotion,
COUNT(CASE WHEN h1.Attrition='Yes' THEN 1 END) AS Attrition_Count
FROM hr1 h1
JOIN hr2 h2
ON h1.EmployeeNumber = h2.EmployeeID
GROUP BY h2.YearsSinceLastPromotion
ORDER BY h2.YearsSinceLastPromotion;

------- Average Monthly Income by Job Role -------------------
SELECT 
h1.JobRole,
AVG(h2.MonthlyIncome) AS Avg_Income
FROM hr1 h1
JOIN hr2 h2
ON h1.EmployeeNumber = h2.EmployeeID
GROUP BY h1.JobRole
ORDER BY Avg_Income DESC;

