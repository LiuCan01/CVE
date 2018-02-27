import os
import sys
import re

def get_severityi_v3(json):
    pattern = """CVSS\s*3.0\s*Base\s*Score\s*(\S*)"""
    m = re.search(pattern, json, re.S)
    print  m.group(1)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        sys.exit("Parameter not right")

    file_json = sys.argv[1]

    if os.path.exists(file_json):
        pass
    else:
        print "File %s not exist"%file_json

    fopen_json = open(file_json)
    read_json = fopen_json.read()
    get_severityi_v3(read_json)

    fopen_json.close()
