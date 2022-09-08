--DATA CLEANING

select* 
from [Portfolio Project]..Nashville_Housing




--STANDARDIZE DATE FORMAT


select saledate
from [Portfolio Project]..Nashville_Housing

select saledate, convert(date,saledate) as SaleDateconverted
from [Portfolio Project]..Nashville_Housing

Alter table [Portfolio Project]..Nashville_Housing
add SaleDateConverted date;

update [Portfolio Project]..Nashville_Housing
set SaleDateConverted = convert(date,saledate)





--POPULATNG PROPERTY ADDRESS DATA


Select propertyaddress
from [Portfolio Project]..Nashville_Housing

Select propertyaddress
from [Portfolio Project]..Nashville_Housing
where propertyaddress is null

--observation-whereever the parccelid is same the propertyaddress is same

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress , ISNULL(a.PropertyAddress, b.PropertyAddress)
from [Portfolio Project]..Nashville_Housing a
JOIN [Portfolio Project]..Nashville_Housing b
   ON a.parcelid = b.parcelid
   and a.[UniqueID ] <> b.[UniqueID ]
   where a.PropertyAddress is null


   update a
   set a.propertyaddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
   from [Portfolio Project]..Nashville_Housing a
   JOIN [Portfolio Project]..Nashville_Housing b
   ON a.parcelid = b.parcelid
   and a.[UniqueID ] <> b.[UniqueID ]
   where a.PropertyAddress is null




   --BREAKING OUT ADDRESS INTO INDIVIDUAL COLUMNS (ADDRESS, CITY, STATE)

   --Property Address


Select propertyaddress
from [Portfolio Project]..Nashville_Housing

select 
SUBSTRING(propertyaddress, 1, CHARINDEX(',', propertyaddress)-1),
SUBSTRING(propertyaddress, CHARINDEX(',', propertyaddress)+1 , len(propertyaddress))
from [Portfolio Project]..Nashville_Housing


Alter table [Portfolio Project]..Nashville_Housing
add PropertSplitAddress varchar(255)

update [Portfolio Project]..Nashville_Housing
set PropertSplitAddress = SUBSTRING(propertyaddress, 1, CHARINDEX(',', propertyaddress)-1)

Alter table [Portfolio Project]..Nashville_Housing
add PropertSplitCity varchar(255)

update [Portfolio Project]..Nashville_Housing
set PropertSplitCity = SUBSTRING(propertyaddress, CHARINDEX(',', propertyaddress)+1 , len(propertyaddress))

select *
from [Portfolio Project]..Nashville_Housing



--Owner Address


Select *
from [Portfolio Project]..Nashville_Housing

select OwnerAddress
from [Portfolio Project]..Nashville_Housing

select 
PARSENAME(REPLACE(owneraddress, ',' , '.'), 3),
PARSENAME(REPLACE(owneraddress, ',' , '.'), 2),
PARSENAME(REPLACE(owneraddress, ',' , '.'), 1)
from [Portfolio Project]..Nashville_Housing


ALTER table [Portfolio Project]..Nashville_Housing
Add OwnerSplitAddress varchar(255),
    OwnerSplitCity varchar(255),
	OwnerSplitState varchar(255)


Update [Portfolio Project]..Nashville_Housing
set  OwnerSplitAddress =  PARSENAME(REPLACE(owneraddress, ',' , '.'), 3),
     OwnerSplitCity    =  PARSENAME(REPLACE(owneraddress, ',' , '.'), 2),
     OwnerSplitState   =  PARSENAME(REPLACE(owneraddress, ',' , '.'), 1)




-- CHANGE 'Y and N' to 'Yes and No' in 'SoldAsVacant' FIELD 


SELECT DISTINCT(SoldAsVacant), count(SoldAsVacant)
from [Portfolio Project]..Nashville_Housing
group by SoldAsVacant
order by 2


 SELECT SoldAsVacant,
 CASE when SoldAsVacant = 'Y' then 'Yes'
      when SoldAsVacant = 'N' then 'No'
      Else SoldAsVacant
      End
from [Portfolio Project]..Nashville_Housing


Update [Portfolio Project]..Nashville_Housing
set SoldAsVacant = CASE when SoldAsVacant = 'Y' then 'Yes'
                        when SoldAsVacant = 'N' then 'No'
                        Else SoldAsVacant
                        End








-- DELETING UNUSED COLUMNS

ALTER TABLE [Portfolio Project]..Nashville_Housing
drop column owneraddress, taxdistrict, propertyaddress

select* 
from [Portfolio Project]..Nashville_Housing
            