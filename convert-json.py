# -*- coding: UTF-8 -*- 
import json
import os
import sys

def loadjson(file_json):
    f = open(file_json, "r") 
    filejson = json.load(f,encoding='utf-8')
    return filejson

if __name__ == "__main__":
    if len(sys.argv) != 3:
        sys.exit("Parameter not right")

    file_json = sys.argv[1]
    cve_score = sys.argv[2]

    if os.path.exists(file_json):
        pass
    else:
        print "File %s not exist"%file_json
 
    data_json = loadjson(file_json)


    print '============================================================================================'
    print "ID: ", data_json["CVE_data_meta"]["ID"]
    print "STATE: ", data_json["CVE_data_meta"]["STATE"]
    print 'V3_Score: ', cve_score
    print '\n'

    print 'Affects:'

    for affect in data_json["affects"]["vendor"]["vendor_data"][0]["product"]["product_data"]:
        print "product_name: ", affect["product_name"]

        for version in  affect["version"]["version_data"]:
            print "version", version["version_affected"], version["version_value"]  
    print '\n'

    print 'Description:'
    print(data_json["description"]["description_data"][0]["value"])
    print '\n'

    print 'Problemtype:'
    print(data_json["problemtype"]["problemtype_data"][0]["description"][0]["value"])
    print '\n'

    print 'References:'

    for url in data_json["references"]["reference_data"]:
        print url["url"]
    
    print '\n'
    print '\n'
