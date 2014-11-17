#!/usr/bin/env python

import xlrd
import csv
from os import sys

def csv_from_excel(excel_file):
    log_excel(excel_file)
    workbook = xlrd.open_workbook(excel_file)

    all_worksheets = workbook.sheet_names()
    for worksheet_name in all_worksheets:
        worksheet = workbook.sheet_by_name(worksheet_name)

        outname = mk_sheet_fname(excel_file, worksheet_name)
        log_csv(outname)

        your_csv_file = open(outname, 'wb')
        wr = csv.writer(your_csv_file)  # , quoting=csv.QUOTE_ALL

        for rownum in xrange(worksheet.nrows):
            # originally created in Win Excel so output w/ Win encoding
            wr.writerow([unicode(entry).encode("windows-1252") for entry in worksheet.row_values(rownum)])

        your_csv_file.close()

def log_excel(excel_file):
    print("XLSX:\t{0}".format(excel_file))

def log_csv(excel_file):
    print("CSV:\t{0}".format(excel_file))

def mk_sheet_fname(fname, sheet, extension="csv"):
    parts = fname.split('.')
    base_parts = parts[0:-1]
    base_name = '.'.join(base_parts)
    return "{0}-{1}.{2}".format(base_name, sheet, extension)

if __name__ == "__main__":
    csv_from_excel(sys.argv[1])
