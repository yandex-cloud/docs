---
title: Integrating an L7 load balancer with {{ cdn-full-name }} and {{ objstorage-full-name }} using {{ TF }}
description: In this tutorial, you will use {{ TF }} to set up an L7 {{ alb-full-name }} that uses a {{ objstorage-full-name }} bucket as a backend and receives user requests via {{ cdn-full-name }} to reduce content delivery time.
canonical: '{{ link-docs }}/tutorials/web/cdn-storage-integration/terraform'
---

# Integrating an L7 load balancer with {{ cdn-short-name }} and {{ objstorage-short-name }} using {{ TF }}


{% note info %}

To implement this solution, you will need a domain. We will use the `example.com` domain name as an example.

{% endnote %}

To create an infrastructure to [integrate](./index.md) an L7 load balancer with {{ cdn-full-name }} and {{ objstorage-full-name }} using [{{ TF }}](../../../terraform/index.yaml):

{% include [cdn-storage-integration-terraform](../../../_tutorials/infrastructure/cdn-storage-integration-terraform.md) %}

#### See also {#see-also}

* [{#T}](./console.md)