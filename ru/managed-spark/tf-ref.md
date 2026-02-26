# Справочник {{ TF }} для {{ msp-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ msp-full-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_spark_cluster]({{ tf-provider-msp }}) | Кластер |
| [yandex_spark_cluster_iam_binding]({{ tf-provider-resources-link }}/spark_cluster_iam_binding) | [Настройка](../iam/concepts/access-control/index.md#access-bindings) прав доступа к кластеру |
