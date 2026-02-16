---
title: Запись логов в журнал выполнения в {{ er-full-name }}
description: Следуя данной инструкции, вы сможете настроить логирование шины.
---

# Записать логи в журнал выполнения шины

{% include [logging-note](../../../../_includes/functions/logging-note.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [шина](../../../concepts/eventrouter/bus.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева выберите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. В строке с нужной шиной нажмите ![image](../../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. В блоке **{{ ui-key.yacloud.logging.label_title }}**:

      1. Включите опцию **{{ ui-key.yacloud.logging.field_logging }}**.
      1. В поле **{{ ui-key.yacloud.logging.label_destination }}** выберите:

         * `{{ ui-key.yacloud.common.folder }}` — чтобы записывать логи в лог-группу по умолчанию для каталога, в котором находится шина.
         * {% include [log-group](../../../../_includes/functions/log-group.md) %}

      1. (Опционально) Выберите минимальный уровень логирования.

  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

  {% include [min-log-level](../../../../_includes/serverless-integrations/bus-min-log-level.md) %}

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  ## Включение логирования {#enabled}
  
  Чтобы записывать логи при [создании](create.md) или [изменении](update.md) [шины](../../../concepts/eventrouter/bus.md), укажите параметр `--enable-logging`.
  
  ## Назначение логирования {#destination}
  
  Чтобы записывать логи в [лог-группу](../../../../logging/concepts/log-group.md) по умолчанию для [каталога](../../../../resource-manager/concepts/resources-hierarchy.md#folder), укажите идентификатор этого каталога в подпараметре `folder-id` параметра `--log-options`. Если шина находится в другом каталоге, [аккаунту](../../../../iam/concepts/users/accounts.md), от имени которого выполняется команда, на этот каталог должна быть назначена [роль](../../../../logging/security/index.md#logging-editor) `logging.editor` или выше.
  
  Чтобы записывать логи в пользовательскую лог-группу, укажите идентификатор этой лог-группы в подпараметре `log-group-id` параметра `--log-options`. Лог-группа может находиться в другом каталоге. Аккаунту, от имени которого выполняется команда, на этот каталог должна быть назначена роль `logging.editor` или выше.

  ## Минимальный уровень логирования {#log-level}

  Чтобы задать минимальный уровень логирования, укажите его в параметре `min-level` при создании или изменении шины.

  {% include [min-log-level](../../../../_includes/serverless-integrations/bus-min-log-level.md) %}

  ## Отключение логирования {#disabled}

  Чтобы отключить логирование, при изменении шины укажите параметр `--disable-logging`.

  ## Пример команды {#example}

  Чтобы записывать логи в пользовательскую лог-группу, выполните команду:

  ```
  {{ yc-serverless }} eventrouter bus update <имя_или_идентификатор_шины> \
    --enable-logging \
    --log-options log-group-id=<идентификатор_лог-группы>,min-level=<минимальный_уровень_логирования>
  ```

  Где:

  * `--log-options` — параметры логирования:
    * `log-group-id` — идентификатор лог-группы.
    * `min-level` — минимальный уровень логирования. Необязательный параметр.

  Результат:

  ```text
  id: f66302237ren********
  folder_id: b1g0ijbfaqsn********
  cloud_id: b1gia87mbaom********
  created_at: "2025-07-13T16:47:31.559209Z"
  name: my-bus
  status: ACTIVE
  logging_enabled: true
  log_options:
    log_group_id: e23uimb4tabs********
    min_level: DEBUG
  ```

- API {#api}

  Чтобы записывать логи в журнал выполнения шины, воспользуйтесь методом REST API [Update](../../../../serverless-integrations/eventrouter/api-ref/Bus/update.md) для ресурса [Bus](../../../../serverless-integrations/eventrouter/api-ref/Bus/index.md) или вызовом gRPC API [Bus/Update](../../../../serverless-integrations/eventrouter/api-ref/grpc/Bus/update.md).

{% endlist %}