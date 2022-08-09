# Поиск событий {{ yandex-cloud }} в {{ objstorage-name }}

## Перед началом работы {#before-you-begin}
1. Установите и настройте программу [s3fs](../../storage/tools/s3fs.md) или [goofys](../../storage/tools/goofys.md), позволяющую монтировать бакеты {{ objstorage-name }} через [FUSE](https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)).
1. Смонтируйте бакет с аудитными логами к вашей файловой системе через [s3fs](../../storage/tools/s3fs.md#mounting-bucket) или [goofys](../../storage/tools/goofys.md#bucket-mounting).
1. Установите утилиту [jq](https://stedolan.github.io/jq) для поиска по формату JSON.

## Сценарии поиска {#search}

1. Для поиска по нескольким файлам используйте команду `find`. В качестве аргумента командной строки укажите путь к папке, к которой подключен бакет с аудитными логами, или ее подпапку с логами за определенный месяц или сутки.

   Пример команды для поиска событий по типу:

    ```bash
    find <путь к папке> -type f -exec cat {} \; | jq  '.[] | select( .event_type == "{{ yandex-dot-cloud }}.audit.iam.CreateServiceAccount")'
    ```

1. Чтобы найти, кто удалил [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) в облаке, необходимо искать по полю `eventType` (_тип события_) по всем файлам за период с фильтром по идентификатору каталога:

   ```bash
   find <путь к папке> -type f -exec cat {} \; | jq  '.[] | select( .event_type == "{{ yandex-dot-cloud }}.audit.resourcemanager.DeleteFolder" and .details.folder_id == "<идентификатор каталога>") | .authentication'
   ```

1. Чтобы найти, кто создал/остановил/перезапустил/удалил виртуальную машину, необходимо искать по полю `eventType` по всем файлам за период с фильтром по идентификатору ВМ:

   ```bash
   find <путь к папке> -type f -exec cat {} \; | jq  '.[] | select((.event_type | test("yandex\\.cloud\\.audit\\.compute\\..*Instance")) and .details.instance_id == "<идентификатор ВМ>") | .authentication'
   ```

3. Чтобы найти, какие действия совершал пользователь за период времени, необходимо искать по идентификатору субъекта:

   ```bash
   find <путь к папке> -type f -exec cat {} \; | jq  '.[] | select(.authentication.subject_id == "<идентификатор пользователя>" and .event_time > "2021-03-01" and .event_time < "2021-04-01")'
   ```

   Так же можно искать по имени субъекта:

   ```bash
   find <путь к папке> -type f -exec cat {} \; | jq  '.[] | select(.authentication.subject_name == "<имя пользователя>" and .event_time > "2021-03-01" and .event_time < "2021-04-01")'
   ```

4. Чтобы найти, какие события происходили по объектам определенного каталога, необходимо искать по идентификатору каталога:

   ```bash
   find <путь к папке> -type f -exec cat {} \; | jq  '.[] | select(.resource_metadata != null and .resource_metadata.path != null) | select( .resource_metadata.path[] | .resource_type == "resource-manager.folder" and .resource_id == "<идентификатор каталога>")'
   ```

   Так же можно искать по имени каталога:

   ```bash
   find <путь к папке> -type f -exec cat {} \; | jq  '.[] | select(.resource_metadata != null and .resource_metadata.path != null) | select( .resource_metadata.path[] | .resource_type == "resource-manager.folder" and .resource_name == "<имя каталога>")'
   ```

#### См. также {#see-also}

* [Аудитный лог](../concepts/format.md)
* [Документация jq](https://stedolan.github.io/jq/tutorial)
* [s3fs](../../storage/tools/s3fs.md)
* [goofys](../../storage/tools/goofys.md)