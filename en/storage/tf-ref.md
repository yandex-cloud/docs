---
title: "{{ TF }} reference for {{ objstorage-full-name }}"
description: "This page provides reference information on the Terraform provider resources supported for {{ network-load-balancer-name }}."
---

# {{ TF }} reference for {{ objstorage-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ objstorage-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_storage_bucket]({{ tf-provider-resources-link }}/storage_bucket) | [Bucket](./concepts/bucket.md) |
| [yandex_storage_object]({{ tf-provider-resources-link }}/storage_object) | [Object](./concepts/object.md) |