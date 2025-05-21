# Интерфейс командной строки {{ yandex-cloud }} (CLI)

[{{ yandex-cloud }} CLI](../../cli/) — скачиваемое программное обеспечение для управления вашими облачными ресурсами через командную строку.

## Установите {{ yandex-cloud }} CLI {#install}

{% include [install-cli](../../_includes/cli/install-cli.md) %}

## Аутентифицируйтесь в {{ yandex-cloud }} CLI {#cli-auth}

Для доступа к {{ yandex-cloud }} CLI выполните аутентификацию, выбрав один из следующих методов:

{% list tabs group=authentication %}

- Аккаунт на Яндексе {#yandex-account}

  {% include [create-profile](../../_includes/cli/create-profile.md) %}

- Федеративный аккаунт {#federated-account}

  {% include [auth-federated-user](../../_includes/cli/auth-federated-user.md) %}

- Сервисный аккаунт {#service-account}

  {% include [auth-as-sa](../../_includes/cli/auth-as-sa.md) %}

{% endlist %}

## Проверьте работу {{ yandex-cloud }} CLI с {{ objstorage-name }}

{% note info %}

Для включения отладочного вывода в консоли используйте флаг `--debug`.

{% endnote %}

### Создайте бакет {#create-bucket}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

{% include [create-bucket-via-cli](../../_includes/storage/create-bucket-via-cli.md) %}

### Загрузите объект в бакет {#upload-object}

{% include [upload-object-via-cli](../../_includes/storage/upload-obect-via-cli.md) %}

### Скачайте объект из бакета {#download-object}

{% include [upload-object-via-cli](../../_includes/storage/download-from-bucket-via-cli.md) %}