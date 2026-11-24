[Документация Yandex Cloud](../../../index.md) > [Yandex MetaData Hub](../../index.md) > Data Catalog > Пошаговые инструкции > Каталог > Изменение каталога

# Изменение каталога


{% note info %}

Эта функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно изменить каталог метаданных.
    1. [Перейдите](https://console.yandex.cloud/link/metadata-hub) в сервис **Yandex MetaData Hub**.
    1. В блоке **Управляйте метаданными** выберите **Data Catalog**.
    1. Справа от имени каталога, который вы хотите изменить, нажмите ![horizontal-ellipsis](../../../_assets/horizontal-ellipsis.svg) и выберите **Редактировать**.
    1. В поле **Имя** укажите новое имя каталога.
    1. Измените описание каталога.
    1. Добавьте или удалите [метки Yandex Cloud](../../../resource-manager/concepts/labels.md).
    1. Включите или выключите опцию **AI-разметка метаданных**.
    
        Если AI-разметка включена, AI-ассистент предлагает описания, [домены](../../concepts/data-catalog.md#domains-and-subdomains), [классификации и теги](../../concepts/data-catalog.md#classifications-and-tags), [глоссарии и термины](../../concepts/data-catalog.md#glossaries-and-terms), а также размечает с их помощью ваши метаданные. Предложения ассистента можно подтвердить, отредактировать или отклонить. Для этого наведите курсор на значок **AI** рядом с предложением ассистента и выберите нужное действие.

    1. Нажмите кнопку **Сохранить изменения**.

- Terraform {#tf}

  1. Откройте конфигурационный файл, использованный при [создании каталога](create-catalog.md#tf).
  1. Измените параметры нужного ресурса `yandex_datacatalog_catalog`: `name`, `description` или `labels`. Для включения AI-разметки задайте значение `true` в поле `ai_enabled` параметра `ai_markup_rules`, для выключения — `false`. Сохраните остальные параметры каталога.

     Структура параметров приведена в [документации провайдера](../../../terraform/resources/datacatalog_catalog.md).

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