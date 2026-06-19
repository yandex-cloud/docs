1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Добавьте ссылку на функцию в навык Алисы](#add-link).
1. [Протестируйте работу навыка](#test).

Если созданные ресурсы вам больше не нужны, [удалите](#clear-out) их.

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}

## Создайте инфраструктуру {#deploy}

{% include [terraform-definition](../../_tutorials_includes/terraform-definition.md) %}

Чтобы создать инфраструктуру с помощью {{ TF }}:

1. [Установите {{ TF }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файл с описанием инфраструктуры:

    {% list tabs group=infrastructure_description %}

    - Готовая конфигурация {#ready}

      1. Склонируйте репозиторий с конфигурационными файлами и примерами кода функции:

          ```bash
          git clone https://github.com/yandex-cloud-examples/yc-serverless-alice-skill
          ```
      1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:

          * `alice-skill.tf` — конфигурация создаваемой инфраструктуры.
          * `alice-skill.auto.tfvars` — пользовательские данные.
          * `parrot.py` — файл с кодом функции на Python.
          * `index.js` — файл с кодом функции на Node.js.
      1. Подготовьте код для навыка Алисы. Чтобы создать [версию](*function_version) функции, вы загрузите ее код в {{ sf-full-name }} в [формате](*upload_formats) ZIP-архива.

          {% list tabs group=programming_language %}

          - Python {#python}

              Добавьте файл `parrot.py`, расположенный в склонированном репозитории, в ZIP-архив `parrot-py.zip`.

          - Node.js {#node}

              Добавьте файл `index.js`, расположенный в склонированном репозитории, в ZIP-архив `parrot-js.zip`.

          {% endlist %}

    - Вручную {#manual}

      1. Подготовьте код для навыка Алисы. Чтобы создать [версию](*function_version) функции, вы загрузите ее код в {{ sf-full-name }} в [формате](*upload_formats) ZIP-архива.

          {% include [prepare-code](../../_tutorials_includes/alice-skill/prepare-code.md) %}

      1. Создайте папку для файла с описанием инфраструктуры.
      1. Создайте в папке конфигурационный файл `alice-skill.tf`:

          {% cut "alice-skill.tf" %}

          {% include [alice-skill-tf-config](../../_tutorials_includes/alice-skill/alice-skill-tf-config.md) %}

          {% endcut %}

      1. Создайте в папке файл с пользовательскими данными `alice-skill.auto.tfvars`:

          {% cut "alice-skill.auto.tfvars" %}

          {% include [alice-skill-tf-vars](../../_tutorials_includes/alice-skill/alice-skill-tf-vars.md) %}

          {% endcut %}

    {% endlist %}

    Подробнее о параметрах используемых ресурсов в {{ TF }} читайте в [документации провайдера]({{ tf-provider-resources-link }}).

1. В файле `alice-skill.auto.tfvars` задайте пользовательские параметры:

    * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
    * `file_path` — локальный путь к файлу с архивом, содержащим код функции. Например: `/Users/myuser/Temp/parrot-py.zip`.
    * `language` — в зависимости от используемого в коде функции языка программирования укажите:

        * `python` — если вы используете пример на `Python`;
        * `nodejs` — если вы используете пример на `Node.js`.

1. Создайте ресурсы:

    {% include [terraform-validate-plan-apply](../../_tutorials_includes/terraform-validate-plan-apply.md) %}

{% include [add-link](../../_tutorials_includes/alice-skill/add-link.md) %}

{% include [test](../../_tutorials_includes/alice-skill/test.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `alice-skill.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../../_tutorials_includes/terraform-validate-plan-apply.md) %}

[*function_version]: Версия содержит код функции, параметры запуска, а также все необходимые зависимости. На разных стадиях процесса разработки вы можете работать с разными версиями одной функции. Подробнее читайте в разделе [{#T}](../../../functions/concepts/function.md#version).

[*upload_formats]: Загружать код версии функции можно несколькими способами: в редакторе в консоли управления, из локальных файлов и директорий или в виде архива. Подробнее читайте в разделе [{#T}](../../../functions/concepts/function.md#upload).