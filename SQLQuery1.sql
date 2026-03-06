--Cleaning data in SQL queries
--......

-- 1. Standardize data format

SELECT SaleDateConverted, Convert(Date,SaleDate)as date FROM NashvilleHousing



Alter Table NashvilleHousing
add SaleDateConverted Date;

update [NashvilleHousing ]
Set SaleDateConverted = Convert(Date,SaleDate)


-- 2. populate property address data

SELECT * FROM NashvilleHousing
Where PropertyAddress is null
order by ParcelID

SELECT * FROM NashvilleHousing a
Join NashvilleHousing b
On a.ParcelID = b.ParcelID
and a.UniqueID <> b.UniqueID




