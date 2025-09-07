--DML
-- Examination System DML - Complete Data Insertion
USE Examination_System_Data;
GO

--------------------- CORE DATA INSERTION ---------------------

-- Insert 5 Branches
INSERT INTO Branch (Bran_Name) VALUES 
('Cairo'), 
('Alexandria'), 
('Mansoura'), 
('Damanhur'), 
('Minia');
GO

-- Insert 5 Departments
INSERT INTO Department (Dep_Name) VALUES 
('Information Technology'), 
('Computer Science'), 
('Data Science'), 
('Network Engineering'), 
('System Administration');
GO

-- Insert Department-Branch Mappings (Assuming all departments are in all branches)
INSERT INTO Dept_Branch (Dep_ID, Bran_ID) VALUES 
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5),
(2, 1), (2, 2), (2, 3), (2, 4), (2, 5),
(3, 1), (3, 2), (3, 3), (3, 4), (3, 5),
(4, 1), (4, 2), (4, 3), (4, 4), (4, 5),
(5, 1), (5, 2), (5, 3), (5, 4), (5, 5);
GO

-- Insert 5 Tracks
INSERT INTO Track (Track_Name, Dep_ID) VALUES 
('Power BI Development', 3),       -- Belongs to Data Science Dept
('Python Backend Development', 2), -- Belongs to Computer Science Dept
('Data Analysis', 3),              -- Belongs to Data Science Dept
('Network', 4),                    -- Belongs to Network Engineering Dept
('System Administration', 5);      -- Belongs to System Administration Dept
GO

-- Insert Intakes
INSERT INTO Intake (Year) VALUES 
(2023), 
(2024), 
(2025);
GO

-- Insert 10 Courses (2 per track theme)
INSERT INTO Course (Crs_Name, Description, Min_Deg, Max_Deg) VALUES 
-- Power BI & Data Analysis Courses
('Power BI Fundamentals', 'Introduction to Power BI development and dashboard creation.', 60, 100),
('Advanced Power BI', 'Advanced Power BI features and data modeling.', 60, 100),
-- Python Backend Courses
('Python Programming Basics', 'Introduction to Python programming language.', 60, 100),
('Django Framework', 'Web development using the Django framework.', 60, 100),
-- Data Analysis & General Courses
('Data Analysis with Python', 'Statistical analysis and data visualization using Python.', 60, 100),
('SQL Database Management', 'Database querying, data manipulation, and management.', 60, 100),
-- Network Courses
('Network Fundamentals', 'Basic networking concepts, protocols, and devices.', 60, 100),
('Network Security', 'Principles and implementation of network security.', 60, 100),
-- System Administration Courses
('Windows Server Administration', 'Managing and maintaining Windows Server environments.', 60, 100),
('Linux System Administration', 'Managing and configuring Linux servers.', 60, 100);
GO

-- Insert 10 Instructors (2 per department)
INSERT INTO Instructor (Ins_Name, User_Name, Email, Dep_ID) VALUES 
('Ahmed Mohamed Ali', 'ahmed.mohamed', 'ahmed.mohamed@examcenter.edu.eg', 1),
('Fatma Hassan Ibrahim', 'fatma.hassan', 'fatma.hassan@examcenter.edu.eg', 2),
('Mahmoud Abdullah El-Sayed', 'mahmoud.abdullah', 'mahmoud.abdullah@examcenter.edu.eg', 3),
('Aisha Mohamed Hassan', 'aisha.mohamed', 'aisha.mohamed@examcenter.edu.eg', 3),
('Omar Khaled Ahmed', 'omar.khaled', 'omar.khaled@examcenter.edu.eg', 4),
('Nora Samy Mohamed', 'nora.samy', 'nora.samy@examcenter.edu.eg', 4),
('Youssef Emad El-Din', 'youssef.emad', 'youssef.emad@examcenter.edu.eg', 5),
('Mariam Ahmed Fathy', 'mariam.ahmed', 'mariam.ahmed@examcenter.edu.eg', 5),
('Hossam El-Din Mohamed', 'hossam.mohamed', 'hossam.mohamed@examcenter.edu.eg', 1),
('Sara Abdelrahman', 'sara.abdelrahman', 'sara.abdelrahman@examcenter.edu.eg', 2);
GO

-- Insert 20 Students (4 per track, all in 2024 Intake)
INSERT INTO Student (ST_Name, User_Name, Email, Intake_ID, Track_ID, Bran_ID) VALUES 
-- Power BI Development Track (Track_ID = 1)
('Mohamed Ahmed Mahmoud', 'mohamed.ahmed.001', 'mohamed.ahmed.001@student.edu.eg', 2, 1, 1),
('Salma Hossam El-Din', 'salma.hossam.002', 'salma.hossam.002@student.edu.eg', 2, 1, 2),
('Kareem Abdullah Ali', 'kareem.abdullah.003', 'kareem.abdullah.003@student.edu.eg', 2, 1, 3),
('Nada Mohamed Samy', 'nada.mohamed.004', 'nada.mohamed.004@student.edu.eg', 2, 1, 1),
-- Python Backend Development Track (Track_ID = 2)
('Amir Hassan Fathy', 'amir.hassan.005', 'amir.hassan.005@student.edu.eg', 2, 2, 2),
('Dina Emad Mohamed', 'dina.emad.006', 'dina.emad.006@student.edu.eg', 2, 2, 4),
('Tamer Khaled Ahmed', 'tamer.khaled.007', 'tamer.khaled.007@student.edu.eg', 2, 2, 1),
('Yasmin Ali Hassan', 'yasmin.ali.008', 'yasmin.ali.008@student.edu.eg', 2, 2, 3),
-- Data Analysis Track (Track_ID = 3)
('Abdelrahman Mahmoud', 'abdelrahman.mahmoud.009', 'abdelrahman.mahmoud.009@student.edu.eg', 2, 3, 5),
('Rania Ahmed Salem', 'rania.ahmed.010', 'rania.ahmed.010@student.edu.eg', 2, 3, 2),
('Eslam Hossam Ali', 'eslam.hossam.011', 'eslam.hossam.011@student.edu.eg', 2, 3, 1),
('Shimaa Mohamed Fathy', 'shimaa.mohamed.012', 'shimaa.mohamed.012@student.edu.eg', 2, 3, 4),
-- Network Track (Track_ID = 4)
('Ahmed Samy Hassan', 'ahmed.samy.013', 'ahmed.samy.013@student.edu.eg', 2, 4, 3),
('Hend Abdullah Mohamed', 'hend.abdullah.014', 'hend.abdullah.014@student.edu.eg', 2, 4, 5),
('Mohamed Ali Ibrahim', 'mohamed.ali.015', 'mohamed.ali.015@student.edu.eg', 2, 4, 1),
('Nour El-Hoda Ahmed', 'nour.ahmed.016', 'nour.ahmed.016@student.edu.eg', 2, 4, 2),
-- System Administration Track (Track_ID = 5)
('Khaled Mohamed Omar', 'khaled.mohamed.017', 'khaled.mohamed.017@student.edu.eg', 2, 5, 4),
('Mona Hassan Ali', 'mona.hassan.018', 'mona.hassan.018@student.edu.eg', 2, 5, 1),
('Wael Ahmed Mahmoud', 'wael.ahmed.019', 'wael.ahmed.019@student.edu.eg', 2, 5, 3),
('Heba Samy Fathy', 'heba.samy.020', 'heba.samy.020@student.edu.eg', 2, 5, 5);
GO

