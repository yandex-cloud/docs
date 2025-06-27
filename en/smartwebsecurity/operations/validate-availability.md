---
title: How to check resource availability in a {{ sws-name }} domain
description: Follow this guide to check the status and availability of your resources from the {{ sws-full-name }} proxy server load balancer.
---

# Checking resources for availability

Make sure the [proxy server](../concepts/domain-protect.md#proxy), [domain](../concepts/domain-protect.md#domain), and your infrastructure are configured correctly, and the proxy server load balancer has access to the associated resources:

{% list tabs group=instructions %}

- Management console {#console}

  {% include [validate-resource-stats](../../_includes/smartwebsecurity/validate-resource-stats.md) %}

{% endlist %}

### See also {#see-also}

* [{#T}](setup-infrastructure.md)
* [{#T}](proxy-create.md)
* [{#T}](domain-create.md)
* [{#T}](host-connect.md)

