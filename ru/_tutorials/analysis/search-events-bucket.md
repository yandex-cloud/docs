# Поиск событий {{ yandex-cloud }} в {{ objstorage-name }}

## Перед началом работы {#before-you-begin}

1. Установите и настройте программу [s3fs](../../storage/tools/s3fs.md) или [goofys](../../storage/tools/goofys.md), позволяющую монтировать бакеты {{ objstorage-name }} через [FUSE](https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)).
1. Смонтируйте бакет с аудитными логами к вашей файловой системе через [s3fs](../../storage/tools/s3fs.md#mounting-bucket) или [goofys](../../storage/tools/goofys.md#bucket-mounting).
1. Установите утилиту [jq](https://jqlang.org/) для поиска по файлам в формате JSON.

## Сценарии поиска {#search}

1. Чтобы искать по нескольким файлам, передайте команде `find` путь к точке монтирования бакета. Чтобы ограничить поиск периодом, укажите путь к подкаталогу с логами за нужный месяц или день.

    Пример команды для поиска событий по типу:

    ```bash
    find "<путь_к_папке>" -type f -name '*.json' -exec cat {} + | jq '.[] | select( .event_type == "{{ at-event-prefix }}.audit.iam.CreateServiceAccount")'
    ```

1. Чтобы узнать, кто удалил [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), найдите событие `DeleteFolder` со статусом `DONE` по идентификатору каталога. Поле `authentication.subject_id` содержит идентификатор инициатора операции.

    ```bash
    find "<путь_к_папке>" -type f -name '*.json' -exec cat {} + | jq '.[] | select(.event_type == "{{ at-event-prefix }}.audit.resourcemanager.DeleteFolder" and .event_status == "DONE" and .details.folder_id == "<идентификатор_каталога>") | .authentication'
    ```

1. Чтобы найти, кто выполнял операции с [виртуальной машиной](../../glossary/vm.md), отфильтруйте записи за нужный период по типу события `event_type` и идентификатору ВМ:

    ```bash
    find "<путь_к_папке>" -type f -name '*.json' -exec cat {} + | jq '.[] | select((.event_type | test("yandex\\.cloud\\.audit\\.compute\\..*Instance")) and .details.instance_id == "<идентификатор_ВМ>") | .authentication'
    ```

1. Чтобы найти, какие действия совершал пользователь за период времени, необходимо искать по идентификатору субъекта:

    ```bash
    find "<путь_к_папке>" -type f -name '*.json' -exec cat {} + | jq '.[] | select(.authentication.subject_id == "<идентификатор_пользователя>" and .event_time > "2021-03-01" and .event_time < "2021-04-01")'
    ```

    Также можно искать по имени субъекта:

    ```bash
    find "<путь_к_папке>" -type f -name '*.json' -exec cat {} + | jq '.[] | select(.authentication.subject_name == "<имя_пользователя>" and .event_time > "2021-03-01" and .event_time < "2021-04-01")'
    ```

1. Чтобы найти, какие события происходили по объектам определенного каталога, необходимо искать по идентификатору каталога:

    ```bash
    find "<путь_к_папке>" -type f -name '*.json' -exec cat {} + | jq '.[] | select(.resource_metadata != null and .resource_metadata.path != null) | select( .resource_metadata.path[] | .resource_type == "resource-manager.folder" and .resource_id == "<идентификатор_каталога>")'
    ```

    Также можно искать по имени каталога:

    ```bash
    find "<путь_к_папке>" -type f -name '*.json' -exec cat {} + | jq '.[] | select(.resource_metadata != null and .resource_metadata.path != null) | select( .resource_metadata.path[] | .resource_type == "resource-manager.folder" and .resource_name == "<имя_каталога>")'
    ```

#### Полезные ссылки {#see-also}

* [Аудитный лог](../../audit-trails/concepts/format.md)
* [Документация jq](https://jqlang.org/tutorial/)
* [s3fs](../../storage/tools/s3fs.md)
* [goofys](../../storage/tools/goofys.md)
