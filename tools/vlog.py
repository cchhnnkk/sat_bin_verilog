#!python

import os
import sys
import json
import re
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
pattern_error = re.compile(r'\((\d+)\)')

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
        # str_all = ""
        # while subp.poll() is None:
        #     vlog_info = subp.stdout.read()
        #     print vlog_info
        #     str_all += vlog_info
        vlog_info = subp.stdout.read()
        print vlog_info
        if "Error" in vlog_info:
            # subprocess.Popen("start gvim %s" % filename)
            match = pattern_error.search(vlog_info)
            print match.group(1)
            subprocess.Popen(["gvim", filename, "+%s" % match.group(1)])
            break
        subp.wait()
    elif filename.endswith('.gen'):
        # subp = subprocess.Popen(["../tools/gen_num_verilog.py",
        #                         filename,
        #                         '8'])
        gn.gen_num_verilog(filename, 8)

    mtime_list[filename] = mtime


file_db = open("vlog_db.txt", 'w')
str1 = json.dumps(mtime_list, indent=2)
file_db.write(str1)
