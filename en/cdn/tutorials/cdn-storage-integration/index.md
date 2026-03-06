---
title: Integrating an L7 load balancer with {{ cdn-full-name }} and {{ objstorage-full-name }}
description: In this tutorial, you will set up an L7 {{ alb-full-name }} that uses a {{ objstorage-full-name }} bucket as a backend and receives user requests via {{ cdn-full-name }} to reduce content delivery time.
canonical: '{{ link-docs }}/tutorials/web/cdn-storage-integration'
---

{% include [cdn-storage-integration](../../../_tutorials/infrastructure/cdn-storage-integration.md) %}

* [Management console](./console.md): Create your infrastructure step by step from the {{ yandex-cloud }} management console.
* [{{ TF }}](./terraform.md): Streamline creating and managing your resources using the _Infrastructure as Code_ (IaC) approach. Download a {{ TF }} configuration example from the GitHub repository and then deploy your infrastructure using the [{{ yandex-cloud }} {{ TF }} provider]({{ tf-docs-link }}).