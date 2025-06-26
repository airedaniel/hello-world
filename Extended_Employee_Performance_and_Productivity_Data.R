###Get and Set your working directory
getwd()
setwd("C:\\Users\\HP\\Desktop\\Term 2 Project\\Input Files") 

# Load required libraries
library(scales)
library(lubridate)
library(quantmod)
library(ggplot2)
library(dplyr)
library(magrittr)

####### RUN THESE COLORS WITH THE LEGEND TO CORRESPOND WITH THE PIE CHART
jc <- c("red", "gold", "chartreuse", "green", "lightgreen", "cyan",  "blue", "purple", "magenta")



## Import and Explore Data

### Import data
Employees <- read.csv("Extended_Employee_Performance_and_Productivity_Data.csv")
Employees


## Check for missing values 
sum(is.na(Employees))


ncol(Employees)
nrow(Employees)
colnames(Employees)
str(Employees)
#View(Employees)

# Convert Hire_Date to a proper date format
data <- Employees
data$Hire_Date <- ymd_hms(data$Hire_Date)
#View(data)
# Check the structure of the data
str(data)

##Viewing the NUNIQUE Monthly Salary from the duplicated ones in the data set
Employees %>%
  select(Monthly_Salary) %>%
  distinct(Monthly_Salary)

##EXPLORING OUR DATASET
sum(is.na(Employees))### checking to see if there any missing Values in the data set

max(Employees$Monthly_Salary) ### Maximum monthly Salary
min(Employees$Monthly_Salary) ### Minimum monthly salary

Earners_high<- Employees[Employees$Monthly_Salary == "9000",] ##Viewing all employees who earns the highest
Earners_high
#View(Earners_high)
Earners_low <- Employees[Employees$Monthly_Salary == "3850",] ##Viewing all employees who earns lowest
Earners_low
#View(Earners_low)

min(Employees$Work_Hours_Per_Week) ## minimum work hours per week
max(Employees$Work_Hours_Per_Week) ## maximum work hours per week

min(Employees$Years_At_Company) ## minimum Years at Company
max(Employees$Years_At_Company) ##Maximum Years at Company

min(Employees$Employee_Satisfaction_Score) ## Minimum Satisfaction score
max(Employees$Employee_Satisfaction_Score) ## Maximum Satisfaction score

min(Employees$Projects_Handled) ## Minimum project handled
max(Employees$Projects_Handled) ## Maximum project handled

#Salary vs. Years at Company, I.e if there is a relationship between years and salary using scattered plot
ggplot(Employees, aes(x = Years_At_Company, y = Monthly_Salary)) +
  geom_point(aes(color = factor(Years_At_Company)), alpha = 0.7) +
  geom_smooth(method = "lm", color = "red") +
  theme_minimal() +
  labs(title = "Salary vs. Years at Company", x = "Years at Company", 
       y = "Monthly Salary", color = "Years at Company")

###Increasing salary of Employees that meets some certain criteria but first we have to
  ## filter employees that has resigned from the company.
EmployeesR <- Employees[Employees$Resigned != "True", ] ## Removing all rows of resigned employees
EmployeesR

#EmployeesR <- Employees[Employees$Resigned == "True", ] ## Removing all rows of resigned employees
#EmployeesR
#View(EmployeesR) 

##Increasing the salary of Employees that meets the following criteria by  6000
Cri1 <-EmployeesR[EmployeesR$Monthly_Salary == 3850
                  & EmployeesR$Years_At_Company > 4
                  & EmployeesR$Projects_Handled > 40,] 
Cri1
#View(Cri1)
##Increasing the salary of Employees that meets the following criteria by  800
Cri2 <-EmployeesR[EmployeesR$Monthly_Salary == 4400
                  & EmployeesR$Work_Hours_Per_Week > 55,]

Cri2
#View(Cri2)
##Increasing the salary of Employees that meets the following criteria by  1200
Cri3 <- EmployeesR[EmployeesR$Monthly_Salary == 4200
                   & EmployeesR$Employee_Satisfaction_Score > 3 
                   & EmployeesR$Overtime_Hours> 25,]

Cri3
#View(Cri3)

###INCREASING SALARY and creating an extra column for the updated salary so as not to change anything
##in the data set. NOTE: The new column will carry the updated salary for only employees that will meet the
##criteria below, else the updated column will return the original monthly_salary.
salary_increased <- EmployeesR %>%
  mutate(Monthly_Salary_Updated = case_when(
    Monthly_Salary == 3850 & Years_At_Company > 4 & Projects_Handled > 40 ~ 3850+6000,
    Monthly_Salary == 4400 & Work_Hours_Per_Week >55 ~ 4400+801,     
    Monthly_Salary == 4200 & Employee_Satisfaction_Score > 3 & Overtime_Hours> 25 ~ 4200+1201,                       
    TRUE ~ Monthly_Salary                                    
  ))
