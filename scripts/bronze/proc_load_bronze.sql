/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/
Create or alter procedure bronze.load_bronze as 
Begin
    declare @start_time Datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime;
	  begin try
	    set @batch_start_time=GETDATE();
		print '=========================================';
		print ' Loading the Bronze layer ';
		print '=========================================';

		print '******************************************';
		print ' Loading crm tables';
		print '******************************************';

		set @start_time=getdate();
		print '>> Truncating table: bronze.crm_cust_info'
		Truncate table bronze.crm_cust_info;

		print '>> inserting data into : bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		from 'C:\Users\mm699\OneDrive\Desktop\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
		FIRSTROW=2,
		FIELDTERMINATOR =',',
		TABLOCK
		);
		set @end_time=getdate();
		print'>>Load Duration:'+cast(datediff(second,@start_time,@end_time) as nvarchar)+'seconds';
		print'>>---------------------------------------';

		--SELECT count(*) from bronze.crm_cust_info
		set @start_time=getdate();
		print '>> Truncating table:bronze.crm_prd_info';
		Truncate table bronze.crm_prd_info;

		print '>> inserting data into : bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		from 'C:\Users\mm699\OneDrive\Desktop\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with(
		FIRSTROW=2,
		FIELDTERMINATOR =',',
		TABLOCK
		);
		set @end_time=getdate();
		print'>>Load Duration:'+cast(datediff(second,@start_time,@end_time) as nvarchar)+'seconds';
		print'>>---------------------------------------';

		set @start_time=getdate();
		print '>> Truncating table:bronze.crm_sales_details';
		Truncate table bronze.crm_sales_details;

		print '>> inserting data into : bronze.crm_sales_details'; 
		BULK INSERT bronze.crm_sales_details
		from 'C:\Users\mm699\OneDrive\Desktop\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with(
		FIRSTROW=2,
		FIELDTERMINATOR =',',
		TABLOCK
		);
		set @end_time=getdate();
		print'>>Load Duration:'+cast(datediff(second,@start_time,@end_time) as nvarchar)+'seconds';
		print'>>---------------------------------------';


		print '******************************************';
		print ' Loading ERP tables';
		print '******************************************';

		set @start_time=getdate();
		print '>> Truncating table:bronze.erp_loc_a101';
		Truncate table bronze.erp_loc_a101;

		print '>> inserting data into : bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		from 'C:\Users\mm699\OneDrive\Desktop\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		with(
		FIRSTROW=2,
		FIELDTERMINATOR =',',
		TABLOCK
		);
		set @end_time=getdate();
		print'>>Load Duration:'+cast(datediff(second,@start_time,@end_time) as nvarchar)+'seconds';
		print'>>---------------------------------------';

		set @start_time=getdate();

		print '>> Truncating table: bronze.erp_cust_az12';
		Truncate table bronze.erp_cust_az12;

		print '>> inserting data into : bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		from 'C:\Users\mm699\OneDrive\Desktop\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		with(
		FIRSTROW=2,
		FIELDTERMINATOR =',',
		TABLOCK
		);
		set @end_time=getdate();
		print'>>Load Duration:'+cast(datediff(second,@start_time,@end_time) as nvarchar)+'seconds';
		print'>>---------------------------------------';

		set @start_time=getdate();
		print '>> Truncating table:bronze.erp_px_cat_g1v2';
		Truncate table bronze.erp_px_cat_g1v2;

		print '>> inserting data into : bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		from 'C:\Users\mm699\OneDrive\Desktop\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		with(
		FIRSTROW=2,
		FIELDTERMINATOR =',',
		TABLOCK
		);
		set @end_time=getdate();
		print'>>Load Duration:'+cast(datediff(second,@start_time,@end_time) as nvarchar)+'seconds';
		print'>>---------------------------------------';

		set @batch_end_time=GETDATE();
		print ' *****************************************';
		print'Loading Bronze Layer is Completed';
        print'>>-Total Load Duration:'+cast(datediff(second,@batch_start_time,@batch_end_time) as nvarchar)+'seconds';
		print'>>---------------------------------------';
	  end try 
		begin catch 
		print ' *****************************************';
		print ' Error occured during loading bronze layer';
		print ' error message' + Error_Message();
		print ' error message' + cast ( error_number() as Nvarchar);
		print ' error message' + cast ( error_state() as Nvarchar);
		print ' *****************************************';
		end catch 
	end 
