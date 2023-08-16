---
title: "Начало работы с реестрами устройств {{ iot-name }}"
description: "Чтобы начать работать с {{ iot-name }}, создайте сертификат X.509, реестр и устройство. Затем настройте обмен сообщениями между реестром и устройством."
---

# Начало работы с реестрами устройств {{ iot-name }}

Чтобы начать работу с сервисом {{ iot-name }}, создайте:

1. [X.509-сертификаты](#create-ca).
1. [Реестр](#create-registry).
1. [Устройство](#create-device).

Затем [настройте обмен сообщениями](#exchange) между устройством и реестром.

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Создайте сертификат {#create-ca}

X.509-сертификаты нужны для взаимодействия клиентов MQTT: [реестра](concepts/index.md#registry) и [устройства](concepts/index.md#device). Для каждого из них нужен свой сертификат.

* Если у вас есть сертификаты, добавьте их к клиентам MQTT. Это можно сделать во время создания клиентов.
* Если у вас нет сертификатов, создайте их с помощью программы [OpenSSL](https://www.openssl.org) (команда ниже создает только один сертификат):

    ```bash
    openssl req -x509 \
    -newkey rsa:4096 \
      -keyout private-key.pem \
      -out cert.pem \
      -nodes \
      -days 365 \
      -subj '/CN=localhost'
    ```

    Где:

    * `-x509` — вид сертификата: X.509.
    * `-newkey` — алгоритм шифрования.
    * `-keyout` — файл с приватным ключом сертификата.
    * `-out` — файл с публичным ключом сертификата.
    * `-nodes` — флаг, который устанавливается, когда не надо шифровать публичный ключ.
    * `-days` — срок действия сертификата в днях.
    * `-subj` — объект запроса.

   Для каждого из клиентов MQTT укажите разные названия файлов с приватными и публичными ключами.

## Создайте реестр {#create-registry}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать реестр.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
    1. На панели слева выберите иконку **{{ ui-key.yacloud.iot.label_registries }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.iot.button_create-registry }}**.
    1. В блоке **Общая информация** добавьте имя реестра `my-registry`.
    1. Добавьте сертификаты:

        * Чтобы добавить файл:

            1. Выберите способ **{{ ui-key.yacloud.component.file-content-dialog.value_upload }}**.
            1. Нажмите кнопку **Прикрепить файл**.
            1. Выберите файл с публичным ключом сертификата и нажмите кнопку **Открыть**.
            1. Нажмите кнопку **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

        * Чтобы добавить текст:

            1. Выберите способ **{{ ui-key.yacloud.component.file-content-dialog.value_manual }}**.
            1. Вставьте публичный ключ сертификата в поле **{{ ui-key.yacloud.component.file-content-dialog.field_content }}**.
            1. Нажмите кнопку **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

    1. Нажмите кнопку **Создать**.

- CLI

    {% include [cli-install](../_includes/cli-install.md) %}

    {% include [default-catalogue](../_includes/default-catalogue.md) %}

    1. Выполните команду:

        ```bash
        yc iot registry create --name my-registry
        ```

        Результат:

        ```text
        id: b91hafek85**********
        folder_id: aoek49ghmk*********
        created_at: "2019-05-27T13:40:06.923Z"
        name: my-registry
        ```

    1. Добавьте реестру сертификат:

        ```bash
        yc iot registry certificate add \
           --registry-name my-registry \
           --certificate-file registry-cert.pem
        ```

        Где:

            * `--registry-name` — имя реестра.
            * `--certificate-file` — путь к публичному ключу сертификата.

        Результат:

        ```text
        registry_id: b91hafek85**********
        fingerprint: 589ce16050****
        certificate_data: |
           -----BEGIN CERTIFICATE-----
           MIIE/jCCAuagAwIBAgIJAPRA...
           -----END CERTIFICATE-----
        created_at: "2019-05-27T13:41:45.295Z"
        ```

{% endlist %}

## Создайте устройство {#create-device}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать устройство.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
    1. Выберите в списке реестр `my-registry`.
    1. В левой части окна выберите раздел **{{ ui-key.yacloud.iot.label_devices }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.iot.button_add-device }}**.
    1. В блоке **Общая информация** добавьте имя устройства `my-device`.
    1. Добавьте сертификаты:

        * Чтобы добавить файл:

            1. Выберите способ **{{ ui-key.yacloud.component.file-content-dialog.value_upload }}**.
            1. Нажмите кнопку **Прикрепить файл**.
            1. Выберите файл с публичным ключом сертификата и нажмите кнопку **Открыть**.
            1. Нажмите кнопку **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

        * Чтобы добавить текст:

            1. Выберите способ **{{ ui-key.yacloud.component.file-content-dialog.value_manual }}**.
            1. Вставьте публичный ключ сертификата в поле **{{ ui-key.yacloud.component.file-content-dialog.field_content }}**.
            1. Нажмите кнопку **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

    1. Нажмите кнопку **Создать**.

- CLI

    1. Выполните команду:

        ```bash
        yc iot device create \
           --registry-name my-registry \
           --name my-device
        ```

        Где:

        * `--registry-name` — название реестра, в который входит устройство.
        * `--name` — название устройства.

        Результат:

        ```text
        id: b912an77oq**********
        registry_id: b91hafek85**********
        created_at: "2019-05-27T13:44:35.164Z"
        name: my-device
        ```

    1. Добавьте устройству сертификат:

        ```bash
        yc iot device certificate add \
           --device-name my-device \
           --certificate-file ./certs/device-cert.pem
        ```

        Где:

        * `--device-name` — название устройства.
        * `--certificate-file` — путь к публичному ключу сертификата.

        Результат:

        ```text
        device_id: b912an77oq**********
        fingerprint: 65e5b05006***
        certificate_data: |
           -----BEGIN CERTIFICATE-----
           MIIE/jCCAuagAwIBAgIJANZbq...
           -----END CERTIFICATE-----
        created_at: "2019-05-27T13:45:23.306Z"
        ```

{% endlist %}

## Настройте обмен сообщениями между устройством и реестром {#exchange}

Узнайте, как:

* [Подписать устройство или реестр на получение сообщений](operations/subscribe.md).
* [Отправить сообщение](operations/publish.md).

## Что дальше {#what-is-next}

* Ознакомьтесь с [концепциями сервиса](concepts/index.md).
* Посмотрите, как [работать с реестрами и устройствами](operations/index.md).
