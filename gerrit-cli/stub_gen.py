#!/usr/bin/env python3

""" Stub generator for lint checking for python. """

import json

class Parser:
    def __init__(self, data):
        self.__dict__ = json.loads(data)

def write_class(fh, data, class_name, indent=0):
    fh.write("\n")
    fh.write(indent * " " + "class " + class_name + "\n")

    def write_property(fh, key, value, indent):
        class_name = value.__class__.__name__
        property_type = value.__class__.__name__
        if type(value) == dict:
            class_name = key[0].upper() + key[1:]
            property_type = class_name
            write_class(fh, value, class_name, indent=indent)
        fh.write(indent * " " + "def " + key + "() -> " + property_type + ":\n")

    for key, value in data.items():
        write_property(fh, key, value, indent + 4)

    fh.write("\n")

if __name__ == "__main__":
    import argparse, sys
    parser = argparse.ArgumentParser(prog="Python stub generator for serializing input data.")
    parser.add_argument("--input-file", help="Input filepath.")
    parser.add_argument("-o", "--output-file",
        help="Output filepath.")
    parser.add_argument("--input-format", choices=["json"], default="json",
        help="Input data format (default=json).")
    parser.add_argument("--stub-class", default="Object",
        help="Class name for the python interface (default=Object).")
    parser.add_argument("--stdin", action="store_true",
        help="Read input data from standard input.")
    args = parser.parse_args(sys.argv[1:])

    assert args.stdin or args.input_file, "Argument --stdin or --input-file is required."

    if args.stdin:
        data = sys.stdin.read()
    elif args.input_file:
        with open(args.input_file, "r") as fh:
            data = fh.read()

    if args.input_format == "json":
        dict_data = json.loads(data)
    else:
        assert False, "Unsupported input format: %s" % args.input_format

    try:
        if args.output_file:
            fh = open(args.output_file, "w")
        else:
            fh = sys.stdout

        fh.write("#/usr/bin/env python3\n")

        class_name = args.stub_class
        write_class(fh, dict_data, class_name)
    finally:
        fh.close()