--------------------- QUESTION BANK INSERTION ---------------------

-- Insert 200 Questions (100 MCQ, 100 True/False | 20 per course | Degree=5)
-- Qu_ID 1-100 for MCQs, 101-200 for True/False
INSERT INTO Qu_Pool (Body, Type, Degree, Crs_ID) VALUES 
-- Course 1: Power BI Fundamentals (MCQ: 1-10, T/F: 101-110)
('What is the primary function of Power BI?', 'MCQ', 5, 1),
('Which Power BI component is used for data modeling?', 'MCQ', 5, 1),
('What file extension is used for Power BI Desktop files?', 'MCQ', 5, 1),
('Which service is used to share Power BI reports?', 'MCQ', 5, 1),
('What is Power Query primarily used for in Power BI?', 'MCQ', 5, 1),
('Which chart is best for showing trends over time?', 'MCQ', 5, 1),
('A Power BI gateway connects to what kind of data source?', 'MCQ', 5, 1),
('Real-time dashboards in Power BI are enabled by what feature?', 'MCQ', 5, 1),
('What are slicers used for in Power BI reports?', 'MCQ', 5, 1),
('Which part of Power BI is used to create calculated columns with DAX?', 'MCQ', 5, 1),
('Power BI can connect to Excel spreadsheets.', 'True/False', 5, 1),
('DAX is the formula language used in Power BI.', 'True/False', 5, 1),
('Power BI Desktop requires a paid subscription to use.', 'True/False', 5, 1),
('You can only connect to Microsoft data sources in Power BI.', 'True/False', 5, 1),
('Power Query is the data transformation engine in Power BI.', 'True/False', 5, 1),
('Power BI reports can be embedded into custom applications.', 'True/False', 5, 1),
('Power BI supports real-time data streaming.', 'True/False', 5, 1),
('DirectQuery mode imports a copy of the data into Power BI.', 'True/False', 5, 1),
('You can create custom visuals for Power BI.', 'True/False', 5, 1),
('Bookmarks in Power BI capture the current state of a report page.', 'True/False', 5, 1),

-- Course 2: Advanced Power BI (MCQ: 11-20, T/F: 111-120)
('Which DAX function is essential for creating complex filters?', 'MCQ', 5, 2),
('What is a key difference between calculated columns and measures?', 'MCQ', 5, 2),
('Which DAX function is used to iterate over a table row by row?', 'MCQ', 5, 2),
('What is the purpose of bookmarks in Power BI reports?', 'MCQ', 5, 2),
('Which DAX function is used to create a filtered copy of a table?', 'MCQ', 5, 2),
('Row-level security in Power BI is configured based on what?', 'MCQ', 5, 2),
('The DIVIDE function is preferred over the "/" operator in DAX to handle what?', 'MCQ', 5, 2),
('What does "context transition" mean in DAX?', 'MCQ', 5, 2),
('Where do you configure scheduled data refreshes for a dataset?', 'MCQ', 5, 2),
('What is a primary benefit of using Power BI dataflows?', 'MCQ', 5, 2),
('Row-level security can be implemented in Power BI.', 'True/False', 5, 2),
('Measures are calculated at query time and do not store data physically.', 'True/False', 5, 2),
('Calculated columns are computed during data refresh and consume memory.', 'True/False', 5, 2),
('Time intelligence functions in DAX require a dedicated date table.', 'True/False', 5, 2),
('The CALCULATE function can modify the filter context.', 'True/False', 5, 2),
('A row context exists by default within a calculated column formula.', 'True/False', 5, 2),
('A Power BI Pro license is required to share reports and dashboards.', 'True/False', 5, 2),
('Power BI dataflows can be shared and reused across multiple datasets.', 'True/False', 5, 2),
('Incremental refresh can significantly reduce data load times.', 'True/False', 5, 2),
('Composite models in Power BI allow combining DirectQuery and Import modes.', 'True/False', 5, 2),

-- Course 3: Python Programming Basics (MCQ: 21-30, T/F: 121-130)
('How do you create a list in Python?', 'MCQ', 5, 3),
('Which keyword is used to define a function in Python?', 'MCQ', 5, 3),
('What is the purpose of Python''s Global Interpreter Lock (GIL)?', 'MCQ', 5, 3),
('Which of the following Python data types is immutable?', 'MCQ', 5, 3),
('What is a list comprehension in Python?', 'MCQ', 5, 3),
('Which standard library module is used for regular expressions in Python?', 'MCQ', 5, 3),
('What is a decorator in Python?', 'MCQ', 5, 3),
('Which block of code is used to handle exceptions in Python?', 'MCQ', 5, 3),
('What is the difference between the "==" and "is" operators in Python?', 'MCQ', 5, 3),
('Which built-in function converts a string to an integer?', 'MCQ', 5, 3),
('Python is a compiled programming language.', 'True/False', 5, 3),
('Python supports multiple inheritance in classes.', 'True/False', 5, 3),
('Lists in Python are mutable.', 'True/False', 5, 3),
('Python uses indentation to define code blocks.', 'True/False', 5, 3),
('Python is a dynamically-typed language.', 'True/False', 5, 3),
('Python garbage collection is handled automatically.', 'True/False', 5, 3),
('The "pass" statement is a null operation in Python.', 'True/False', 5, 3),
('Python supports operator overloading.', 'True/False', 5, 3),
('Tuples in Python are immutable.', 'True/False', 5, 3),
('As of Python 3.7+, dictionaries maintain insertion order.', 'True/False', 5, 3),

-- Course 4: Django Framework (MCQ: 31-40, T/F: 131-140)
('Django is primarily used for what type of development?', 'MCQ', 5, 4),
('Which command starts a new Django project?', 'MCQ', 5, 4),
('What does the Django ORM (Object-Relational Mapper) do?', 'MCQ', 5, 4),
('Which command applies database migrations?', 'MCQ', 5, 4),
('What is middleware in the context of Django?', 'MCQ', 5, 4),
('Which Django template tag is used for looping through a list?', 'MCQ', 5, 4),
('What is the purpose of Django''s CSRF protection?', 'MCQ', 5, 4),
('Which command gathers all static files into a single directory?', 'MCQ', 5, 4),
('Django''s architecture pattern is known as what?', 'MCQ', 5, 4),
('Which built-in Django app handles user authentication?', 'MCQ', 5, 4),
('Django follows the Model-View-Controller (MVC) architectural pattern.', 'True/False', 5, 4),
('Django includes a built-in ORM.', 'True/False', 5, 4),
('Django uses a templating engine to generate HTML.', 'True/False', 5, 4),
('Django migrations are used to manage database schema changes.', 'True/False', 5, 4),
('The Django admin interface is generated automatically from models.', 'True/False', 5, 4),
('Django Forms are used to handle and validate user input.', 'True/False', 5, 4),
('The Django REST Framework is part of the core Django library.', 'True/False', 5, 4),
('Django can work with multiple database systems like PostgreSQL and MySQL.', 'True/False', 5, 4),
('Django provides a built-in system for user authentication and authorization.', 'True/False', 5, 4),
('Django middleware can process requests before they reach the view.', 'True/False', 5, 4),

