# Finding ID:	RHEL-07-020660
# Version:	RHEL-07-020660_rule
# SRG ID:	SRG-OS-000480-GPOS-00227
# Finding Level:	medium
# 
# Rule Summary:
#	All local interactive user home directories must be owned by
#	their respective users.
#
# CCI-000366 
#    NIST SP 800-53 :: CM-6 b 
#    NIST SP 800-53A :: CM-6.1 (iv) 
#    NIST SP 800-53 Revision 4 :: CM-6 b 
#
#################################################################
{%- set stig_id = 'RHEL-07-020660' %}
{%- set helperLoc = 'ash-linux/el7/STIGbyID/cat2/files' %}
{%- set loginDef = '/etc/login.defs' %}
{%- if salt.file.search(loginDef, 'SYS_UID_MAX') %}
  {%- set sysuserMax = salt.cmd.run("awk '/SYS_UID_MAX/{print $2}' /etc/login.defs")|int %}
{%- else %}
  {%- set sysuserMax = 999 %}
{%- endif %}
{%- set userList =  salt.user.list_users() %}
{%- set skipIt = salt.pillar.get('ash-linux:lookup:skip-stigs', []) %}


script_{{ stig_id }}-describe:
  cmd.script:
    - source: salt://{{ helperLoc }}/{{ stig_id }}.sh
    - cwd: /root

{%- if stig_id in skipIt %}
notify_{{ stig_id }}-skipSet:
  cmd.run:
    - name: 'printf "\nchanged=no comment=''Handler for {{ stig_id }} has been selected for skip.''\n"'
    - cwd: /root
    - stateful: True
{%- else %}
  {%- for user in userList %}
    {%- set userInfo = salt.user.info(user) %}
    {%- set userHome = userInfo['home'] %}
    {%- set userUid = userInfo['uid']|int %}
    {%- set userGid = userInfo['gid']|int %}
    {%- if userUid > sysuserMax %}
fixowner_{{ stig_id }}-{{ user }}:
  file.directory:
    - name: '{{ userHome }}'
    - user: {{ userUid }}
    - recurse:
      - user

    {%- endif %}
  {%- endfor %}
{%- endif %}
