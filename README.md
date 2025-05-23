
 <h3>Comments from my instructor:

This project shows excellent initiative and thoroughness in managing a complex dataset from a reputable source (CDC). You demonstrated strong data handling skills by using SQL, DAX, AI tools, and Power BI to clean, transform, and visualize the data. Congratulations and Great Job overall!</h3>

<h1>Quickstart Data Analytics Simulation_3 Project (NHIS_Survey)</h1>
 <p>This Repo is a Power BI project that takes a look at NHIS survey data from the CDC website and looks at comparisons of poverty ratios with stress/hypertension, anxiety, and memory.</p>

 - Predicted Target: That those in poverty would have higher rates of stress and anxiety to those who are in the middle or higher end income brackets.

Full Survey Description:
https://ftp.cdc.gov/pub/Health_Statistics/NCHS/Dataset_Documentation/NHIS/2023/srvydesc-508.pdf
Codebook(For Data Cleaning):
-	Determine the data I want to use from each dataset
-	Clean data by changing headings, converting numbers of answers to strings from codebook, publish cleaned data to Github and import to SQL Server
-	Use AI to analyze and write SQL queries for comparison from Github files
https://ftp.cdc.gov/pub/Health_Statistics/NCHS/Dataset_Documentation/NHIS/2023/adult-codebook.pdf


https://www.cdc.gov/nchs/nhis/documentation/2023-nhis.html

Chose to use real data from the CDC 
***Data user agreement states that I cannot try to identify and disclose personal information, however, this information is removed from the dataset prior to publishing.


Compare hypertension from poverty and stress in NHIS survey data from 2022-2023. If time, determine if has a direct reflection on memory. Offer predictive analysis for future years based on trends.

<ul>
<h2>General:</h2>
<li>MHRX_A(ANY_MEDS) (Took medication for other emotions/concentration/behavior/mental health, past 12 months)</li>
<li>URBRRL(MET_SIZE) (Size of Metro Area)</li>
<li>HHX(HH_NUM) (Randomly assigned household number unique to a household) Would not match same household in previous years</li>
<li>AGEP_A (Age)</li>
<li>SEX_A (Sex)</li>
<li>SRVY_YR (Survey Year)</li>
<li>REGION (Household Region)</li>
<li>HISP_A(HISP) (Hispanic?)</li>
<li>EDUCP_A(EDU_LEV) (Education Level)</li>
<li>BMICAT_A(BMI) (Body Mass Index)</li>
<li>RACEALLP_A (RACE)</li>

<h2>Hypertension Fields:</h2>

<li>HYPEV_A(HYPPEV)  (Have you EVER been told by a doctor or other health professional that you had ...Hypertension, also called high blood pressure?)</li>
<li>HYPDIF_A(HYPDIF) (Were you told on two or more DIFFERENT visits that you had hypertension or high blood pressure?)</li>
<li>HYP12M_A(HYP12M) (During the past 12 months, have you had hypertension or high blood pressure?)</li>
<li>HYPMED_A(HYPMED) (Are you NOW taking any medication prescribed by a doctor for your high blood pressure?)</li>

<h2>Poverty Fields:</h2>

<li>POVRATTC_A (SA family poverty ratio) </li>
<li>RATCAT_A (Ratio of family income to poverty threshold for SA's family)</li>

<h2>Stress/Anxiety:</h2>

<li>ANXEV_A(ANXDIAG) (Have you EVER been told by a doctor or other health professional that you had ...Any type of anxiety disorder?)</li>
<li>ANXFREQ_A(ANXFREQ) (How often do you feel worried, nervous or anxious? Would you say daily, weekly, monthly, a few times a year, or never?)</li>
<li>ANXMED_A(ANXMED) (Take medication for worried/nervous/anxious feelings)</li>
<li>ANXLEVEL_A(ANXLEVEL) (Thinking about the last time you felt worried, nervous or anxious, how would you describe the level of these feelings? Would you say a little, a lot, or somewhere in between?)</li>

<h2>Memory: Very limited responses so may not use.</h2>

<li>COGMEMDFF_A(MEMDIF) (Do you have difficulty remembering or concentrating?)</li>
<li>COGTYPEDFF_A(COGTYPE) (Is that a difficulty with remembering, concentrating, or both?)</li>
<li>COGFRQDFF_A(COGFRQ) (How often do you have difficulty remembering? Would you say sometimes, often, or all of the time?)</li>
<li>COGAMTDFF_A(COGAMOUNT) (Do you have difficulty remembering a few things, a lot of things, or almost everything?)</li>

</ul>

<h1>Steps:</h1>
<ol>
<li>☒Save copies of original data</li>
<li>☒Search for Field names in Codebook for Hypertension, Poverty, Stress/Anxiety</li>
<li>☒Search for Field names in common from both files for #2, Household ID, year, age, sex, health care, etc.</li>
<li>☒Definitions for common fields added to this report</li>
<li>☒Rename files and save</li>
<li>☒Create a Github Repo for Simulation 3 and publish with csv files.</li>
<li>☒Use AI to analyze data from the new Github Repo, write SQL queries and DAX formulas to transform the data and make Power BI report suggestions</li>
<li>☒Connect to SQL Server, create database, import csv’s</li>
<li>☒enter SQL queries to create views</li>
<li>☒Convert Codes to Descriptions for each field(Some in SQL Server and some in Power BI)</li>
<li>☒Connect from Power BI and create visualizations </li>
<li>☒Finish Report</li>

</ol>

  - Achieved Target: Those who are near or below the poverty line have a higher Comorbidity rate with Hypertension and Anxiety than those who are Middle or Higher income.
