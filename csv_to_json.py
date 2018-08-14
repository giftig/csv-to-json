#!/usr/bin/env python2.7
import argparse
import csv
import json
import sys


def convert_file(input_file, output_file):
    with open(input_file, 'rb') as fin:
        data = csv.reader(fin)
        headers = data.next()

        with open(output_file, 'wb') as fout:
            for record in data:
                fout.write(json.dumps(dict(zip(headers, record))) + '\n')


def main():
    parser = argparse.ArgumentParser('csv_to_json')
    parser.add_argument(
        '-i', dest='input', help='Input file, with headers'
    )
    parser.add_argument(
        '-o', dest='output', help='Output file (will be overidden)'
    )
    args = parser.parse_args()

    return convert_file(args.input, args.output)


if __name__ == '__main__':
    main()
