use portfolio;

-- View the dataset
select *
from failed_bank_dataset_2;


-- Check for bank names that have duplicate
select bank_name, count(bank_name) as duplicate_count
from failed_bank_dataset_2
group by bank_name
having duplicate_count > 1;


-- Count of distinct bank names in the dataset
select count(distinct bank_name) as distinct_bank_count
from failed_bank_dataset_2;


-- Total number of failed banks in the dataset
select count(*)
from failed_bank_dataset_2;


-- Total number of failed banks by state
select state, count(*) as failed_banks_count
from failed_bank_dataset_2
group by state
order by failed_banks_count desc;


-- Top 10 acquiring institutions to have acquired the failed banks
select Acquiring_Institution, count(*) as AcquiredBanks_Count
from failed_bank_dataset_2
group by Acquiring_Institution
order by AcquiredBanks_Count desc
limit 10;


-- Total failed banks on a yearly basis
select year(str_to_date(Closing_Date, '%Y-%c-%e')) as extracted_year, count(*) as failed_banks_count
from failed_bank_dataset_2
group by extracted_year
order by extracted_year;


-- Total failed banks on a monthly basis
select month(str_to_date(Closing_Date, '%Y-%c-%e')) as extracted_month, count(*) as failed_banks_count
from failed_bank_dataset_2
group by extracted_month
order by extracted_month;


-- The average estimated loss of the failed banks
select avg(Estimated_Loss) as average_loss
from failed_bank_dataset_2;


-- The average estimated loss of failed banks by state
select state, avg(Estimated_Loss) as average_loss
from failed_bank_dataset_2
group by state
order by average_loss desc;


-- Top 10 banks that had the highest estimated loss
select Bank_Name, City, State, Estimated_Loss
from failed_bank_dataset_2
order by Estimated_Loss desc
limit 10;


-- City in each state with the number of failed bank
select State, City, count(*) as failed_banks_count
from failed_bank_dataset_2
group by State, City
order by failed_banks_count desc;


-- State that had the largest total assets among the failed bank
select state, sum(total_assets) as 'Total Assets Value'
from failed_bank_dataset_2
group by state
order by 'Total Assets Value';


-- Categorized the bank based on their total assets
-- First, I calculated the average of the total assets in order to effectively group the baank based on it
select avg(total_assets)
from failed_bank_dataset_2;
-- Then the categorization...
-- The basis of the Average range is the median (calculated with python) and the average calculated earlier
select
    case
        when total_assets > 2195363727.92 then 'High'
        when total_assets >= 200365000 and total_assets <= 2195363727.92 then 'Average'
        else 'Low'
    end as  'Total Assets Grade',
    count(*) as 'Number of Banks'
from failed_bank_dataset_2
group by
    case
        when total_assets > 2195363727.92 then 'High'
        when total_assets >= 200365000 and total_assets <= 2195363727.92 then 'Average'
        else 'Low'
    end;
    
    
    -- Some financial metrics calculation
    -- Loss to Asset Ratio
    -- A higher loss-to-asset ratio denotes a higher proportion of non-performing assets in the bank's portfolio.
    select Bank_Name, Estimated_Loss, Total_Assets, (Estimated_Loss/Total_Assets)*100 as Loss_Asset_Ratio
    from failed_bank_dataset_2;

    
    -- Asset to Deposit Ratio
	-- A higher asset-to-deposit ratio means the organization is more dependent on non-deposit funding sources, such borrowing, to finance its assets.
    -- This can potentially expose the institution to higher risks
    select Bank_Name, Total_Assets, Total_Deposits, (Total_Assets/Total_Deposits)*100 as Asset_Deposit_Ratio
    from failed_bank_dataset_2;
    
