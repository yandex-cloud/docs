---
title: "How to set up security groups for a {{ mgl-full-name }} instance"
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
1. [Consult the support]({{ link-console-support }}) to bind a security group to a {{ GL }} instance.

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
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `{{ port-https }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: To provide access, specify subnet IP ranges within {{ yandex-cloud }} or public IP addresses of web-connected computers.
||
|| For [health checks](../../network-load-balancer/concepts/health-check.md) by a network load balancer |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: Target port specified in the load balancer settings.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}`.
||
|| To connect to {{ GL }} Container Registry |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `5050`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: To provide access, specify subnet IP ranges within {{ yandex-cloud }} or public IP addresses of web-connected computers.

   To allow all traffic from any IP, specify `0.0.0.0/0`.
||
|#

## Rules for outgoing traffic {#egress-rules}

{% note info %}

{{ mgl-name }} relies on external resources, so imposing restrictions on outbound traffic may lead to errors and failures. If you still need to restrict outbound traffic, make sure to add the rule described below.

{% endnote %}

#|
|| **Why use the rule** | **Rule settings** ||
|| To create backups and store user objects in {{ objstorage-full-name }} |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `{{ port-https }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: `213.180.193.243/32`.
||
|#
