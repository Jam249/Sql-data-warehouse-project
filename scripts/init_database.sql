/*
Database and Schema Initialization
Purpose:
This script initializes a database called 'DataWarehouse' after checking
whether it already exists. If detected, the current database is removed
and rebuilt from scratch. Furthermore, the script configures three separate
schemas within the database: 'bronze', 'silver', and 'gold'.

CAUTION:
Executing this script will delete the entire 'DataWarehouse' database if present.
All existing data will be irreversibly erased. Proceed with care and confirm
that verified backups exist prior to running this script.
*/

USE master;
GO

-- Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN 
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
GO


-- Create DataWarehouse database
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Create Schemas

CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
