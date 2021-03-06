#!/bin/sh
#
# STIG URL: http://www.stigviewer.com/stig/red_hat_enterprise_linux_6/2014-06-11/finding/V-38521
# Finding ID:	V-38521
# Version:	RHEL-06-000137
# Finding Level:	Medium
#
#     The operating system must support the requirement to centrally manage 
#     the content of audit records generated by organization defined 
#     information system components. A log server (loghost) receives syslog 
#     messages from one or more systems. This data can be used as an 
#     additional log source in the event a system is compromised and its 
#     local logs are suspect. ...
#
############################################################

diag_out() {
   echo "${1}"
}

diag_out "----------------------------------"
diag_out "STIG Finding ID: V-38521"
diag_out "  The rsyslog service must be"
diag_out "  configured send copies of log"
diag_out "  entries to a remote collection-"
diag_out "  node"
diag_out "----------------------------------"
