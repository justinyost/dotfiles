#!/usr/bin/env bash
#
# If you're like me and have to switch between VMware Fusion and
# VirtualBox virtual machines on your Mac frequently, then you've
# probably run into one of the associated errors in this gist
# (https://gist.github.com/beporter/2841de37edbcc48a8755), particularly
# if you're using vagrant. This script shuts down or removes the bridge
# interfaces from BOTH providers so that they can start up cleanly again
# without conflicting with each other and without having to reboot your
# Mac.
#
# NOTE! For VirtualBox, this is done by REMOVING the host-only adapters
# ENTIRELY! If you are not experiencing THIS EXACT ISSUE, you probably
# shouldn't use this script for anything other than reference.
#
# Brian Porter <beporter@users.sourceforge.net>
# 2014-10-23


# Gracefully shut down VMware bridge adapters using the provided script.
sudo /Applications/VMware\ Fusion.app/Contents/Library/vmnet-cli --stop

# Enumerate and !!REMOVE!! Virtualbox host-only adapters. This could
# be descructive, but is okay if your use of Virtualbox is entirely via
# Vagrant since it will recreate the adapters as necessary.
INTERFACES=$(VBoxManage list hostonlyifs | grep "^Name" | sed 's/^Name:[ ]*//')
for INTERFACE in $INTERFACES; do
    VBoxManage hostonlyif remove $INTERFACE
done
