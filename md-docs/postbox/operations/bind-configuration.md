# Привязка конфигурации к адресу

Привяжите предварительно созданную [конфигурацию](../concepts/configuration.md) к адресу, чтобы применять ее ко всем письмам, которые отправляются с этого адреса.

Чтобы применить конфигурацию к отдельному письму, передайте ее название в заголовке `X-Ses-Configuration-Set`.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находятся адрес и конфигурация.
    1. Перейдите в сервис **Cloud Postbox**.
    1. На панели слева выберите ![image](../../_assets/console-icons/at.svg) **Адреса**.
    1. Выберите адрес, к которому хотите привязать конфигурацию.
    1. Нажмите кнопку **Редактировать**.
    1. Выберите конфигурацию или [создайте новую](create-configuration.md).
    1. Нажмите кнопку **Сохранить**.

- AWS CLI {#aws-cli}

    Если у вас еще нет интерфейса командной строки AWS CLI, [установите и сконфигурируйте его](../tools/aws-cli.md).

    Чтобы привязать конфигурацию к адресу, назначьте сервисному аккаунту, через который работает AWS CLI, [роль](../security/index.md#postbox-editor) `postbox.editor`.

    1. В терминале определите переменные:

        ```bash
        ENDPOINT=https://postbox.cloud.yandex.net
        PROFILE=<имя_профиля>
        CONFIGSET_NAME=<имя_конфигурации>
        IDENTITY=<домен>
        ```

    1. Привяжите конфигурацию к адресу:

        ```bash
        aws sesv2 put-email-identity-configuration-set-attributes \
           --endpoint-url=$ENDPOINT \
           --profile $PROFILE \
           --email-identity $IDENTITY \
           --configuration-set-name $CONFIGSET_NAME
        ```

{% endlist %}

## Полезные ссылки {#see-also}

* [Создать конфигурацию](create-configuration.md)