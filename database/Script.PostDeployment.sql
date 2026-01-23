-- Create database
IF NOT EXISTS (SELECT name
FROM sys.databases
WHERE name = 'incomedata')
BEGIN
    CREATE DATABASE incomedata;
END
GO

-- Switch to the incomedata database
USE incomedata;
GO

-- Create schema
IF NOT EXISTS (SELECT *
FROM sys.schemas
WHERE name = 'input')
BEGIN
    EXEC('CREATE SCHEMA input');
END
GO

-- Create customer_information table
IF NOT EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'[input].[customer_information]') AND type in (N'U'))
BEGIN
    CREATE TABLE [input].[customer_information]
    (
        id INT IDENTITY(1,1) PRIMARY KEY,
        customer_id NVARCHAR(11) NOT NULL,
        period NVARCHAR(6) NOT NULL,
        age INT NOT NULL,
        employment_status NVARCHAR(20) NOT NULL,
        income_month FLOAT NOT NULL,
        aml_flag BIT DEFAULT 0,
        created_date DATETIME DEFAULT GETDATE(),
        updated_date DATETIME DEFAULT GETDATE(),
        CONSTRAINT CHK_customer_id CHECK (customer_id LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
        CONSTRAINT CHK_period CHECK (period LIKE '[0-9][0-9][0-9][0-9][0-9][0-9]'),
        CONSTRAINT CHK_age CHECK (age >= 0),
        CONSTRAINT CHK_employment_status CHECK (employment_status IN ('employed', 'unemployed', 'student')),
        CONSTRAINT CHK_income_month CHECK (income_month >= 0.0)
    );
END
GO

-- Insert test data
INSERT INTO [input].[customer_information]
    (customer_id, period, age, employment_status, income_month, aml_flag)
VALUES
    ('01010199999', '202208', 22, 'student', 16500.00, 0),
    ('01010199999', '202209', 22, 'student', 14800.00, 0),
    ('01010199999', '202210', 22, 'student', 15200.00, 0),
    ('01010199999', '202211', 22, 'student', 15100.00, 0),
    ('01010199999', '202212', 22, 'student', 18500.00, 0),
    ('01010199999', '202301', 23, 'student', 14500.00, 0),
    ('01010199999', '202302', 23, 'student', 15000.00, 0),
    ('01010199999', '202303', 23, 'student', 14900.00, 0),
    ('01010199999', '202304', 23, 'student', 17800.00, 0),
    ('01010199999', '202305', 23, 'student', 15300.00, 0),
    ('01010199999', '202306', 23, 'student', 18200.00, 0),
    ('01010199999', '202307', 23, 'student', 19500.00, 0),
    ('01010199999', '202308', 23, 'student', 18800.00, 0),
    ('01010199999', '202309', 23, 'student', 15100.00, 0),
    ('01010199999', '202310', 23, 'student', 14700.00, 0),
    ('01010199999', '202311', 23, 'student', 15400.00, 0),
    ('01010199999', '202312', 23, 'student', 18200.00, 0),
    ('01010199999', '202401', 24, 'student', 14800.00, 0),
    ('01010199999', '202402', 24, 'student', 15200.00, 0),
    ('01010199999', '202403', 24, 'student', 17500.00, 0),
    ('01010199999', '202404', 24, 'student', 15000.00, 0),
    ('01010199999', '202405', 24, 'student', 15600.00, 0),
    ('01010199999', '202406', 24, 'student', 18500.00, 0),
    ('01010199999', '202407', 24, 'student', 19200.00, 0),
    ('01010199999', '202408', 24, 'student', 18900.00, 0),
    ('01010199999', '202409', 24, 'student', 15300.00, 0),
    ('01010199999', '202410', 24, 'student', 14900.00, 0),
    ('01010199999', '202411', 24, 'student', 15500.00, 0),
    ('01010199999', '202412', 24, 'student', 18700.00, 0),
    ('01010199999', '202501', 25, 'student', 15100.00, 0),
    ('01010199999', '202502', 25, 'student', 14600.00, 0),
    ('01010199999', '202503', 25, 'student', 15200.00, 0),
    ('01010199999', '202504', 25, 'student', 17900.00, 0),
    ('01010199999', '202505', 25, 'student', 15400.00, 0),
    ('01010199999', '202506', 25, 'student', 18600.00, 0),
    ('01010199999', '202507', 25, 'student', 19400.00, 0),
    ('01010199999', '202508', 25, 'student', 19100.00, 0),
    ('01010199999', '202509', 25, 'employed', 30500.00, 0),
    ('01010199999', '202510', 25, 'employed', 29800.00, 0),
    ('01010199999', '202511', 25, 'employed', 30200.00, 0),
    ('01010199999', '202512', 25, 'employed', 30100.00, 0),
    ('02020299999', '202508', 35, 'employed', 50200.00, 0),
    ('02020299999', '202509', 35, 'employed', 49800.00, 0),
    ('02020299999', '202510', 35, 'employed', 50500.00, 0),
    ('02020299999', '202511', 35, 'employed', 50100.00, 0),
    ('02020299999', '202512', 35, 'employed', 49900.00, 0),
    ('03030399999', '202501', 42, 'unemployed', 0.0, 1),
    ('03030399999', '202502', 42, 'unemployed', 0.0, 1),
    ('03030399999', '202503', 42, 'unemployed', 100000.00, 1),
    ('03030399999', '202504', 42, 'unemployed', 0.0, 1),
    ('03030399999', '202505', 42, 'unemployed', 0.0, 1),
    ('03030399999', '202506', 42, 'unemployed', 100000.00, 1),
    ('03030399999', '202507', 42, 'unemployed', 0.0, 1),
    ('03030399999', '202508', 42, 'unemployed', 0.0, 1),
    ('03030399999', '202509', 42, 'unemployed', 100000.00, 1),
    ('03030399999', '202510', 42, 'unemployed', 0.0, 1),
    ('03030399999', '202511', 42, 'unemployed', 0.0, 1),
    ('03030399999', '202512', 42, 'unemployed', 100000.00, 1);
GO