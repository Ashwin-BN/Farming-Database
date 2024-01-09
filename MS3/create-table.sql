--CREATE location TABLE
CREATE TABLE location
(
    locationID NUMBER(38),
    provinceOrTerritory CHAR(25),
    cityOrDistrict CHAR(25),
    CONSTRAINT location_PK PRIMARY KEY(locationID)
);

--CREATE growinZone TABLE
CREATE TABLE growingZone
(
    growingZoneID NUMBER(38),
    locationID NUMBER(38),
    chillHours NUMBER(4),
    waterAvailability CHAR(25),
    soilQuality CHAR(25),
    CONSTRAINT growingZone_PK PRIMARY KEY(growingZoneID),
    CONSTRAINT growingZone_location_FK FOREIGN KEY(locationID) REFERENCES location(locationID)
);

--CREATE farmer TABLE
CREATE TABLE farmer
(
    farmerID NUMBER(38),
    lastName VARCHAR2(50) NOT NULL,
    firstName VARCHAR2(50),
    phoneNumber NUMBER(10),
    CONSTRAINT farmer_PK PRIMARY KEY(farmerID)
);

-- CREATE species TABLE
CREATE TABLE species
(
    speciesID NUMBER(38),
    speciesName VARCHAR2(50) NOT NULL, 
    requiredChillHours NUMBER(4),
    requiredWaterAvailability CHAR(25),
    requiredSoilQuality CHAR(25),
    CONSTRAINT species_PK PRIMARY KEY(speciesID)
);

-- CREATE farm TABLE
CREATE TABLE farm
(
    farmID NUMBER(38),
    growingZoneID NUMBER(38),
    farmerID NUMBER(38),
    productiveSurface NUMBER(7,0),
    CONSTRAINT farm_PK PRIMARY KEY(farmID),
    CONSTRAINT farm_farmer_FK FOREIGN KEY(farmerID) REFERENCES farmer(farmerID),
    CONSTRAINT farm_growingZone_FK FOREIGN KEY(growingZoneID) REFERENCES growingZone(growingZoneID)
);

-- CREATE crop TABLE
CREATE TABLE crop
(
    cropID NUMBER(38),
    speciesID NUMBER(38),
    cropName VARCHAR2(50) NOT NULL,
    CONSTRAINT crop_PK PRIMARY KEY(cropID),
    CONSTRAINT crop_species_FK FOREIGN KEY(speciesID) REFERENCES species(speciesID)
); 

-- CREATE farm_crop_bridge TABLE
CREATE TABLE farm_crop_bridge
(
    farmID NUMBER(38),
    cropID NUMBER(38),
    targetYield NUMBER(5,2),
    costPerSurf NUMBER(7,2),
    revenuePerSurf NUMBER(7,2),
    yieldPerSurf NUMBER(5,2),
    CONSTRAINT farm_crop_PK PRIMARY KEY(farmID,cropID),
    CONSTRAINT farm_crop_farm_FK FOREIGN KEY(farmID) REFERENCES farm(farmID),
    CONSTRAINT farm_crop_crop_FK FOREIGN KEY(cropID) REFERENCES crop(cropID)
);

