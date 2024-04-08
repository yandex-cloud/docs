# {{ TF }} reference for {{ backup-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ backup-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_backup_policy]({{ tf-provider-resources-link }}/backup_policy) | [Backup policy](./concepts/policy.md) |