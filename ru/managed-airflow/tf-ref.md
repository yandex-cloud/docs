# Справочник {{ TF }} для {{ maf-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ maf-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_airflow_cluster]({{ tf-provider-maf }}) | [Кластер](./concepts/index.md#cluster) |
| [yandex_airflow_cluster_iam_binding]({{ tf-provider-resources-link }}/airflow_cluster_iam_binding) | [Настройка](../iam/concepts/access-control/index.md#access-bindings) прав доступа к кластеру |
