#!python
# -*- coding: utf-8 -*-

# cat hietree.json | gen_wavedo.py > wave.do
# 输出是json格式 [name, inst, [sublit]]

import sys
import json

data = sys.stdin.read()

mlist_json = json.loads(data)
# print mlist_json


def gen_sub(mlist, str_inst):
    sublist = []
    # print mlist[0], mlist[1]
    inst = mlist[1]
    sublist = mlist[2]

    str_inst1 = str_inst[:]
    str_inst1 += '/' + inst

    print str_inst1

    for l in sublist:
        gen_sub(l, str_inst1)


gen_sub(mlist_json, "")
