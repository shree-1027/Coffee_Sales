import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# Load data
data = pd.read_excel("C:/Users/admin/OneDrive/Desktop/coffee_sales.xlsx")

# Preview data
print(data.head())

# Check for null values in each column
print("Total missing values in dataset:", data.isnull().sum().sum())

# Convert 'Date' to datetime, ensuring day-first format
data['Date'] = pd.to_datetime(data['Date'], dayfirst=True)

# Extract the weekday name
#data['weekday_name'] = data['Date'].dt.day_name()

# Convert Date to 'dd-mm-yyyy' format (as string)
data['Date'] = data['Date'].dt.strftime('%d-%m-%Y')

# Remove decimal values by converting to integer (this is the critical change)
data['Money'] = data['Money'].astype(int)
data['Total Amount'] = data['Total Amount'].astype(int)
data['Final Amount'] = data['Final Amount'].astype(int)

# Replace 'Returning' with 'Old' in 'Customer Type' column
data['Customer Type'] = data['Customer Type'].replace('Returning', 'Old')

# Save the updated file with a new name
data.to_excel("C:/Users/admin/OneDrive/Desktop/coffee_sales_updated.xlsx", index=False)

# Print the updated data (optional)
print(data.head())
