# STIG URL: http://www.stigviewer.com/stig/red_hat_enterprise_linux_6/2014-06-11/finding/V-38679
# Finding ID:	V-38679
# Version:	RHEL-06-000292
# Finding Level:	Medium
#
#     The DHCP client must be disabled if not needed. DHCP relies on 
#     trusting the local network. If the local network is not trusted, then 
#     it should not be used. However, the automatic configuration provided 
#     by DHCP is commonly used and the alternative, ...
#
#  CCI: CCI-000366
#  NIST SP 800-53 :: CM-6 b
#  NIST SP 800-53A :: CM-6.1 (iv)
#  NIST SP 800-53 Revision 4 :: CM-6 b
#
############################################################

script_V38679-describe:
  cmd.script:
  - source: salt://STIGbyID/cat2/files/V38679.sh

{% set netCfgRoot = '/etc/sysconfig/network-scripts/ifcfg-' %}

# Ingest list of mounted filesystesm into a searchable-structure
{% set netIfStream = salt['network.interfaces']() %}

{% for netIfBase in netIfStream.keys() %}
  {% if not netIfBase == 'lo' %}
test_IfPrint-{{ netIfBase }}:
  cmd.run:
  - name: 'echo "Base Interface Name: {{ netIfBase }}"'

    {% set inetList = netIfBase['inet'] %}
    {% set ifDict = netIfStream[netIfBase] %}
    {% set ifInetList = ifDict['inet'] %}

    {% for listElem in ifInetList %}
     {% set ifLabel = listElem['label'] %}
test-printit-{{ ifLabel }}:
  cmd.run:
  - name: 'echo "{{ ifLabel }}"'
    {% endfor %}

  {% endif %}
{% endfor %}