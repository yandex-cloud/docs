---
title: Dedicated IP addresses in {{ postbox-full-name }}
description: In this article, you will learn about dedicated IP addresses and dedicated IP address pools in {{ postbox-name }}.
---

# Dedicated IP addresses

{% include [note-preview](../../_includes/note-preview.md) %}

A _dedicated IP address_ is an IP address {{ postbox-name }} uses to send emails for a single customer cloud. Unlike shared service IP addresses, the reputation of a dedicated IP address depends only on the user's traffic.

You can group dedicated IP addresses into [pools](#pools) and [assign](#binding) these pools to [configurations](configuration.md).

Dedicated IP addresses are issued to a cloud upon request. To get them, contact [support]({{ link-console-support }}).

## IP address pools {#pools}

A pool is a named group of dedicated IP addresses. The same dedicated IP address can belong only to one pool at any given time.

Each pool has `ScalingMode`. {{ postbox-name }} only supports the `STANDARD` scaling mode.

## Reserved pools {#reserved-pools}

The following pools are reserved by {{ postbox-name }}:

#|
|| **Name** | **Description** ||
|| `ses-default-dedicated-pool` | Default pool. It contains all dedicated IP addresses allocated to the cloud that are not distributed across user pools. ||
|| `ses-shared-pool` | Shared IP address pool. ||
|#

These names cannot be used for user pools. Moreover, you cannot get information about reserved pools using the [GetDedicatedIpPool](../aws-compatible-api/api-ref/get-dedicated-ip-pool.md) method, and the [ListDedicatedIpPools](../aws-compatible-api/api-ref/list-dedicated-ip-pools.md) method does not return them.

## Assigning a pool to a configuration {#binding}

To assign a pool to a configuration, use the `SendingPoolName` parameter in the configuration delivery settings. You can set this parameter using two methods:

* [CreateConfigurationSet](../aws-compatible-api/api-ref/create-configuration-set.md): Under `DeliveryOptions` when creating the configuration.
* [PutConfigurationSetDeliveryOptions](../aws-compatible-api/api-ref/put-configuration-set-delivery-options.md): For an existing configuration.

{% note warning %}

The `PutConfigurationSetDeliveryOptions` method completely updates the configuration's delivery settings. If you do not specify `SendingPoolName` during the call, the pool will be unlinked from the configuration, and emails will be sent from the service’s shared IP addresses.

{% endnote %}

{% include [delete-dedicated-ip-pool-note.md](../../_includes/postbox/delete-dedicated-ip-pool-note.md) %}

## Sending emails through a pool {#sending}

If a pool is assigned to a configuration, all emails the configuration applies to are sent from the assigned pool's IP addresses. This allows you to separate email traffic, e.g., send transactional emails from one pool and bulk emails from another.

{% note warning %}

{% include [no-ip-address-in-pool-note.md](../../_includes/postbox/no-ip-address-in-pool-note.md) %}

{% endnote %}

As soon as a pool has at least one dedicated IP address, emails using this configuration are sent automatically.

## IP warm-up {#warmup}

{{ postbox-name }} does not manage dedicated IP warm-up: IP addresses are ready for email sending as soon as they are assigned. The `WarmupStatus` and `WarmupPercentage` fields always return `DONE` and `100` and appear in the response for AWS SDK compatibility.

#### Useful links {#see-also}

* [{#T}](../operations/manage-dedicated-ip.md)
