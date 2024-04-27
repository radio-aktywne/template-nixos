#!/bin/sh

### CONFIGURATION ###

# Don't try to make the script self-contained
# Just use binaries that are already available
# This is because this goes to initrd
# And initrd goes to boot partition which is small

DISK='@disk@'
MAIN='@main@'
MKFSEXT4='@mkfsext4@'
PARTED='@parted@'

### PARTITIONING ###

printf '%s\n' "Partitioning disk ${DISK}"

# partition the disk
# use GPT to store partition metadata
# main partition only
if ! ${PARTED} --script --align optimal "${DISK}" -- \
	mklabel gpt \
	mkpart "${MAIN}" 1MB 100%; then
	printf '%s\n' 'Partitioning failed' >&2
	exit 1
fi

# force udev to reread partition table
udevadm trigger

printf '%s' 'Waiting for partitions to appear...'
while [ ! -e "/dev/disk/by-partlabel/${MAIN}" ]; do
	sleep 1
	printf '%s' '.'
done
printf '\n'

printf '%s\n' 'Partitioning complete'

### FORMATTING ###

# format the partitions with appropriate filesystems
# note that referring to devices by by-partlabel works only when using GPT

printf '%s\n' "Formatting /dev/disk/by-partlabel/${MAIN} with ext4"

# ext4 for the main partition
if ! ${MKFSEXT4} -L "${MAIN}" "/dev/disk/by-partlabel/${MAIN}"; then
	printf '%s\n' "Formatting /dev/disk/by-partlabel/${MAIN} failed" >&2
	exit 2
fi

# force udev to reread filesystems
udevadm trigger

printf '%s' 'Waiting for filesystems to appear...'
while [ ! -e "/dev/disk/by-label/${MAIN}" ]; do
	sleep 1
	printf '%s' '.'
done
printf '\n'

printf '%s\n' 'Formatting complete'