-- Course 5: Data Analysis with Python (MCQ: 41-50, T/F: 141-150)
('Which Python library is the cornerstone for data manipulation and analysis?', 'MCQ', 5, 5),
('Which pandas function is used to read data from a CSV file?', 'MCQ', 5, 5),
('What is the main purpose of the NumPy library?', 'MCQ', 5, 5),
('Which pandas method is commonly used to handle missing values?', 'MCQ', 5, 5),
('What is the primary use of the Matplotlib library?', 'MCQ', 5, 5),
('Which method is used to combine multiple pandas DataFrames?', 'MCQ', 5, 5),
('What is the Seaborn library typically used for?', 'MCQ', 5, 5),
('Which pandas method is used to remove duplicate rows?', 'MCQ', 5, 5),
('What does "data cleaning" refer to in data analysis?', 'MCQ', 5, 5),
('Which pandas function is used to create spreadsheet-style pivot tables?', 'MCQ', 5, 5),
('The pandas library is built on top of NumPy.', 'True/False', 5, 5),
('A pandas DataFrame can contain columns with different data types.', 'True/False', 5, 5),
('NumPy arrays are generally more memory-efficient than Python lists for numerical data.', 'True/False', 5, 5),
('Matplotlib is a low-level library for creating data visualizations.', 'True/False', 5, 5),
('Seaborn is a high-level visualization library based on Matplotlib.', 'True/False', 5, 5),
('Pivot tables are a tool for summarizing large datasets.', 'True/False', 5, 5),
('Data cleaning is an optional step in the data analysis process.', 'True/False', 5, 5),
('Pandas can read data from various file formats, including Excel and JSON.', 'True/False', 5, 5),
('The "dropna()" method in pandas is used to fill missing values.', 'True/False', 5, 5),
('Jupyter Notebooks are widely used for interactive data analysis.', 'True/False', 5, 5),

-- Course 6: SQL Database Management (MCQ: 51-60, T/F: 151-160)
('What does SQL stand for?', 'MCQ', 5, 6),
('What is the purpose of a JOIN clause in SQL?', 'MCQ', 5, 6),
('Which SQL clause is used to filter query results?', 'MCQ', 5, 6),
('What is a subquery in SQL?', 'MCQ', 5, 6),
('Which SQL function is commonly used to get the current date and time?', 'MCQ', 5, 6),
('What is a stored procedure?', 'MCQ', 5, 6),
('Which SQL command is used to give permissions to a user?', 'MCQ', 5, 6),
('What is the primary goal of database normalization?', 'MCQ', 5, 6),
('Which SQL statement is used to modify the structure of a table?', 'MCQ', 5, 6),
('Which SQL clause is used with aggregate functions to group rows?', 'MCQ', 5, 6),
('SQL is a procedural programming language.', 'True/False', 5, 6),
('A JOIN clause is used to combine rows from two or more tables.', 'True/False', 5, 6),
('The GROUP BY clause must be used with aggregate functions like SUM() or COUNT().', 'True/False', 5, 6),
('The HAVING clause is used to filter results after grouping.', 'True/False', 5, 6),
('A primary key column can contain NULL values.', 'True/False', 5, 6),
('Foreign keys are used to enforce referential integrity between tables.', 'True/False', 5, 6),
('Indexes can slow down data retrieval in large databases.', 'True/False', 5, 6),
('A stored procedure is a pre-compiled set of SQL statements.', 'True/False', 5, 6),
('A view is a virtual table based on the result-set of an SQL statement.', 'True/False', 5, 6),
('A trigger is a special type of stored procedure that automatically runs when an event occurs.', 'True/False', 5, 6),

-- Course 7: Network Fundamentals (MCQ: 61-70, T/F: 161-170)
('What does OSI stand for in the context of networking?', 'MCQ', 5, 7),
('Which layer of the OSI model is responsible for routing?', 'MCQ', 5, 7),
('What is a key difference between TCP and UDP?', 'MCQ', 5, 7),
('What is the default port number for HTTP?', 'MCQ', 5, 7),
('What is the purpose of subnetting?', 'MCQ', 5, 7),
('A network switch primarily operates at which OSI layer?', 'MCQ', 5, 7),
('What is the function of DHCP in a network?', 'MCQ', 5, 7),
('Which protocol is used to resolve an IP address to a MAC address?', 'MCQ', 5, 7),
('What is the primary role of DNS in a network?', 'MCQ', 5, 7),
('Which device is used to connect different networks together?', 'MCQ', 5, 7),
('TCP is a connection-oriented protocol.', 'True/False', 5, 7),
('HTTP operates on port 443 by default.', 'True/False', 5, 7),
('UDP provides more reliable data delivery than TCP.', 'True/False', 5, 7),
('NAT (Network Address Translation) is used to map private IP addresses to a public one.', 'True/False', 5, 7),
('Network switches operate at the Network Layer (Layer 3).', 'True/False', 5, 7),
('DNS is used to resolve domain names into IP addresses.', 'True/False', 5, 7),
('IPv6 addresses are 128 bits long.', 'True/False', 5, 7),
('A VLAN is used to logically segment a network.', 'True/False', 5, 7),
('A router operates at the Data Link Layer (Layer 2).', 'True/False', 5, 7),
('DHCP is used to manually assign IP addresses to devices.', 'True/False', 5, 7),

-- Course 8: Network Security (MCQ: 71-80, T/F: 171-180)
('Which protocol provides a secure, encrypted web connection?', 'MCQ', 5, 8),
('What is the main purpose of a network firewall?', 'MCQ', 5, 8),
('What is a Virtual Private Network (VPN) used for?', 'MCQ', 5, 8),
('Which encryption standard is commonly used to secure Wi-Fi networks?', 'MCQ', 5, 8),
('What is an Intrusion Detection System (IDS)?', 'MCQ', 5, 8),
('Which protocol is a secure alternative to FTP for file transfers?', 'MCQ', 5, 8),
('What is penetration testing?', 'MCQ', 5, 8),
('What does the "Principle of Least Privilege" entail?', 'MCQ', 5, 8),
('What is two-factor authentication (2FA)?', 'MCQ', 5, 8),
('Which security protocol is fundamental to encrypting email communications (e.g., SMTPS)?', 'MCQ', 5, 8),
('HTTPS uses SSL/TLS to encrypt communication.', 'True/False', 5, 8),
('A firewall can prevent all types of cyber attacks.', 'True/False', 5, 8),
('A VPN creates a secure, encrypted tunnel over a public network.', 'True/False', 5, 8),
('Two-factor authentication adds an extra layer of security.', 'True/False', 5, 8),
('Encryption is the process of converting data into a code to prevent unauthorized access.', 'True/False', 5, 8),
('A digital certificate is used to verify the identity of a website or user.', 'True/False', 5, 8),
('Social engineering attacks exploit technical vulnerabilities rather than human psychology.', 'True/False', 5, 8),
('Penetration testing is the practice of simulating a cyber attack to find vulnerabilities.', 'True/False', 5, 8),
('A strong password should be short and easy to remember.', 'True/False', 5, 8),
('Antivirus software is designed to detect and remove malicious software.', 'True/False', 5, 8),