#View(salary_increased) 
#to check the effect. For example, sighting rows 150, 399 and 537.

### VIEWING INCREASED SALARY 
increased_Cri1 <-salary_increased[salary_increased$Monthly_Salary_Updated == 3850+6000
                                  & salary_increased$Years_At_Company >4
                                  & salary_increased$Projects_Handled > 40,] 
increased_Cri1
#View(increased_Cri1)

increased_Cri2 <-salary_increased[salary_increased$Monthly_Salary_Updated == 4400+801
                                  & salary_increased$Work_Hours_Per_Week > 55,] 
increased_Cri2
#View(increased_Cri2)

increased_Cri3 <- salary_increased[salary_increased$Monthly_Salary_Updated == 4200+1201 
                                   & salary_increased$Employee_Satisfaction_Score > 3
                                   & salary_increased$Overtime_Hours> 25,]
increased_Cri3
#View(increased_Cri3)

ggplot(salary_increased, aes(x = Years_At_Company, y = Monthly_Salary_Updated)) +
  geom_point(aes(color = factor(Years_At_Company)), alpha = 0.7) +
  geom_smooth(method = "lm", color = "red") +
  theme_minimal() +
  labs(title = "Salary vs. Years at Company", x = "Years at Company",
       y = "Monthly Salary", color = "Years at Company")

###Viewing the NUNIQUE  Job Departments and Job Titles from the duplicated ones in the dataset

Employees  %>%
  select(Job_Title) %>%
  distinct(Job_Title)

Employees %>%
  select(Department) %>%
  distinct(Department)

## Calculating total salary per department
Legal_Sum <- sum(Employees$Monthly_Salary[Employees$Department == "Legal"])
Legal_Sum

Sales_Sum <- sum(Employees$Monthly_Salary[Employees$Department == "Sales"])
Sales_Sum

Operations_Sum <- sum(Employees$Monthly_Salary[Employees$Department == "Operations"])
Operations_Sum

Marketing_Sum <- sum(Employees$Monthly_Salary[Employees$Department == "Marketing"])
Marketing_Sum

HR_Sum <- sum(Employees$Monthly_Salary[Employees$Department == "HR"])
HR_Sum

IT_Sum <- sum(Employees$Monthly_Salary[Employees$Department == "IT"])
IT_Sum

CS_Sum <- sum(Employees$Monthly_Salary[Employees$Department == "Customer Support"])
CS_Sum

Finance_Sum <- sum(Employees$Monthly_Salary[Employees$Department == "Finance"])
Finance_Sum

Engineering_Sum <- sum(Employees$Monthly_Salary[Employees$Department == "Engineering"])
Engineering_Sum

##Bringing together the total salary by Job Departments
T_Salary_Per_Department <- c(Legal_Sum, Sales_Sum, Operations_Sum, Marketing_Sum, HR_Sum, IT_Sum,
                             CS_Sum, Finance_Sum, Engineering_Sum)
T_Salary_Per_Department

## Formatting the salary by add currency sign and Commas to it
# Function to format numbers as currency with commas
format_Salary_by_D <- function(amount, symbol = "$") {
  paste0(symbol, format(amount, big.mark = ",", scientific = FALSE, nsmall = 1))
}
# Apply formatting

Department_Salary <- sapply(T_Salary_Per_Department, format_Salary_by_D)
Department_Salary

##Listing the department names
Department_Names <- c("Legal", "Sales", "Operations", "Marketing", "HR", "IT", "CS", "Finance", "Engineering")
Department_Names

##Creating a PIECHART to represent Total Salary going to each Department and their percentage
salary_percentage <- round(T_Salary_Per_Department/sum(T_Salary_Per_Department)*100)
percentage_label <- paste(Department_Salary, "(",salary_percentage, "%)", sep = "")
pie(x = T_Salary_Per_Department,
    labels = percentage_label, col =  rainbow (length(T_Salary_Per_Department)),
    radius = 0.6, clockwise = TRUE,
    main = "Salary Distribution Per Department")
legend("right", legend = Department_Names, fill = jc, cex = 0.4) ## Adding a Legend for more details

## Calculating total salary per Job Title
Specialist_Sum <- sum(Employees$Monthly_Salary[Employees$Job_Title == "Specialist"])
Specialist_Sum

Developer_Sum <- sum(Employees$Monthly_Salary[Employees$Job_Title == "Developer"])
Developer_Sum

Analyst_Sum <- sum(Employees$Monthly_Salary[Employees$Job_Title == "Analyst"])
Analyst_Sum

