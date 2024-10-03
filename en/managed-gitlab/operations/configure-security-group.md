---
title: How to set up security groups for a {{ mgl-full-name }} instance
---

# Setting up security groups and {{ mgl-name }} instance access restrictions

[Security group](../../vpc/concepts/security-groups.md) rules specify the following:

* IPs that can access the instance, including web access.
* Protocol to work with Git repositories in the {{ GL }} instance: SSH or HTTPS.
* Certificate to work over HTTPS: [Let's Encrypt]({{ gl.docs }}/omnibus/settings/ssl/#enable-the-lets-encrypt-integration) (by default) or [your own certificate]({{ gl.docs }}/omnibus/settings/ssl/#configure-https-manually).
* Whether or not access to [{{ GL }} Container Registry]({{ gl.docs }}/ee/user/packages/container_registry/) has been provided.

To set traffic rules for a {{ GL }} instance:

1. [Create a security group](../../vpc/operations/security-group-create.md) in the {{ yandex-cloud }} network you selected when creating the instance.
1. [Add](../../vpc/operations/security-group-add-rule.md) inbound and outbound traffic rules to the security groups. See the list of rules further below.
1. [Contact support]({{ link-console-support }}) to bind a security group to a {{ GL }} instance.

   If you do not bind a separate security group to an instance, the group created by default in the instance's network will apply to it. The rules of this security group added for other services affect access to the {{ GL }} instance.

   If you have no access to the instance or it works incorrectly when using the default security group, add rules for {{ GL }} to this group or bind a new one.

## Rules for incoming traffic {#ingress-rules}

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
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `{{ port-https }}`
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: To provide access, specify subnet IP ranges within {{ yandex-cloud }} or public IP addresses of web-connected computers.
||
|| For [health checks](../../network-load-balancer/concepts/health-check.md) by a network load balancer |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: Target port specified in the load balancer settings.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}`
||
|| To connect to {{ GL }} Container Registry |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `5050`
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: To provide access, specify subnet IP ranges within {{ yandex-cloud }} or public IP addresses of web-connected computers.

   To allow all traffic from any IP, specify `0.0.0.0/0`.
||
|#

## Rules for outgoing traffic {#egress-rules}

{{ mgl-name }} relies on third-party integrations to provide its services. If you limit the outgoing traffic in the instance's security group, the instance may work incorrectly. To avoid this, add one of the rules presented in the table to the security group. You need them to create backups and store user objects in {{ objstorage-full-name }}.

Your choice of rule depends on the certificate you are using: Let's Encrypt (default) or self-signed.

#|
|| **Instance certificate type** | **Rule settings** ||
|| Let's Encrypt |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `{{ port-https }}`
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: `0.0.0.0/0`
||
|| Self-signed certificate |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `{{ port-https }}`
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: `213.180.193.243/32`
||
|#
