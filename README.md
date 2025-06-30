The analysis of the "Extended Employee Performance and Productivity  dataset examines employee performance, compensation, and workforce dynamics.

## Data Overview
The dataset, with no missing values, includes attributes like Monthly_Salary ($3,850–$9,000), Hire_Date, Work_Hours_Per_Week, Years_At_Company (0–10 years), Employee_Satisfaction_Score (1–5), Projects_Handled (0–50), Department, Job_Title, Gender, Age, Education_Level, and Performance_Score.

## Data Overview and Cleaning
The dataset was loaded and inspected for structure and completeness. The Hire_Date column was converted to a proper date format (yyyy-mm-dd hh:mm:ss) for analysis. No missing values were found in the dataset, ensuring data integrity for subsequent analysis. The dataset includes employees across multiple departments (Legal, Sales, Operations, Marketing, HR, IT, Customer Support, Finance, Engineering) and job titles (Specialist, Developer, Analyst, Manager, Technician, Engineer, Consultant).

## Salary Analysis
No strong correlation exists between Years_At_Company and Monthly_Salary (scatter plot). Salary increases were applied to non-resigned employees:
$6,000 for those earning $3,850 with >4 years tenure and >40 projects.
$801 for those earning $4,400 with >55 weekly hours. 
$1,201 for those earning $4,200 with >3 satisfaction score and >25 overtime hours.
Updated salaries were stored in a new column and visualized.

## Department and Job Title
Salary distribution by department (pie chart) and job title (bar plot) shows higher expenditures in departments like Engineering/IT and roles like Manager/Engineer. Employee counts by department and gender distribution by job title highlight potential imbalances.

## Performance and Demographics
Performance scores vary by job title (box plot), with leadership roles showing higher consistency. Average performance by age bracket (21–30, 31–40, 41–50, 51–60) and education level distribution across age groups were visualized.

## Hiring Trends
A line plot of hires over time shows recruitment patterns, indicating seasonal or yearly fluctuations.

## Conclusion
The analysis reveals a diverse workforce with varied compensation and performance profiles. Tenure weakly correlates with salary, suggesting other factors (e.g., role, performance) drive pay. Targeted salary increases reward high performers, while department and job title analyses highlight resource allocation and diversity gaps. Performance varies by role and age, and hiring trends suggest strategic recruitment cycles.

## Recommendations
Adopt performance-based pay to align compensation with contributions.
Address gender imbalances in roles through diversity initiatives.
Use satisfaction and performance data for retention strategies.
Plan recruitment based on hiring trends to meet business needs.
