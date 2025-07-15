---
title: How to configure the infrastructure when adding a domain in {{ sws-name }}
description: Follow this guide to set up your own domain to work via a {{ sws-full-name }} proxy server.
---

# Setting up the infrastructure

To route the network traffic between users and resources connected to your domain via a {{ sws-full-name }} [proxy server](../concepts/domain-protect.md#proxy), create a type A [resource record](../../dns/concepts/resource-record.md#a) in your domain’s public [DNS zone](../../dns/concepts/dns-zone.md#public-zones). The A record specifies that requests to your domain must be forwarded to the proxy server's public IPv4 address. To prohibit requests to resources other than through the proxy server, configure traffic restrictions on your server.

To set up your infrastructure to use a proxy server:

{% list tabs group=instructions %}

- Management console {#console}

  1. Find out the proxy server's public IPv4 address:

      1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing your proxy server.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
      1. In the left-hand panel, select ![domain-protection-icon](../../_assets/smartwebsecurity/domain-protection-icon.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection }}** and select the proxy server of interest.

          Save the proxy server’s IPv4 address under **{{ ui-key.yacloud.common.overview }}** in the **{{ ui-key.yacloud.smart-web-security.proxy-servers.publicIpColumn_dPwQF }}** field: you will need it to create a resource DNS record.
  1. {% include [create-proxy-a-record](../../_includes/smartwebsecurity/create-proxy-a-record.md) %}
  1. {% include [limit-traffic-to-yc](../../_includes/smartwebsecurity/limit-traffic-to-yc.md) %}

{% endlist %}

### See also {#see-also}

* [{#T}](validate-availability.md)
* [{#T}](proxy-create.md)
* [{#T}](domain-create.md)
* [{#T}](host-connect.md)