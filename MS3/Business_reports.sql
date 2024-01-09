/*
1. Farm Productivity Overview:
This view aggregates essential farm productivity metrics, including crop yield, 
costs, and revenues per surface area. Businesses can use this to compare the 
performance of different farms, assess profitability, and identify high-performing
crops.
*/
CREATE VIEW farm_productivity AS
SELECT 
    f.farmID,
    f.productiveSurface,
    c.cropName,
    b.targetYield,
    b.costPerSurf,
    b.revenuePerSurf,
    b.yieldPerSurf
FROM farm f
JOIN farm_crop_bridge b ON f.farmID = b.farmID
JOIN crop c ON b.cropID = c.cropID;


/*
2. Farmer Details with Contact:
This view combines farmer details with their location information. It helps in 
communication, allows businesses to understand the geographical spread of farmers,
and facilitates targeted support or engagement strategies.
*/
CREATE VIEW farmer_contact AS
SELECT 
    f.farmerID,
    f.firstName || ' ' ||  f.lastName AS "farmerName",
    f.phoneNumber,
    l.cityOrDistrict,
    l.provinceOrTerritory
FROM farmer f
JOIN farm fa ON f.farmerID = fa.farmerID
JOIN growingZone g ON fa.growingZoneID = g.growingZoneID
JOIN location l ON g.locationID = l.locationID;


/*
3. Crop Suitability Analysis:
This view helps in suggesting which crops are suitable for cultivation in 
specific growing zones, reducing the risk of crop failure and ensuring optimal 
crop growth.
*/
CREATE VIEW Crop_Suitability_Analysis AS
SELECT 
    c.cropID,
    c.cropName,
    s.speciesID,
    s.requiredChillHours,
    s.requiredWaterAvailability,
    s.requiredSoilQuality,
    gz.growingZoneID
FROM crop c
JOIN species s ON c.speciesID = s.speciesID
JOIN farm_crop_bridge fcb ON c.cropID = fcb.cropID
JOIN farm f ON fcb.farmID = f.farmID
JOIN growingZone gz ON f.growingZoneID = gz.growingZoneID
WHERE s.requiredChillHours <= gz.chillHours 
    AND s.requiredWaterAvailability <= gz.waterAvailability 
    AND s.requiredSoilQuality = gz.soilQuality;




/*
4. Species Requirements Overview:
 This view lists the specific requirements of different crop species. It assists
 businesses in understanding the needs of each crop, allowing better matching 
 with suitable growing zones and optimizing crop growth conditions.
*/
CREATE VIEW species_requirements AS
SELECT 
    s.speciesID,
    s.speciesName,
    s.requiredChillHours,
    s.requiredWaterAvailability,
    s.requiredSoilQuality
FROM species s;

