---
title: Инструкция о том, как выгрузить логи из {{ cloud-logging-name }} в поток {{ yds-name }}
description: Из статьи вы узнаете, как выгрузить логи из {{ cloud-logging-name }} в поток {{ yds-name }}.
---

# Выгрузить логи в {{ yds-name }}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится лог-группа.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
    1. В строке с лог-группой нажмите значок ![image](../../_assets/console-icons/ellipsis.svg).
    1. В открывшемся меню нажмите кнопку **{{ ui-key.yacloud.common.edit }}**.
    1. В поле **{{ ui-key.yacloud.logging.label_stream }}** выберите имеющийся [поток данных](../../data-streams/concepts/glossary.md#stream-concepts) или [создайте](../../data-streams/operations/manage-streams.md#create-data-stream) новый.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}
  
    Чтобы выгружать логи в [поток данных](../../data-streams/concepts/glossary.md#stream-concepts), выполните команду:

    ```bash
    yc logging group update \
      --name=<имя_лог-группы> \
      --data-stream=<идентификатор_потока>
    ```

    Где:
    * `--name` — имя лог-группы.
    * `--data-stream` — идентификатор потока данных [{{ yds-full-name }}](../../data-streams/index.yaml), который состоит из [зоны доступности](../../overview/concepts/geo-scope.md), [идентификатора облака](../../resource-manager/operations/cloud/get-id.md), идентификатора [базы данных](../../ydb/concepts/resources.md#database) и имени [потока данных](../../data-streams/concepts/glossary.md#stream-concepts).

    {% include [stream-name-example](../../_includes/data-streams/stream-name-example.md) %}

- API {#api}

    Чтобы выгружать логи в [поток данных](../../data-streams/concepts/glossary.md#stream-concepts), воспользуйтесь методом REST API [update](../api-ref/LogGroup/update.md) для ресурса [LogGroup](../api-ref/LogGroup/index.md) или вызовом gRPC API [LogGroupService/Update](../api-ref/grpc/LogGroup/update.md).

{% endlist %}

В указанный поток данных автоматически будут перенаправляться записи, которые добавили в лог-группу.