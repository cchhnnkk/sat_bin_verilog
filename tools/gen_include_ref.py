#!python
# -*- coding: utf-8 -*-

# gen_include_ref.py > include_ref.json

import os
import json
import re

include_flist = {}

files1 = os.popen('find .. -name "*.v"').read()
files2 = os.popen('find .. -name "*.sv"').read()
files = files1 + files2
# print files

filelist = files.strip().split('\n')

# cat $files1 $files2 | gen_hielist.py > hielist.json

pattern_module = re.compile(r'`include[\s\t]+"([\.\d\w\/]+)"')
for f in filelist:
    # print f
    fdata = open(f).read()
    inc_list = pattern_module.findall(fdata)
    # print inc_list

    include_flist[f] = inc_list

    # for mname in inc_list:
    #     print mname
    #     include_flist[mname].insert(0, f)

# include_flist_json = json.dumps(include_flist, indent=2)
# print include_flist_json

include_ref_list = {}
for f in filelist:
    include_ref_list[f] = []
    for l in include_flist:
        if f in include_flist[l]:
            include_ref_list[f] += [l]


include_ref_json = json.dumps(include_ref_list, indent=2)
print include_ref_json