-- Course 9: Windows Server Administration (MCQ: 81-90, T/F: 181-190)
('Which Windows Server role provides centralized authentication and authorization?', 'MCQ', 5, 9),
('What is the primary function of Active Directory?', 'MCQ', 5, 9),
('What does a DNS server do in a Windows network?', 'MCQ', 5, 9),
('What is Group Policy used for in a Windows environment?', 'MCQ', 5, 9),
('Which command-line tool is used for advanced administration and scripting in Windows Server?', 'MCQ', 5, 9),
('Which Windows Server feature provides virtualization capabilities?', 'MCQ', 5, 9),
('What is the role of a DHCP server?', 'MCQ', 5, 9),
('Which tool is used to manage Windows Server roles and features?', 'MCQ', 5, 9),
('What is a Domain Controller?', 'MCQ', 5, 9),
('Which protocol allows for secure remote administration of a Windows Server?', 'MCQ', 5, 9),
('Active Directory is a directory service developed by Microsoft.', 'True/False', 5, 9),
('Windows Server can only be installed with a graphical user interface (GUI).', 'True/False', 5, 9),
('PowerShell is a task automation and configuration management framework.', 'True/False', 5, 9),
('Group Policy can be used to enforce security settings on computers and users.', 'True/False', 5, 9),
('Windows Update is used to manage software patches and updates.', 'True/False', 5, 9),
('Hyper-V is Microsoft''s hardware virtualization product.', 'True/False', 5, 9),
('A domain controller is a server that responds to security authentication requests.', 'True/False', 5, 9),
('NTFS is the standard file system for Windows Server.', 'True/False', 5, 9),
('Remote Desktop Protocol (RDP) provides remote access to the server''s desktop.', 'True/False', 5, 9),
('The Windows Firewall is enabled by default on Windows Server.', 'True/False', 5, 9),

-- Course 10: Linux System Administration (MCQ: 91-100, T/F: 191-200)
('Which command is used to list files and directories in Linux?', 'MCQ', 5, 10),
('Which command is used to change file permissions?', 'MCQ', 5, 10),
('What is the top-level directory of the Linux file system?', 'MCQ', 5, 10),
('Which command is used to display currently running processes?', 'MCQ', 5, 10),
('What is the `cron` daemon used for in Linux?', 'MCQ', 5, 10),
('Which command is used to create a new directory?', 'MCQ', 5, 10),
('What is `systemd` in modern Linux distributions?', 'MCQ', 5, 10),
('Which command is used to execute commands with root privileges?', 'MCQ', 5, 10),
('Which command is used to view the contents of a text file?', 'MCQ', 5, 10),
('Which command shows the disk usage of the file system?', 'MCQ', 5, 10),
('Linux is a proprietary operating system.', 'True/False', 5, 10),
('The `root` user has administrative privileges on a Linux system.', 'True/False', 5, 10),
('The `sudo` command allows a permitted user to execute a command as another user.', 'True/False', 5, 10),
('Cron jobs are used to schedule tasks to run at a specific time.', 'True/False', 5, 10),
('A shell script is a program designed to be run by the Linux shell.', 'True/False', 5, 10),
('A package manager like `apt` or `yum` is used to install and manage software.', 'True/False', 5, 10),
('Log files in Linux are typically stored in the `/var/log` directory.', 'True/False', 5, 10),
('The `chmod` command is used to change the owner of a file.', 'True/False', 5, 10),
('SSH (Secure Shell) is commonly used for secure remote access to Linux systems.', 'True/False', 5, 10),
('All Linux distributions use the same kernel.', 'True/False', 5, 10);
GO

