# Настроить логирование

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится канал уведомлений.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
    1. Выберите канал.
    1. Справа вверху нажмите кнопку ![image](../../_assets/edit.svg) **{{ ui-key.yacloud.common.edit }}** .
    1. В разделе **{{ ui-key.yacloud.cns.section_logging }}** включите **{{ ui-key.yacloud.cns.field_logging }}**.
    1. В списке **{{ ui-key.yacloud.cns.field_logging-folder }}** выберите каталог, в котором будет расположена [лог-группа](../../logging/concepts/log-group.md).
    1. В поле **{{ ui-key.yacloud.cns.field_log-group }}** выберите существующую лог-группу или создайте новую.
    1. Чтобы остановить запись логов, отключите **{{ ui-key.yacloud.cns.field_logging }}**.

- AWS CLI {#aws-cli}

    1. Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../storage/tools/aws-cli.md).
    1. Выполните команду:

        ```bash
        aws sns set-endpoint-attributes \
            --endpoint-arn <ARN_эндпоинта> \
            --attributes LoggingPath=<идентификатор_каталога>/<идентификатор_лог_группы>
        ```

        Где:

        * `--endpoint-arn` — идентификатор (ARN) эндпоинта.
        * `--attributes` — параметры эндпоинта. Для настройки логирования используйте параметр `LoggingPath`.
        * `идентификатор_каталога` — идентификатор каталога, в котором расположена [лог-группа](../../logging/concepts/log-group.md). Каталог должен находиться в том же облаке, что и приложение.
        * `идентификатор_лог_группы` — идентификатор лог_группы, в которую будут отправляться логи. Этот параметр необязательный: если идентификатор не указан, будет использована дефолтная лог-группа.

    1. Чтобы отключить логирование, передайте пустое значение для атрибута `LoggingPath`.        

    Подробнее о команде `aws sns set-endpoint-attributes` см. в [документации AWS](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/set-endpoint-attributes.html).


{% endlist %}