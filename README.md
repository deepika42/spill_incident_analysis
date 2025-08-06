Spill Incident Analysis

Data Cleaning/Preprocessing - SQL (AWS RDS)/R/Python:

Upload raw dataset into S3/EC2 instance

Raw/Dirty Data --> Clean Data
** Change Dates into datetime format
** Select relevant columns
** Drop records with no spill date and select only dates after '1984-01-01'
** Waterbody - Remove Digits, Phone numbers, Special chars

Analysis:

NOIR Data Types
Nominal Data:
Street 1
Locality
County
Waterbody
Source
Contributing Factor
Material Name
Material Family
Units

Ordinal Data:
Spill Number

Interval Data:
Spill Date
Received Date
Close Date

Ratio Data:
Quantity
Recovered

Street 1 --> 
1 AIR NATIONAL GUARD 
                                                 1 
1 AIR NATIONAL GUARD RD 
                                               118 
1 AIR NATIONAL GUARD ROAD 
                                                 3 
1 AIR NATIONLA GUARD RD 
                                                 1

Locality -->
NIAGARA, NAIGARA
NIAGARA FALLS, NIAGRA FALLS
WATERVLIET
ALBANY(many) & ALBANY NY(only 2 records)
ALBANY  COLONIE

FORT EDWARD , FT EDWARD, FT. EDWARD

Change UNKNOWN value in Locality column to BLANK

Waterbody 
Unknown creek --> CREEK, UNK POND --> POND
Converting NONE to blank

Source with data 'Missing Code in Old Data - Must be fixed' should be removed as it does not not provide meaningful information and could potentially skew any analysis or modeling

Some records have data containing quantity but no corresponding units (Limitations)

Visualization:

1. How has the frequency and severity of spills of petroleum and hazardous materials evolved over the years, and are there specific patterns (or factors) associated with a higher incidence of spills?

2. When is the peak time for most industrial spills? Where do the large spills come from? Which types of materials are the most commonly spilled?

3. What are the primary contributing factors? Is there any correlation between these factors and sources of origin?

4. Are there any specific regions (counties or localities) more prone to spilling incidents?

5. How often do spills affect water bodies, and are there specific water bodies more frequently impacted by hazardous material spills?

6. What is the average time between spill occurrence and reporting, and how promptly are spills typically resolved?

Results/Interpretation: 
Value ? So What?
Decline in petroleum spills since 1990, with #2 fuel oil, gasoline, and diesel being the most commonly spilled materials. 
August is a critical period characterized by a surge in spill incidents across various categories. 
Commercial and industrial facilities are identified as the primary sources of spills, with equipment failure being the leading contributing factor. 
Private dwellings have unknown causes as the primary contributing factor, followed by deliberate spills. Human error and traffic accidents also contribute significantly to spill occurrences.
The localities of Westchester County in New York such as Jamaica Bay, Yonkers, White Plains, and New Rochelle are frequently affected by spills. Brooklyn records the highest number of spills.
The Hudson River experiences the largest spill encounter, with other water bodies such as creeks, ponds, lakes, and bays also affected.
Positive trends in reporting and resolution times reflect upon improved responsiveness and efficiency in addressing spill incidents. 