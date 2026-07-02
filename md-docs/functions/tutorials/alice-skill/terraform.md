[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Functions](../../index.md) > [Практические руководства](../index.md) > Интеграция с сервисами Яндекса и Yandex Cloud > [Создание навыка Алисы](index.md) > Terraform

# Создание навыка Алисы с помощью Terraform


Чтобы создать навык Алисы с помощью Terraform:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Добавьте ссылку на функцию в навык Алисы](#add-link).
1. [Протестируйте работу навыка](#test).

Если созданные ресурсы вам больше не нужны, [удалите](#clear-out) их.

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

## Создайте инфраструктуру {#deploy}

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

Чтобы создать инфраструктуру с помощью Terraform:

1. [Установите Terraform](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера Yandex Cloud (раздел [Настройте провайдер](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
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
      1. Подготовьте код для навыка Алисы. Чтобы создать [версию](*function_version) функции, вы загрузите ее код в Yandex Cloud Functions в [формате](*upload_formats) ZIP-архива.

          {% list tabs group=programming_language %}

          - Python {#python}

              Добавьте файл `parrot.py`, расположенный в склонированном репозитории, в ZIP-архив `parrot-py.zip`.

          - Node.js {#node}

              Добавьте файл `index.js`, расположенный в склонированном репозитории, в ZIP-архив `parrot-js.zip`.

          {% endlist %}

    - Вручную {#manual}

      1. Подготовьте код для навыка Алисы. Чтобы создать [версию](*function_version) функции, вы загрузите ее код в Yandex Cloud Functions в [формате](*upload_formats) ZIP-архива.

          {% list tabs group=programming_language %}
          
          - Python {#python}
          
              1. Скачайте из репозитория на GitHub файл с примером: [parrot.py](https://github.com/yandex-cloud-examples/yc-serverless-alice-skill/blob/main/parrot.py).
              1. Создайте ZIP-архив `parrot-py.zip` с файлом `parrot.py`.
          
          - Node.js {#node}
          
              1. Скачайте из репозитория на GitHub файл с примером: [index.js](https://github.com/yandex-cloud-examples/yc-serverless-alice-skill/blob/main/index.js).
              1. Создайте ZIP-архив `parrot-js.zip` с файлом `index.js`.
          
          {% endlist %}

      1. Создайте папку для файла с описанием инфраструктуры.
      1. Создайте в папке конфигурационный файл `alice-skill.tf`:

          {% cut "alice-skill.tf" %}

          ```hcl
          # Объявление переменных
          
          variable "folder_id" {
            type = string
          }
          
          variable "file_path" {
            type = string
          }
          
          variable "language" {
            type = string
          }
          
          # Настройка провайдера
          
          terraform {
            required_providers {
              yandex = {
                source = "yandex-cloud/yandex"
              }
            }
            required_version = ">= 0.13"
          }
          
          provider "yandex" {
            folder_id = var.folder_id
          }
          
          # Создание функции и версии функции
          
          resource "yandex_function" "alice_parrot" {
            name               = "alice-parrot"
            description        = "Yandex Alice skill: Parrot (repeats user input)"
            runtime            = var.language == "python" ? "python314" : "nodejs22"
            entrypoint         = var.language == "python" ? "parrot.handler" : "index.handler"
            memory             = 128
            execution_timeout  = 2
          
            content {
              zip_filename = var.file_path
            }
          
            user_hash = filesha256(var.file_path)
          }
          ```

          {% endcut %}

      1. Создайте в папке файл с пользовательскими данными `alice-skill.auto.tfvars`:

          {% cut "alice-skill.auto.tfvars" %}

          ```hcl
          folder_id         = "<идентификатор_каталога>"
          file_path         = "<локальный_путь_к_архиву_с_кодом_функции>"
          language          = "<язык_программирования>"
          ```

          {% endcut %}

    {% endlist %}

    Подробнее о параметрах используемых ресурсов в Terraform читайте в [документации провайдера](../../../terraform/resources).

1. В файле `alice-skill.auto.tfvars` задайте пользовательские параметры:

    * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
    * `file_path` — локальный путь к файлу с архивом, содержащим код функции. Например: `/Users/myuser/Temp/parrot-py.zip`.
    * `language` — в зависимости от используемого в коде функции языка программирования укажите:

        * `python` — если вы используете пример на `Python`;
        * `nodejs` — если вы используете пример на `Node.js`.

1. Создайте ресурсы:

    1. В терминале перейдите в директорию с конфигурационным файлом.
    1. Проверьте корректность конфигурации с помощью команды:
    
       ```bash
       terraform validate
       ```
    
       Если конфигурация является корректной, появится сообщение:
    
       ```bash
       Success! The configuration is valid.
       ```
    
    1. Выполните команду:
    
       ```bash
       terraform plan
       ```
    
       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
    1. Примените изменения конфигурации:
    
       ```bash
       terraform apply
       ```
    
    1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

## Добавьте ссылку на функцию в навык Алисы {#add-link}

{% list tabs %}

- Интерфейс Яндекс Диалогов

  1. Перейдите на страницу навыка Алисы в [личном кабинете](https://dialogs.yandex.ru/developer/).
  1. Нажмите ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **Создать навык Алисы** и в открывшемся окне:

      1. В поле **Название навыка** задайте уникальное имя создаваемого навыка.
      1. В поле **Backend** выберите вариант **Функция в Яндекс Облаке**. В выпадающем списке выберите созданную ранее функцию.

          {% note warning %}

          В списке отображаются функции, которые вы имеете право просматривать. Чтобы прикрепить функцию к навыку, вам необходимо разрешение на запуск функции. Это разрешение входит в роль [functions.functionInvoker](*functions_invoker) и выше.

          {% endnote %}

      1. Настройки остальных параметров оставьте без изменений и вверху страницы нажмите кнопку **Сохранить**.

{% endlist %}

[*functions_invoker]: Роль `functions.functionInvoker` позволяет вызывать функции. Подробнее об управлении доступом в Yandex Cloud читайте в разделе [Как устроено управление доступом в Yandex Cloud](../../../iam/concepts/access-control/index.md).

## Протестируйте работу навыка {#test}

{% list tabs %}

- Интерфейс Яндекс Диалогов

  1. В [личном кабинете](https://dialogs.yandex.ru/developer/) Яндекс Диалогов на странице с созданным ранее навыком в меню слева выберите **Тестирование**.
  1. Если все настроено правильно, в блоке **Чат** вы увидите сообщение с приглашением начать беседу: `Hello! I'll repeat anything you say to me.`
  1. Отправьте сообщение с любым текстом и убедитесь, что вам пришел ответ с таким же содержанием.

{% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `alice-skill.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    1. В терминале перейдите в директорию с конфигурационным файлом.
    1. Проверьте корректность конфигурации с помощью команды:
    
       ```bash
       terraform validate
       ```
    
       Если конфигурация является корректной, появится сообщение:
    
       ```bash
       Success! The configuration is valid.
       ```
    
    1. Выполните команду:
    
       ```bash
       terraform plan
       ```
    
       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
    1. Примените изменения конфигурации:
    
       ```bash
       terraform apply
       ```
    
    1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

[*function_version]: Версия содержит код функции, параметры запуска, а также все необходимые зависимости. На разных стадиях процесса разработки вы можете работать с разными версиями одной функции. Подробнее читайте в разделе [Версия функции](../../concepts/function.md#version).

[*upload_formats]: Загружать код версии функции можно несколькими способами: в редакторе в консоли управления, из локальных файлов и директорий или в виде архива. Подробнее читайте в разделе [Формат загрузки кода](../../concepts/function.md#upload).

#### Полезные ссылки {#see-also}

* [Создание навыка Алисы в консоли управления, с помощью Yandex Cloud CLI или API](console.md)