-- Insert Choices for all 100 MCQ Questions (4 choices each, 1 correct)
-- Note: Is_Correct=1 indicates the correct answer.
INSERT INTO Choices (Body, Is_Correct, Qu_ID) VALUES
-- Course 1 Choices (Qu_ID 1-10)
('Data visualization and business intelligence', 1, 1), ('Web development', 0, 1), ('Database administration', 0, 1), ('Network management', 0, 1),
('Power BI Desktop', 1, 2), ('Power BI Service', 0, 2), ('Power BI Mobile', 0, 2), ('Power BI Gateway', 0, 2),
('.pbix', 1, 3), ('.xlsx', 0, 3), ('.pdf', 0, 3), ('.csv', 0, 3),
('Power BI Service', 1, 4), ('Power BI Desktop', 0, 4), ('Power BI Mobile', 0, 4), ('Power BI Gateway', 0, 4),
('Data transformation and preparation', 1, 5), ('Creating visualizations', 0, 5), ('User authentication', 0, 5), ('Report sharing', 0, 5),
('Line chart', 1, 6), ('Pie chart', 0, 6), ('Bar chart', 0, 6), ('Table', 0, 6),
('On-premises data sources', 1, 7), ('Cloud data sources', 0, 7), ('Mobile devices', 0, 7), ('Web applications', 0, 7),
('Streaming datasets', 1, 8), ('Static reports', 0, 8), ('Scheduled refresh', 0, 8), ('Manual refresh', 0, 8),
('Filtering data interactively', 1, 9), ('Creating calculations', 0, 9), ('Storing data', 0, 9), ('Connecting data sources', 0, 9),
('Power BI Desktop', 1, 10), ('Power BI Service', 0, 10), ('Power BI Mobile', 0, 10), ('Power BI Gateway', 0, 10),
-- Course 2 Choices (Qu_ID 11-20)
('CALCULATE', 1, 11), ('SUM', 0, 11), ('FILTER', 0, 11), ('RELATED', 0, 11),
('Calculated columns are stored in memory, measures are calculated on-the-fly', 1, 12), ('There is no difference', 0, 12), ('Measures are stored in memory, calculated columns are on-the-fly', 0, 12), ('Both are stored on disk', 0, 12),
('SUMX', 1, 13), ('CALCULATE', 0, 13), ('FILTER', 0, 13), ('ALL', 0, 13),
('To save and restore specific states of a report page', 1, 14), ('To bookmark favorite data sources', 0, 14), ('To create links to external websites', 0, 14), ('To manage user permissions', 0, 14),
('FILTER', 1, 15), ('SELECT', 0, 15), ('WHERE', 0, 15), ('TABLE', 0, 15),
('User roles', 1, 16), ('Table permissions', 0, 16), ('Column encryption', 0, 16), ('Workspace access levels', 0, 16),
('Division by zero errors', 1, 17), ('Negative numbers', 0, 17), ('Incorrect data types', 0, 17), ('Rounding issues', 0, 17),
('Converting a row context into an equivalent filter context', 1, 18), ('Switching between different data tables', 0, 18), ('Changing the data type of a column', 0, 18), ('Moving from Power BI Desktop to Service', 0, 18),
('Power BI Service', 1, 19), ('Power BI Desktop', 0, 19), ('Power BI Mobile App', 0, 19), ('Power Query Editor', 0, 19),
('To create a reusable and centralized data preparation process', 1, 20), ('To create visualizations', 0, 20), ('To manage user subscriptions', 0, 20), ('To distribute final reports', 0, 20),
-- Course 3 Choices (Qu_ID 21-30)
('my_list = []', 1, 21), ('my_list = {}', 0, 21), ('my_list = ()', 0, 21), ('my_list = ""', 0, 21),
('def', 1, 22), ('function', 0, 22), ('fun', 0, 22), ('define', 0, 22),
('It prevents multiple native threads from executing Python bytecodes at once', 1, 23), ('It is a code compilation tool', 0, 23), ('It is a debugging feature', 0, 23), ('It is a package manager', 0, 23),
('Tuple', 1, 24), ('List', 0, 24), ('Dictionary', 0, 24), ('Set', 0, 24),
('A concise way to create lists', 1, 25), ('A tool for understanding list memory usage', 0, 25), ('A type of for loop', 0, 25), ('A complex data structure', 0, 25),
('re', 1, 26), ('regex', 0, 26), ('regexp', 0, 26), ('str', 0, 26),
('A function that modifies or enhances another function', 1, 27), ('A specific data type for styling text', 0, 27), ('A loop construct', 0, 27), ('A variable type', 0, 27),
('try...except', 1, 28), ('if...else', 0, 28), ('do...while', 0, 28), ('switch...case', 0, 28),
('"==" compares values, "is" compares memory identity', 1, 29), ('They are identical', 0, 29), ('"==" compares identity, "is" compares values', 0, 29), ('"==" is for numbers, "is" is for strings', 0, 29),
('int()', 1, 30), ('str()', 0, 30), ('to_integer()', 0, 30), ('parse_int()', 0, 30),
-- Course 4 Choices (Qu_ID 31-40)
('Web development', 1, 31), ('Data analysis', 0, 31), ('Machine learning', 0, 31), ('Game development', 0, 31),
('django-admin startproject', 1, 32), ('django new project', 0, 32), ('python manage.py startproject', 0, 32), ('django createapp', 0, 32),
('It provides a way to interact with the database using Python objects', 1, 33), ('It optimizes relational models', 0, 33), ('It manages static files', 0, 33), ('It handles URL routing', 0, 33),
('python manage.py migrate', 1, 34), ('python manage.py makemigrations', 0, 34), ('python manage.py sqlmigrate', 0, 34), ('python manage.py syncdb', 0, 34),
('A system that processes requests and responses globally', 1, 35), ('Software that connects two applications', 0, 35), ('A part of the Django templating engine', 0, 35), ('A tool for database management', 0, 35),
('{% for %}', 1, 36), ('{% loop %}', 0, 36), ('{% iterate %}', 0, 36), ('{% cycle %}', 0, 36),
('To prevent Cross-Site Request Forgery attacks', 1, 37), ('To encrypt user passwords', 0, 37), ('To manage session cookies', 0, 37), ('To validate form data', 0, 37),
('python manage.py collectstatic', 1, 38), ('python manage.py findstatic', 0, 38), ('python manage.py loadstatic', 0, 38), ('python manage.py runserver', 0, 38),
('Model-View-Template (MVT)', 1, 39), ('Model-View-Controller (MVC)', 0, 39), ('Module-View-Component (MVC)', 0, 39), ('Model-Variable-Template (MVT)', 0, 39),
('django.contrib.auth', 1, 40), ('django.contrib.sessions', 0, 40), ('django.contrib.admin', 0, 40), ('django.security.auth', 0, 40),
-- Course 5 Choices (Qu_ID 41-50)
('pandas', 1, 41), ('numpy', 0, 41), ('scipy', 0, 41), ('matplotlib', 0, 41),
('read_csv()', 1, 42), ('load_csv()', 0, 42), ('import_csv()', 0, 42), ('get_csv()', 0, 42),
('Efficient numerical computation, especially with arrays', 1, 43), ('Creating interactive plots', 0, 43), ('Web scraping', 0, 43), ('Building web applications', 0, 43),
('fillna()', 1, 44), ('dropna()', 0, 44), ('replace()', 0, 44), ('clean()', 0, 44),
('Creating static, animated, and interactive visualizations', 1, 45), ('Data cleaning and preprocessing', 0, 45), ('Connecting to databases', 0, 45), ('Performing statistical tests', 0, 45),
('concat()', 1, 46), ('join()', 0, 46), ('append()', 0, 46), ('merge()', 0, 46),
('Creating high-level, statistically-informed visualizations', 1, 47), ('Performing complex mathematical calculations', 0, 47), ('Machine learning model training', 0, 47), ('Database management', 0, 47),
('drop_duplicates()', 1, 48), ('remove_duplicates()', 0, 48), ('delete_duplicates()', 0, 48), ('unique()', 0, 48),
('Identifying and correcting errors or inconsistencies in data', 1, 49), ('Deleting all data from a dataset', 0, 49), ('Archiving old data', 0, 49), ('Visualizing raw data', 0, 49),
('pivot_table()', 1, 50), ('crosstab()', 0, 50), ('groupby()', 0, 50), ('melt()', 0, 50),
-- Course 6 Choices (Qu_ID 51-60)
('Structured Query Language', 1, 51), ('Standard Query Language', 0, 51), ('Simple Query Logic', 0, 51), ('System Query Language', 0, 51),
('To combine rows from two or more tables based on a related column', 1, 52), ('To create a new table', 0, 52), ('To delete records from a table', 0, 52), ('To update existing records', 0, 52),
('WHERE', 1, 53), ('FILTER', 0, 53), ('HAVING', 0, 53), ('FROM', 0, 53),
('A query nested inside another query', 1, 54), ('A very fast query', 0, 54), ('A query that joins multiple tables', 0, 54), ('A query saved as a view', 0, 54),
('GETDATE() or NOW()', 1, 55), ('CURRENT_DATE()', 0, 55), ('TODAY()', 0, 55), ('DATE()', 0, 55),
('A pre-compiled set of one or more SQL statements stored in the database', 1, 56), ('A temporary table', 0, 56), ('A database backup file', 0, 56), ('A user-defined function', 0, 56),
('GRANT', 1, 57), ('ALLOW', 0, 57), ('PERMIT', 0, 57), ('ASSIGN', 0, 57),
('To reduce data redundancy and improve data integrity', 1, 58), ('To increase query speed', 0, 58), ('To encrypt the database', 0, 58), ('To back up the database', 0, 58),
('ALTER TABLE', 1, 59), ('MODIFY TABLE', 0, 59), ('UPDATE TABLE', 0, 59), ('CHANGE TABLE', 0, 59),
('GROUP BY', 1, 60), ('ORDER BY', 0, 60), ('AGGREGATE BY', 0, 60), ('SUMMARIZE BY', 0, 60),
-- Course 7 Choices (Qu_ID 61-70)
('Open Systems Interconnection', 1, 61), ('Operating System Interface', 0, 61), ('Open Source Initiative', 0, 61), ('Optical System Integration', 0, 61),
('Network Layer (Layer 3)', 1, 62), ('Data Link Layer (Layer 2)', 0, 62), ('Transport Layer (Layer 4)', 0, 62), ('Physical Layer (Layer 1)', 0, 62),
('TCP is connection-oriented and reliable; UDP is connectionless and faster', 1, 63), ('TCP is faster than UDP', 0, 63), ('UDP is more reliable than TCP', 0, 63), ('There is no significant difference', 0, 63),
('80', 1, 64), ('443', 0, 64), ('21', 0, 64), ('25', 0, 64),
('To divide a larger network into smaller, more manageable networks', 1, 65), ('To combine multiple networks into one', 0, 65), ('To encrypt network traffic', 0, 65), ('To assign IP addresses', 0, 65),
('Data Link Layer (Layer 2)', 1, 66), ('Network Layer (Layer 3)', 0, 66), ('Physical Layer (Layer 1)', 0, 66), ('Transport Layer (Layer 4)', 0, 66),
('To automatically assign IP addresses to devices on a network', 1, 67), ('To resolve domain names to IP addresses', 0, 67), ('To route traffic between networks', 0, 67), ('To secure network connections', 0, 67),
('ARP (Address Resolution Protocol)', 1, 68), ('DNS (Domain Name System)', 0, 68), ('DHCP (Dynamic Host Configuration Protocol)', 0, 68), ('ICMP (Internet Control Message Protocol)', 0, 68),
('To resolve human-readable domain names into IP addresses', 1, 69), ('To assign dynamic IP addresses to hosts', 0, 69), ('To transfer files between computers', 0, 69), ('To manage network traffic', 0, 69),
('Router', 1, 70), ('Switch', 0, 70), ('Hub', 0, 70), ('Bridge', 0, 70),
-- Course 8 Choices (Qu_ID 71-80)
('HTTPS', 1, 71), ('HTTP', 0, 71), ('FTP', 0, 71), ('SMTP', 0, 71),
('To monitor and control incoming and outgoing network traffic', 1, 72), ('To increase network speed', 0, 72), ('To back up network data', 0, 72), ('To host websites', 0, 72),
('To create a secure and encrypted connection over a less secure network', 1, 73), ('To boost Wi-Fi signal strength', 0, 73), ('To block advertisements', 0, 73), ('To manage local network devices', 0, 73),
('WPA2/WPA3', 1, 74), ('WEP', 0, 74), ('MD5', 0, 74), ('Open Wi-Fi', 0, 74),
('A device or software that monitors a network for malicious activity', 1, 75), ('A system that prevents intrusions', 0, 75), ('A system for data encryption', 0, 76), ('A tool for password management', 0, 75),
('SFTP (SSH File Transfer Protocol)', 1, 76), ('FTP (File Transfer Protocol)', 0, 76), ('TFTP (Trivial File Transfer Protocol)', 0, 76), ('HTTP (Hypertext Transfer Protocol)', 0, 76),
('A simulated cyber attack against your computer system to check for vulnerabilities', 1, 77), ('A test of network hardware performance', 0, 77), ('A review of security policies and procedures', 0, 77), ('A backup and recovery drill', 0, 77),
('Granting users only the access rights they need to perform their job', 1, 78), ('Giving all users administrative rights', 0, 78), ('Removing all user permissions', 0, 78), ('Encrypting all user data', 0, 78),
('A security process where users provide two different authentication factors', 1, 79), ('Using two different passwords for the same account', 0, 79), ('Authenticating on two different devices', 0, 79), ('A password that must be entered twice', 0, 79),
('SSL/TLS', 1, 80), ('HTTP', 0, 80), ('FTP', 0, 80), ('DHCP', 0, 80),
-- Course 9 Choices (Qu_ID 81-90)
('Active Directory Domain Services (AD DS)', 1, 81), ('DNS Server', 0, 81), ('DHCP Server', 0, 81), ('File Server', 0, 81),
('To manage users, computers, and other resources on a network', 1, 82), ('To host websites', 0, 82), ('To manage databases', 0, 82), ('To provide virtualization', 0, 82),
('Resolves domain names to IP addresses', 1, 83), ('Assigns IP addresses dynamically', 0, 83), ('Authenticates users', 0, 83), ('Stores files', 0, 83),
('To centrally manage and configure operating systems, applications, and user settings', 1, 84), ('To create user groups', 0, 84), ('To monitor network traffic', 0, 84), ('To install software', 0, 84),
('PowerShell', 1, 85), ('Command Prompt (CMD)', 0, 85), ('Server Manager', 0, 85), ('Task Manager', 0, 85),
('Hyper-V', 1, 86), ('IIS', 0, 86), ('Active Directory', 0, 86), ('DNS', 0, 86),
('To automatically assign IP addresses and other network configuration to clients', 1, 87), ('To manage domain names', 0, 87), ('To authenticate users', 0, 87), ('To host virtual machines', 0, 87),
('Server Manager', 1, 88), ('Control Panel', 0, 88), ('PowerShell', 0, 88), ('Registry Editor', 0, 88),
('A server running Active Directory Domain Services (AD DS)', 1, 89), ('The main file server in a network', 0, 89), ('A server that controls a firewall', 0, 89), ('A server that hosts a website', 0, 89),
('Remote Desktop Protocol (RDP)', 1, 90), ('Telnet', 0, 90), ('SSH', 0, 90), ('FTP', 0, 90),
-- Course 10 Choices (Qu_ID 91-100)
('ls', 1, 91), ('dir', 0, 91), ('list', 0, 91), ('show', 0, 91),
('chmod', 1, 92), ('chown', 0, 92), ('chgrp', 0, 92), ('perm', 0, 92),
('/', 1, 93), ('/root', 0, 93), ('/home', 0, 93), ('C:', 0, 93),
('ps', 1, 94), ('proc', 0, 94), ('top', 0, 94), ('list-proc', 0, 94),
('Scheduling tasks and scripts to run automatically', 1, 95), ('Managing file compression', 0, 95), ('Configuring network interfaces', 0, 95), ('Creating new user accounts', 0, 95),
('mkdir', 1, 96), ('newdir', 0, 96), ('crdir', 0, 96), ('dir-make', 0, 96),
('An init system and service manager', 1, 97), ('A file system type', 0, 97), ('A network protocol', 0, 97), ('A graphical desktop environment', 0, 97),
('sudo', 1, 98), ('root', 0, 98), ('admin', 0, 98), ('exec', 0, 98),
('cat', 1, 99), ('read', 0, 99), ('view', 0, 99), ('display', 0, 99),
('df', 1, 100), ('du', 0, 100), ('diskusage', 0, 100), ('space', 0, 100);
GO

