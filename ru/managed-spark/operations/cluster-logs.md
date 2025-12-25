# Просмотр логов кластера {{ SPRK }}

{{ msp-full-name }} позволяет [получить фрагмент логов кластера](#get-log) за выбранный период.

{% include [log-duration](../../_includes/mdb/log-duration.md) %}

## Получить лог кластера {#get-log}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.common.logs }}**.
    1. Укажите **Уровень** логов и период времени, за который нужно отобразить лог.

- CLI {#cli}

    При помощи YC CLI вы можете получить логи кластера {{ SPRK }} из [лог-группы](../../logging/concepts/log-group.md) сервиса {{ cloud-logging-full-name }}.

    1. {% include [cli-install](../../_includes/cli-install.md) %}

    1. {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Чтобы посмотреть записи в лог-группе, выполните команду:

        ```
        yc logging read --group-name <имя_лог-группы> --follow
        ```

        Вы можете посмотреть имя лог-группы на вкладке **{{ ui-key.yacloud.common.overview }}** кластера {{ SPRK }}.

{% endlist %}
