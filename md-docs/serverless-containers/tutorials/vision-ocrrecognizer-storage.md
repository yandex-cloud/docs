# Регулярное распознавание изображений и PDF-документов из бакета {{ objstorage-short-name }}

В этом руководстве вы с помощью [{{ vision-full-name }}]({{ link-docs-ai }}vision/concepts/ocr/index) настроите автоматическое распознавание изображений в [поддерживаемых форматах]({{ link-docs-ai }}vision/concepts/ocr/index#image-requirements) и PDF-документов, регулярно загружаемых в [бакет]({{ link-docs }}/storage/concepts/bucket) [{{ objstorage-full-name }}]({{ link-docs }}/storage/).


## Процесс распознавания {#ocr}

![image](../../_assets/vision/ocr-storage-recognizer.svg)

1. Пользователь загружает изображения или документы в бакет {{ objstorage-full-name }}, в директорию ([префикс]({{ link-docs }}/storage/concepts/object#folder)) `input`.
1. [Триггер]({{ link-docs }}/functions/concepts/trigger/index) [{{ sf-full-name }}]({{ link-docs }}/functions/) запускается по таймеру и проверяет наличие файлов в папке `input`. После этого файлы отправляются на распознавание в [контейнер]({{ link-docs }}/serverless-containers/concepts/container) [{{ serverless-containers-full-name }}]({{ link-docs }}/serverless-containers/).
1. Идет процесс распознавания файлов, идентификатор операции сохраняется в папке `process` в исходном бакете.
1. После успешного завершения операции, результаты распознавания сохраняются в папке `result` в виде JSON и TXT файлов. Идентификатор успешно выполненной операции удаляется из папки `process`.

Для создания инфраструктуры используется [{{ TF }}-провайдер {{ yandex-cloud }}]({{ tf-provider-link }}). Исходный код руководства доступен на [GitHub](https://github.com/yandex-cloud-examples/yc-vision-ocr-recognizer).

Чтобы настроить автоматическое распознавание изображения с помощью {{ vision-name }}:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Загрузите файлы для распознавания и проверьте работу сервиса](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).



### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для регулярного распознавания изображений и документов входят:
* плата за хранение данных в бакете и операции с ними (см. [тарифы {{ objstorage-name }}]({{ link-docs }}/storage/pricing));
* плата за использование {{ vision-name }} (см. [тарифы для {{ vision-name }}]({{ link-docs-ai }}vision/pricing));
* плата за количество вызовов контейнера, вычислительные ресурсы, выделенные для выполнения приложения, и исходящий трафик (см. [тарифы {{ serverless-containers-name }}]({{ link-docs }}/serverless-containers/pricing));
* плата за хранение и операции с [секретом]({{ link-docs }}/lockbox/concepts/secret) (см. [тарифы {{ lockbox-name }}]({{ link-docs }}/lockbox/pricing)).


## Создайте инфраструктуру {#deploy}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

Для создания инфраструктуры с помощью {{ TF }}:
1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).

1. Подготовьте файлы с описанием инфраструктуры:

    1. Клонируйте репозиторий с конфигурационными файлами.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-vision-ocr-recognizer.git
        ```

    1. Перейдите в директорию `terraform` внутри репозитория.

    1. В файле `variables.auto.tfvars` задайте пользовательские параметры:
        * `cloud_id` — идентификатор облака.
        * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
        * `zone` — зона доступности.

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
   
      В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
   1. Примените изменения конфигурации:
   
      ```bash
      terraform apply
      ```
   
   1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

Будет создан бакет с именем в формате `ocr-recognition-...`.


## Загрузите файлы для распознавания и проверьте работу сервиса {#test}

1. [Загрузите](../../storage/operations/objects/upload.md) файлы для распознавания в папку `input` внутри бакета, созданного ранее.
1. Откройте в бакете папку `result` — там должны отобразиться результаты распознавания в виде файлов с расширением .txt и .json.


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Удалите файлы из бакета.
1. Откройте конфигурационный файл `main.tf` и удалите описание создаваемой инфраструктуры из файла.
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
    
       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
    1. Примените изменения конфигурации:
    
       ```bash
       terraform apply
       ```
    
    1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.