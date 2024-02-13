---
title: "How to set up security groups for a {{ mgl-full-name }} instance"
---

# Setting up security groups and {{ mgl-name }} instance access restrictions

[Security group](../../vpc/concepts/security-groups.md) rules specify the following:

* IPs that can access the instance, including web access.
* Protocol to work with Git repositories in the {{ GL }} instance: SSH or HTTPS.
* Certificate to work over HTTPS: [Let's Encrypt]({{ gl.docs }}/omnibus/settings/ssl/#enable-the-lets-encrypt-integration) (by default) or [your own certificate]({{ gl.docs }}/omnibus/settings/ssl/#configure-https-manually).
* If dedicated access to [{{ GL }} {{ container-registry-name }}]({{ gl.docs }}/ee/user/packages/container_registry/) was provided.

To set traffic rules for a {{ GL }} instance:

1. [Create a security group](../../vpc/operations/security-group-create.md) in the {{ yandex-cloud }} network you selected when creating the instance.
1. [Add](../../vpc/operations/security-group-add-rule.md) inbound traffic rules to the security groups. See the list of rules [further below](#rules).

   {% note info %}

   Do not set any rules for outbound traffic. {{ mgl-name }} relies on third-party integrations to provide its services. Imposing restrictions on outbound traffic may lead to errors and failures.

   {% endnote %}

1. [Consult the support]({{ link-console-support }}) to bind a security group to a {{ GL }} instance.

## Security group rules for inbound traffic {#rules}

#|
|| **Purpose of the rule** | **Rule settings** ||
|| To access your Git repository over SSH |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `{{ port-ssh }}` and `2222`. Create a separate rule for each port.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: To provide access, specify subnet IP ranges within {{ yandex-cloud }} or public IP addresses of web-connected computers. Examples:

   * `172.16.0.0/12`
   * `85.32.32.22/32`

   To allow all traffic from any IP, specify `0.0.0.0/0`.
||
|| To enable Let’s Encrypt

This certificate is [used by default]({{ gl.docs }}/omnibus/settings/ssl/#enable-the-lets-encrypt-integration) when working with Git repositories over HTTPS. If you do not specify this rule, you will need to configure HTTPS manually with [your own certificate]({{ gl.docs }}/omnibus/settings/ssl/#configure-https-manually). |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `{{ port-http }}`
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: `0.0.0.0/0`
||
|| To access your Git repository over SSH |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `{{ port-https }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: To provide access, specify subnet IP ranges within {{ yandex-cloud }} or public IP addresses of web-connected computers.
||
|| To connect to {{ GL }} {{ container-registry-name }} |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `5050`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: To provide access, specify subnet IP ranges within {{ yandex-cloud }} or public IP addresses of web-connected computers.

   To allow all traffic from any IP, specify `0.0.0.0/0`.
||
|#
