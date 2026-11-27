---
title: Изменение каталога метаданных
description: Следуя данной инструкции, вы сможете изменить параметры каталога метаданных в {{ data-catalog-full-name }}.
alternate:
  - href: ru/metadata-hub/operations/data-catalog/update-catalog.md
    type: text/markdown
    title: Markdown version
---

# Изменение каталога


{% note info %}

{% include [preview-pp](../../../_includes/preview-pp.md) %}

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно изменить каталог метаданных.
    1. [Перейдите]({{ link-console-main }}/link/metadata-hub) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. В блоке **{{ ui-key.yacloud.metadata-hub.label_manage-metadata }}** выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
    1. Справа от имени каталога, который вы хотите изменить, нажмите ![horizontal-ellipsis](../../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
    1. В поле **{{ ui-key.yacloud.common.name }}** укажите новое имя каталога.
    1. Измените описание каталога.
    1. Добавьте или удалите [метки {{ yandex-cloud }}](../../../resource-manager/concepts/labels.md).
    1. Включите или выключите опцию **AI-разметка метаданных**.
    
        Если AI-разметка включена, AI-ассистент предлагает описания, [домены](../../concepts/data-catalog.md#domains-and-subdomains), [классификации и теги](../../concepts/data-catalog.md#classifications-and-tags), [глоссарии и термины](../../concepts/data-catalog.md#glossaries-and-terms), а также размечает с их помощью ваши метаданные. Предложения ассистента можно подтвердить, отредактировать или отклонить. Для этого наведите курсор на значок **{{ ui-key.yacloud.data-catalog.label_ai-label }}** рядом с предложением ассистента и выберите нужное действие.

    1. Нажмите кнопку **{{ ui-key.yacloud.common.save-changes }}**.

- {{ TF }} {#tf}

  1. Откройте конфигурационный файл, использованный при [создании каталога](create-catalog.md#tf).
  1. Измените параметры нужного ресурса `yandex_datacatalog_catalog`: `name`, `description` или `labels`. Для включения AI-разметки задайте значение `true` в поле `ai_enabled` параметра `ai_markup_rules`, для выключения — `false`. Сохраните остальные параметры каталога.

     Структура параметров приведена в [документации провайдера]({{ tf-provider-resources-link }}/datacatalog_catalog).

  1. Проверьте план изменений и примените его:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

- API {#api}

    [Пройдите аутентификацию](../../api-ref/authentication-datacatalog.md). Воспользуйтесь методом REST API [updateCatalog](../../datacatalog/api-ref/Catalog/updateCatalog.md) для ресурса [Catalog](../../datacatalog/api-ref/Catalog/index.md) или вызовом gRPC API [CatalogService/UpdateCatalog](../../datacatalog/api-ref/grpc/Catalog/updateCatalog.md).

    Передайте идентификатор каталога метаданных в `catalog.id`, новые значения параметров — в объекте `catalog`, а список изменяемых полей — в `updateMask`. Например, чтобы изменить описание:

    ```json
    {
      "catalog": {
        "id": "<идентификатор_каталога_метаданных>",
        "description": "<новое_описание>"
      },
      "updateMask": "description"
    }
    ```

    Для управления AI-разметкой используется поле `catalog.aiMarkupRules.aiEnabled` (в gRPC — `catalog.ai_markup_rules.ai_enabled`). В gRPC маска передается в `update_mask`.

    Всегда указывайте маску: если ее не передать, значения всех отсутствующих в запросе полей будут сброшены. Поля, перечисленные в маске без новых значений, также будут сброшены.

{% endlist %}
