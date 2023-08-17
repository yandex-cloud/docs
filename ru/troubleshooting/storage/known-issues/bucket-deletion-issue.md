# Устранение ошибки Bucket not empty при удалении бакета


## Описание проблемы {#issue-description}

* При попытке удалить бакет управлен появляется сообщение об ошибке `Bucket is not empty`;

## Решение {#issue-resolution}

Для удаления каталога или бакета необходимо сначала удалить из него все объекты.
Вот самые распространённые причины невозможности удалить бакет:

* В бакете есть незавершённые составные загрузки;
* В бакете остались загруженные объекты;
* В бакете удалены все объекты, но в нём включено версионирование, и существуют старые версии удалённых объектов.

Вы можете удалить все старые версии объектов и незавершённые загрузки, настроив автоматическое удаление всех этих сущностей в правиле жизненного цикла бакета.
Правила жизненного цикла обрабатываются в 00 часов по UTC раз в сутки.

{% list tabs %}

- Консоль управления

  Вы можетепосмотреть и удалить незавершённые загрузки из Консоли управления [по этой инструкции](../../../storage/operations/objects/deleting-multipart.md)

  Удаление всех объектов из бакета средствами консоли управления описано в материале [по этой ссылке](../../../storage/operations/objects/delete-all.md)

- AWS CLI

  * Наличие незавершённых составных загрузок можно проверить, выполнив команду:

    ```bash
    aws --endpoint <https://storage.yandexcloud.net> s3api list-multipart-uploads \
    --bucket \<bucket_name\>
    ```

  * Удалить такие загрузки можно командой `abort-multipart-upload`:

    ```bash
    aws --endpoint <https://storage.yandexcloud.net> s3api abort-multipart-upload \
    --bucket \<bucket_name\> --key \<object_key\> --upload-id \<upload_id\>
    ```

  * Наличие объектов в бакете можно проверить командой `list-objects`:

    ```bash
    aws --endpoint <https://storage.yandexcloud.net> s3api list-objects \
    --bucket \<bucket_name\>
    ```

  * Удалить один объект можно командой `delete-object`:

    ```bash
    aws --endpoint <https://storage.yandexcloud.net> s3api delete-object \
    --bucket \<bucket_name\> --key
    ```

  * Удалить сразу несколько объектов можно командой `delete-object`:

    ```bash
    aws --endpoint <https://storage.yandexcloud.net> s3api delete-objects \
    --bucket \<bucket_name\> --delete '\{ "Objects": \[ \{ "Key": \}, \{ "Key": \}, ...\] \}'
    ```

  * Если в вашем бакете включено версионирование, то после удаления самих объектов в каталоге (бакете) всё ещё хранятся их прошлые версии. Их тоже необходимо удалить. Увидеть старые версии можно так:

    ```bash
    aws --endpoint <https://storage.yandexcloud.net> s3api list-object-versions \
    --bucket \<bucket_name\>

  * Удалить конкретную версию объекта можно командой:

    ```bash
    aws --endpoint <https://storage.yandexcloud.net> s3api delete-object \
    --bucket \<bucket_name\> --key \<key_name\> --version-id \<version_id\>
    ```

{% endlist %}