--------------------- MAPPING TABLE INSERTION ---------------------

-- Map Courses to Instructors for the 2024 Intake (Intake_ID = 2)
INSERT INTO Crs_Inst_Intake (Crs_ID, Ins_ID, Intake_ID) VALUES 
(1, 3, 2), (1, 4, 2),   -- Power BI Fundamentals taught by Data Science instructors
(2, 3, 2), (2, 4, 2),   -- Advanced Power BI taught by Data Science instructors
(3, 2, 2), (3, 10, 2),  -- Python Basics taught by CS instructors
(4, 2, 2), (4, 10, 2),  -- Django taught by CS instructors
(5, 3, 2), (5, 4, 2),   -- Data Analysis with Python by Data Science instructors
(6, 1, 2), (6, 9, 2),   -- SQL taught by IT instructors
(7, 5, 2), (7, 6, 2),   -- Network Fundamentals by Network instructors
(8, 5, 2), (8, 6, 2),   -- Network Security by Network instructors
(9, 7, 2), (9, 8, 2),   -- Windows Server by System Admin instructors
(10, 7, 2), (10, 8, 2); -- Linux System Admin by System Admin instructors
GO

-- Map Courses to Tracks
INSERT INTO Track_Crs (Track_ID, Crs_ID) VALUES 
-- Power BI Development Track (ID=1)
(1, 1), (1, 2), (1, 6), (1, 5),
-- Python Backend Development Track (ID=2)
(2, 3), (2, 4), (2, 6), 
-- Data Analysis Track (ID=3)
(3, 5), (3, 6), (3, 1), (3, 2),
-- Network Track (ID=4)
(4, 7), (4, 8),
-- System Administration Track (ID=5)
(5, 9), (5, 10);
GO

-- Map Instructors to Branches for the 2024 Intake (Intake_ID = 2)
INSERT INTO Intake_Ins_Branch (Intake_ID, Ins_ID, Bran_ID) VALUES 
(2, 1, 1), (2, 1, 2),
(2, 2, 1), (2, 2, 3),
(2, 3, 2), (2, 3, 5),
(2, 4, 1), (2, 4, 4),
(2, 5, 3), (2, 5, 5),
(2, 6, 2), (2, 6, 4),
(2, 7, 1), (2, 7, 3),
(2, 8, 4), (2, 8, 5),
(2, 9, 1), (2, 9, 2),
(2, 10, 2), (2, 10, 3);
GO

