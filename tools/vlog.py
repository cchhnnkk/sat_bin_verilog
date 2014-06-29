#!python
# -*- coding: utf-8 -*-

# todo: 添加include引用文件的编译功能

import os
import sys
import json
import re
import subprocess
import gen_num_verilog as gn

# vlog_exe = "D:/questasim_10.0c/win32/vlog.exe"
vlog_exe = "vlog.exe"
vlog_db_mtime = 'vlog_mtime.db'
vlog_db_ref = 'vlog_include_ref.db'

if os.path.isfile(vlog_db_mtime) is False:
    mtime_list = {}
else:
    file_db = open(vlog_db_mtime, 'r+')
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
        subp = subprocess.Popen(vlog_exe + " -sv " + filename,
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
            # subprocess.Popen(["gvim", filename, "+%s" % match.group(1)])
            subprocess.Popen(["sublime_text", filename])
            break
        subp.wait()
    elif filename.endswith('.gen'):
        # subp = subprocess.Popen(["../tools/gen_num_verilog.py",
        #                         filename,
        #                         '8'])
        gn.gen_num_verilog(filename, 8)

    mtime_list[filename] = mtime


file_db = open(vlog_db_mtime, 'w')
str1 = json.dumps(mtime_list, indent=2)
file_db.write(str1)
