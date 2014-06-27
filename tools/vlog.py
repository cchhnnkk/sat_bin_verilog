#!python
# import os

# os.system("vlog ../src/sat_engine/lit1.v")

import os
import sys
import json
# import re
import subprocess
import gen_num_verilog as gn

vlog_db = 'vlog_db.txt'
if os.path.isfile(vlog_db) is False:
    mtime_list = {}
else:
    file_db = open("vlog_db.txt", 'r+')
    data = file_db.read()
    # print data
    mtime_list = json.loads(data)
    file_db.close()

# pattern_v = re.compile(r'\.v$|\.sv$')
# pattern_g = re.compile(r'\.gen$')

for i in xrange(1, len(sys.argv)):
    filename = sys.argv[i]
    print filename
    statinfo = os.stat(filename)
    mtime = statinfo.st_mtime
    mtime = int(mtime)

    if filename in mtime_list:
        if mtime_list[filename] == mtime:
            continue

    if filename.endswith('.v') or filename.endswith('.sv'):
        # subp = subprocess.Popen(["vlog", "-quiet", filename])
        # subp = subprocess.Popen("vlog -sv %s" % filename)
        subp = subprocess.Popen("vlog -sv %s" % filename,
                                stdout=subprocess.PIPE)
        subp.wait()
        vlog_info = subp.stdout.read()
        print vlog_info
        if "Error" in vlog_info:
            break
    elif filename.endswith('.gen'):
        # subp = subprocess.Popen(["../tools/gen_num_verilog.py",
        #                         filename,
        #                         '8'])
        gn.gen_num_verilog(filename, 8)

    mtime_list[filename] = mtime


file_db = open("vlog_db.txt", 'w')
str1 = json.dumps(mtime_list, indent=2)
file_db.write(str1)
