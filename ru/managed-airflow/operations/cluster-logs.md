---
title: Просмотр логов кластера {{ maf-full-name }}
description: Из статьи вы узнаете, как посмотреть логи кластера {{ maf-name }}.
---

# Просмотр логов кластера {{ maf-name }}

Логи кластера хранятся в [лог-группе](../../logging/concepts/log-group.md) {{ cloud-logging-full-name }}, указанной в настройках кластера. Вы можете [изменить параметры лог-группы](../../logging/operations/retention-period.md), включая время хранения логов.

## Получить лог кластера {#get-log}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.common.logs }}**.
    1. Укажите **Уровень** логов и период времени, за который нужно отобразить лог.

- CLI {#cli}

    1. {% include [cli-install](../../_includes/cli-install.md) %}

    1. {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Чтобы прочитать логи, выполните команду:

        ```
        yc logging read --group-name <имя_лог-группы> --follow
        ```

        Имя лог-группы можно получить с [информацией о кластере](./cluster-list.md#get-cluster).

{% endlist %}