Manager_Sum <- sum(Employees$Monthly_Salary[Employees$Job_Title == "Manager"])
Manager_Sum

Technician_Sum <- sum(Employees$Monthly_Salary[Employees$Job_Title == "Technician"])
Technician_Sum

Engineer_Sum <- sum(Employees$Monthly_Salary[Employees$Job_Title == "Engineer"])
Engineer_Sum

Consultant_Sum <- sum(Employees$Monthly_Salary[Employees$Job_Title == "Consultant"])
Consultant_Sum

##Bringing together the total salary by Job Departments
T_salary_per_JT <- c(Specialist_Sum, Developer_Sum, Analyst_Sum, Manager_Sum, Technician_Sum,
                     Engineer_Sum, Consultant_Sum)
T_salary_per_JT

##Listing our Job Titles
Job_Titles <- c("Specialist", "Developer", "Analyst", "Manager", "Technician", "Engineer", "Consultant")
Job_Titles

##Creating a BARPLOT to represent Total Salary going to each Job Title
# Change the scientific notation display

Salary_per_Job_Title <- data.frame(
  Job_Titless = c(Job_Titles),
  Salaries = c(T_salary_per_JT)
)

options(scipen = 999)  # This sets R to prefer non-scientific notation in our Y-LAB or AXIS
# Create the plot
ggplot(Salary_per_Job_Title, aes(x = Salaries, y = reorder(Job_Titless, Salaries), fill = Salaries)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = scales::dollar(Salaries)), hjust = -0.1,color = "black", size = 2.4) +
  ggtitle("Salary per Job Title") + xlab("Salary") + ylab("Job Title") +
  scale_fill_gradient(low = "red", high = "green") +
  theme(plot.margin = margin(2.5, 10, 2.5, 2.5))  # adds right margin space for labels

#Department Distribution, How many employees are in each department using barplot
ggplot(data, aes(x = Department)) +
  geom_bar(fill = "steelblue") +
  theme_minimal() +
  labs(title = "Employee Count by Department", x = "Department", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

###Gender Distribution by Job Title
ggplot(Employees, aes(x = Job_Title, fill = Gender)) +
  geom_bar(position = "dodge") +
  labs(title = "Gender Distribution by Job Title", 
       x = "Job Title", 
       y = "Number of Employees") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_brewer(palette = "Set2")

# Create age brackets and calculate mean performance score
employees <- Employees %>%
  mutate(Age_Bracket = cut(Age, 
                           breaks = c(20, 30, 40, 50, Inf), 
                           labels = c("21-30", "31-40", "41-50", "51-60"), 
                            right = FALSE)) %>%
  group_by(Age_Bracket) %>%
  summarise(Avg_Performance = mean(Performance_Score, na.rm = TRUE))

# Create the bar plot
ggplot(employees, aes(x = Age_Bracket, y = Avg_Performance)) +
  geom_bar(stat = "identity", fill = "skyblue", color = "black") +
  geom_text(aes(label = round(Avg_Performance, 2)), vjust = -0.5) +
  labs(title = "Average Performance Score by Age Bracket",
       x = "Age Bracket",
       y = "Average Performance Score") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

# Create age brackets and calculate the count for Educational Level
employee_performance <- Employees
employee_performance <- employee_performance %>%
  mutate(Age_Bracket = cut(Age,
                           breaks = c(20,30,40,50,Inf),
                           labels = c('21-30', '31-40', '41-50', '51-60'),
                           right = FALSE)) %>%
  group_by(Education_Level, Age_Bracket) %>%
  summarise(Count = n(), .groups = 'drop')

## Create the Bar plot 
ggplot(employee_performance, aes(x = Education_Level, y = Count, fill = Age_Bracket)) +
  geom_col(position = position_dodge()) +
  geom_text(aes(label = Age_Bracket), 
            position = position_dodge(width = 0.9), 
            vjust = -0.5) +
  labs(title = "Education vs Age Bracket", x = "Education", y = "Age Bracket Counts") +
  theme_minimal()

#Performance Score by Job Title, showing How does performance vary by job title using boxplot
ggplot(data, aes(x = Job_Title, y = Performance_Score)) +
  geom_boxplot(fill = "orange") +
  theme_minimal() +
  labs(title = "Performance Score by Job Title", x = "Job Title", y = "Performance Score") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#Hire Date Trends, How have hires trended over time.
data %>%
  mutate(Year_Month = floor_date(Hire_Date, "month")) %>%
  group_by(Year_Month) %>%
  summarise(Count = n()) %>%
  ggplot(aes(x = Year_Month, y = Count)) +
  geom_line(color =  "red") +
  theme_minimal() +
  labs(title = "Hiring Trends Over Time", x = "Year-Month", y = "Number of Hires")

