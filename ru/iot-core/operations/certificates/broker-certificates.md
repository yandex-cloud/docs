---
title: "Инструкция по управлению сертификатами брокера в {{ iot-full-name }}"
description: "Из статьи вы узнаете, как получить список сертификатов брокера, добавить или удалить сертификат брокера в {{ iot-full-name }}."
---

# Управление сертификатами брокера

{% include [note-pp](../../../_includes/iot-core/note-pp.md) %}

Чтобы начать обмен сообщениями между клиентами брокера, необходимо [авторизоваться](../../concepts/authorization.md). В данном разделе описано, как управлять сертификатами брокера для соответствующего способа авторизации.

{% include [pass-priority-note](../../../_includes/iot-core/pass-priority-note.md) %}

- [Посмотреть список сертификатов брокера](broker-certificates.md#list-cert)
- [Добавить сертификат брокеру](broker-certificates.md#add-cert)
- [Удалить сертификат брокера](broker-certificates.md#delete-cert)

Для обращения к [брокеру](../../concepts/index.md#broker) используйте его уникальный идентификатор или имя. Как узнать уникальный идентификатор или имя брокера, читайте в разделе [{#T}](../broker/broker-list.md).

## Получить список сертификатов брокера {#broker-certificates-list}

{% include [broker-certificates-list](../../../_includes/iot-core/broker-certificates-list.md) %}

## Добавить сертификат {#add-cert}

{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в который вы хотите добавить сертификат брокера.
   1. Выберите сервис **{{ iot-short-name }}**.
   1. Выберите брокер.
   1. На странице **Обзор** перейдите к разделу **Сертификаты** и нажмите кнопку **Добавить сертификат**.

      - Чтобы добавить файл:

         1. Выберите способ **Файл**.
         1. Нажмите **Выбрать файл**.
         1. Выберите файл сертификата на вашем компьютере, нажмите **Открыть**.
         1. Нажмите **Добавить**.

      - Чтобы добавить текст:

         1. Выберите способ **Текст**.
         1. Вставьте тело сертификата в поле **Содержимое**.
         1. Нажмите **Добавить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}
    
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Добавьте сертификат брокеру:

  ```
  yc iot broker certificate add \
    --broker-name my-broker \
    --certificate-file broker-cert.pem
  ```

  Где:
  * `--broker-name` — имя брокера.
  * `--certificate-file` — путь к публичной части сертификата.
  
  Результат:
  ```
  broker_id: b91ki3851h**********
  fingerprint: 589ce1605...
  certificate_data: |
    -----BEGIN CERTIFICATE-----
    MIIE/jCCAuagAw...
    -----END CERTIFICATE-----
  created_at: "2019-05-29T16:40:48.230Z"
  ```

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}
  
  Подробнее о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы добавить сертификат брокеру, созданному с помощью {{ TF }}:

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     * `yandex_iot_core_broker` — параметры брокера:
       * `name` — имя брокера.
       * `description` — описание брокера.
       * `certificates` — список сертификатов брокера для авторизации с помощью [сертификатов](../../concepts/authorization.md#certs).

      Пример описания брокера в конфигурации {{ TF }}:

      ```hcl
      resource "yandex_iot_core_broker" "my_broker" {
        name        = "test-broker"
        description = "test broker for terraform provider documentation"
      ...
        certificates = [
          file("<путь_к_первому_файлу_с_сертификатом>"),
          file("<путь_ко_второму_файлу_с_сертификатом>")
        ]
      ...
      }
      ```

      Более подробную информацию о параметрах ресурса `yandex_iot_core_broker` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/iot_core_broker).
  1. В командной строке перейдите в папку, где вы отредактировали конфигурационный файл.
  1. Проверьте корректность конфигурационного файла с помощью команды:

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
  
      В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Примените изменения конфигурации:

      ```bash
      terraform apply
      ```
     
  1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Проверить сертификаты брокера можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot broker certificate list --broker-name <имя_брокера>
      ```

- API

  Добавить сертификат брокеру можно с помощью метода API [addCertificate](../../broker/api-ref/Broker/addCertificate.md).

{% endlist %}

## Удалить сертификат {#delete-cert}

{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, из которого хотите удалить сертификат брокера.
   1. Выберите сервис **{{ iot-short-name }}**.
   1. Выберите брокер.
   1. На странице **Обзор** перейдите к разделу **Сертификаты**.
   1. В строке с нужным сертификатом нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) и в выпадающем списке выберите **Удалить**.
   1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}
    
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Удалите сертификат брокера:

      ```
      yc iot broker certificate delete --broker-name my-broker --fingerprint 0f...
      ```

  1. Проверьте, что сертификат удален:

      ```
      yc iot broker certificate list --broker-name my-broker
	    ```
	  
	    Результат:
	  
	    ```
      +-------------+------------+
      | FINGERPRINT | CREATED AT |
      +-------------+------------+
      +-------------+------------+
      ```

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}
  
  Подробнее о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы удалить сертификат брокера, созданного с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и удалите значение сертификата в блоке `certificates`, во фрагменте с описанием брокера. Чтобы удалить все сертификаты, удалите блок `certificates` целиком.

      Пример описания брокера в конфигурации {{ TF }}:

      ```hcl
      resource "yandex_iot_core_broker" "my_broker" {
        name        = "test-broker"
        description = "test broker for terraform provider documentation"
      ...
        certificates = [
          file("<путь_к_первому_файлу_с_сертификатом>"),
          file("<путь_ко_второму_файлу_с_сертификатом>")
        ]
      ...
      }
      ```

      Более подробную информацию о параметрах ресурса `yandex_iot_core_broker` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/iot_core_broker).
  1. В командной строке перейдите в папку, где вы отредактировали конфигурационный файл.
  1. Проверьте корректность конфигурационного файла с помощью команды:

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
  
      В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Примените изменения конфигурации:

      ```bash
      terraform apply
      ```
     
  1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Проверить сертификаты брокера можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot broker certificate list --broker-name <имя_брокера>
      ```

- API

  Удалить сертификат брокера можно с помощью метода API [deleteCertificate](../../broker/api-ref/Broker/deleteCertificate.md).

{% endlist %}