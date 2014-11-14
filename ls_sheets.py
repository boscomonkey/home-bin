#!/usr/bin/env python

import xlrd
import csv
from os import sys

def csv_from_excel(excel_file):
    workbook = xlrd.open_workbook(excel_file)
    all_worksheets = workbook.sheet_names()
    for worksheet_name in all_worksheets:
        print worksheet_name

if __name__ == "__main__":
    csv_from_excel(sys.argv[1])
