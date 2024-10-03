To restrict access to resource content using an [IP-based access policy](../../cdn/concepts/ip-address-acl.md), enable **{{ ui-key.yacloud.cdn.field_address-acl }}**:

* Select the type of access policy:

   * `{{ ui-key.yacloud.cdn.field_address-acl_policy-type_deny }}`: Allowing policy. Access to the resource content will be allowed for any IP addresses other than those specified below.
   * `{{ ui-key.yacloud.cdn.field_address-acl_policy-type_allow }}`: Blocking policy. Access to the resource content will be denied for any IP addresses other than those specified below.

* In the **{{ ui-key.yacloud.cdn.field_address-acl_excepted-values }}** field, specify the list of IP addresses [excluded](../../cdn/concepts/ip-address-acl.md#ip-list) from the above access policy.

   You must specify IP addresses with a subnet prefix in [CIDR notation](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) separated by commas. For example: `192.168.3.2/32, 192.168.17.0/24`.