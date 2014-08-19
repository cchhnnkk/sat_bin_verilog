#!python
# -*- coding: utf-8 -*-

# cmp_log.py sb_verilog.log sb_python.log 1

import sys

vmax = 8
cmax = 8


def find_vlog_update_bin(starti, vlines):
    strc = ''
    strvs = ''
    strls = ''
    while starti < len(vlines):
        line = vlines[starti].strip()
        index = line.find('cnt_update_bin', 0)
        starti += 1
        if index == -1:
            continue

        index += len('cnt_update_bin = ')
        cnt_up = int(line[index:])

        starti += 2
        line = vlines[starti].strip()
        starti += 1
        index = line.find('done_update_cbin', 0)
        index += len('done_update_cbin = ')
        num_bin = int(line[index:])

        strc += 'update_bin %d\n' % num_bin
        strc += 'cnt_update %d\n' % cnt_up

        ci = 1
        for i in xrange(cmax):
            line = vlines[starti].strip()
            starti += 1
            index = line.find('=', 0)
            index += len('= ')
            str1 = 'c%d  ' % ci
            tag = 0
            i = 0
            for c in line[index:]:
                var = i + 1
                if c in '012':
                    i += 1
                if c == '1':
                    str1 += str(-var) + ' '
                    tag = 1
                elif c == '2':
                    str1 += str(var) + ' '
                    tag = 1

            if tag == 1:
                strc += str1 + '\n'
                ci += 1

        line = vlines[starti].strip()
        starti += 1   # done_update_vs
        if 'done_update_vs' not in line:
            break
        line = vlines[starti].strip()
        starti += 1
        index = line.find('value =', 0)
        strvs += line[index:]
        strvs += '\n'

        line = vlines[starti].strip()
        starti += 1
        index = line.find('imply =', 0)
        strvs += line[index:]
        strvs += '\n'

        line = vlines[starti].strip()
        starti += 1
        index = line.find('level =', 0)
        strvs += line[index:]
        strvs += '\n'

        line = vlines[starti].strip()
        starti += 1   # done_update_ls
        line = vlines[starti].strip()
        starti += 1
        index = line.find('dcd_bin =', 0)
        strls += line[index:]
        strls += '\n'

        line = vlines[starti].strip()
        starti += 1
        index = line.find('has_bkt =', 0)
        strls += line[index:]
        strls += '\n'

        break

    return strc + strvs + strls, starti


def complement(strp):
    i = 0
    strv = ''
    for c in strp:
        if c in ',':
            i += 1
        if c not in '[],':
            strv += c

    for j in xrange(i + 1, vmax):
        strv += ' 0'

    return strv


def find_plog_update_bin(starti, plines):
    strc = ''
    strvs = ''
    strls = ''
    while starti < len(plines):
        line = plines[starti].strip()
        starti += 1
        index = line.find('update_bin', 0)
        if index == -1:
            continue

        partial_sat = False
        if 'partial sat' in plines[starti - 2]:
            partial_sat = True

        # cnt_update
        strc += line + '\n'
        line = plines[starti].strip()
        starti += 1

        while 'global vars' not in line:
            strc += line + '\n'
            line = plines[starti].strip() + ' '
            starti += 1

        if partial_sat is False:
            break

        starti += 2
        line = plines[starti].strip()
        starti += 1
        index = line.find('[', 0)   # value
        strvs += 'value = ' + complement(line[index:])
        strvs += '\n'

        line = plines[starti].strip()
        starti += 1
        index = line.find('[', 0)
        strvs += 'imply = ' + complement(line[index:])
        strvs += '\n'

        line = plines[starti].strip()
        starti += 1
        index = line.find('[', 0)
        strvs += 'level = ' + complement(line[index:])
        strvs += '\n'

        line = plines[starti].strip()
        starti += 1   # lvl state list:
        line = plines[starti].strip()
        starti += 1
        index = line.find('[', 0)
        strls += 'dcd_bin = ' + complement(line[index:])
        strls += '\n'

        line = plines[starti].strip()
        starti += 1
        index = line.find('[', 0)
        strls += 'has_bkt = ' + complement(line[index:])
        strls += '\n'

        break

    return strc + strvs + strls, starti


if __name__ == '__main__':

    test_case = 1
    if(len(sys.argv) == 4):
        vfilename = sys.argv[1]
        pfilename = sys.argv[2]
        test_case = int(sys.argv[3])

    vfp = open(vfilename)
    pfp = open(pfilename)

    vlines = vfp.readlines()
    plines = pfp.readlines()

    vindex = 0
    pindex = 0
    for i, line in enumerate(vlines):
        if 'test_case' in line:
            if ' ' + str(test_case) in line:
                vindex = i
                break

    error = False
    while vindex < len(vlines) and pindex < len(plines):
        strv, vindex = find_vlog_update_bin(vindex, vlines)
        strp, pindex = find_plog_update_bin(pindex, plines)
        print '======================== strv ========================'
        print strv
        print '======================== strp ========================'
        print strp
        str1 = ''
        print len(strv)
        print len(strp)
        for i in xrange(len(strv)):
            str1 += strv[i]
            if strv[i] != strp[i]:
                print str1
                print 'error'
                break

        if strv != strp:
            error = True
            # print strv
            break
