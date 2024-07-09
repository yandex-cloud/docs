# Привязка конфигурации к адресу

Привяжите [конфигурацию](../concepts/glossary.md#configuration) к адресу, чтобы получать [уведомления о доставке писем](../concepts/notification.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находятся адрес и конфигурация.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/at.svg) **{{ ui-key.yacloud.postbox.label_identities }}**.
    1. Выберите адрес, к которому хотите привязать конфигурацию.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.edit }}**.
    1. Выберите конфигурацию или [создайте новую](create-configuration.md).
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- AWS CLI {#aws-cli}

    Если у вас еще нет интерфейса командной строки AWS CLI, [установите и сконфигурируйте его](../tools/aws-cli.md).

    Чтобы привязать конфигурацию к адресу, назначьте сервисному аккаунту, через который работает AWS CLI, [роль](../security/index.md#postbox-editor) `postbox.editor`.

    1. В терминале определите переменные:

        ```bash
        ENDPOINT={{ postbox-endpoint }}
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

## См. также {#see-also}

* [Создать конфигурацию](create-configuration.md)
