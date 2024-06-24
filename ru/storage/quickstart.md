---
title: "Начало работы c помощью консоли управления"
description: "Следуя данной инструкции, вы сможете создать бакет и загрузить в него объект с помощью консоли управления."
---

# Как начать работать с {{ objstorage-full-name }}

В этом разделе вы научитесь работать с сервисом с помощью консоли управления {{ yandex-cloud }}. Инструкцию о работе с AWS CLI см. в документе [{#T}](./quickstart/quickstart-aws-cli.md).

Чтобы начать работать с {{ objstorage-name }}:

1. [Создайте бакет](#the-first-bucket) для хранения данных.
1. [Загрузите файл в бакет](#upload-files).
1. [Получите ссылку на скачивание файла](#get-link).


## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.
1. На странице [**{{ ui-key.yacloud_billing.billing.label_service }}**]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
1. На странице [{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}]({{ link-console-access-management }}) убедитесь, что у вас есть [роль](../iam/roles-reference.md#editor) `editor` или выше. Роль должна быть назначена на [каталог](../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете работать, или на [облако](../resource-manager/concepts/resources-hierarchy.md#cloud), которому принадлежит этот каталог.


## Создание первого бакета {#the-first-bucket}

Чтобы создать первый бакет в {{ objstorage-name }}:

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать бакет.
1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите **{{ ui-key.yacloud.iam.folder.dashboard.value_storage }}**.
1. Введите имя бакета.

    Имя бакета должно быть уникальным для всего {{ objstorage-name }}. Это имя используется как часть URL для доступа к данным и его будут видеть ваши пользователи.
1. При необходимости ограничьте максимальный размер бакета.

    {% include [storage-no-max-limit](_includes_service/storage-no-max-limit.md) %}
    
1. Чтобы загруженные файлы всегда были доступны извне {{ yandex-cloud }}, вы можете выбрать публичный [тип доступа](concepts/bucket.md#bucket-access). 

    {% include [public-access-warning](../_includes/storage/security/public-access-warning.md) %}

    В бакете с ограниченным доступом загруженные файлы также можно сделать доступными с помощью [временных ссылок](./concepts/pre-signed-urls.md).

1. Выберите [класс хранилища](concepts/storage-class.md), который будет использоваться по умолчанию при загрузке объектов:
    * _Стандартное хранилище_ предназначено для активной работы с объектами.
    * _Холодное хранилище_ предназначено для длительного хранения объектов с редкими запросами на чтение.
    * _Ледяное хранилище_ предназначено для хранения объектов от года с очень редкими запросами на чтение.
1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.button_create }}** для завершения операции.

## Загрузка файлов в бакет {#upload-files}

Чтобы загрузить объект в бакет:

1. В [консоли управления]({{ link-console-main }}) выберите каталог.
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
1. Нажмите на имя необходимого бакета.
1. Чтобы загрузить объекты в бакет, перетащите файлы на экран с бакетом или нажмите кнопку **{{ ui-key.yacloud.storage.bucket.button_upload }}**.

## Получение ссылки на скачивание файла {#get-link}

Чтобы получить ссылку на загруженный объект:

{% include [storage-get-link-for-download](_includes_service/storage-get-link-for-download.md) %}

Полученной ссылкой вы можете поделиться или использовать ее в своем сервисе для доступа к файлу.

Операции с бакетами и объектами вы можете выполнять не только в консоли управления {{ yandex-cloud }}, но и с помощью [других инструментов](tools/index.md).


## См. также {#see-also}

* [{#T}](quickstart/quickstart-aws-cli.md).
