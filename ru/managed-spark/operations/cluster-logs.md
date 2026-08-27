# Просмотр логов кластера {{ SPRK }}

{{ msp-full-name }} позволяет [получить фрагмент логов кластера](#get-log) за выбранный период.

{% include [log-duration](../../_includes/mdb/log-duration.md) %}

## Получить лог кластера {#get-log}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог.
    1. [Перейдите]({{ link-console-main }}/link/managed-spark) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.
    1. Нажмите на имя нужного кластера и перейдите в раздел **{{ ui-key.yacloud.common.logs }}**.
    1. Укажите **{{ ui-key.yacloud.logging.label_filter-levels }}** логов и период времени, за который нужно отобразить лог.

- CLI {#cli}

    При помощи YC CLI вы можете получить логи кластера {{ SPRK }} из [лог-группы](../../logging/concepts/log-group.md) сервиса {{ cloud-logging-full-name }}.

    1. {% include [cli-install](../../_includes/cli-install.md) %}

    1. {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Чтобы посмотреть записи в лог-группе, выполните команду:

        ```
        yc logging read --group-name <имя_лог-группы> --follow
        ```

        Вы можете посмотреть имя лог-группы в разделе **{{ ui-key.yacloud.common.overview }}** кластера {{ SPRK }}.

{% endlist %}
