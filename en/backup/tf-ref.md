---
title: '{{ TF }} reference for {{ backup-full-name }}'
description: This page provides reference information on the Terraform provider resources supported for {{ backup-name }}.
---

# {{ TF }} reference for {{ backup-full-name }}


{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

{{ backup-name }} supports the following {{ TF }} provider resources:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_backup_policy]({{ tf-provider-resources-link }}/backup_policy) | [Backup policy](./concepts/policy.md) |
| [yandex_backup_policy_bindings]({{ tf-provider-resources-link }}/backup_policy_bindings) | Associating a backup policy with a [VM](../compute/concepts/vm.md) or a [{{ baremetal-full-name }} server](../baremetal/concepts/servers.md) |

## Data sources {#data-sources}

{{ billing-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_backup_policy]({{ tf-provider-datasources-link }}/backup_policy) | Backup policy information |