--------------------- EXAM & ANSWER INSERTION ---------------------

-- Insert 10 Exams (1 per course, all normal, completed, for Intake 2)
INSERT INTO Exam ([Date], Start_time, End_time, Corrective, Bran_ID, Crs_ID, Intake_ID, Ins_ID, Track_ID, Exam_Status) VALUES 
('2024-12-15', '2024-12-15 09:00:00', '2024-12-15 11:00:00', 0, 1, 1, 2, 3, 1, 'Completed'), -- Power BI Fund. for Power BI Track
('2024-12-16', '2024-12-16 09:00:00', '2024-12-16 11:00:00', 0, 2, 2, 2, 4, 1, 'Completed'), -- Advanced Power BI for Power BI Track
('2024-12-17', '2024-12-17 09:00:00', '2024-12-17 11:00:00', 0, 1, 3, 2, 2, 2, 'Completed'), -- Python Basics for Python Track
('2024-12-18', '2024-12-18 09:00:00', '2024-12-18 11:00:00', 0, 2, 4, 2, 10, 2, 'Completed'),-- Django for Python Track
('2024-12-19', '2024-12-19 09:00:00', '2024-12-19 11:00:00', 0, 5, 5, 2, 3, 3, 'Completed'), -- Data Analysis for DA Track
('2024-12-20', '2024-12-20 09:00:00', '2024-12-20 11:00:00', 0, 4, 6, 2, 1, 3, 'Completed'), -- SQL for DA Track
('2024-12-21', '2024-12-21 09:00:00', '2024-12-21 11:00:00', 0, 3, 7, 2, 5, 4, 'Completed'), -- Network Fund. for Network Track
('2024-12-22', '2024-12-22 09:00:00', '2024-12-22 11:00:00', 0, 5, 8, 2, 6, 4, 'Completed'), -- Network Sec. for Network Track
('2024-12-23', '2024-12-23 09:00:00', '2024-12-23 11:00:00', 0, 1, 9, 2, 7, 5, 'Completed'), -- Windows Server for SysAdmin Track
('2024-12-24', '2024-12-24 09:00:00', '2024-12-24 11:00:00', 0, 3, 10, 2, 8, 5, 'Completed');-- Linux for SysAdmin Track
GO

-- Map Questions to Exams (20 questions per exam)
-- Exam 1 (Crs 1)
INSERT INTO Exam_Questions (Exam_ID, Question_ID, Question_Order) SELECT 1, Qu_ID, ROW_NUMBER() OVER (ORDER BY Qu_ID) FROM Qu_Pool WHERE Crs_ID = 1;
-- Exam 2 (Crs 2)
INSERT INTO Exam_Questions (Exam_ID, Question_ID, Question_Order) SELECT 2, Qu_ID, ROW_NUMBER() OVER (ORDER BY Qu_ID) FROM Qu_Pool WHERE Crs_ID = 2;
-- Exam 3 (Crs 3)
INSERT INTO Exam_Questions (Exam_ID, Question_ID, Question_Order) SELECT 3, Qu_ID, ROW_NUMBER() OVER (ORDER BY Qu_ID) FROM Qu_Pool WHERE Crs_ID = 3;
-- Exam 4 (Crs 4)
INSERT INTO Exam_Questions (Exam_ID, Question_ID, Question_Order) SELECT 4, Qu_ID, ROW_NUMBER() OVER (ORDER BY Qu_ID) FROM Qu_Pool WHERE Crs_ID = 4;
-- Exam 5 (Crs 5)
INSERT INTO Exam_Questions (Exam_ID, Question_ID, Question_Order) SELECT 5, Qu_ID, ROW_NUMBER() OVER (ORDER BY Qu_ID) FROM Qu_Pool WHERE Crs_ID = 5;
-- Exam 6 (Crs 6)
INSERT INTO Exam_Questions (Exam_ID, Question_ID, Question_Order) SELECT 6, Qu_ID, ROW_NUMBER() OVER (ORDER BY Qu_ID) FROM Qu_Pool WHERE Crs_ID = 6;
-- Exam 7 (Crs 7)
INSERT INTO Exam_Questions (Exam_ID, Question_ID, Question_Order) SELECT 7, Qu_ID, ROW_NUMBER() OVER (ORDER BY Qu_ID) FROM Qu_Pool WHERE Crs_ID = 7;
-- Exam 8 (Crs 8)
INSERT INTO Exam_Questions (Exam_ID, Question_ID, Question_Order) SELECT 8, Qu_ID, ROW_NUMBER() OVER (ORDER BY Qu_ID) FROM Qu_Pool WHERE Crs_ID = 8;
-- Exam 9 (Crs 9)
INSERT INTO Exam_Questions (Exam_ID, Question_ID, Question_Order) SELECT 9, Qu_ID, ROW_NUMBER() OVER (ORDER BY Qu_ID) FROM Qu_Pool WHERE Crs_ID = 9;
-- Exam 10 (Crs 10)
INSERT INTO Exam_Questions (Exam_ID, Question_ID, Question_Order) SELECT 10, Qu_ID, ROW_NUMBER() OVER (ORDER BY Qu_ID) FROM Qu_Pool WHERE Crs_ID = 10;
GO

-- Map Instructors to the Exam Questions they created
-- Instructor 3 (Data Science) created questions for Exam 1
INSERT INTO Inst_Exam_QuP(Ins_ID, Ex_ID, Qu_ID) SELECT 3, 1, Question_ID FROM Exam_Questions WHERE Exam_ID = 1;
-- Instructor 2 (CS) created questions for Exam 3
INSERT INTO Inst_Exam_QuP(Ins_ID, Ex_ID, Qu_ID) SELECT 2, 3, Question_ID FROM Exam_Questions WHERE Exam_ID = 3;
-- Instructor 5 (Network) created questions for Exam 7
INSERT INTO Inst_Exam_QuP(Ins_ID, Ex_ID, Qu_ID) SELECT 5, 7, Question_ID FROM Exam_Questions WHERE Exam_ID = 7;
-- Instructor 7 (SysAdmin) created questions for Exam 9
INSERT INTO Inst_Exam_QuP(Ins_ID, Ex_ID, Qu_ID) SELECT 7, 9, Question_ID FROM Exam_Questions WHERE Exam_ID = 9;
GO

-- Insert Sample Student Exam Answers
-- Student 1 (Mohamed Ahmed) - Power BI Track - Takes Exam 1 (Power BI Fund.) - Score: 80/100 (Pass)
INSERT INTO Stu_Exam_QUP (ST_ID, Ex_ID, Qu_ID, Answer_Ch_ID, Answer_TF, Score) VALUES 
-- MCQ Answers (8/10 correct = 40) -- Correct choices have IDs ending in 1, 5, 9, etc.
(1, 1, 1, 1, NULL, 5), (1, 1, 2, 5, NULL, 5), (1, 1, 3, 9, NULL, 5), (1, 1, 4, 13, NULL, 5),
(1, 1, 5, 17, NULL, 5), (1, 1, 6, 21, NULL, 5), (1, 1, 7, 26, NULL, 0), -- Wrong
(1, 1, 8, 29, NULL, 5), (1, 1, 9, 34, NULL, 0), -- Wrong
(1, 1, 10, 37, NULL, 5),
-- True/False Answers (8/10 correct = 40) -- Correct answers are: T, T, F, F, T, T, T, F, T, T
(1, 1, 101, NULL, 1, 5), (1, 1, 102, NULL, 1, 5), (1, 1, 103, NULL, 0, 5), (1, 1, 104, NULL, 0, 5),
(1, 1, 105, NULL, 1, 5), (1, 1, 106, NULL, 1, 5), (1, 1, 107, NULL, 0, 0), -- Wrong
(1, 1, 108, NULL, 0, 5), (1, 1, 109, NULL, 0, 0), -- Wrong
(1, 1, 110, NULL, 1, 5);

