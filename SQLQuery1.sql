--Cleaning data in SQL queries
--......

-- 1.. Standardize data format

SELECT SaleDateConverted, Convert(Date,SaleDate)as date FROM NashvilleHousing



Alter Table NashvilleHousing
add SaleDateConverted Date;

update [NashvilleHousing ]
Set SaleDateConverted = Convert(Date,SaleDate)


-- 2. populate property address dataa

SELECT * FROM NashvilleHousing
Where PropertyAddress is null
order by ParcelID

SELECT a.ParcelID, a.PropertyAddress,b.parcelID, b.PropertyAddress, isnull(a.PropertyAddress,b.PropertyAddress)
FROM NashvilleHousing a
Join NashvilleHousing b
On a.ParcelID = b.ParcelID
and a.UniqueID <> b.UniqueID
where a.PropertyAddress is null

Update a
Set PropertyAddress = isnull(a.PropertyAddress,b.PropertyAddress)
FROM NashvilleHousing a
Join NashvilleHousing b
On a.ParcelID = b.ParcelID
and a.UniqueID <> b.UniqueID
where a.PropertyAddress is null

--............

-- 3. Breaking out into seprate columns(Address, city, state)

SELECT * FROM NashvilleHousing

Select SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1) as Address
Select SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)) + 1 , LEN(PropertyAddress)) as Address
FROM NashvilleHousing

Alter Table NashvilleHousing
add PropertySplitAddress nvarchar(255);

update [NashvilleHousing ]
Set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1)

Alter Table NashvilleHousing
add PropertySplitCity nvarchar(255);

update [NashvilleHousing ]
Set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))


Select OwnerAddress From NashvilleHousing 

Select PARSENAME(Replace(OwnerAddress, ',' , '.'),3),
PARSENAME(Replace(OwnerAddress, ',' , '.'),2),
PARSENAME(Replace(OwnerAddress, ',' , '.'),1)
From NashvilleHousing


Alter Table NashvilleHousing
add OwnerSplitAddress nvarchar(255);

update [NashvilleHousing ]
Set OwnerSplitAddress = PARSENAME(Replace(OwnerAddress, ',' , '.'),3)

Alter Table NashvilleHousing
add OwnerSplitCity nvarchar(255);

update [NashvilleHousing ]
Set OwnerSplitCity = PARSENAME(Replace(OwnerAddress, ',' , '.'),2)

Alter Table NashvilleHousing
add OwnerSplitState nvarchar(255);

update [NashvilleHousing ]
Set OwnerSplitState = PARSENAME(Replace(OwnerAddress, ',' , '.'),1)

--......................

-- Change Y and N to Yes and NO in "Sold as vacant" field

Select Distinct(SoldAsVacant),Count(SoldAsVacant)
From NashvilleHousing
Group by SoldAsVacant
order by 2