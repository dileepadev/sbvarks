import csv

import dataset

# List of data for the form
data_list = dataset.combined_data_list

# Name of the CSV file to save
csv_filename = "form_responses.csv"

# Extracting question names as fieldnames
fieldnames = [
    "How did you feel during the activity?",
    "What are your thoughts or comments about the activity?"
]

# Writing data to CSV
with open(csv_filename, mode='w', newline='', encoding='utf-8') as csv_file:
    writer = csv.DictWriter(csv_file, fieldnames=fieldnames)

    writer.writeheader()
    for row in data_list:
        writer.writerow(row)

print(f"Data saved to {csv_filename}")

# csv file row count
with open(csv_filename, 'r', encoding='utf-8') as csv_file:
    csv_reader = csv.DictReader(csv_file)
    row_count = len(list(csv_reader))

print(f"Number of rows in the CSV: {row_count}")
