---
title: "Начало работы с брокерами {{ iot-name }}"
description: "Чтобы начать работать с {{ iot-name }}, создайте сертификат X.509 и брокер. Затем настройте обмен сообщениями."
---

# Начало работы с брокерами {{ iot-name }}

Чтобы начать работу с сервисом {{ iot-name }}:

1. [Создайте X.509-сертификат](#create-ca).
1. [Создайте брокер](#create-broker).
1. [Настройте обмен сообщениями](#exchange).

{% include [note-pp](../_includes/iot-core/note-pp.md) %}

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Создайте сертификат для брокера {#create-ca}

Если у вас есть сертификат, добавьте его к брокеру после [создания](#create-broker). Если сертификата нет, создайте его с помощью программы [OpenSSL](https://www.openssl.org):

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

## Создайте брокер {#create-broker}

{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать брокер.
   1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. На панели слева выберите иконку **{{ ui-key.yacloud.iot.label_brokers }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.iot.button_create-broker }}**.
   1. В блоке **{{ ui-key.yacloud.common.section-base }}** укажите имя брокера `my-broker`.
   1. Добавьте сертификат:

      * Чтобы добавить файл:

         1. Выберите способ `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}`.
         1. Нажмите кнопку **Прикрепить файл**.
         1. Выберите файл с публичным ключом сертификата и нажмите кнопку **Открыть**.
         1. Нажмите кнопку **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

      * Чтобы добавить текст:

         1. Выберите способ `{{ ui-key.yacloud.component.file-content-dialog.value_manual }}`.
         1. Вставьте публичный ключ сертификата в поле **{{ ui-key.yacloud.component.file-content-dialog.field_content }}**.
         1. Нажмите кнопку **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

   1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI

   {% include [cli-install](../_includes/cli-install.md) %}

   {% include [default-catalogue](../_includes/default-catalogue.md) %}

   1. Создайте брокер:

      ```bash
      yc iot broker create --name my-broker
      ```

      Результат:

      ```text
      id: b91ki3851h**********
      folder_id: aoek49ghmk*********
      created_at: "2022-05-28T11:29:42.420Z"
      name: my-broker
      status: ACTIVE
      ```

   1. Добавьте брокеру сертификат:

      ```bash
      yc iot broker certificate add \
         --broker-name my-broker \
         --certificate-file cert.pem
      ```

      Где:

      * `--broker-name` — имя брокера;
      * `--certificate-file` — путь к публичному ключу сертификата.

      Результат:

      ```text
      broker_id: b91ki3851h**********
      fingerprint: 1f21cf6d0183d****
      certificate_data: |
         -----BEGIN CERTIFICATE-----
         MIIEpDCCAow...
         -----END CERTIFICATE-----
      created_at: "2023-07-11T16:20:53.466370019Z"
      ```

{% endlist %}

## Настройте обмен сообщениями {#exchange}

1. [Подпишитесь на получение сообщений в брокере](operations/subscribe.md#broker).
1. [Отправьте сообщение в брокере](operations/publish.md#broker).

## Что дальше {#what-is-next}

* Ознакомьтесь с [концепциями сервиса](concepts/index.md).
* Посмотрите, как [работать с брокерами](operations/index.md#broker).
