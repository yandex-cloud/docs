1. [Подготовьте облако к работе](#before-you-begin).
1. [Зарегистрируйте Telegram-бота](#create-bot).
1. [Создайте инфраструктуру](#deploy).
1. [Проверьте работу Telegram-бота](#test-bot).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../../../_tutorials/_tutorials_includes/telegram-bot-serverless/paid-resources.md) %}


## Зарегистрируйте Telegram-бота {#create-bot}

{% include [create-bot](../../../_tutorials/_tutorials_includes/telegram-bot-serverless/create-bot.md) %}


## Создайте инфраструктуру {#deploy}

{% include [terraform-definition](../../_tutorials_includes/terraform-definition.md) %}

Для создания инфраструктуры с помощью {{ TF }}:
1. [Установите {{ TF }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

    {% list tabs group=infrastructure_description %}

    - Готовая конфигурация {#ready}

      1. Клонируйте [репозиторий](https://sourcecraft.dev/yandex-cloud-examples/yc-telegram-bot-serverless) с конфигурационными файлами, необходимым для создания бота, для этого в терминале выполните команду [git](https://git-scm.com/):

          ```bash
          git clone https://git@git.sourcecraft.dev/yandex-cloud-examples/yc-telegram-bot-serverless.git
          ```

      1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
          * `telegram-bot.tf` — конфигурация создаваемой инфраструктуры;
          * `telegram-bot.auto.tfvars` — файл с пользовательскими данными;
          * `telegram-bot-function.tpl` — шаблон для создания функции {{ sf-full-name }};
          * `telegram-bot-gw-spec.tpl` — шаблон спецификации API-шлюза;
          * `sayhello.png` — изображение для бота;
          * `package.json` — манифест для функции Node.js.

    - Вручную {#manual}

      1. Создайте папку для конфигурационных файлов.

      1. Создайте в папке:

          1. Конфигурационный файл `telegram-bot.tf`:

              {% cut "telegram-bot.tf" %}

              {% include [telegram-bot-tf-config](../../../_tutorials/_tutorials_includes/telegram-bot-serverless/telegram-bot-tf-config.md) %}

              {% endcut %}

          1. Шаблон для создания функции {{ sf-full-name }} `telegram-bot-function.tpl`:

              {% cut "telegram-bot-function.tpl" %}

              {% include [telegram-bot-index-js](../../../_tutorials/_tutorials_includes/telegram-bot-serverless/telegram-bot-index-js.md) %}

              {% endcut %}

          1. Шаблон спецификации API-шлюза `telegram-bot-gw-spec.tpl`:

              {% cut "telegram-bot-gw-spec.tpl" %}

              {% include [telegram-bot-gw-spec](../../../_tutorials/_tutorials_includes/telegram-bot-serverless/telegram-bot-gw-spec.md) %}

              {% endcut %}

          1. Файл с пользовательскими данными `telegram-bot.auto.tfvars`:

              ```text
              bot_token   = "<токен_Telegram-бота>"
              bucket_name = "<имя_бакета>"
              cloud_id    = "<идентификатор_облака>"
              folder_id   = "<идентификатор_каталога>"
              ```

          1. Манифест для функции Node.js `package.json`:

              {% include [telegram-bot-package-json](../../../_tutorials/_tutorials_includes/telegram-bot-serverless/telegram-bot-package-json.md) %}

    {% endlist %}

    Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:
    * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
    * Назначение [роли](../../../iam/concepts/access-control/roles.md) сервисному аккаунту — [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).
    * [Статический ключ доступа](../../../iam/concepts/authorization/access-key.md) — [yandex_iam_service_account_static_access_key]({{ tf-provider-resources-link }}/iam_service_account_static_access_key).
    * [Бакет](../../../storage/concepts/bucket.md) — [yandex_storage_bucket]({{ tf-provider-resources-link }}/storage_bucket).
    * [Объект](../../../storage/concepts/object.md) — [yandex_storage_object]({{ tf-provider-resources-link }}/storage_object).
    * [API-шлюз](../../../api-gateway/concepts/index.md) — [yandex_api_gateway]({{ tf-provider-resources-link }}/api_gateway).
    * [Функция](../../../functions/concepts/index.md) — [yandex_function]({{ tf-provider-resources-link }}/function).
    * Назначение [роли на функцию](../../../functions/security/index.md) — [yandex_function_iam_binding]({{ tf-provider-resources-link }}/function_iam_binding).

1. В файле `telegram-bot.auto.tfvars` задайте пользовательские параметры:
   * `bot_token` — токен Telegram-бота.
   * `bucket_name` — имя бакета.
   * `cloud_id` — идентификатор облака.
   * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).

1. Создайте ресурсы:

    {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

1. Настройте связь между функцией и Telegram-ботом.

    1. Измените спецификацию API-шлюза — после имеющихся строчек кода добавьте секцию `fshtb-function`:

        {% include [telegram-bot-function-bind](../../../_tutorials/_tutorials_includes/telegram-bot-serverless/telegram-bot-function-bind.md) %}

    1. Примените изменения конфигурации:

        ```bash
        terraform apply
        ```

    1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

    1. {% include [telegram-bot-setwebhook](../../../_tutorials/_tutorials_includes/telegram-bot-serverless/telegram-bot-setwebhook.md) %}


## Проверьте работу Telegram-бота {#test-bot}

{% include [test-bot](../../../_tutorials/_tutorials_includes/telegram-bot-serverless/test-bot.md) %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. Откройте конфигурационный файл `telegram-bot.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}