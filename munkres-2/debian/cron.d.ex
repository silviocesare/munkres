#
# Regular cron jobs for the munkres package
#
0 4	* * *	root	[ -x /usr/bin/munkres_maintenance ] && /usr/bin/munkres_maintenance
