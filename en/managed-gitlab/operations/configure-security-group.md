---
title: Setting up security groups and access restrictions for a {{ mgl-full-name }} instance
description: In this article, you will learn how to set up security groups and restrict access to a {{ mgl-name }} instance, as well as review the rules for incoming and outgoing traffic.
---

# Configuring security groups

## Security groups and {{ mgl-name }} instance access restrictions {#sg-instance}

[Security group](../../vpc/concepts/security-groups.md) rules determine the following:

* IP addresses that can access the instance, including web access.
* Protocol for working with Git repositories in the {{ GL }} instance: SSH or HTTPS.
* Certificate for HTTPS: [Let's Encrypt]({{ gl.docs }}/omnibus/settings/ssl/#enable-the-lets-encrypt-integration) (default) or [your own certificate]({{ gl.docs }}/omnibus/settings/ssl/#configure-https-manually).
* Whether or not access to [{{ GL }} Container Registry]({{ gl.docs }}/ee/user/packages/container_registry/) is provided.

{% note warning %}

The security group's setup determines the {{ mgl-name }} instance performance and availability.

{% endnote %}

To set up a security group for a {{ mgl-name }} instance:
1. [Add](../../vpc/operations/security-group-add-rule.md) rules for [incoming](#ingress-rules-instance) and [outgoing](#egress-rules-instance) traffic to an existing security group or [create](../../vpc/operations/security-group-create.md) a new group with such rules.
1. Apply the security group to the {{ GL }} instance when [creating](instance/instance-create.md) or [updating](instance/instance-update.md) it.

If you do not assign a separate security group to your instance, the default security group of its network will apply. The rules of this security group added for other services affect access to the {{ GL }} instance.

If you have issues with setting up a security group, contact [support]({{ link-console-support }}).

### Rules for incoming traffic {#ingress-rules-instance}

#|
|| **Rule purpose** | **Rule settings** ||
|| For accessing Git repositories over SSH | 
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `{{ port-ssh }}` and `2222`. Create a separate rule for each port.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: Specify IP address ranges of subnets in {{ yandex-cloud }} or public IP addresses of internet hosts to enable access from subnets and computers. Here are some examples:

   * `172.16.0.0/12`
   * `85.32.32.22/32`

   To allow all traffic from any IP address, specify `0.0.0.0/0`.
||
|| For accessing Git repositories over HTTPS. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `{{ port-https }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: Specify IP address ranges of subnets in {{ yandex-cloud }} or public IP addresses of internet hosts to enable access from subnets and computers.
||
|| For enabling Let’s Encrypt certificate.

This certificate is [used by default]({{ gl.docs }}/omnibus/settings/ssl/#enable-the-lets-encrypt-integration) when accessing Git repositories over HTTPS. If you do not specify this rule, add [your own certificate]({{ gl.docs }}/omnibus/settings/ssl/#configure-https-manually) to work over HTTPS. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `{{ port-http }}` and `{{ port-https }}`. Create a separate rule for each port.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: `0.0.0.0/0`.
||
|| For creating instance backups. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `{{ port-https }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: `213.180.193.243/32`.
||
|| For [health checks](../../network-load-balancer/concepts/health-check.md) by a network load balancer |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `80`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}`.
||
|| For connecting to {{ GL }} Container Registry. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `5050`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: Specify IP address ranges of subnets in {{ yandex-cloud }} or public IP addresses of internet hosts to enable access from subnets and computers.

   To allow all traffic from any IP address, specify `0.0.0.0/0`.
||
|#

### Rules for outgoing traffic {#egress-rules-instance}

{{ mgl-name }} relies on third-party integrations. If you limit the outgoing traffic in the instance's security group, the instance may work incorrectly. To avoid this, add the following rules to the security group:

#|
|| **Rule purpose** | **Rule settings** ||
|| For enabling Let’s Encrypt certificate. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `{{ port-https }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: `0.0.0.0/0`.
||
|| For creating instance backups. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `{{ port-https }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: `213.180.193.243/32`.
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
   
   If your subnet has a dedicated DNS server, allow outgoing traffic to it, e.g., `DNS_server_IP_address/32`.
||
|| For requests to NTP servers to support two-factor authentication. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `123`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_udp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: `0.0.0.0/0`.
||
|| For accessing workers managed by a runner [created via the management console](../tutorials/install-gitlab-runner.md#create-runner). |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `22`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: CIDR of the subnet containing the {{ mgl-name }} instance (and hosting the workers), e.g., `10.128.0.0/24`.
||
|#

## Security groups for a managed runner {#sg-runner}

To set up networking between {{ GL }} and managed runners, you need to configure required, recommended, and optional security group settings.

### Rules for incoming traffic {#ingress-rules-runner}

{% include [mr-ingress-rules](../../_includes/managed-gitlab/mr-ingress-rules.md) %}

### Rules for outgoing traffic {#egress-rules-runner}

{% include [mr-egress-rules](../../_includes/managed-gitlab/mr-egress-rules.md) %}
