import xlrd
import os
import sqlite3

# List of year/quarter folder names
folder_list = ['2022_q2', '2022_q3', '2022_q4', '2023_q1']

# Full path to xls, including filename
xls_path = 'Top_100_Contractors_Report_Fiscal_Year_2015.xls'

# Read in the xls file
contractors_file = xlrd.open_workbook_xls(xls_path)

# Get the total number of sheets in the index file
contractor_sheet_list = contractors_file.sheets()

'''
**********************************************
                    BACKUP
**********************************************
'''

# Filter and save only departments
department_dict = {}

# Populate department_dict, checking to see if the sheet is a contractor
print('The following departments are being processed..')
for c in contractor_sheet_list:
    c_name = c.name
    if c_name.rfind('00)') != -1:
        department_dict[c_name] = c
        print(c_name)
        
# Find the unique contractors contained in all of the sheets.
contractor_list = []
for dept_name in department_dict:
    cur_sheet = department_dict[dept_name]
    
    # Get the column names, excluding the heading
    cur_sheet_dept = cur_sheet.col_values(0)[1:]
    
    # Only add the contractor to the "contractor_list" if it doesn't already exist there
    for contractor in cur_sheet_dept:
        contractor = contractor.replace('''\'''', '')
        contractor = contractor.replace('''\"''', '')
        if contractor not in contractor_list:
            contractor_list.append(contractor)
            
# Connect to SQLITE database, and update the "contractors" table
database_path = './contracts.db'
con = sqlite3.connect(database_path)
cur = con.cursor()

# Update the database to include each contractor
contractor_id = 1
for contractor in contractor_list:
    contractor_str =f'''{contractor_id}, \'{contractor}\''''
    command_str = f'''INSERT INTO contractors VALUES({contractor_str});'''
    cur.execute(command_str)
    con.commit()
    contractor_id+=1
    
# Check to see if it worked
cur.execute('SELECT * FROM contractors')
contractor_1 = cur.fetchone()
print(f'id: {contractor_1[0]}, global_vendor_name: {contractor_1[1]}')

'''
department: dept_name
actions: col 1
dollars: col 2
contractor_id (Foreign key)
'''
#query = f'''SELECT contractors.id FROM contractors WHERE global_vendor_name== {contractor_name} '''

actions_id = 1
for dept_name in department_dict:
    cur_sheet = department_dict[dept_name]
    
    # Get the column names, excluding the heading
    contractor_list = cur_sheet.col_values(0)[1:]
    actions_list = cur_sheet.col_values(1)[1:]
    dollars_list = cur_sheet.col_values(2)[1:]
    
    # Iterate through the lists
    for ind in range(0, len(contractor_list)):
        # Edit the format of the contractor string from the sheet to match contractor table
        contractor = contractor_list[ind]
        contractor = contractor.replace('''\'''', '')
        contractor = contractor.replace('''\"''', '')
        
        # Get contractor ID from the "contractors" table
        query = f'''SELECT contractors.id FROM contractors WHERE global_vendor_name== \'{contractor}\' '''
        cur.execute(query)
        contractor_id = cur.fetchone()[0]
        
        # Get actions and dollars values
        actions = actions_list[ind]
        dollars = dollars_list[ind]
        
        action_str = f'''{actions_id}, \'{dept_name}\', {actions}, {dollars}, {contractor_id}'''
        command_str = f'''INSERT INTO actions VALUES({action_str});'''
        cur.execute(command_str)
        con.commit()
        
        actions_id+=1

# Double check that our database was updated properly
query = '''SELECT * FROM actions'''
cur.execute(query)
r = cur.fetchall()

print('Veryifying actions table update, checking some table values...')
for s in r[0:2000:250]:
    print(s)
print('\n')

con.close()
