#!/bin/perl
# 
# 
# find ./ -name '*.v' -print0 |xargs -0 echo
# cdir=`find ./ | egrep "*\.?v$"`
# echo $cdir
# find ./ | grep "\.v$"
# files=$(find ./ | egrep "*\.?v$")
# echo $files

# $files = `find ../ | egrep "*\.?v$"`;

# print $files

$files = `find ..`;
# print grep /.sv$|.v$/i, $files;

# my $regex = "*\.?v";
# print grep { $_ =~ /$regex/ } $files
# cat $files > files.svv
# cat $files | gen_hielist.py > hielist.json
