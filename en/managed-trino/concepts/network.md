---
title: Networking in {{ mtr-full-name }}
description: This article outlines networking in {{ mtr-full-name }} ways to configure it.
---

# Networking in {{ mtr-name }}

When creating a cluster, you can specify the following network settings:

* [Network and subnet](../../vpc/concepts/network.md) within it.

   There are some [requirements](#subnet-requirements) in place for the subnet because the cluster dedicates special [IP addresses](#addresses).

* [Security groups](#security-groups) to allow only specific outbound traffic.

## Cluster IP addresses {#addresses}

The {{ mtr-name }} cluster dedicates special IP addresses in its subnet. The cluster uses these addresses to connect to other {{ yandex-cloud }} resources. You can add a [catalog](../concepts/index.md#catalog) and configure it to connect to your cloud resources supported by {{ mtr-name }} [connectors](../concepts/index.md#connector).

By default, the cluster's IP addresses only work within the internal network. To give your cluster access to resources on the internet, [configure a NAT gateway](../../vpc/operations/create-nat-gateway.md).

{{ mtr-name }} clusters use dynamic IP addresses which may change, e.g., during maintenance. So if you need to identify cluster addresses, use subnet ranges instead of specific IP addresses. For example, if you are using [{{ interconnect-full-name }}](../../interconnect/concepts/index.md) to connect a {{ mtr-name }} cluster to your on-prem infrastructure, we recommend whitelisting the whole subnet range in your firewall settings. 

## Requirements for cluster subnets {#subnet-requirements}

Make sure your {{ mtr-name }} cluster subnet meets the following conditions:

* The cluster's IP range does not overlap with the {{ trino-service-address }} service IP range {{ yandex-cloud }} uses to manage {{ mtr-name }} cluster components.

    If this condition is not met, you will get an error when creating the cluster.

    This requirement also applies to networks in your on-premise infrastructure if it is connected to the {{ mtr-name }} cluster via [{{ interconnect-full-name }}](../../interconnect/concepts/index.md). From a {{ TR }} cluster, you will not be able to connect to resources with IPs from the {{ trino-service-address }} range.

* The subnet range includes at least `2 × N` vacant IP addresses, where `N` is the total number of instances of all {{ mtr-name }} cluster components. Let's assume your cluster consists of a coordinator and four workers. Then, `N = 5`, and the subnet must have at least ten vacant addresses.

    If you have enabled autoscaling for workers, use the maximum possible number of cluster workers in your calculations.

## Security groups {#security-groups}

[Security groups](../../vpc/concepts/security-groups.md) do not restrict inbound traffic to the {{ mtr-name }} cluster and do not affect the {{ TR }} web interface availability. You do not need to configure any inbound traffic rules.

You can use security groups to configure outbound traffic rules, e.g., when setting up a new [catalog](../concepts/index.md#catalog).

{% note tip %}

Before you connect from your {{ mtr-name }} cluster to another {{ yandex-cloud }} resource, make sure the resource's security groups allow such a connection.

{% endnote %}

If you have not assigned any security group to your {{ mtr-name }} cluster, the default security group will be automatically assigned.
