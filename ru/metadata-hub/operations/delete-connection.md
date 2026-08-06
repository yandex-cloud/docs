---
title: Как удалить подключение {{ metadata-hub-name }}. Пошаговые инструкции
description: Пошаговые инструкции по работе с {{ connection-manager-name }} в {{ yandex-cloud }}. Из статьи вы узнаете, как удалять подключения.
---

# Удаление подключения


Подключение, [созданное вручную](../quickstart/connection-manager.md#database-connections), нельзя удалить пока у него есть хотя бы одна [зависимость](../concepts/connection-manager.md#dependencies). 

Подключение, [созданное автоматически](../quickstart/connection-manager.md#mdb-integration) при создании кластера управляемой базы данных, вручную удалить нельзя. Такие подключения удаляются автоматически при удалении кластера MDB, но будут сохраняться пока есть хотя бы одна резервная копия, ссылающаяся на них. Поскольку после удаления кластера, создавшего подключение, его автоматические резервные копии хранятся еще неделю, подключение не удаляется сразу вместе с кластером.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно удалить подключение.
    1. [Перейдите]({{ link-console-main }}/link/metadata-hub) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
    1. Справа в строке подключения, которое хотите удалить, нажмите ![image](../../_assets/console-icons/ellipsis.svg) → ![image](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}** и подтвердите удаление.

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
