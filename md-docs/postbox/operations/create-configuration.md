# Создание конфигурации

Создайте [конфигурацию](../concepts/glossary.md#configuration), чтобы получать [уведомления об операциях с письмами](../concepts/notification.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится адрес.
    1. Перейдите в сервис **Cloud Postbox**.
    1. На панели слева выберите ![image](../../_assets/console-icons/list-ul.svg) **Конфигурации**.
    1. Нажмите кнопку **Создать конфигурацию**.
    1. Введите имя и (опционально) описание конфигурации.
    1. В блоке **Подписки** нажмите **Добавить**:
        1. Введите название [подписки](../concepts/glossary.md#subscription).
        1. Выберите [поток данных](../../data-streams/concepts/glossary.md#stream-concepts) Yandex Data Streams, в который будут отправляться уведомления об операциях с письмами. Если у вас нет потока данных, [создайте его](../../data-streams/operations/manage-streams.md#create-data-stream).
        1. Выберите типы уведомлений, которые хотите получать.
        1. Выберите опцию **Включено**, чтобы активировать подписку.

        Можно добавить несколько подписок.
    1. В блоке **Настройки доставки** включите опцию **Доставлять письмо только по защищённому соединению** и укажите минимальную версию TLS, чтобы отправлять письма от Yandex Cloud Postbox до серверов получателя только с использованием TLS-шифрования.

        {% note warning %}

        Если сервер получателя не поддерживает указанную версию TLS, письмо не будет доставлено.

        {% endnote %}

    1. В блоке **Настройки сбора статистики** включите опцию **Статистика вовлечённости**, чтобы собирать статистику открытия писем и переходов по ссылкам в письмах. Вся остальная [статистика](../concepts/statistics.md), кроме открытия писем и переходов по ссылкам, собирается по умолчанию.

        {% note info %}

        Включение опции **Статистика вовлечённости** приведет к модификации тела письма. Подробнее в разделах [Отслеживание открытия писем](../concepts/mail-opened.md) и [Отслеживание переходов по ссылкам](../concepts/click-tracking.md).

        {% endnote %}

    1. Нажмите кнопку **Создать конфигурацию**.

- AWS CLI {#aws-cli}

    Если у вас еще нет интерфейса командной строки AWS CLI, [установите и сконфигурируйте его](../tools/aws-cli.md).

    Чтобы создать конфигурацию, назначьте сервисному аккаунту, через который работает AWS CLI, [роль](../security/index.md#postbox-editor) `postbox.editor`.

    1. В терминале определите переменные:

        ```bash
        ENDPOINT=https://postbox.cloud.yandex.net
        PROFILE=<имя_профиля>
        CONFIGSET_NAME=<имя_конфигурации>
        IDENTITY=<домен>
        KINESIS_ENDPOINT=https://yds.serverless.yandexcloud.net/ru-central1/<идентификатор_каталога>/<идентификатор_базы_данных_YDB>
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