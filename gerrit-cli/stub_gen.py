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
    parser.add_argument("data", help="Input data for creating stubs.")
    parser.add_argument("-o", "--output-file",
        help="Output file.")
    parser.add_argument("--input-format", choices=["file", "text"], default="file",
        help="Input data format (default=file).")
    parser.add_argument("--stub-class", default="Object",
        help="Class name for the python interface (default=Object).")
    args = parser.parse_args(sys.argv[1:])

    if args.input_format == "file":
        with open(args.data, "r") as fh:
            data = fh.read()
    elif args.input_format == "text":
        data = args.data
    else:
        assert False, "Unsupported input format: %s" % args.input_format

    obj = Parser(data)

    try:
        if args.output_file:
            fh = open(args.output_file, "w")
        else:
            fh = sys.stdout
        
        fh.write("#/usr/bin/env python3\n")

        class_name = args.stub_class or obj.__class__.__name__
        write_class(fh, obj.__dict__, class_name)
    finally:
        fh.close()