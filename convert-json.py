# -*- coding: UTF-8 -*- 
import json
import os
import sys

def loadjson(file_json):
    f = open(file_json, "r") 
    filejson = json.load(f,encoding='utf-8')
    return filejson

if __name__ == "__main__":
    if len(sys.argv) != 2:
        sys.exit("Parameter not right")

    file_json = sys.argv[1]

    if os.path.exists(file_json):
        pass
    else:
        print "File %s not exist"%file_json
 
    data_json = loadjson(file_json)


    print "ID: ", data_json["CVE_data_meta"]["ID"]
    print "STATE:", data_json["CVE_data_meta"]["STATE"]
    print 'V3_Score:'
    print '\n'
    print 'Affects:'
    print(data_json["affects"]["vendor"]["vendor_data"][0]["product"]["product_data"])
    print '\n'
    print 'Description:'
    print(data_json["description"]["description_data"][0]["value"])
    print '\n'
    print 'Problemtype:'
    print(data_json["problemtype"]["problemtype_data"][0]["description"][0]["value"])
    print '\n'
    print 'Refrences:'
    print(data_json["references"]["reference_data"])
