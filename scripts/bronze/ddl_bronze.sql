/* 
=============================================
DDL Script : Create bronze layer tables
=============================================
Scripts purpose :
The scipts creates the tables in the 'bronze' schema, dropping existing tables if they already exists
Run this script to redefine the DDL structure of 'bronze' Tables
============================================
*/



DROP PROCEDURE IF EXISTS bronze.load_bronze;
GO

CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '==========================================';
        PRINT 'Loading the Bronze Layer';
        PRINT '==========================================';
        
        PRINT '-------------------------------------------';
        PRINT 'Loading CRM tables';
        PRINT '-------------------------------------------';
        
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table : bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;
        PRINT '>> Inserting Data Into Table : bronze.crm_cust_info';
        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\nandi\Downloads\SQL datawarehouse project\Cust_data\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR =',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '>>Load Duration :'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' seconds';
        PRINT '>> -------------';

        SET @start_time = GETDATE();
        PRINT '>> Truncating Table :bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info

        PRINT '>> Inserting Data into Table:bronze.crm_prd_info';
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\nandi\Downloads\SQL datawarehouse project\Cust_data\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
            );
        
        SET @end_time = GETDATE();
        PRINT '>>Load Duration :'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' seconds';
        PRINT '>> -------------';
        
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table :bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details

    
        PRINT '>> Inserting Data into Table : bronze.crm_sales_details';
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\nandi\Downloads\SQL datawarehouse project\Cust_data\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '>>Load Duration :'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' seconds';
        PRINT '>> -------------';

        PRINT '-------------------------------------------';
        PRINT 'Loading ERP tables';
        PRINT '-------------------------------------------';

        SET @start_time = GETDATE();
        PRINT '>> Truncating the Table:bronze.erp_cust_az12';
        TRUNCATE TABLE bronze.erp_cust_az12

        PRINT '>> Inserting Data into Table : bronze.erp_cust_az12';
        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Users\nandi\Downloads\SQL datawarehouse project\Erp_data\CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '>>Load Duration :'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' seconds';
        PRINT '>> -------------';
        
        SET @start_time = GETDATE();
        PRINT '>> Truncating the Table:bronze.erp_loc_101';
        TRUNCATE TABLE bronze.erp_loc_101

        PRINT '>> Inserting Data into Table : bronze.erp_loc_101';

        BULK INSERT bronze.erp_loc_101
        FROM 'C:\Users\nandi\Downloads\SQL datawarehouse project\Erp_data\LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
            );

       ;

        SET @end_time = GETDATE();
        PRINT '>>Load Duration :'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' seconds';
        PRINT '>> -------------';

        SET @start_time = GETDATE();
        PRINT '>> Truncating the Table : bronze.erp_px_car_g1v2';
        TRUNCATE TABLE bronze.erp_px_car_g1v2;

        PRINT '>> Inserting Data into Table : bronze.erp_px_car_g1v2';
        BULK INSERT bronze.erp_px_car_g1v2
        FROM 'C:\Users\nandi\Downloads\SQL datawarehouse project\Erp_data\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>>Load Duration :'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' seconds';
        PRINT '>> -------------';

        SET @batch_end_time = GETDATE();
        PRINT '==========================================';
        PRINT 'Loading Bronze Layer is Completed';
        PRINT '>>Load Duration:' + CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR) +' seconds';
        PRINT '==========================================';
    END TRY

    BEGIN CATCH
        PRINT '===============================';
        PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
        PRINT 'Error Message'+ ERROR_MESSAGE();
        PRINT 'Error Message'+ CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error Message'+ CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '===============================';
        
    END CATCH
END


EXEC bronze.load_bronze
    


