# STIG URL: http://www.stigviewer.com/stig/red_hat_enterprise_linux_6/2014-06-11/finding/V-38496
# Finding ID:	V-38496
# Version:	RHEL-06-000029
# Finding Level:	Medium
#
#     Default operating system accounts, other than root, must be locked. 
#     Disabling authentication for default system accounts makes it more 
#     difficult for attackers to make use of them to compromise a system.
#
#  CCI: CCI-000366
#  NIST SP 800-53 :: CM-6 b
#  NIST SP 800-53A :: CM-6.1 (iv)
#  NIST SP 800-53 Revision 4 :: CM-6 b
#
############################################################

script_V38496-describe:
  cmd.script:
    - source: salt://ash-linux/STIGbyID/cat2/files/V38496.sh

notify_V38496-userScan:
  cmd.run:
    - name: 'printf "Scanning locally-managed users:\n\t* Examing users with uid 0 >< 500\n\t* Looking for set or null passwords\n"'

{% set userList = salt['user.list_users']() %}
{% for userName in userList %}
{% set userInfo =  salt['user.info'](userName) %}
{% set userShadow =  salt['shadow.info'](userName) %}
{% set userID = userInfo['uid'] %}
{% set userPasswd = userShadow['passwd'] %}

{% if userID < 500 and userID > 0%}
  {% if userPasswd == '*' or userPasswd == '!!' %}
list_V38496-{{ userName }}:
  cmd.run:
    - name: 'echo "Info: User ''{{ userName }}'' has a locked password"'

  {% elif '$' in userPasswd %}
list_V38496-{{ userName }}:
  cmd.run:
    - name: 'echo "WARNING: User ''{{ userName }}'' has a password assigned" ; exit 1'

  {% elif userPasswd == '' %}
list_V38496-{{ userName }}:
  cmd.run:
    - name: 'printf "** CRITICAL: User ''{{ userName }}'' has a NULL password!! **\n\tAttempting to lock...\n" ; exit 1'

pwlock__V38496-{{ userName }}:
  user.present:
    - name: {{ userName }}
    - password: '!!'

  {% endif %}
{% endif %}

{% endfor %}