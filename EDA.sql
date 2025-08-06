select * from spillincidents.spills limit 10;

-- Number of spills based on contributing factors
SELECT `Contributing Factor` AS ContributingFactor, COUNT(*) AS Spill_Frequency
FROM spillincidents.spills
GROUP BY ContributingFactor
ORDER BY Spill_Frequency DESC;

-- Number of materials spilled on a particular incident identified by the Spill Number
SELECT `Spill Number` AS SpillNumber, count(`Material Name`) AS noOfMaterialsSpilled 
FROM spillincidents.spills
GROUP BY SpillNumber
ORDER BY noOfMaterialsSpilled desc;

-- Total quantity of each material spilled (Quantity : Numeric, Ratio Data)
SELECT `Material Name` AS MaterialName, SUM(Quantity) AS Total_Quantity
FROM spillincidents.spills
GROUP BY MaterialName
ORDER BY Total_Quantity DESC;

-- Spills that were received before they occurred
SELECT count(*)
-- `Spill Number`, `Spill Date` AS SpillDate, `Received Date` AS ReceivedDate
FROM spillincidents.spills
WHERE `Spill Date` > `Received Date`
LIMIT 50000;
-- count(*) = '1678'

-- Spills that were closed before they occurred
SELECT count(*)
-- `Spill Number`, `Spill Date` AS SpillDate, `Received Date` AS ReceivedDate
FROM spillincidents.spills
WHERE `Spill Date` > `Close Date`
LIMIT 50000;
-- count(*) = '6181'

-- Spills that were closed on the same day they occurred
SELECT `Spill Number`, `Spill Date` AS SpillDate, `Close Date` AS CloseDate
FROM spillincidents.spills
WHERE `Spill Date` = `Close Date`
LIMIT 50000;





