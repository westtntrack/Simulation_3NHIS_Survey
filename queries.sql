-- Create a view for the 2022 data
CREATE VIEW vw_NHIS_2022 AS
SELECT *
FROM 
    adult22_Clean;
GO

-- Create a view for the 2022 data
CREATE VIEW vw_NHIS_2023 AS
SELECT *
FROM 
    adult23_Clean;
GO

-- Create a view for the 2023 data
CREATE VIEW vw_NHIS_Combined AS
SELECT 
   *,
    '2022' AS SurveyYear
FROM 
    adult22_Clean
UNION ALL
SELECT 
  *,
    '2023' AS SurveyYear
FROM 
    adult23_Clean;
GO

-- View for poverty ratio categories by year

CREATE VIEW vw_NHIS_Poverty_Analysis AS
SELECT
    SurveyYear,
    -- Create poverty categories for analysis
    CASE 
        WHEN POVRATIO < 1.0 THEN 'Below poverty line'
        WHEN POVRATIO BETWEEN 1.0 AND 1.99 THEN 'Near poverty'
        WHEN POVRATIO BETWEEN 2.0 AND 3.99 THEN 'Middle income'
        ELSE 'High income' 
    END AS PovertyCategory,
    AVG(POVRATIO) AS AvgPovertyRatio,
    AVG(INC_POV_RATIO) AS AvgIncPovRatio,
    COUNT(*) AS RespondentCount
FROM
    vw_NHIS_Combined
GROUP BY
    SurveyYear,
    CASE 
        WHEN POVRATIO < 1.0 THEN 'Below poverty line'
        WHEN POVRATIO BETWEEN 1.0 AND 1.99 THEN 'Near poverty'
        WHEN POVRATIO BETWEEN 2.0 AND 3.99 THEN 'Middle income'
        ELSE 'High income' 
    END;
GO

