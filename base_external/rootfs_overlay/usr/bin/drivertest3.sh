#!/bin/sh
# Test script used to test assignment 8 char driver implementation

rc=0
device=/dev/aesdchar

check_output()
{
	local read_file=$1
	local expected_file=$2
	diff ${read_file} ${expected_file}
	if [ $? -ne 0 ]; then
		echo "difference detected, expected:"
		cat ${expected_file}
		echo "but found"
		cat ${read_file}
		rc=-1
	fi
}

echo -n "w" > ${device}
echo -n "r" > ${device}
echo -n "it" > ${device}
echo "e1"  > ${device}
echo "write2" > ${device}
echo "write3" > ${device}
echo "write4" > ${device}
echo "write5" > ${device}
echo "write6" > ${device}
echo "write7" > ${device}
echo "write8" > ${device}
echo "write9" > ${device}
echo -n "wr" > ${device}
echo -n "it" > ${device}
echo "e10" > ${device}

expected_file=$(mktemp)
cat >${expected_file}  << EOF
write1
write2
write3
write4
write5
write6
write7
write8
write9
write10
EOF

read_file=$(mktemp)
cat ${device} > ${read_file}

echo "The output should show writes 1-10 in order, with write1 and write10 on a single line"
cat ${read_file}

check_output ${read_file} ${expected_file}

exit ${rc}
