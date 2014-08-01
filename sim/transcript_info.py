#!python
# coding:utf-8


def repeat_space(n):
    s = ''
    for i in xrange(n):
        s += ' '
    return s

f = open("transcript")
data = f.readlines()
f.close()

f = open("transcript.log", "w")

start_tag = 0
for i, l in enumerate(data):
    if "start sim" in l:
        start_tag = i

info_data = []
tab_len = 4
for i in xrange(start_tag, len(data)):
    if "# " in data[i]:
        line = data[i][2:]
        # print line
        if 'ns ' in line:
            l = line.strip().split()
            if tab_len < len(l[0]):
                tab_len = len(l[0])
                # print l[0], tab_len
        info_data += [line]

print "    tab_len=" + str(tab_len)
cur_time = 0
for line in info_data:
    if line[0] == '=':
        pass
    elif line[0] not in ' \t':
        l = line.strip().split()
        if len(l) == 0:
            continue
        n = tab_len - len(l[0])
        index1 = line.find(' ')
        index2 = line.find('\t')
        index = index1
        if index == -1 or index > index2:
            index = index2
        # print index
        if index != -1:
            line = l[0] + repeat_space(n + 1) + line[index + 1:]

        if len(l[0]) >= 3 and l[0][-2:]=='ns':
            next_time = int(l[0][:-2])
            if cur_time < next_time:
                cur_time = next_time
                # f.write(repeat_space(tab_len) + 
                #         '----------------------------------\n\n')
                f.write('----------------------------------\n\n')

    elif line[0] == '\t':
        line = repeat_space(tab_len + 1) + line[1:]
    else:
        line = repeat_space(tab_len) + line[:]
    f.write(line)

f.close()

print 'please view transcript.log'