-- Student 5 (Amir Hassan) - Python Track - Takes Exam 3 (Python Basics) - Score: 55/100 (Fail)
INSERT INTO Stu_Exam_QUP (ST_ID, Ex_ID, Qu_ID, Answer_Ch_ID, Answer_TF, Score) VALUES 
-- MCQ Answers (5/10 correct = 25) -- Correct choices have IDs ending in 1, 5, 9, etc.
(5, 3, 21, 81, NULL, 5), (5, 3, 22, 86, NULL, 0), (5, 3, 23, 89, NULL, 5), (5, 3, 24, 94, NULL, 0),
(5, 3, 25, 97, NULL, 5), (5, 3, 26, 102, NULL, 0), (5, 3, 27, 105, NULL, 5), (5, 3, 28, 110, NULL, 0),
(5, 3, 29, 113, NULL, 5), (5, 3, 30, 118, NULL, 0),
-- True/False Answers (6/10 correct = 30) -- Correct answers are: F, T, T, T, T, T, T, T, T, T
(5, 3, 121, NULL, 0, 5), (5, 3, 122, NULL, 0, 0), (5, 3, 123, NULL, 1, 5), (5, 3, 124, NULL, 1, 5),
(5, 3, 125, NULL, 0, 0), (5, 3, 126, NULL, 1, 5), (5, 3, 127, NULL, 0, 0), (5, 3, 128, NULL, 1, 5),
(5, 3, 129, NULL, 0, 0), (5, 3, 130, NULL, 1, 5);

-- Student 13 (Ahmed Samy) - Network Track - Takes Exam 7 (Network Fund.) - Score: 90/100 (Pass)
INSERT INTO Stu_Exam_QUP (ST_ID, Ex_ID, Qu_ID, Answer_Ch_ID, Answer_TF, Score) VALUES 
-- MCQ Answers (9/10 correct = 45)
(13, 7, 61, 241, NULL, 5), (13, 7, 62, 245, NULL, 5), (13, 7, 63, 249, NULL, 5), (13, 7, 64, 253, NULL, 5),
(13, 7, 65, 257, NULL, 5), (13, 7, 66, 261, NULL, 5), (13, 7, 67, 265, NULL, 5), (13, 7, 68, 269, NULL, 5),
(13, 7, 69, 274, NULL, 0), (13, 7, 70, 277, NULL, 5),
-- True/False Answers (9/10 correct = 45) -- Correct: T, F, F, T, F, T, T, T, F, F
(13, 7, 161, NULL, 1, 5), (13, 7, 162, NULL, 0, 5), (13, 7, 163, NULL, 0, 5), (13, 7, 164, NULL, 1, 5),
(13, 7, 165, NULL, 0, 5), (13, 7, 166, NULL, 1, 5), (13, 7, 167, NULL, 1, 5), (13, 7, 168, NULL, 1, 5),
(13, 7, 169, NULL, 1, 0), (13, 7, 170, NULL, 0, 5);

-- Student 17 (Khaled Mohamed) - SysAdmin Track - Takes Exam 9 (Windows Server) - Score: 50/100 (Fail)
INSERT INTO Stu_Exam_QUP (ST_ID, Ex_ID, Qu_ID, Answer_Ch_ID, Answer_TF, Score) VALUES 
-- MCQ Answers (6/10 correct = 30)
(17, 9, 81, 321, NULL, 5), (17, 9, 82, 326, NULL, 0), (17, 9, 83, 329, NULL, 5), (17, 9, 84, 333, NULL, 5),
(17, 9, 85, 338, NULL, 0), (17, 9, 86, 341, NULL, 5), (17, 9, 87, 345, NULL, 5), (17, 9, 88, 350, NULL, 0),
(17, 9, 89, 353, NULL, 5), (17, 9, 90, 358, NULL, 0),
-- True/False Answers (4/10 correct = 20) -- Correct: T, F, T, T, T, T, T, T, T, T
(17, 9, 181, NULL, 1, 5), (17, 9, 182, NULL, 1, 0), (17, 9, 183, NULL, 1, 5), (17, 9, 184, NULL, 0, 0),
(17, 9, 185, NULL, 1, 5), (17, 9, 186, NULL, 0, 0), (17, 9, 187, NULL, 1, 5), (17, 9, 188, NULL, 0, 0),
(17, 9, 189, NULL, 0, 0), (17, 9, 190, NULL, 0, 0);
GO

-- Insert Corrective Exams for students who failed
INSERT INTO Exam_Corrective (Original_Exam_ID, Student_ID, Corrective_Date, Start_time, End_time, Is_Completed, Score) VALUES 
-- Student 5 retakes Exam 3 and passes
(3, 5, '2025-01-10', '2025-01-10 10:00:00', '2025-01-10 12:00:00', 1, 75),
-- Student 17 is scheduled for a retake of Exam 9 but has not completed it yet
(9, 17, '2025-01-12', '2025-01-12 10:00:00', '2025-01-12 12:00:00', 0, NULL);
GO

PRINT 'DML script executed successfully. All data has been inserted.';
GO

--------------------- Indexes---------------------

-- Unique Exam per Course (Normal only)
CREATE UNIQUE INDEX Normal_Exam ON Exam (Crs_ID) WHERE Corrective = 0;

-- Indexes
CREATE INDEX IX_Student_IntakeID ON Student(Intake_ID);
CREATE INDEX IX_Student_TrackID ON Student(Track_ID);
CREATE INDEX IX_Student_BranchID ON Student(Bran_ID);
CREATE INDEX IX_Student_UserName ON Student(User_Name);
CREATE INDEX IX_Exam_CourseID ON Exam(Crs_ID);
CREATE INDEX IX_Exam_BranchID ON Exam(Bran_ID);
CREATE INDEX IX_Exam_IntakeID ON Exam(Intake_ID);
CREATE INDEX IX_Exam_Instructor ON Exam(Ins_ID);
CREATE INDEX IX_Exam_TrackID ON Exam(Track_ID);
CREATE INDEX IX_Instructor_UserName ON Instructor(User_Name); 
CREATE INDEX IX_Qu_Pool_CourseID ON Qu_Pool(Crs_ID);
CREATE INDEX IX_Stu_Exam_QUP_ExamID ON Stu_Exam_QUP(Ex_ID);
CREATE INDEX IX_Stu_Exam_QUP_QuestionID ON Stu_Exam_QUP(Qu_ID);
CREATE INDEX IX_Student_Name ON Student(ST_Name);
CREATE INDEX IX_Instructor_Name ON Instructor(Ins_Name);
CREATE INDEX IX_Exam_Date ON Exam(Date);
CREATE INDEX IX_Course_Name ON Course(Crs_Name);
CREATE INDEX IX_Dept_Branch_DepID ON Dept_Branch(Dep_ID); 
CREATE INDEX IX_Dept_Branch_BranID ON Dept_Branch(Bran_ID);