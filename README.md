# Overview-of-Environmental-Protection-Expenditures-2006-2024

# Project Background

Environmental protection expenditures reflect government priorities in addressing key ecological challenges such as air quality, water management, waste treatment, and climate-related initiatives.

This project analyzes official data from the Czech Statistical Office (https://csu.gov.cz/domov) to examine how environmental funds are allocated across regions, programs, and expenditure types over time. Using SQL-based data transformation and an interactive dashboard, the analysis explores spending structure, regional distribution, and year-over-year dynamics.

Key analysis questions:

Budget Allocation and Structure:
  * How have **total environmental protection expenditures** evolved over time?
  * Which environmental programs receive the **largest** share of funding?
  * How is the budget distributed across **different expenditure types** (investment vs. non-investment)?

Regional Distribution:
  * Which regions receive the **highest** and **lowest** levels of funding?
  * How has **regional allocation changed** year-over-year?

Expenditure Types Distribution:
  * What proportion of total spending is allocated to investment projects?
  * Which sector is the main sponsor of environmental protection activities?

An interactive **Power BI dashboard** used in this project can be found [here](https://app.powerbi.com/view?r=eyJrIjoiMTExYzZjYWUtNTNmYy00YjIwLWFhN2MtY2RmM2ZiM2Q1Y2ZmIiwidCI6ImUwMGRkY2RmLTFlMGYtNGJlNS1hMzdhLTg5NGE0NzMxOTg2YSIsImMiOjh9).

# Data Structure and Overview

The data was obtained from the web page of the Czech Statistical Office, the link to the exact page is given [here](https://csu.gov.cz/produkty/naklady-na-ochranu-zivotniho-prostredi-a-ekonomicky-prinos-techto-aktivit). Besides the dataset, official page provides a dataset documentation with a description of specific columns and links to dimensional tables (it can be found in the attachments under the name "info_czech.docx" or through the link above) .

To facilitate the perception of the project for English-speaking users, some data documents (folder "raw data" => "czech") that do not contain an English translation were translated into English using **python script** ("data_translate.ipybn").

The dataset structure consists of five tables: *dnn_cis_eng, ozp_cis_eng, sector_cis_eng, stapro, eco_expenses* with the *eco_expenses* as the main table containing **21006 rows**. The data model with names of columns and data types is:

<img width="1278" height="1138" alt="image" src="https://github.com/user-attachments/assets/bbb9541c-71e6-4c25-9cec-1db623804a95" />

<br>
<br>

Dimensional tables overview:

 * *dnn_cis_eng* contains data about the character of non-investment expenses.

 * *ozp_cis_eng* contains data about names of environmental protection programs.

 * *sector_cis_eng* contains data about sponsors.

 * *stapro* contains data about types of expenses.

After uploading mentioned dataset into pgAdmin data were processed using **PostgreSQL** ("eco_tables.sql") resulting in six **csv files** (folder "clean data").

# Executive Summary

Environmental protection expenditures grew from **CZK 439 million** in 2006 to **CZK 1.6 billion** in 2024, indicating a **substantial increase** in investments and prioritization of environmental initiatives. **Waste Management and Wastewater Management dominate funding**, reflecting a current focus on managing and treating waste over other environmental programs. Most spending is **operational** and heavily supported by **non-financial enterprises**, highlighting reliance on private-sector contributions. Some programs, particularly **Research and Development and Noise Reduction**, show **high volatility**, suggesting challenges in maintaining consistent long-term funding, especially in the field of **Radiation Protection with its extreme spikes in funding changes**. Regionally, **Prague** receives the **largest share**, while **Karlovy Vary Region** has the **least funding**, but **many expenditures are unassigned**, signaling limitations in assessing true regional allocation.

# Insights 

**1. Expenditures Evolution**

Over the observed period, annual expenditures demonstrated a consistent upward trend, reaching a cumulative total of **CZK 18 billion**. In 2006, annual spending amounted to **CZK 439 million**, whereas by 2024 it had increased to **CZK 1.6 billion**. This represents an approximate 368% increase, highlighting a **substantial expansion in investments** dedicated to environmental protection.

Part of the increase may reflect inflation, regulatory changes, or expanded program scope rather than purely intensified policy focus.Overall, the trend points toward sustained expansion of environmental investment, implying increased institutional and financial commitment to the sector.

<img width="626" height="184" alt="image" src="https://github.com/user-attachments/assets/c367020b-b94e-4ab9-9e99-c8210fa3ec15" />

<img width="295" height="93" alt="image" src="https://github.com/user-attachments/assets/6d879d1b-9b5d-4033-983b-366c9229a5b4" />

<br>
<br>

The majority of expenditures consisted of **non-investment (operational) expenses**, with this pattern remaining consistent throughout the entire period under review. Furthermore, across all years, the **largest share** of spending within the sector* related to **non-financial enterprises**, which accounted for **63.12%** of total expenditures.

The persistent dominance of non-investment (operational) expenditures suggests that funding is primarily directed toward maintaining existing systems rather than expanding or modernizing infrastructure. While operational stability is essential, a relatively low proportion of capital investment may limit long-term structural improvements. Additionally, the fact that non-financial enterprises account for over 63% of total expenditures highlights the significant role of the private sector in environmental financing.

<img width="600" height="151" alt="image" src="https://github.com/user-attachments/assets/7465324e-7504-4220-a20a-c287ff2fcc84" />

<img width="440" height="427" alt="image" src="https://github.com/user-attachments/assets/edf0d5e6-49e8-4c36-a00e-3064763b684c" />
**most of transactions does not have the source sector*

<br>
<br>

**2. Programs Expenditures**

The **most highly funded** program overall was **Waste Management**, with total expenditures amounting to **CZK 5.2 billion**. This figure is more than double that of the **second most funded** program, **Wastewater Management**, which received **CZK 2.0 billion**. **Air and Climate Protection** ranked **third**, with total expenditures of **CZK 0.9 billion**.

The clear prioritization of Waste Management and Wastewater Management over other programs suggests that waste-related issues represent either the most urgent environmental challenge or the most capital-intensive area within the sector. 

<img width="902" height="275" alt="image" src="https://github.com/user-attachments/assets/3e31df41-d61f-4f37-9089-6f87727efcbc" />

<br>
<br>

The **most pronounced fluctuations** in expenditure over the observed years were recorded in three programs: **Limitation of Noise and Vibration, Research and Development for Environmental Protection, and Other Environmental Activities**. In certain years, these programs experienced changes **exceeding 200%**, indicating **substantial variability** in financing levels.

<img width="613" height="281" alt="image" src="https://github.com/user-attachments/assets/b10701ba-3d27-4d68-83c5-a157bf7db664" />

<br>
<br>

An exception was **Radiation Protection**, which exhibited the **most extreme volatility** in expenditures among all programs, reaching an **extraordinary 29192%** increase in 2010.
Further examination revealed that this apparent anomaly was driven by very low total expenses that year: official expenditures in 2009 amounted to only **CZK 4,932**, while in 2010 spending increased to **CZK 1,444,683**. Consequently, the exceptionally high growth rates compared to the previous year reflect a lack of spending in a particular year, rather than a structurally significant increase in financing.

<img width="597" height="260" alt="image" src="https://github.com/user-attachments/assets/b73f8815-9a95-49c0-bce0-46b63644c055" />

<img width="477" height="89" alt="image" src="https://github.com/user-attachments/assets/c67c2809-6ad5-41c2-ac08-0774c6feecff" />

<br>
<br>

**3. Regional Expenditures Evaluation**

As illustrated in the map below (white indicating the lowest funding and dark green the highest), **Prague (Hlavní město Praha)** received the **highest** level of funding, whereas  **Karlovy Vary Region (Karlovarský kraj)** recorded the **lowest** environmental expenditures. Total spending in Prague amounted to approximately **CZK 2 billion**, compared to **CZK 147.5 million** in the Karlovy Vary Region.

The concentration of environmental expenditures in Prague may reflect the presence of large-scale infrastructure projects, higher population density, or centralized administrative allocations. Conversely, lower spending in smaller regions such as the Karlovy Vary Region does not necessarily imply lower environmental need.

<img width="397" height="264" alt="image" src="https://github.com/user-attachments/assets/580628dc-64f4-4ad5-a88f-25a1dfed913e" />

<img width="268" height="57" alt="image" src="https://github.com/user-attachments/assets/0f314b04-1e83-495a-83e7-007a12d8236b" />

<img width="252" height="58" alt="image" src="https://github.com/user-attachments/assets/02c7d622-dd1e-41a4-a89f-ed54f2640dd6" />

<br>
<br>

However, a substantial proportion of expenditures was not allocated to a specific region, which complicates an accurate assessment of the true regional distribution of funds. This fact limits the reliability of conclusions regarding regional distribution, so regional comparisons may be incomplete or potentially distorted.

<img width="407" height="70" alt="image" src="https://github.com/user-attachments/assets/70110bdb-b7e2-474a-be7b-41360a519feb" />

<br>
<br>

# Challenges:

The main challenge in processing the dataset was the lack of complete metadata for many transactions, as a large portion of records were missing at least one key attribute, such as regional, programmatic, or other relevant characteristics. As a result, these attributes were analyzed separately rather than being combined in a single unified analysis.
   

