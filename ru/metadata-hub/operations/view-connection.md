---
title: Как получить информацию о подключении {{ metadata-hub-name }}. Пошаговые инструкции
description: Пошаговые инструкции по работе с {{ connection-manager-name }} в {{ yandex-cloud }}. Из статьи вы узнаете, как просматривать подключения.
---

# Просмотр информации о подключении



{% include notitle [preview](../../_includes/note-preview.md) %}



## Получить список подключений {#connection-list}


{% note info %}

В списке подключений показываются только те подключения, к которым у пользователя есть доступ (выдана [роль `connection-manager.auditor`](../security/connection-manager-roles.md#connection-manager-auditor) или [роль `connection-manager.viewer`](../security/connection-manager-roles.md#connection-manager-viewer)). Пользователь с доступом к каталогу будет видеть все подключения в этом каталоге.

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Выберите сервис **{{ metadata-hub-full-name }}**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список подключений:

  1. Посмотрите описание команды CLI для получения списка подключений:

      ```bash
      yc connection-manager connection list --help
      ```

  1. Получите список подключений, выполнив команду:
      
      ```bash
      yc connection-manager connection list
      ```

      Чтобы получить только нужные подключения, передайте в команде один или несколько флагов:

      * `--db-type` — тип базы данных. Возможные значения: `postgresql`, `mysql`, `clickhouse`, `mongodb`, `kafka`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`.

      * `--is-manual` — подключения, созданные вручную.

      * `--mdb-cluster-id` — идентификатор кластера.

      * `--is-on-premise` — подключения к пользовательским инсталляциям.
      
      Например, чтобы получить подключения к пользовательским инсталляциям базы данных `mysql`, выполните команду:
      
      ```bash
      yc connection-manager connection list \
        --db-type mysql \
        --is-on-premise
      ```

- API {#api}

  Чтобы получить список подключений {{ connection-manager-name }} в каталоге по умолчанию, воспользуйтесь методом REST API [Connection.List](../api-ref/Connection/list.md) или методом gRPC API [ConnectionService.List](../api-ref/grpc/Connection/list.md).

  Чтобы посмотреть список подключений в другом каталоге, передайте в запросе идентификатор каталога. [Подробнее о том, как получить идентификатор каталога](../../resource-manager/operations/folder/get-id.md).

{% endlist %}

## Просмотр информации о подключении {#connection-get}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Выберите сервис **{{ metadata-hub-full-name }}**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
  1. Нажмите на строку подключения для просмотра детальной информации о нем.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить информацию о подключении:
  
  1. Посмотрите описание команды CLI для получения информации о подключении:

      ```bash
      yc connection-manager connection get --help
      ```

  1. Получите информацию о подключении, выполнив команду:
      
      ```bash
      yc connection-manager connection get <идентификатор_подключения>
      ```

      Идентификатор подключения можно получить со [списком подключений](#connection-list) в каталоге.

- API {#api}
  
  Чтобы получить информацию о подключении {{ connection-manager-name }}, воспользуйтесь методом REST API [Connection.Get](../api-ref/Connection/get.md) или методом gRPC API [ConnectionService.Get](../api-ref/grpc/Connection/get.md) и передайте в запросе идентификатор подключения.

  Идентификатор подключения можно получить со [списком подключений](view-connection.md#connection-list) в каталоге.

{% endlist %}

## Просмотр зависимостей подключения {#dependencies}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Выберите сервис **{{ metadata-hub-full-name }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}** и нажмите на имя нужного подключения.
  1. На панели слева выберите ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.connection-manager.label_dependences }}**.

     В списке зависимостей показываются кластеры управляемых баз данных и экземпляры сервисов, которые используют {{ connection-manager-name }} для хранения информации о подключениях. Нажмите на строку в списке зависимостей, чтобы перейти к кластеру или экземпляру сервиса.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить информацию о зависимостях подключения:
  
  1. Посмотрите описание команды CLI для получения информации о зависимостях подключения:

      ```bash
      yc connection-manager connection resolve-cluster --help
      ```

  1. Получите информацию о зависимостях подключения, выполнив команду:
      
      ```bash
      yc connection-manager connection resolve-cluster <идентификатор_подключения>
      ```

      Идентификатор подключения можно получить со [списком подключений](#connection-list) в каталоге.

      {% note info %}
      
      Для подключений к кластерам управляемых баз данных команда `resolve-cluster` возвращает топологию кластера. Для подключений к пользовательским инсталляциям баз данных команда возвращает ту же информацию, что и команда [get](#connection-get).
      
      {% endnote %}

- API {#api}
  
  Чтобы получить информацию о зависимостях подключения {{ connection-manager-name }}, воспользуйтесь методом REST API [Connection.ResolveCluster](../api-ref/Connection/resolveCluster.md) или методом gRPC API [ConnectionService.ResolveCluster](../api-ref/grpc/Connection/resolveCluster.md) и передайте в запросе идентификатор подключения.

  Идентификатор подключения можно получить со [списком подключений](view-connection.md#connection-list) в каталоге.

  {% note info %}

  Для подключений к кластерам управляемых баз данных метод `ResolveCluster` возвращает топологию кластера. Для подключений к пользовательским инсталляциям баз данных метод возвращает ту же информацию, что и метод [Get](view-connection.md#connection-get).

  {% endnote %}

{% endlist %}

## Просмотр выполненных операций {#operations}

{% include [connection-manager-operations](../../_includes/metadata-hub/connection-manager-operations.md) %}