[Документация Yandex Cloud](../../../index.md) > [Yandex MetaData Hub](../../index.md) > Data Catalog > Пошаговые инструкции > Каталог > Удаление каталога

# Удаление каталога


{% note info %}

Эта функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно удалить каталог метаданных.
    1. [Перейдите](https://console.yandex.cloud/link/metadata-hub) в сервис **Yandex MetaData Hub**.
    1. В блоке **Управляйте метаданными** выберите **Data Catalog**.
    1. Справа от имени каталога, который вы хотите удалить, нажмите ![horizontal-ellipsis](../../../_assets/horizontal-ellipsis.svg) и выберите **Удалить**.
    1. В открывшемся окне нажмите кнопку **Удалить**.

- Terraform {#tf}

  1. Откройте конфигурационный файл, использованный при [создании каталога](create-catalog.md#tf).
  1. Удалите ресурс `yandex_datacatalog_catalog`, соответствующий нужному каталогу метаданных, и ссылки на него. Описание ресурса приведено в [документации провайдера](../../../terraform/resources/datacatalog_catalog.md).

  1. Проверьте план изменений и примените его:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список планируемых изменений: ресурсы и/или выходные переменные. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

- API {#api}

    [Пройдите аутентификацию](../../api-ref/authentication-datacatalog.md). Воспользуйтесь методом REST API [deleteCatalog](../../datacatalog/api-ref/Catalog/deleteCatalog.md) для ресурса [Catalog](../../datacatalog/api-ref/Catalog/index.md) или вызовом gRPC API [CatalogService/DeleteCatalog](../../datacatalog/api-ref/grpc/Catalog/deleteCatalog.md).

    Передайте идентификатор удаляемого каталога метаданных в параметре `catalogId` (REST) или `catalog_id` (gRPC). Его можно получить со [списком каталогов](catalog-list.md#api).

{% endlist %}