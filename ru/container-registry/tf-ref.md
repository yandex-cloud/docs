# Справочник {{ TF }} для {{ container-registry-full-name }}

{% include [terraform-ref-intro](../_includes/terraform-ref-intro.md) %}

## Ресурсы {#resources}

Для {{ container-registry-name }} поддерживаются следующие ресурсы провайдера {{ TF }}:

| **Ресурс {{ TF }}** | **Ресурс {{ yandex-cloud }}** |
| --- | --- |
| [yandex_container_registry]({{ tf-provider-resources-link }}/container_registry) | [Реестр](./concepts/registry.md) |
| [yandex_container_registry_iam_binding]({{ tf-provider-resources-link }}/container_registry_iam_binding) | [Привязка](../iam/concepts/access-control/index.md#access-bindings) прав доступа к реестру |
| [yandex_container_registry_ip_permission]({{ tf-provider-resources-link }}/container_registry_ip_permission) | [Доступ к реестру](./operations/registry/registry-access.md) |
| [yandex_container_repository]({{ tf-provider-resources-link }}/container_repository) | [Репозиторий](./concepts/repository.md) |
| [yandex_container_repository_iam_binding]({{ tf-provider-resources-link }}/container_repository_iam_binding) | [Привязка](../iam/concepts/access-control/index.md#access-bindings) прав доступа к репозиторию |
| [yandex_container_repository_lifecycle_policy]({{ tf-provider-resources-link }}/container_repository_lifecycle_policy) | [Политика автоматического удаления Docker-образов](./concepts/lifecycle-policy.md) |

## Источники данных {#data-sources}

Для {{ container-registry-name }} поддерживаются следующие источники данных провайдера {{ TF }}:

| **Источник данных {{ TF }}** | **Описание** |
| --- | --- |
| [yandex_container_registry]({{ tf-provider-datasources-link }}/datasource_container_registry) | Информация о [реестре](./concepts/registry.md) |
| [yandex_container_registry_ip_permission]({{ tf-provider-datasources-link }}/datasource_container_registry_ip_permission) | Информация о [доступе к реестру](./operations/registry/registry-access.md) |