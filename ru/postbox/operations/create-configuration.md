# Создание конфигурации

Создайте [конфигурацию](../concepts/glossary.md#configuration), чтобы получать [уведомления о доставке писем](../concepts/notification.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится адрес.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/list-ul.svg) **{{ ui-key.yacloud.postbox.label_configuration-sets }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.postbox.button_create-configuration-set }}**.
    1. Введите имя и (опционально) описание конфигурации.
    1. В блоке **{{ ui-key.yacloud.postbox.label_event-destinations }}** нажмите **{{ ui-key.yacloud.common.add }}**:
        1. Введите название [подписки](../concepts/glossary.md#subscription).
        1. Выберите [поток данных](../../data-streams/concepts/glossary.md#stream-concepts) {{ yds-full-name }}, в который будут отправляться уведомления о доставке писем. Если у вас нет потока данных, [создайте его](../../data-streams/operations/manage-streams.md#create-data-stream).
        1. Выберите опцию **{{ ui-key.yacloud.common.enabled }}**, чтобы активировать подписку.

        Можно добавить несколько подписок.

    1. Нажмите кнопку **{{ ui-key.yacloud.postbox.button_create-configuration-set }}**.

- AWS CLI {#aws-cli}

    Если у вас еще нет интерфейса командной строки AWS CLI, [установите и сконфигурируйте его](../tools/aws-cli.md).

    Чтобы создать конфигурацию, назначьте сервисному аккаунту, через который работает AWS CLI, [роль](../security/index.md#postbox-editor) `postbox.editor`.

    1. В терминале определите переменные:

        ```bash
        ENDPOINT={{ postbox-endpoint }}
        PROFILE=<имя_профиля>
        CONFIGSET_NAME=<имя_конфигурации>
        IDENTITY=<домен>
        KINESIS_ENDPOINT=https://yds.serverless.yandexcloud.net/{{ region-id }}/<идентификатор_каталога>/<идентификатор_базы_данных_{{ ydb-short-name }}>
        TOPIC=<имя_потока_данных>
        ```

    1. Создайте [конфигурацию](../concepts/glossary.md#configuration):

        ```bash
        aws sesv2 create-configuration-set \
           --endpoint-url=$ENDPOINT \
           --profile $PROFILE \
           --configuration-set-name $CONFIGSET_NAME
        ```

    1. Добавьте [подписку](../concepts/glossary.md#subscription) в конфигурацию:

        ```bash
        aws sesv2 create-configuration-set-event-destination \
           --endpoint-url=$ENDPOINT \
           --profile $PROFILE \
           --configuration-set-name $CONFIGSET_NAME \
           --event-destination-name <имя_подписки> \
           --event-destination "{\"Enabled\":true,\"KinesisFirehoseDestination\":{\"DeliveryStreamArn\":\"arn:aws:keenesis:::$KINESIS_ENDPOINT:$TOPIC\",\"IamRoleArn\":\"arn:\"}}"

        ```

        Можно добавить несколько подписок.

{% endlist %}

Чтобы получать уведомления, [привяжите](bind-configuration.md) конфигурацию к адресу.
