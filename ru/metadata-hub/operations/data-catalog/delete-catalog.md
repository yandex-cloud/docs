---
title: Удаление каталога метаданных
description: Следуя данной инструкции, вы сможете удалить каталог метаданных в {{ data-catalog-full-name }}.
---

# Удаление каталога


{% note info %}

{% include [preview-pp](../../../_includes/preview-pp.md) %}

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно удалить каталог метаданных.
    1. [Перейдите]({{ link-console-main }}/link/metadata-hub) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. В блоке **{{ ui-key.yacloud.metadata-hub.label_manage-metadata }}** выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
    1. Справа от имени каталога, который вы хотите удалить, нажмите ![horizontal-ellipsis](../../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
    1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- {{ TF }} {#tf}

  1. Откройте конфигурационный файл, использованный при [создании каталога](create-catalog.md#tf).
  1. Удалите ресурс `yandex_datacatalog_catalog`, соответствующий нужному каталогу метаданных, и ссылки на него. Описание ресурса приведено в [документации провайдера]({{ tf-provider-resources-link }}/datacatalog_catalog).

  1. Проверьте план изменений и примените его:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

- API {#api}

    [Пройдите аутентификацию](../../api-ref/authentication-datacatalog.md). Воспользуйтесь методом REST API [deleteCatalog](../../datacatalog/api-ref/Catalog/deleteCatalog.md) для ресурса [Catalog](../../datacatalog/api-ref/Catalog/index.md) или вызовом gRPC API [CatalogService/DeleteCatalog](../../datacatalog/api-ref/grpc/Catalog/deleteCatalog.md).

    Передайте идентификатор удаляемого каталога метаданных в параметре `catalogId` (REST) или `catalog_id` (gRPC). Его можно получить со [списком каталогов](catalog-list.md#api).

{% endlist %}
