# Поставка данных из {{ forms-full-name }} в {{ datalens-full-name }} с использованием {{ sf-full-name }} и {{ yq-full-name }} при помощи {{ TF }}


Чтобы настроить интеграцию {{ forms-name }} и {{ datalens-name }} при помощи Terraform:

1. [Подготовьте инфраструктуру](#prepare-infrastructure).
1. [Создайте и настройте функцию {{ sf-full-name }}](#create-function).
1. [Создайте и настройте форму в {{ forms-name }}](#create-form).
1. [Настройте подключение и привязку к данным в сервисе {{ yq-full-name }}](#yq-integration).
1. [Настройте получение данных в {{ datalens-name }}](#set-up-datalens).
1. [Протестируйте интеграцию созданных ресурсов](#test-forms-integration).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#prepare-cloud}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/forms-and-datalens-paid-resources.md) %}

## Подготовьте инфраструктуру {#prepare-infrastructure}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

Чтобы подготовить инфраструктуру при помощи {{ TF }}:

1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

1. Скачайте в ту же рабочую директорию файл конфигурации [forms-and-datalens-integration.tf](https://github.com/yandex-cloud-examples/yc-serverless-forms-datalens-integration/blob/main/forms-and-datalens-integration.tf).

    В этом файле описаны:

    * Сеть и подсеть, в которых будет создаваться инфраструктура для функции {{ sf-name }}.
    * Сервисный аккаунт со следующими ролями:
        * `lockbox.payloadViewer` — для чтения секретов {{ lockbox-full-name }};
        * `functions.functionInvoker` — для вызова функции {{ sf-name }};
        * `storage.admin` — для чтения и записи данных в бакет {{ objstorage-name }}, а также управления ACL бакета;
        * `yq.viewer` и `yq.invoker` — для интеграции {{ datalens-name }} и {{ yq-name }}.      
    * Статический ключ сервисного аккаунта, который используется для создания бакета {{ objstorage-name }}.
    * Статический ключ сервисного аккаунта, который используется для создания функции {{ sf-name }}.
    * Секрет {{ lockbox-name }} для хранения данных о статическом ключе сервисного аккаунта для функции {{ sf-name }}.
    * Информационный ресурс `data` для секрета {{ lockbox-name }}, из которого функция {{ sf-name }} получает идентификатор версии секрета.
    * Бакет {{ objstorage-name }} для результатов работы функции.
    * Функция {{ sf-name }} с публичным доступом.

1. В блоке с локальными переменными файла `forms-and-datalens-integration.tf` укажите:
    * идентификатор вашего каталога в переменной `sa_folder_id`;
    * имя бакета {{ objstorage-name }} в переменной `bucket-name`.

1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

    ```bash
    terraform validate
    ```

    Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

1. Создайте необходимую инфраструктуру:

    {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}


## Создайте и настройте функцию {{ sf-name }} {#create-function}

1. Скачайте в директорию с файлом `forms-and-datalens-integration.tf` [архив с кодом функции](https://github.com/yandex-cloud-examples/yc-serverless-forms-datalens-integration/blob/main/function-zip).    

1. В блоке локальных переменных файла `forms-and-datalens-integration.tf` укажите значения:

    * `content_path` = `function.zip`.
    * `create-function` = `1`.

1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

    ```bash
    terraform validate
    ```

    Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

1. Создайте необходимую инфраструктуру:

    {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

## Создайте и настройте форму {{ forms-name }} {#set-up-form}

{% include [set-up-form](../_tutorials_includes/forms-and-datalens-set-up-form.md) %}

## Настройте подключение и привязку к данным в сервисе {{ yq-name }} {#yq-integration}

{% include [yq-integration](../_tutorials_includes/forms-and-datalens-yq-integration.md) %}

## Настройте получение данных в {{ datalens-name }} {#set-up-datalens}

{% include [yq-integration](../_tutorials_includes/forms-and-datalens-set-up-datalens.md) %}

## Протестируйте интеграцию созданных ресурсов {#test-forms-integration}

{% include [yq-integration](../_tutorials_includes/forms-and-datalens-test-integration.md) %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать.

{% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}
