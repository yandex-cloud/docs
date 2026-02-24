### В Yandex Object Storage включено шифрование данных at rest с ключом KMS {#object-storage-encryption}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | data.object-storage-encryption ||
|#

#### Описание

{% note tip "**Автоматическая проверка**" %}

Данный контроль автоматически проверяет настройки шифрования на бакетах Object Storage.

{% endnote %}

Для защиты критичных данных в Yandex Object Storage рекомендуется использовать шифрование бакета на стороне сервера с помощью ключей Yandex Key Management Service (server-side encryption). Такое шифрование защищает от случайной или намеренной публикации содержимого бакета в интернете. Подробнее см. в разделе [Шифрование](https://yandex.cloud/ru/docs/storage/concepts/encryption) документации Object Storage.

#### Инструкции и решения по выполнению

* Рекомендуется включить шифрование данных для бакетов с критическими данными: https://yandex.cloud/ru/docs/tutorials/security/server-side-encryption