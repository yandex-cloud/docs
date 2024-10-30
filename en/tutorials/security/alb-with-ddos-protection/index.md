---
title: Creating an L7 load balancer with DDoS protection
description: In this tutorial, you will deploy a DDoS protection infrastructure. To do this, you will create a cloud network, set up {{ vpc-full-name }} security groups, create a {{ compute-full-name }} instance group, link it to a backend group, and then create an HTTP router and a {{ alb-full-name }} L7 load balancer.
---

{% include [alb-with-ddos-protection](../../../_tutorials/security/alb-with-ddos-protection.md) %}

* [Management console, CLI](console.md): Use the {{ yandex-cloud }} management console or CLI to create your infrastructure step by step.
* [{{ TF }}](terraform.md): Streamline creating and managing your resources using the _infrastructure as code_ (IaC) approach. Download a {{ TF }} configuration example and then deploy the infrastructure using the [{{ yandex-cloud }} {{ TF }} provider]({{ tf-docs-link }}).