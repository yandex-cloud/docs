---
title: "Инструкция о том, как удалить брокер в {{ iot-full-name }}"
description: "Из статьи вы узнаете, как удалить брокер в {{ iot-full-name }}."
---

# Удаление брокера

{% include [note-pp](../../../_includes/iot-core/note-pp.md) %}

Для обращения к [брокеру](../../concepts/index.md#broker) используйте его уникальный идентификатор или имя. Как узнать уникальный идентификатор или имя брокера, читайте в разделе [{#T}](broker-list.md).

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, из которого вы хотите удалить брокер.
    1. Выберите сервис **{{ iot-short-name }}**.
    1. Справа от имени брокера, который хотите удалить, нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) и в выпадающем списке выберите **Удалить**.
    1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. Удалите брокер:

        ```
        yc iot broker delete my-broker
        ```

    1. Проверьте, что брокер удален:

        ```
        yc iot broker list
        ```

        Результат:
        ```
        +----+------+
        | ID | NAME |
        +----+------+
        +----+------+
        ```

- {{ TF }}

    {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

    Подробнее о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

    Чтобы удалить брокер, созданный с помощью {{ TF }}:

    1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием брокера.

        Пример описания брокера в конфигурации {{ TF }}:

        ```hcl
        resource "yandex_iot_core_broker" "my_broker" {
          name        = "test-broker"
          description = "test broker for terraform provider documentation"
          }
        ...
        }
        ```

        Более подробную информацию о параметрах ресурса `yandex_iot_core_broker` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iot_core_broker).
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

        Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

        ```bash
        yc iot broker list
        ```

- API

  Чтобы удалить брокер, воспользуйтесь методом REST API [delete](../../broker/api-ref/Broker/delete.md) для ресурса [Broker](../../broker/api-ref/Broker/index.md) или вызовом gRPC API [BrokerService/Delete](../../broker/api-ref/grpc/broker_service.md#Delete).

{% endlist %}
