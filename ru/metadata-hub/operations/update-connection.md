---
title: Как изменить подключение {{ metadata-hub-name }}. Пошаговые инструкции
description: Пошаговые инструкции по работе с {{ connection-manager-name }} в {{ yandex-cloud }}. Из статьи вы узнаете, как изменять подключения.
---

# Изменение подключения


Для изменения настроек подключения:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Выберите сервис **{{ metadata-hub-full-name }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
  1. В списке подключений нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) справа в строке подключения, которое вы хотите изменить.
  1. Выберите пункт **{{ ui-key.yacloud.common.edit }}**.
  1. Измените требуемые параметры подключения, такие как описание, метки, настройки сервера базы данных или данные аутентификации пользователя.
  1. Нажмите **{{ ui-key.yacloud.common.apply }}** для сохранения изменений.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Вы можете изменить настройки подключения к кластеру с управляемой базой данных и к пользовательской инсталляции базы данных.

  1. Чтобы изменить настройки подключения к кластеру с управляемой базой данных:

      1. Посмотрите описание команды CLI для изменения подключения:

          ```bash
          yc connection-manager connection update <тип_базы_данных> --help
          ```

          Возможные типы баз данных: `postgresql`, `mysql`, `clickhouse`, `mongodb`, `opensearch`, `valkey`, `greenplum`.

      1. Измените подключение, выполнив команду:
      
          ```bash
          yc connection-manager connection update <тип_базы_данных> <идентификатор_подключения> \
            --name <имя_подключения> \
            --user <имя_пользователя> \
            --password <пароль> \
            --managed-cluster-id <идентификатор_кластера>
          ```

          Где:

          * `--name` — имя подключения.

          * `--user` — имя пользователя для подключения к кластеру.

          * `--password` — пароль пользователя.
      
          * `--managed-cluster-id` — идентификатор кластера. Идентификатор кластера можно получить со списком кластеров в каталоге.

          Идентификатор подключения можно получить со [списком подключений](view-connection.md#connection-list) в каталоге.

      1. Вы можете изменить список баз данных для всех подключений, кроме подключений к {{ mos-name }}, выполнив команду:

          ```bash
          yc connection-manager connection update <тип_базы_данных> <идентификатор_подключения> \
            --databases <список_БД>
          ```

          Где `--databases` — список баз данных, разделенный запятыми.
          
          Убедитесь, что у пользователя есть необходимые права на доступ к ним.
  
  1. Чтобы изменить настройки подключения к пользовательской инсталляции базы данных:
      
      1. Посмотрите описание команды CLI для изменения подключения:

          ```bash
          yc connection-manager connection update <тип_базы_данных> --help
          ```

          Возможные типы баз данных: `postgresql`, `mysql`, `clickhouse`, `mongodb`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`.

      1. Измените подключение, выполнив команду:
      
          ```bash
          yc connection-manager connection update <тип_базы_данных> <идентификатор_подключения> \
            --name <имя_подключения> \
            --user <имя_пользователя> \
            --password <пароль> \
            --ca-certificate <путь_к_сертификату>
          ```

          Где:

          * `--name` — имя подключения.
          
          * `--description` — описание подключения.
          
          * `--labels` — список меток в формате `"<ключ>":"<значение>"`, через запятую.
          
          * `--user` — имя пользователя для подключения к кластеру.
          
          * `--password` — пароль пользователя.
          
          * `--ca-certificate` — путь к файлу CA-сертификата для TLS.
          
            По умолчанию [TLS](../../glossary/tls.md) включен. Чтобы отключить его, используйте флаг `--tls-disabled`.

      1. Дополнительно вы можете изменить:

          * Список хостов для всех подключений, кроме подключения к {{ TR }}, выполнив команду:

            ```bash
            yc connection-manager connection update <тип_базы_данных> <идентификатор_подключения> \
              --hosts <список_хостов>
            ```

            Где `--hosts` — список хостов, разделенных запятой.

            {% note warning %}

            Формат записи хостов зависит от типа базы данных. Подробнее см. в [справочнике CLI](../../cli/cli-ref/connection-manager/cli-ref/connection/update/index.md).

            {% endnote %}

          * Параметры координатора для подключения к {{ TR }}, выполнив команду:

            ```bash
            yc connection-manager connection update trino <идентификатор_подключения> \
              --coordinator <параметры_координатора>
            ```

            Где `--coordinator` — параметры координатора в формате `<хост>:<порт>`.

          * Список баз данных для всех подключений, кроме подключений к {{ TR }} и {{ OS }}, выполнив команду:

            ```bash
            yc connection-manager connection update <тип_базы_данных> <идентификатор_подключения> \
              --databases <список_БД>
            ```

            Где `--databases` — список баз данных, разделенный запятыми.
          
            Убедитесь, что у пользователя есть необходимые права на доступ к ним.

- API {#api}

  Воспользуйтесь методом REST API [Connection.Update](../api-ref/Connection/update.md) или методом gRPC API [ConnectionService.Update](../api-ref/grpc/Connection/update.md) и передайте в запросе идентификатор подключения.

  Идентификатор подключения можно получить со [списком подключений](view-connection.md#connection-list) в каталоге.

{% endlist %}


