Personal Telco Project packages for OpenWrt
===========================================

For more information about OpenWrt, visit https://openwrt.org/

For more information about the Personal Telco Project, visit
https://personaltelco.net/wiki/

Authors: Jason McArthur, Russell Senior, Keegan Quinn

This is a second whack at the problem, particularly of .config creation, 
based on an initial stab by Keegan Quinn.  This version starts from the 
existing state of package selections, and thus represents a smaller departure
from the status quo than Keegan's version did, which allows it to be an
immediately useful replacement.  Over time, more functionality will be moved
here.


Concept
-------

The goal of this project is to assist in generating Personal Telco OpenWrt
node device images, initially just by automating the creation of .config
files used in building OpenWrt. 


Usage
-----

Add to your feeds.conf:

	src-git ptpcab git://github.com/ptpcab.git

Then retrieve and install the packages:

	scripts/feeds update ptpcab
	scripts/feeds install -a -p ptpcab

Because the standard node disables two default packages, firewall
and ppp, and because OpenWrt dependency resolution does not support
automatic de-selection of packages, and until something comes along
that is better, do the following:

For your chosen target (alix2, wgt634u, atheros, net45xx), copy the 
starting config to .config:

	cp feeds/ptpcab/ptp-node/files/.config-alix2 .config

These sample configs using a particular value of CONFIG_DOWNLOAD_FOLDER, 
the location that OpenWrt buildroot uses to store downloaded source tarballs
and the like:

	CONFIG_DOWNLOAD_FOLDER="/src_archive/openwrt/dl"

Adapt as needed.  For building on iris.personaltelco.net, a value of:

	CONFIG_DOWNLOAD_FOLDER="/usr/portage/distfiles"

is preferred.  Complete the configuration using the defconfig make 
target:

	make defconfig

In the case of alix2 and net45xx, if you are installing a radio and 
not just using the device as a gateway:

	make menuconfig

and select the desired wireless driver from the PTP menu (this will 
also select a set of wireless utilities to accompany the driver).

OpenWrt allows the builder to override files that are baked into the 
image filesystem by means of a "files" tree.  Compute one, consisting
of configuration files and local tweaks using the files-master 
FOOCAB.pl script for now.  Then compile using:

	time make -j8 BUILD_LOG=1 IGNORE_ERRORS=m V=99
