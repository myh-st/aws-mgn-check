#!/bin/bash
echo ""
echo "--------------------------------------------------------------------------"
echo "## STEP 1 : Check tools are required for agent ##"
echo "Require Python 2 (2.4 or above) or Python 3 (3.0 or above)."
echo "--------------------------------------------------------------------------"
which python
status=$?
[ $status -eq 0 ] && echo -e "python : present" && python --version || echo -e "python : not present\n"
echo ""
echo "--------------------------------------------------------------------------"
echo "## STEP 2 : Check tools are required for agent ##"
echo "The following tools are required for agent installation only"
echo "--------------------------------------------------------------------------"
which make
status=$?
[ $status -eq 0 ] && echo -e "make : present\n" || echo -e "make : not present\n"
which gcc
status=$?
[ $status -eq 0 ] && echo -e "gcc : present\n" || echo -e "gcc : not present\n"
which perl
status=$?
[ $status -eq 0 ] && echo -e "perl : present\n" || echo -e "perl : not present\n"
which tar
status=$?
[ $status -eq 0 ] && echo -e "tar : present\n" || echo -e "tar : not present\n"
which gawk
status=$?
[ $status -eq 0 ] && echo -e "gawk : present\n" || echo -e "gawk : not present\n"
which rpm
status=$?
[ $status -eq 0 ] && echo -e "rpm : present\n" || echo -e "rpm : not present\n"
echo "--------------------------------------------------------------------------"
echo "## STEP 3 : Check kernel verion ##"
echo -e "Verify that you have kernel-devel/linux-headers installed that are exactly 
the same version as the kernel you are running."
echo "--------------------------------------------------------------------------"
echo ""
CHECK_KERNEL=$(uname -r)
echo -e "Kernel you are running version: $CHECK_KERNEL\n"
SET_KERNEL_VERSION=$(rpm -qa | grep kernel-$CHECK_KERNEL | wc -l)
SET_KERNELD_VERSION=$(rpm -qa | grep kernel-devel-$CHECK_KERNEL | wc -l)
SET_KERNELH_VERSION=$(rpm -qa | grep kernel-headers-$CHECK_KERNEL | wc -l)
rpm -qa | grep kernel-$CHECK_KERNEL
rpm -qa | grep kernel-devel-$CHECK_KERNEL
rpm -qa | grep kernel-headers-$CHECK_KERNEL
echo ""
if [[ $SET_KERNEL_VERSION -gt 0 ]]; then
	echo 'kernel "MATCH VERSION"'
else
	echo 'kernel "VERSION NOT MATCH "'
fi 
if [[ $SET_KERNELD_VERSION -gt 0 ]]; then
	echo 'kernel-devel "MATCH VERSION"'
else
	echo 'kernel-devel "VERSION NOT MATCH "'
fi
if [[ $SET_KERNELH_VERSION -gt 0 ]]; then
	echo 'kernel-headers "MATCH VERSION"'
else
	echo 'kernel-headers "VERSION NOT MATCH "'
fi  
echo ""
# echo "For everything to work, you need to install a kernel headers package "
# echo "with the exact same version number of the running kernel."
# echo "To install the correct kernel-devel/linux-headers, run the following command:"
# echo "On RHEL/CENTOS/Oracle/SUSE:"
# echo "sudo yum install kernel-devel-`uname -r`"
# echo "On Debian/Ubuntu:"
# echo "sudo apt-get install linux-headers-`uname -r`"
# echo ""
echo "--------------------------------------------------------------------------"
echo "## STEP 4 : Check disk space ##"
echo -e "Verify that you have at least 2 GB of free disk space on the root directory"
echo -e "Verify that you have at least 500 MB of free disk space on the /tmp directory"
echo "--------------------------------------------------------------------------"
ROOT_AVAIL=$(df -h / | tail -1 | awk '{print $4}')
echo -e "\nFree disk space on the root (/) : $ROOT_AVAIL" ; 
TMP_AVAIL=$(df -h /tmp | tail -1 | awk '{print $4}')
echo -e "Free disk space on the /tmp : $TMP_AVAIL"
echo ""
echo "--------------------------------------------------------------------------"
echo "## STEP 5 : verify kernel symbolic link ##"
echo "Verify that the folder that contains the kernel-devel/linux-headers is not a symbolic link"
echo "--------------------------------------------------------------------------"
ls -l /usr/src/kernels
echo ""
echo "[If a symbolic link exists] Delete the symbolic link."
echo "If you found that the content of the kernel-devel/linux-headers, which match the version of the kernel, is a symbolic link," 
echo "you need to delete the link. Run the following command: rm /usr/src/kernels/<LINK NAME>"
echo "For example: rm /usr/src/kernels/linux-headers-4.4.1"
echo ""
echo "--------------------------------------------------------------------------"
echo "NOTED: https://docs.aws.amazon.com/mgn/latest/ug/installation-requiremets.html#general-requirements2"
echo ""
