import pandas as pd

import dataset

# Replace 'file.csv' with the actual path to CSV file
csv_file_path = 'form_responses.csv'

# Read the CSV file using pandas
data = pd.read_csv(csv_file_path)

# Get the row count
row_count = len(data)

# Display the row count
print(f"Number of rows in the CSV: {row_count}")

# length of dataset.data_list1
print(len(dataset.data_list1))