#!/bin/sh
#
# STIG URL:
# Finding ID:	RHEL-07-021240
# Version:	RHEL-07-021240_rule
# SRG ID:	
# Finding Level:	low
#
# Rule Summary:
#     A separate file system must be used for user home directories 
#     (such as /home or an equivalent).
#
# CCI-000366
#    NIST SP 800-53 :: CM-6 b
#    NIST SP 800-53A :: CM-6.1 (iv)
#    NIST SP 800-53 Revision 4 :: CM-6 b
#
#################################################################

diag_out() {
   echo "${1}"
}

diag_out "---------------------------------------------"
diag_out "STIG Finding ID: RHEL-07-021240"
diag_out "   The system must use a separate filesystem"
diag_out "   for /home."
diag_out "---------------------------------------------"
