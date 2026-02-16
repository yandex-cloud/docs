---
title: Deploying Nextcloud in {{ yandex-cloud }}
description: In this tutorial, you will deploy Nextcloud in a {{ yandex-cloud }} infrastructure, integrated with {{ objstorage-full-name }}.
canonical: '{{ link-docs }}/tutorials/archive/integrate-nextcloud/'
---

{% include [index](../../../_tutorials/archive/integrate-nextcloud/index.md) %}

* [Nextcloud deployment on a {{ compute-full-name }} VM using a {{ coi }}](./coi-based.md) is a way to quickly deploy the basic Nextcloud functionality in your {{ yandex-cloud }} infrastructure.
* [Manual Nextcloud deployment on a {{ compute-name }}](./fault-tolerant.md) VM or VM group is a way to deploy Nextcloud in your {{ yandex-cloud }} infrastructure manually in either the [basic](./fault-tolerant.md#the-basic-variant) or [fault-tolerant](./fault-tolerant.md#the-redundant-variant) configuration.
* [Nextcloud deployment on a {{ compute-name }} VM or VM group via {{ TF }}](./terraform.md) is a way to deploy Nextcloud in your {{ yandex-cloud }} infrastructure in either the [basic](./terraform.md#the-basic-variant) or [fault-tolerant](./terraform.md#the-redundant-variant) configuration via the [{{ yandex-cloud }} {{ TF }} provider]({{ tf-docs-link }}).