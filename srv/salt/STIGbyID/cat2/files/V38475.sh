#!/bin/sh
#
# STIG URL: http://www.stigviewer.com/stig/red_hat_enterprise_linux_6/2014-06-11/finding/V-38475
# Finding ID:	V-38475
# Version:	RHEL-06-000050
# Finding Level:	Medium
#
#     The system must require passwords to contain a minimum of 14 
#     characters. Requiring a minimum password length makes password 
#     cracking attacks more difficult by ensuring a larger search space. 
#     However, any security benefit from an onerous requirement must be 
#     carefully weighed against usability problems, support costs, or
#     counterproductive behavior that may result.
#
#  CCI: CCI-000205
#  NIST SP 800-53 :: IA-5 (1) (a)
#  NIST SP 800-53A :: IA-5 (1).1 (i)
#  NIST SP 800-53 Revision 4 :: IA-5 (1) (a)
#
############################################################

# Standard outputter function
diag_out() {
   echo "${1}"
}

diag_out "----------------------------------"
diag_out "STIG Finding ID: V-38475"
diag_out "  Set minimum password length to"
diag_out "  Fourteen characters"
diag_out "----------------------------------"
