#!python

import sys
import re
import json

data = sys.stdin.read()
# print data

pattern_module = re.compile(r'module[\s\t]+([\w\d]+\b.*?)endmodule', re.DOTALL)
pattern_mname = re.compile(r'([\w\d]+\b)')

# clause1 #(
# .NUM_VARS_A_BIN(NUM_VARS_A_BIN),
# ......
# .WIDTH_C_LEN(WIDTH_C_LEN)
# )
# clause1_0 (
#     .clk(clk),
#     ......
#     .apply_backtrack_i(apply_backtrack_i)
# );
# pattern_inst1 = re.compile(
    # r'[\w|\d]+\b\s*#\s*\([\n|\s|\t]*\..*?\;',
    # re.DOTALL)
pattern_inst1 = re.compile(
    r'([\w|\d]+\b)\s*#\s*\([\n|\s|\t]*\..*?\)[\n\t\s]*([\w\d]+\b)[\n\t\s]*\(',
    re.DOTALL)


# clause1 clause1_0 (
#     .clk(clk),
#     ......
#     .apply_backtrack_i(apply_backtrack_i)
# );
pattern_inst2 = re.compile(
    r'([\w|\d]+\b)\s*([\w|\d]+)[\n\s\t]*\([\n\s\t]*\..*?\;', re.DOTALL)

mscope_list = pattern_module.findall(data)
# print module_list

module_list = {}

for module_scope in mscope_list:
    # print module_scope
    inst_list = []

    match_mname = pattern_mname.search(module_scope)
    assert match_mname is not None
    mname = match_mname.group(1)
    # print mname
    module_list[mname] = inst_list

    inst1_s = pattern_inst1.findall(module_scope)
    inst_list += inst1_s
    # for inst in inst1_s:
    #     # print inst
    #     instname = pattern_instname.search(inst).group(1)
    #     inst_list += [instname]

    inst2_s = pattern_inst2.findall(module_scope)
    inst_list += inst2_s
    # for inst in inst2_s:
    #     print inst

# print module_list
if module_list is not None:
    mlist_json = json.dumps(module_list, indent=2)
    print mlist_json
