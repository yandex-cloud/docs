---
title: 'Setting up security groups and access restrictions to a {{ mgl-full-name }} instance '
description: In this article, you will learn how to set up security groups and restrict access to a {{ mgl-name }} instance, as well as review the rules for incoming and outgoing traffic.
---

# Setting up security groups and access restrictions to a {{ mgl-name }} instance 

[Security group](../../vpc/concepts/security-groups.md) rules determine the following:

* IPs that can access the instance, including web access.
* Protocol to work with Git repositories in the {{ GL }} instance: SSH or HTTPS.
* Certificate for HTTPS: [Let's Encrypt]({{ gl.docs }}/omnibus/settings/ssl/#enable-the-lets-encrypt-integration) (default) or [your own certificate]({{ gl.docs }}/omnibus/settings/ssl/#configure-https-manually).
* Whether or not access to [{{ GL }} Container Registry]({{ gl.docs }}/ee/user/packages/container_registry/) is provided.

To set traffic rules for a {{ GL }} instance:

1. [Create a security group](../../vpc/operations/security-group-create.md) in the {{ yandex-cloud }} network you selected when creating the instance.
1. [Add](../../vpc/operations/security-group-add-rule.md) inbound and outbound traffic rules to the security groups. See the list of rules further below.
1. [Contact support]({{ link-console-support }}) to bind a security group to a {{ GL }} instance.

   If you do not bind a separate security group to an instance, the group created by default in the instance's network will apply to it. The rules of this security group added for other services affect access to the {{ GL }} instance.

   If you have no access to the instance or it works incorrectly when using the default security group, add rules for {{ GL }} to this group or bind a new one.

## Rules for incoming traffic {#ingress-rules}

#|
|| **Why the rule is required** | **Rule settings** ||
|| To access Git repositories over SSH. | 
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `{{ port-ssh }}` and `2222`. Create a separate rule for each port.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: To provide access, specify subnet IP ranges within {{ yandex-cloud }} or public IP addresses of web-connected computers. Examples:

   * `172.16.0.0/12`
   * `85.32.32.22/32`

   To allow all traffic from any IP, specify `0.0.0.0/0`.
|| 
|| To enable Let’s Encrypt certificate.

This certificate is [used by default]({{ gl.docs }}/omnibus/settings/ssl/#enable-the-lets-encrypt-integration) when using Git repositories over HTTPS. If you do not specify this rule, add [your own certificate]({{ gl.docs }}/omnibus/settings/ssl/#configure-https-manually) to work over HTTPS. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `{{ port-http }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: `0.0.0.0/0`.
||
|| To access Git repositories over HTTPS. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `{{ port-https }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: To provide access, specify subnet IP ranges within {{ yandex-cloud }} or public IP addresses of web-connected computers.
||
|| For [health checks](../../network-load-balancer/concepts/health-check.md) by a network load balancer. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `80`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}`.
||
|| To connect to {{ GL }} Container Registry. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `5050`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: To provide access, specify subnet IP ranges within {{ yandex-cloud }} or public IP addresses of web-connected computers.

   To allow all traffic from any IP, specify `0.0.0.0/0`.
||
|| For requests to the [metadata](../../compute/concepts/vm-metadata.md) service when updating an instance. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `80`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: `169.254.169.254/32`.
||
|| For requests to the DNS service. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `53`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_udp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} — `<second_IP_address_in_subnet>/32`. For example, for the `10.128.0.0/24` subnet, this will be the `10.128.0.2/32` CIDR.
||
|| For requests to NTP servers to support two-factor authentication. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `123`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_udp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: `0.0.0.0/0`.
||
|#

## Rules for outgoing traffic {#egress-rules}

{{ mgl-name }} relies on third-party integrations to provide its services. If you limit the outgoing traffic in the instance's security group, the instance may work incorrectly. To avoid this, add one of the rules presented in the table to the security group. You need them to create [backups](../concepts/backup.md) and store user objects in {{ objstorage-full-name }}.

Your choice of rule depends on the certificate you are using: Let's Encrypt (default) or self-signed.

#|
|| **Instance certificate type** | **Rule settings** ||
|| Let's Encrypt |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `{{ port-https }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: `0.0.0.0/0`.
||
|| Self-signed certificate |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `{{ port-https }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: `213.180.193.243/32`.
||
|#
