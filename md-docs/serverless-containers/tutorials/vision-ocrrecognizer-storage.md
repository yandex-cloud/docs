# Регулярное распознавание изображений и PDF-документов из бакета Object Storage

В этом руководстве вы с помощью [Yandex Vision OCR](https://aistudio.yandex.ru/docs/ru/vision/concepts/ocr/index) настроите автоматическое распознавание изображений в [поддерживаемых форматах](https://aistudio.yandex.ru/docs/ru/vision/concepts/ocr/index#image-requirements) и PDF-документов, регулярно загружаемых в [бакет](../../storage/concepts/bucket.md) [Yandex Object Storage](../../storage/index.md).


## Процесс распознавания {#ocr}

![image](../../_assets/vision/ocr-storage-recognizer.svg)

1. Пользователь загружает изображения или документы в бакет Yandex Object Storage, в директорию ([префикс](../../storage/concepts/object.md#folder)) `input`.
1. [Триггер](../../functions/concepts/trigger/index.md) [Yandex Cloud Functions](../../functions/index.md) запускается по таймеру и проверяет наличие файлов в папке `input`. После этого файлы отправляются на распознавание в [контейнер](../concepts/container.md) [Yandex Serverless Containers](../index.md).
1. Идет процесс распознавания файлов, идентификатор операции сохраняется в папке `process` в исходном бакете.
1. После успешного завершения операции, результаты распознавания сохраняются в папке `result` в виде JSON и TXT файлов. Идентификатор успешно выполненной операции удаляется из папки `process`.

Для создания инфраструктуры используется [Terraform-провайдер Yandex Cloud](../../terraform/index.md). Исходный код руководства доступен на [GitHub](https://github.com/yandex-cloud-examples/yc-vision-ocr-recognizer).

Чтобы настроить автоматическое распознавание изображения с помощью Vision OCR:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Загрузите файлы для распознавания и проверьте работу сервиса](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).



### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для регулярного распознавания изображений и документов входят:
* плата за хранение данных в бакете и операции с ними ([тарифы Object Storage](../../storage/pricing.md));
* плата за использование Vision OCR ([тарифы для Vision OCR](https://aistudio.yandex.ru/docs/ru/vision/pricing));
* плата за количество вызовов контейнера, вычислительные ресурсы, выделенные для выполнения приложения, и исходящий трафик ([тарифы Serverless Containers](../pricing.md));
* плата за хранение и операции с [секретом](../../lockbox/concepts/secret.md) ([тарифы Yandex Lockbox](../../lockbox/pricing.md)).


## Создайте инфраструктуру {#deploy}

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

Для создания инфраструктуры с помощью Terraform:
1. [Установите Terraform](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера Yandex Cloud (раздел [Настройте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).

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
   
      В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
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
    
       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
    1. Примените изменения конфигурации:
    
       ```bash
       terraform apply
       ```
    
    1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.