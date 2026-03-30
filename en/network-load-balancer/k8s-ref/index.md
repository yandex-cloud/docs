---
title: '{{ network-load-balancer-full-name }} tool reference for {{ managed-k8s-full-name }}'
description: This page provides a {{ network-load-balancer-name }} tool reference for {{ managed-k8s-name }}.
---

# Resource reference for {{ managed-k8s-name }}

This reference describes the configuration of {{ k8s }} resources for deploying network load balancers in {{ managed-k8s-full-name }} clusters:

* [Service](service.md): Description of [{{ k8s }} services](../../managed-kubernetes/concepts/index.md#service) used as network load balancers.
* [NetworkPolicy](networkpolicy.md): Description of [{{ k8s }} network policies](../../managed-kubernetes/concepts/network-policy.md) used for filtering incoming traffic in the network load balancer.

{% note warning %}

Do not modify or delete the network load balancer and target groups automatically created in your folder via the {{ yandex-cloud }} interfaces (the management console, {{ TF }}, CLI, or API). This may cause incorrect operation of the {{ managed-k8s-name }} cluster.

{% endnote %}
