#!/bin/sh
#
# This script runs as root through sudo without the need for a password,
# so it needs to make sure it can't be abused.
#

if [ $# -ne 1 ]; then
  echo "usage: $0 <block device>"
  exit 1
fi

OUTPUT="$1"

echo ${OUTPUT} | egrep '^/dev/[a-z0-9]+$' > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "ERROR: illegal device: ${OUTPUT}"
  exit 1
fi

if [ ! -f ${OUTPUT} ]; then
  echo "ERROR: missing device: ${OUTPUT}"
  exit 1
fi

# copy image to block device with 1 MB block size
dd if=root.img if=${OUTPUT} bs=1M
