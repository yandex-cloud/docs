### В Yandex Object Storage включено шифрование данных at rest с ключом KMS {#object-storage-encryption}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | data.object-storage-encryption ||
|#

#### Описание

Для защиты критичных данных в Yandex Object Storage рекомендуется использовать шифрование бакета на стороне сервера с помощью ключей Yandex Key Management Service (server-side encryption). Такое шифрование защищает от случайной или намеренной публикации содержимого бакета в интернете. Подробнее см. в разделе [Шифрование в Object Storage](https://yandex.cloud/ru/docs/storage/concepts/encryption).

#### Инструкции и решения по выполнению

Рекомендуется включить [шифрование](https://yandex.cloud/ru/docs/tutorials/security/server-side-encryption) данных для бакетов с критическими данными
