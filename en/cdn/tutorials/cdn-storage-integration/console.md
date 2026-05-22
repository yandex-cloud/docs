---
title: Integrating an L7 load balancer with {{ cdn-full-name }} and {{ objstorage-full-name }} using the management console
description: In this tutorial, you will use the management console to set up an L7 {{ alb-full-name }} that uses a {{ objstorage-full-name }} bucket as a backend and receives user requests via {{ cdn-full-name }} to reduce content delivery time.
canonical: '{{ link-docs }}/tutorials/web/cdn-storage-integration/console'
---

# Integrating an L7 load balancer with {{ cdn-short-name }} and {{ objstorage-short-name }} using the management console


{% note info %}

To implement this solution, you will need a domain. We will use the `example.com` domain name as an example.

{% endnote %}

To [set up integration](./index.md) of an L7 load balancer with {{ cdn-full-name }} and {{ objstorage-full-name }} using the [management console]({{ link-console-main }}), {{ yandex-cloud }} [CLI](../../../cli/index.yaml), or [API](../../../api-design-guide/index.yaml):

{% include [cdn-storage-integration-console](../../../_tutorials/infrastructure/cdn-storage-integration-console.md) %}

#### See also {#see-also}

* [{#T}](./terraform.md)