-- View for hypertension analysis by year
CREATE VIEW vw_NHIS_Hypertension_Analysis AS
SELECT
    SurveyYear,
    COUNT(*) AS TotalRespondents,
    -- HYPEV: Ever been told you had hypertension
    SUM(CASE WHEN HYPEV = 1 THEN 1 ELSE 0 END) AS HYPEV_Yes_Count,
    CAST(100.0 * SUM(CASE WHEN HYPEV = 1 THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS HYPEV_Yes_Percentage,
    -- HYP12M: Had hypertension in past 12 months
    SUM(CASE WHEN HYP12M = 1 THEN 1 ELSE 0 END) AS HYP12M_Yes_Count,
    CAST(100.0 * SUM(CASE WHEN HYP12M = 1 THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS HYP12M_Yes_Percentage,
    -- HYPDIF: Hypertension causing difficulty
    SUM(CASE WHEN HYPDIF = 1 THEN 1 ELSE 0 END) AS HYPDIF_Yes_Count,
    CAST(100.0 * SUM(CASE WHEN HYPDIF = 1 THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS HYPDIF_Yes_Percentage,
    -- HYPMED: Taking medication for hypertension
    SUM(CASE WHEN HYPMED = 1 THEN 1 ELSE 0 END) AS HYPMED_Yes_Count,
    CAST(100.0 * SUM(CASE WHEN HYPMED = 1 THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS HYPMED_Yes_Percentage,
    -- Medication rate among those with hypertension
    CASE 
        WHEN SUM(CASE WHEN HYPEV = 1 THEN 1 ELSE 0 END) > 0 
        THEN CAST(100.0 * SUM(CASE WHEN HYPMED = 1 THEN 1 ELSE 0 END) / 
                 SUM(CASE WHEN HYPEV = 1 THEN 1 ELSE 0 END) AS DECIMAL(5,2))
        ELSE 0
    END AS HYPMED_Among_Diagnosed_Percentage
FROM
    vw_NHIS_Combined
GROUP BY
    SurveyYear;
GO

-- View for anxiety analysis by year
CREATE VIEW vw_NHIS_Anxiety_Analysis AS
SELECT
    SurveyYear,
    COUNT(*) AS TotalRespondents,
    -- ANXDIAG: Ever been diagnosed with anxiety
    SUM(CASE WHEN ANXDIAG = 1 THEN 1 ELSE 0 END) AS ANXDIAG_Yes_Count,
    CAST(100.0 * SUM(CASE WHEN ANXDIAG = 1 THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS ANXDIAG_Yes_Percentage,
    -- ANXMED: Taking medication for anxiety
    SUM(CASE WHEN ANXMED = 1 THEN 1 ELSE 0 END) AS ANXMED_Yes_Count,
    CAST(100.0 * SUM(CASE WHEN ANXMED = 1 THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS ANXMED_Yes_Percentage,
    -- ANXFREQ: Frequency categories
    SUM(CASE WHEN ANXFREQ = 1 THEN 1 ELSE 0 END) AS ANXFREQ_Daily_Count,
    SUM(CASE WHEN ANXFREQ = 2 THEN 1 ELSE 0 END) AS ANXFREQ_Weekly_Count,
    SUM(CASE WHEN ANXFREQ = 3 THEN 1 ELSE 0 END) AS ANXFREQ_Monthly_Count,
    SUM(CASE WHEN ANXFREQ = 4 THEN 1 ELSE 0 END) AS ANXFREQ_Few_Times_Year_Count,
    -- ANXLEVEL: Anxiety level categories
    SUM(CASE WHEN ANXLEVEL = 1 THEN 1 ELSE 0 END) AS ANXLEVEL_Mild_Count,
    SUM(CASE WHEN ANXLEVEL = 2 THEN 1 ELSE 0 END) AS ANXLEVEL_Moderate_Count,
    SUM(CASE WHEN ANXLEVEL = 3 THEN 1 ELSE 0 END) AS ANXLEVEL_Severe_Count,
    -- Medication rate among those diagnosed with anxiety
    CASE 
        WHEN SUM(CASE WHEN ANXDIAG = 1 THEN 1 ELSE 0 END) > 0 
        THEN CAST(100.0 * SUM(CASE WHEN ANXMED = 1 THEN 1 ELSE 0 END) / 
                 SUM(CASE WHEN ANXDIAG = 1 THEN 1 ELSE 0 END) AS DECIMAL(5,2))
        ELSE 0
    END AS ANXMED_Among_Diagnosed_Percentage
FROM
    vw_NHIS_Combined
GROUP BY
    SurveyYear;
GO

-- View for poverty by demographics
CREATE VIEW vw_NHIS_Poverty_Demographics AS
SELECT
    SurveyYear,
    SEX,
    CASE 
        WHEN AGE < 18 THEN 'Under 18'
        WHEN AGE BETWEEN 18 AND 34 THEN '18-34'
        WHEN AGE BETWEEN 35 AND 49 THEN '35-49'
        WHEN AGE BETWEEN 50 AND 64 THEN '50-64'
        ELSE '65+' 
    END AS AgeGroup,
    RACE,
    REGION,
    AVG(POVRATIO) AS AvgPovertyRatio,
    AVG(INC_POV_RATIO) AS AvgIncPovRatio,
    COUNT(*) AS RespondentCount
FROM
    vw_NHIS_Combined
GROUP BY
    SurveyYear,
    SEX,
    CASE 
        WHEN AGE < 18 THEN 'Under 18'
        WHEN AGE BETWEEN 18 AND 34 THEN '18-34'
        WHEN AGE BETWEEN 35 AND 49 THEN '35-49'
        WHEN AGE BETWEEN 50 AND 64 THEN '50-64'
        ELSE '65+' 
    END,
    RACE,
    REGION;
GO

-- View for hypertension by demographics
CREATE VIEW vw_NHIS_Hypertension_Demographics AS
SELECT
    SurveyYear,
    SEX,
    CASE 
        WHEN AGE < 18 THEN 'Under 18'
        WHEN AGE BETWEEN 18 AND 34 THEN '18-34'
        WHEN AGE BETWEEN 35 AND 49 THEN '35-49'
        WHEN AGE BETWEEN 50 AND 64 THEN '50-64'
        ELSE '65+' 
    END AS AgeGroup,
    RACE,
    REGION,
    COUNT(*) AS TotalRespondents,
    SUM(CASE WHEN HYPEV = 1 THEN 1 ELSE 0 END) AS HYPEV_Yes_Count,
    CAST(100.0 * SUM(CASE WHEN HYPEV = 1 THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS HYPEV_Yes_Percentage,
    SUM(CASE WHEN HYPMED = 1 THEN 1 ELSE 0 END) AS HYPMED_Yes_Count,
    CAST(100.0 * SUM(CASE WHEN HYPMED = 1 THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS HYPMED_Yes_Percentage
FROM
    vw_NHIS_Combined
GROUP BY
    SurveyYear,
    SEX,
    CASE 
        WHEN AGE < 18 THEN 'Under 18'
        WHEN AGE BETWEEN 18 AND 34 THEN '18-34'
        WHEN AGE BETWEEN 35 AND 49 THEN '35-49'
        WHEN AGE BETWEEN 50 AND 64 THEN '50-64'
        ELSE '65+' 
    END,
    RACE,
    REGION;
GO

-- View for anxiety by demographics
CREATE VIEW vw_NHIS_Anxiety_Demographics AS
SELECT
    SurveyYear,
    SEX,
    CASE 
        WHEN AGE < 18 THEN 'Under 18'
        WHEN AGE BETWEEN 18 AND 34 THEN '18-34'
        WHEN AGE BETWEEN 35 AND 49 THEN '35-49'
        WHEN AGE BETWEEN 50 AND 64 THEN '50-64'
        ELSE '65+' 
    END AS AgeGroup,
    RACE,
    REGION,
    COUNT(*) AS TotalRespondents,
    SUM(CASE WHEN ANXDIAG = 1 THEN 1 ELSE 0 END) AS ANXDIAG_Yes_Count,
    CAST(100.0 * SUM(CASE WHEN ANXDIAG = 1 THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS ANXDIAG_Yes_Percentage,
    SUM(CASE WHEN ANXMED = 1 THEN 1 ELSE 0 END) AS ANXMED_Yes_Count,
    CAST(100.0 * SUM(CASE WHEN ANXMED = 1 THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS ANXMED_Yes_Percentage,
    -- Anxiety level distribution
    SUM(CASE WHEN ANXLEVEL = 1 THEN 1 ELSE 0 END) AS ANXLEVEL_Mild_Count,
    SUM(CASE WHEN ANXLEVEL = 2 THEN 1 ELSE 0 END) AS ANXLEVEL_Moderate_Count,
    SUM(CASE WHEN ANXLEVEL = 3 THEN 1 ELSE 0 END) AS ANXLEVEL_Severe_Count
FROM
    vw_NHIS_Combined
GROUP BY
    SurveyYear,
    SEX,
    CASE 
        WHEN AGE < 18 THEN 'Under 18'
        WHEN AGE BETWEEN 18 AND 34 THEN '18-34'
        WHEN AGE BETWEEN 35 AND 49 THEN '35-49'
        WHEN AGE BETWEEN 50 AND 64 THEN '50-64'
        ELSE '65+' 
    END,
    RACE,
    REGION;
GO

-- View for relationship between poverty, hypertension, and anxiety
CREATE VIEW vw_NHIS_Condition_Relationships AS
SELECT
    SurveyYear,
    CASE 
        WHEN POVRATIO < 1.0 THEN 'Below poverty line'
        WHEN POVRATIO BETWEEN 1.0 AND 1.99 THEN 'Near poverty'
        WHEN POVRATIO BETWEEN 2.0 AND 3.99 THEN 'Middle income'
        ELSE 'High income' 
    END AS PovertyCategory,
    COUNT(*) AS TotalRespondents,
    -- Hypertension rates by poverty category
    SUM(CASE WHEN HYPEV = 1 THEN 1 ELSE 0 END) AS HYPEV_Yes_Count,
    CAST(100.0 * SUM(CASE WHEN HYPEV = 1 THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS HYPEV_Yes_Percentage,
    -- Anxiety rates by poverty category
    SUM(CASE WHEN ANXDIAG = 1 THEN 1 ELSE 0 END) AS ANXDIAG_Yes_Count,
    CAST(100.0 * SUM(CASE WHEN ANXDIAG = 1 THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS ANXDIAG_Yes_Percentage,
    -- Comorbidity: Both hypertension and anxiety
    SUM(CASE WHEN HYPEV = 1 AND ANXDIAG = 1 THEN 1 ELSE 0 END) AS HYP_ANX_Comorbidity_Count,
    CAST(100.0 * SUM(CASE WHEN HYPEV = 1 AND ANXDIAG = 1 THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS HYP_ANX_Comorbidity_Percentage
FROM
    vw_NHIS_Combined
GROUP BY
    SurveyYear,
    CASE 
        WHEN POVRATIO < 1.0 THEN 'Below poverty line'
        WHEN POVRATIO BETWEEN 1.0 AND 1.99 THEN 'Near poverty'
        WHEN POVRATIO BETWEEN 2.0 AND 3.99 THEN 'Middle income'
        ELSE 'High income' 
    END;
GO

-- View for medication usage analysis
CREATE VIEW vw_NHIS_Medication_Analysis AS
SELECT
    SurveyYear,
    -- Hypertension medication analysis
    COUNT(CASE WHEN HYPEV = 1 THEN 1 END) AS Hypertension_Diagnosed_Count,
    SUM(CASE WHEN HYPEV = 1 AND HYPMED = 1 THEN 1 ELSE 0 END) AS Hypertension_On_Medication_Count,
    CAST(100.0 * SUM(CASE WHEN HYPEV = 1 AND HYPMED = 1 THEN 1 ELSE 0 END) / 
         NULLIF(COUNT(CASE WHEN HYPEV = 1 THEN 1 END), 0) AS DECIMAL(5,2)) AS Hypertension_Medication_Rate,
    -- Anxiety medication analysis
    COUNT(CASE WHEN ANXDIAG = 1 THEN 1 END) AS Anxiety_Diagnosed_Count,
    SUM(CASE WHEN ANXDIAG = 1 AND ANXMED = 1 THEN 1 ELSE 0 END) AS Anxiety_On_Medication_Count,
    CAST(100.0 * SUM(CASE WHEN ANXDIAG = 1 AND ANXMED = 1 THEN 1 ELSE 0 END) / 
         NULLIF(COUNT(CASE WHEN ANXDIAG = 1 THEN 1 END), 0) AS DECIMAL(5,2)) AS Anxiety_Medication_Rate,
    -- Combined medication analysis
    SUM(CASE WHEN HYPEV = 1 AND ANXDIAG = 1 AND HYPMED = 1 AND ANXMED = 1 THEN 1 ELSE 0 END) AS Both_Conditions_Both_Medications_Count
FROM
    vw_NHIS_Combined
GROUP BY
    SurveyYear;
GO

-- View for anxiety frequency and level analysis
CREATE VIEW vw_NHIS_Anxiety_Severity_Analysis AS
SELECT
    SurveyYear,
    -- Translate code values to descriptive labels
    CASE 
        WHEN ANXFREQ = 1 THEN 'Daily'
        WHEN ANXFREQ = 2 THEN 'Weekly'
        WHEN ANXFREQ = 3 THEN 'Monthly'
        WHEN ANXFREQ = 4 THEN 'Few times per year'
        ELSE 'Unknown'
    END AS AnxietyFrequency,
    CASE 
        WHEN ANXLEVEL = 1 THEN 'Mild'
        WHEN ANXLEVEL = 2 THEN 'Moderate'
        WHEN ANXLEVEL = 3 THEN 'Severe'
        ELSE 'Unknown'
    END AS AnxietyLevel,
    COUNT(*) AS RespondentCount,
    -- Medication rate by severity and frequency
    SUM(CASE WHEN ANXMED = 1 THEN 1 ELSE 0 END) AS Taking_Medication_Count,
    CAST(100.0 * SUM(CASE WHEN ANXMED = 1 THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(5,2)) AS Medication_Rate
FROM
    vw_NHIS_Combined
WHERE
    ANXDIAG = 1  -- Only include those diagnosed with anxiety
GROUP BY
    SurveyYear,
    CASE 
        WHEN ANXFREQ = 1 THEN 'Daily'
        WHEN ANXFREQ = 2 THEN 'Weekly'
        WHEN ANXFREQ = 3 THEN 'Monthly'
        WHEN ANXFREQ = 4 THEN 'Few times per year'
        ELSE 'Unknown'
    END,
    CASE 
        WHEN ANXLEVEL = 1 THEN 'Mild'
        WHEN ANXLEVEL = 2 THEN 'Moderate'
        WHEN ANXLEVEL = 3 THEN 'Severe'
        ELSE 'Unknown'
    END;
GO