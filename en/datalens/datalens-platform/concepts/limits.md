---
title: '{{ datalens-platform-full-name }} quotas and limits'
description: Learn about the quotas and limits that apply to {{ TR }} and {{ SPRK }} clusters in {{ datalens-platform-short-name }}, how to check your current quotas, and how to request an increase.
editable: false
---

# {{ datalens-platform-full-name }} quotas and limits

{{ datalens-platform-short-name }} resources are created in the cloud of {{ yandex-cloud }} selected within the [environment](clusters/index.md#environments). The following types of limits apply to them:

{% include [quotes-limits-def.md](../../../_includes/quotes-limits-def.md) %}

## Checking and increasing quotas {#manage-quotas}

Quotas are set for a cloud of {{ yandex-cloud }} and are shared by all environments within that cloud. Creating another environment within the same cloud does not increase the available quota.

To check quotas, [find the cloud in your environment settings](../operations/clusters/manage-environment.md#billing-and-quotas), go to the [quotas page in the management console]({{ link-console-quotas }}), and select that cloud. You can only change quotas via the {{ yandex-cloud }} management console.

If resources are insufficient, you can:

* Request an increase in quotas for an existing cloud.
* [Create an environment](../operations/clusters/manage-environment.md#create-environment) in another cloud for a specific resource group. In this case, the quotas of another cloud will be used.

{% note info %}

Linked clusters and REST catalogs must reside in the same cloud and the same environment. An environment in another cloud is suitable for an independent group of resources.

{% endnote %}

{% include [increase-quotas.md](../../../_includes/increase-quotas.md) %}

## {{ TR }} clusters {#trino}

### Quotas {#trino-quotas}

{% include notitle [mtr-quotas](../../../_includes/managed-trino/limits.md#quotas) %}

### Limits {#trino-limits}

{% include notitle [mtr-limits](../../../_includes/managed-trino/limits.md#limits) %}

## {{ SPRK }} clusters {#spark}

### Quotas {#spark-quotas}

{% include notitle [msp-quotas](../../../_includes/managed-spark/limits.md#quotas) %}

### Limits {#spark-limits}

{% include notitle [msp-limits](../../../_includes/managed-spark/limits.md#limits) %}
