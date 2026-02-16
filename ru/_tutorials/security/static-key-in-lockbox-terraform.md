1. [Подготовьте окружение](#prepare).
1. [Создайте инфраструктуру](#deploy).
1. [Используйте ключ из секрета {{ lockbox-name }} для работы с сервисом](#use-key).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/static-key-in-lockbox/paid-resources.md) %}


## Подготовьте окружение {#prepare}

{% include [prepare](../_tutorials_includes/static-key-in-lockbox/prepare.md) %}


## Создайте инфраструктуру {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

Для создания инфраструктуры c помощью {{ TF }}:

1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файл с описанием инфраструктуры:

    {% list tabs group=infrastructure_description %}

    - Готовая конфигурация {#ready}

      1. Клонируйте репозиторий с конфигурационными файлами.

          ```bash
          git clone https://github.com/yandex-cloud-examples/yc-static-keys-in-lockbox
          ```

      1. Перейдите в директорию с репозиторием. В ней должен появиться файл `static-key-in-lockbox-config.tf` — конфигурация создаваемой инфраструктуры.

    - Вручную {#manual}

      1. Создайте папку для конфигурационных файлов.
      1. Создайте в папке конфигурационный файл `static-key-in-lockbox-config.tf`:

          {% cut "static-key-in-lockbox-config.tf" %}

          {% include [static-key-in-lockbox-config](../../_tutorials/_tutorials_includes/static-key-in-lockbox/config.md) %}

          {% endcut %}

    {% endlist %}

    Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:

    * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
    * Назначение [роли](../../iam/concepts/access-control/roles.md) сервисному аккаунту — [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).
    * [Секрет](../../lockbox/concepts/secret.md) — [yandex_lockbox_secret]({{ tf-provider-resources-link }}/lockbox_secret).
    * [Статический ключ доступа](../../iam/concepts/authorization/access-key.md) — [yandex_iam_service_account_static_access_key]({{ tf-provider-resources-link }}/iam_service_account_static_access_key).
    * [Версия секрета](../../lockbox/concepts/secret.md#version) — [yandex_lockbox_secret_version]({{ tf-provider-resources-link }}/lockbox_secret_version).

1. В файле `static-key-in-lockbox-config.tf` задайте пользовательские параметры:
    * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).
    * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).

1. Создайте ресурсы:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

После создания инфраструктуры, [используйте ключ из секрета для работы с сервисом](#use-key).


## Используйте ключ из секрета {{ lockbox-name }} для работы с сервисом {#use-key}

{% include [bash-windows-note-single](../../_includes/translate/bash-windows-note-single.md) %}

Используйте ключ из секрета {{ lockbox-name }} и создайте бакет в {{ objstorage-name }}:

1. Сохраните идентификатор ключа, секретный ключ и значение региона размещения в переменные окружения AWS CLI:

    ```bash
    AWS_ACCESS_KEY_ID=$(terraform output key_id)
    AWS_SECRET_ACCESS_KEY=$(terraform output key)
    AWS_DEFAULT_REGION="{{ region-id }}"
    ```

    AWS CLI будет использовать созданные переменные окружения для аутентификации при выполнении операций с ресурсами сервиса.

1. Создайте бакет в {{ objstorage-name }}, указав в команде уникальное [имя бакета](../../storage/concepts/bucket.md#naming):

    {% include [create-bucket](../_tutorials_includes/static-key-in-lockbox/create-bucket.md) %}

    {% list tabs group=instructions %}

    - AWS CLI {#aws-cli}

      ```bash
      AWS_ACCESS_KEY_ID=$(terraform output key_id) \
      AWS_SECRET_ACCESS_KEY=$(terraform output key) \
      AWS_DEFAULT_REGION="{{ region-id }}" \
      aws --endpoint-url=https://storage.yandexcloud.net \
        s3 mb s3://<имя_бакета>
      ```

      Результат:

      ```bash
      make_bucket: my-first-bucket
      ```

    {% endlist %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../storage/operations/buckets/delete.md) бакет.
1. Откройте конфигурационный файл `static-key-in-lockbox-config.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}