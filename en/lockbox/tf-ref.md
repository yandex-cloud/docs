---
title: "{{ TF }} reference for {{ lockbox-full-name }}"
description: "This page provides reference information on the {{ TF }} provider resources and data sources supported for {{ lockbox-name }}."
---

# {{ TF }} reference for {{ lockbox-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ lockbox-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_lockbox_secret]({{ tf-provider-resources-link }}/lockbox_secret) | [Secret](./concepts/secret.md#secret) |
| [yandex_lockbox_secret_iam_binding]({{ tf-provider-resources-link }}/lockbox_secret_iam_binding) | [Assigning](../iam/concepts/access-control/index.md#access-bindings) access permissions for a secret |
| [yandex_lockbox_secret_version]({{ tf-provider-resources-link }}/lockbox_secret_version) | [Secret version](./concepts/secret.md#version) |

## Data sources {#data-sources}

{{ lockbox-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_lockbox_secret]({{ tf-provider-datasources-link }}/datasource_lockbox_secret) | Information about a [secret](./concepts/secret.md#secret) |
| [yandex_lockbox_secret_version]({{ tf-provider-datasources-link }}/datasource_lockbox_secret_version) | Information about a [secret version](./concepts/secret.md#version) |