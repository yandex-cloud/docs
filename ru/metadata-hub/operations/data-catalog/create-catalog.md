---
title: Создание каталога метаданных
description: Следуя данной инструкции, вы сможете создать каталог метаданных в {{ data-catalog-full-name }}.
alternate:
  - href: ru/metadata-hub/operations/data-catalog/create-catalog.md
    type: text/markdown
    title: Markdown version
---

# Создание каталога


{% note info %}

{% include [preview-pp](../../../_includes/preview-pp.md) %}

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать каталог метаданных.
    1. [Перейдите]({{ link-console-main }}/link/metadata-hub) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. В блоке **{{ ui-key.yacloud.metadata-hub.label_manage-metadata }}** выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.data-catalog.label_create-catalog }}**.
    1. Задайте параметры каталога:

       * В поле **{{ ui-key.yacloud.common.name }}** задайте уникальное имя каталога.
       * (Опционально) Добавьте описание каталога.
       * (Опционально) Добавьте [метки {{ yandex-cloud }}](../../../resource-manager/concepts/labels.md).

    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

    {% include [ai-on](../../../_includes/metadata-hub/data-catalog-ai-markup-on.md) %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Добавьте в конфигурационный файл описание каталога:

     ```hcl
     resource "yandex_datacatalog_catalog" "example" {
       folder_id   = "<идентификатор_каталога_ресурсов>"
       name        = "<имя_каталога_метаданных>"
       description = "<описание>"
       labels = {
         environment = "production"
       }
     }
     ```

     Укажите идентификатор каталога ресурсов {{ yandex-cloud }} в `folder_id` и имя создаваемого каталога метаданных в `name`. При необходимости задайте описание в `description` и метки в `labels`.

     Подробная информация о параметрах ресурса `yandex_datacatalog_catalog` приведена в [документации провайдера]({{ tf-provider-resources-link }}/datacatalog_catalog).

  1. Проверьте план изменений и примените его:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

- API {#api}

    [Пройдите аутентификацию](../../api-ref/authentication-datacatalog.md). Воспользуйтесь методом REST API [createCatalog](../../datacatalog/api-ref/Catalog/createCatalog.md) для ресурса [Catalog](../../datacatalog/api-ref/Catalog/index.md) или вызовом gRPC API [CatalogService/CreateCatalog](../../datacatalog/api-ref/grpc/Catalog/createCatalog.md).

    Передайте в объекте `catalog` идентификатор каталога ресурсов в `folderId`, имя каталога метаданных в `name` и при необходимости `description` и `labels`. Пример тела REST-запроса:

    ```json
    {
      "catalog": {
        "folderId": "<идентификатор_каталога_ресурсов>",
        "name": "<имя_каталога_метаданных>",
        "description": "<описание>",
        "labels": {"environment": "production"}
      }
    }
    ```

    В gRPC идентификатор каталога ресурсов передается в `catalog.folder_id`.

{% endlist %}

[*глоссарий]: {% include notitle [glossary](../../../_popups/metadata-hub/data-catalog.md#glossary) %}

[*домен]: {% include notitle [domain](../../../_popups/metadata-hub/data-catalog.md#domain) %}

[*классификация]: {% include notitle [classification](../../../_popups/metadata-hub/data-catalog.md#classification) %}

[*тег]: {% include notitle [tag](../../../_popups/metadata-hub/data-catalog.md#tag) %}

[*термин]: {% include notitle [term](../../../_popups/metadata-hub/data-catalog.md#term) %}
