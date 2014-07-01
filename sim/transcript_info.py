#!python
# coding:utf-8

f = open("transcript")
data = f.readlines()
f.close()

f = open("transcript.todo", "w")

start_tag = 0
for i, l in enumerate(data):
    if "start sim" in l:
        start_tag = i

for i in xrange(start_tag, len(data)):
    if "# " in data[i]:
        f.write(data[i][2:])

f.close()
