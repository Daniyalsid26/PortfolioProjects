
WITH DerivedColumns AS (
    SELECT 
        [ONS Code (note 6)], 
		[ONS Geography (note 6)],
        [Fuel],
		[Keepership],
        [2022], 
        [2021], 
        [2020],
        ([2022 Q4] + [2022 Q3] + [2022 Q2] + [2022 Q1]) AS [Licensed Vehicles in 2022],
        ([2021 Q4] + [2021 Q3] + [2021 Q2] + [2021 Q1]) AS [Licensed Vehicles in 2021],
        ([2020 Q4] + [2020 Q3] + [2020 Q2] + [2020 Q1]) AS [Licensed Vehicles in 2020],
        [2022] / NULLIF(([2022 Q4] + [2022 Q3] + [2022 Q2] + [2022 Q1]), 0) AS [Charge Points per vehicle 2022],
        [2021] / NULLIF(([2021 Q4] + [2021 Q3] + [2021 Q2] + [2021 Q1]), 0) AS [Charge Points per vehicle 2021],
        [2020] / NULLIF(([2020 Q4] + [2020 Q3] + [2020 Q2] + [2020 Q1]), 0) AS [Charge Points per vehicle 2020]
    FROM Test..LicensedULEVByRegion AS ULEV 
    INNER JOIN Test..EVChargingPoints AS ChargingPoints
    ON ULEV.[ONS Code (note 6)] = ChargingPoints.[Local Authority / Region Code]
)

SELECT *,
    (([Licensed Vehicles in 2022] - [Licensed Vehicles in 2021]) / NULLIF([Licensed Vehicles in 2021], 0)) * 100 AS [Percentage Increase in Licensed Vehicles 2022-2021],
    (([Licensed Vehicles in 2021] - [Licensed Vehicles in 2020]) / NULLIF([Licensed Vehicles in 2020], 0)) * 100 AS [Percentage Increase in Licensed Vehicles 2021-2020],
    (([Charge Points per vehicle 2022] - [Charge Points per vehicle 2021]) / NULLIF([Charge Points per vehicle 2021], 0)) * 100 AS [Percentage Increase in Charge Points per Vehicle 2022-2021],
    (([Charge Points per vehicle 2021] - [Charge Points per vehicle 2020]) / NULLIF([Charge Points per vehicle 2020], 0)) * 100 AS [Percentage Increase in Charge Points per Vehicle 2021-2020]
FROM DerivedColumns
WHERE [Fuel] = 'Total' AND [Keepership] = 'Total' AND [ONS Code (note 6)] NOT IN ('K02000001') AND [ONS Code (note 6)] NOT IN ('K03000001') AND [ONS Code (note 6)] NOT IN ('E92000001') 

-- What is the region with the highest number of Electric Vehicles

WITH DerivedColumns AS (
    SELECT 
        [ONS Code (note 6)], 
		[ONS Geography (note 6)],
        [Fuel],
		[Keepership],
        [2022], 
        [2021], 
        [2020],
        ([2022 Q4] + [2022 Q3] + [2022 Q2] + [2022 Q1]) AS [Licensed Vehicles in 2022],
        ([2021 Q4] + [2021 Q3] + [2021 Q2] + [2021 Q1]) AS [Licensed Vehicles in 2021],
        ([2020 Q4] + [2020 Q3] + [2020 Q2] + [2020 Q1]) AS [Licensed Vehicles in 2020],
        [2022] / NULLIF(([2022 Q4] + [2022 Q3] + [2022 Q2] + [2022 Q1]), 0) AS [Charge Points per vehicle 2022],
        [2021] / NULLIF(([2021 Q4] + [2021 Q3] + [2021 Q2] + [2021 Q1]), 0) AS [Charge Points per vehicle 2021],
        [2020] / NULLIF(([2020 Q4] + [2020 Q3] + [2020 Q2] + [2020 Q1]), 0) AS [Charge Points per vehicle 2020]
    FROM Test..LicensedULEVByRegion AS ULEV 
    INNER JOIN Test..EVChargingPoints AS ChargingPoints
    ON ULEV.[ONS Code (note 6)] = ChargingPoints.[Local Authority / Region Code]
)
SELECT [ONS Geography (note 6)], [ONS Code (note 6)], [Licensed Vehicles in 2022]
FROM DerivedColumns
WHERE [Fuel] = 'Total' AND [Keepership] = 'Total' AND [ONS Code (note 6)] NOT IN ('K02000001') AND [ONS Code (note 6)] NOT IN ('K03000001') AND [ONS Code (note 6)] NOT IN ('E92000001') AND LEFT([ONS Code (note 6)], 2) <> 'E1' AND LEFT([ONS Code (note 6)], 2) <> 'S9'
ORDER BY [Licensed Vehicles in 2022] desc;


--what is the region with the highest number of charging points
select *
from Test..EVChargingPoints
where [Local Authority / Region Code] NOT IN ('K02000001') AND [Local Authority / Region Code] NOT IN ('K03000001') AND [Local Authority / Region Code] NOT IN ('E92000001')
ORDER BY [2022] desc;