---
title: Управление выделенными IP-адресами в {{ postbox-full-name }}
description: Следуя данной инструкции, вы сможете создать пул выделенных IP-адресов, добавить в него IP-адреса и привязать пул к конфигурации.
---

# Управление выделенными IP-адресами

{% include [note-preview](../../_includes/note-preview.md) %}

[Выделенные IP-адреса](../concepts/dedicated-ip.md) объединяются в пулы. Если пул привязан к [конфигурации](../concepts/configuration.md), все письма, к которым она применяется, отправляются с IP-адресов привязанного пула.

Выделенные IP-адреса выдаются облаку по запросу. Чтобы получить их, обратитесь в [техническую поддержку]({{ link-console-support }}).

{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

    Если у вас еще нет интерфейса командной строки AWS CLI, [установите и сконфигурируйте его](../tools/aws-cli.md).

    Чтобы управлять выделенными IP-адресами, назначьте сервисному аккаунту, через который работает AWS CLI, [роль](../security/index.md#postbox-editor) `postbox.editor`.

    1. В терминале определите переменные:

        ```bash
        ENDPOINT={{ postbox-endpoint }}
        PROFILE=<имя_профиля>
        POOL_NAME=<имя_пула>
        CONFIGSET_NAME=<имя_конфигурации>
        IP=<выделенный_IP-адрес>
        ```

    1. Посмотрите список выделенных IP-адресов, которые выданы вашему облаку:

        ```bash
        aws sesv2 get-dedicated-ips \
           --endpoint-url=$ENDPOINT \
           --profile $PROFILE
        ```

        IP-адреса, которые не распределены по пользовательским пулам, находятся в пуле по умолчанию `ses-default-dedicated-pool`.

    1. Создайте пул:

        ```bash
        aws sesv2 create-dedicated-ip-pool \
           --endpoint-url=$ENDPOINT \
           --profile $PROFILE \
           --pool-name $POOL_NAME
        ```

        Имя пула должно быть уникальным в рамках облака и может содержать строчные латинские буквы, цифры, символы подчеркивания `_` и дефисы `-`. Длина имени — от 1 до 64 символов. Нельзя указывать имена, [зарезервированные](../concepts/dedicated-ip.md#reserved-pools) сервисом.

    1. Добавьте выделенный IP-адрес в пул:

        ```bash
        aws sesv2 put-dedicated-ip-in-pool \
           --endpoint-url=$ENDPOINT \
           --profile $PROFILE \
           --ip $IP \
           --destination-pool-name $POOL_NAME
        ```

        Один IP-адрес в каждый момент времени может находиться только в одном пуле.

    1. Привяжите пул к конфигурации:

        ```bash
        aws sesv2 put-configuration-set-delivery-options \
           --endpoint-url=$ENDPOINT \
           --profile $PROFILE \
           --configuration-set-name $CONFIGSET_NAME \
           --sending-pool-name $POOL_NAME \
           --tls-policy REQUIRE
        ```

        {% note warning %}

        Команда полностью обновляет настройки доставки конфигурации. Если выполнить ее, не указав `--sending-pool-name`, пул отвяжется от конфигурации, и письма станут отправляться с общих IP-адресов сервиса.

        {% include [no-ip-address-in-pool-note.md](../../_includes/postbox/no-ip-address-in-pool-note.md) %}

        {% endnote %}

    1. Проверьте состав пула:

        ```bash
        aws sesv2 get-dedicated-ips \
           --endpoint-url=$ENDPOINT \
           --profile $PROFILE \
           --pool-name $POOL_NAME
        ```

    1. Чтобы убрать IP-адрес из пользовательского пула, переместите его в пул по умолчанию:

        ```bash
        aws sesv2 put-dedicated-ip-in-pool \
           --endpoint-url=$ENDPOINT \
           --profile $PROFILE \
           --ip $IP \
           --destination-pool-name ses-default-dedicated-pool
        ```

    1. Удалите пул:

        ```bash
        aws sesv2 delete-dedicated-ip-pool \
           --endpoint-url=$ENDPOINT \
           --profile $PROFILE \
           --pool-name $POOL_NAME
        ```

        {% include [delete-dedicated-ip-pool-note.md](../../_includes/postbox/delete-dedicated-ip-pool-note.md) %}

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](../concepts/dedicated-ip.md)
