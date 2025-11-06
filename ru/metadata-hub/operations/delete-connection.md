---
title: Как удалить подключение {{ metadata-hub-name }}. Пошаговые инструкции
description: Пошаговые инструкции по работе с {{ connection-manager-name }} в {{ yandex-cloud }}. Из статьи вы узнаете, как удалять подключения.
---

# Удаление подключения


{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно удалить подключение.
    1. Выберите сервис **{{ metadata-hub-full-name }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
    1. В списке подключений нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) справа в строке подключения, которое вы хотите удалить.
    1. Выберите пункт **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы удалить подключение:

  1. Посмотрите описание команды CLI для удаления подключения:

      ```bash
      yc metadata-hub connection-manager connection delete --help
      ```

  1. Удалите подключение, выполнив команду:
      
      ```bash
      yc metadata-hub connection-manager connection delete <идентификатор_подключения>
      ```

      Идентификатор подключения можно получить со [списком подключений](view-connection.md#connection-list) в каталоге.


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы удалить подключение, созданное с помощью {{ TF }}:

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  1. Удалите описание подключения.
  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}


- API {#api}
  
  Чтобы удалить подключение {{ connection-manager-name }}, воспользуйтесь методом REST API [Connection.Delete](../connection-manager/api-ref/Connection/delete.md) или методом gRPC API [ConnectionService.Delete](../connection-manager/api-ref/grpc/Connection/delete.md) и передайте в запросе идентификатор подключения.

   Чтобы удалить подключение {{ connection-manager-name }}, воспользуйтесь методом REST API [Connection.Delete](../connection-manager/api-ref/Connection/delete.md) или методом gRPC API [ConnectionService.Delete](../connection-manager/api-ref/grpc/Connection/delete.md) и передайте в запросе идентификатор подключения.

{% endlist %}
