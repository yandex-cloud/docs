# Эмуляция множества IoT-устройств

{% note warning %}

Сервис Yandex IoT Core больше не доступен для новых пользователей. 

Текущие пользователи могут создавать ресурсы до 1 ноября 2026 года. После сервис перейдет в режим read-only, а 1 декабря 2026 года — прекратит работу. Подробнее о сроках и порядке закрытия читайте на странице [Закрытие сервиса](../sunset.md).

{% endnote %}


В этом сценарии вы узнаете, как эмулировать множество [устройств](../concepts/index.md#device), которые отправляют сообщения в MQTT-[топики](../concepts/topic/index.md). В примере эмулируется работа датчиков воздуха, которые измеряют следующие параметры:
* Температура.
* Влажность.
* Давление.
* Уровень содержания CO<sub>2</sub>.

Каждый датчик отправляет результат в формате JSON. Например:

```json
{
  "DeviceId":"0e3ce1d0-1504-4325-972f-55c961319814",
  "TimeStamp":"2020-05-21T22:53:16Z",
  "Values":[{
    "Type":"Float",
    "Name":"Humidity",
    "Value":"25.281837"
  },
  {
    "Type":"Float",
    "Name":"CarbonDioxide",
    "Value":"67.96608"
  },
  {
    "Type":"Float",
    "Name":"Pressure",
    "Value":"110.7021"
  },
  {
    "Type":"Float",
    "Name":"Temperature",
    "Value":"127.708824"
  }]
}
```

Чтобы эмулировать работу множества устройств:
1. [Подготовьте облако к работе](#before-begin).
1. [Установите Terraform](#install-terraform).
1. [Опишите инфраструктуру](#set-configuration).
1. [Разверните облачные ресурсы](#deploy).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

## Установите Terraform {#install-terraform}

С помощью Terraform в Yandex Cloud можно создавать облачные ресурсы всех типов: [виртуальные машины](../../compute/concepts/vm.md), [диски](../../compute/concepts/disk.md), [образы](../../compute/concepts/image.md) и т. д. Подробнее о ресурсах, которые можно создать с помощью Terraform, смотрите в [документации провайдера](../../terraform/index.md).

### Из зеркала {#from-yc-mirror}

{% note alert %}

Зеркало может быть недоступно.

{% endnote %}

Вы можете скачать дистрибутив Terraform для вашей платформы из [зеркала](https://hashicorp-releases.yandexcloud.net/terraform/). После загрузки добавьте путь к папке, в которой находится исполняемый файл, в переменную `PATH`:

```bash
export PATH=$PATH:/path/to/terraform
```

### С сайта HashiCorp {#from-hashicorp-site}

{% list tabs group=operating_system %}

- Windows {#windows}

  Используйте один из способов:
  * [Скачайте дистрибутив Terraform](https://www.terraform.io/downloads.html) и установите его согласно [инструкции](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started).
  * Установите Terraform с помощью пакетного менеджера [Chocolatey](https://chocolatey.org/install), используя команду:

    ```bash
    choco install terraform
    ```

- Linux {#linux}

  [Скачайте дистрибутив Terraform](https://www.terraform.io/downloads.html) и установите его согласно [инструкции](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started).

- macOS {#macos}

  Используйте один из способов:
  * [Скачайте дистрибутив Terraform](https://www.terraform.io/downloads.html) и установите его согласно [инструкции](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started).
  * Установите Terraform с помощью пакетного менеджера [Homebrew](https://brew.sh), используя команду:

    ```bash
    brew install terraform
    ```

{% endlist %}

## Опишите инфраструктуру {#set-configuration}

1. Создайте папку `iot-terraform`. В ней будут храниться конфигурационные файлы Terraform.
1. [Скачайте](https://storage.yandexcloud.net/doc-files/emulator_publish.zip) архив с файлами, которые необходимы для выполнения сценария, и распакуйте в папку `iot-terraform`.

   Архив содержит:
   * `common.tf` — настройки провайдера Terraform.
   * `files.tf` — параметры публикации файлов кода из локальной папки.
   * `function.tf` — параметры [функции](../../functions/concepts/function.md) для записи эмулированных сообщений в устройства.
   * `iot_core.tf` — параметры [реестра](../concepts/index.md#registry), в котором находятся устройства.
   * `output.tf.tf` — выходные переменные.
   * `publish` — файлы, которые необходимы для создания функции.
   * `service_account.tf` — параметры [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), который создается в сценарии.
   * `trigger.tf` — параметры [триггера](../../functions/concepts/trigger/index.md) для вызова функции с заданным таймаутом.
   * `variables.tf` — используемые переменные и их значения.
1. Отредактируйте файл `variables.tf`, указав следующие параметры для эмуляции:
   * `token` — [OAuth-токен](../../iam/concepts/authorization/oauth-token.md) для доступа к Yandex Cloud.
   * `cloud_id` — [идентификатор облака](../../resource-manager/operations/cloud/get-id.md).
   * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
   * `zone` — [зона доступности](../../overview/concepts/geo-scope.md).
   * `device_count` — количество эмулируемых устройств.

     {% note info %}

     Чтобы эмулировать работу более 1000 устройств, необходимо повысить [квоты](../concepts/limits.md), сделав запрос в техническую поддержку.

     {% endnote %}

   * `subtopic_for_publish` — [сабтопик](../concepts/topic/subtopic.md) в формате `$devices/<ID_устройства>/events/<сабтопик>`.
   * `publish_execution_timeout` — таймаут отправки сообщений в секундах.
   * `publish_cron_expression` — расписание отправки сообщений в MQTT-топик в виде cron-выражения. По умолчанию сообщения отправляются каждую минуту.

   Остальные файлы можно оставить без изменений.

## Разверните облачные ресурсы {#deploy}

1. Перейдите в папку `iot-terraform` и проверьте конфигурацию командой:

   ```bash
   terraform validate
   ```

   Результат:

   ```text
   Success! The configuration is valid.
   ```

1. Отформатируйте файлы конфигураций в текущем каталоге и подкаталогах:

   ```bash
   terraform fmt
   ```

   Результат:

   ```text
   main.tf
   variables.tf
   ```

1. После проверки конфигурации выполните команду:

   ```bash
   terraform plan
   ```

   В терминале будет выведен список ресурсов с параметрами. Это проверочный этап: ресурсы не будут созданы. Если в конфигурации есть ошибки, Terraform на них укажет.

   {% note alert %}

   Все созданные с помощью Terraform ресурсы тарифицируются. Внимательно проверьте план.

   {% endnote %}

1. Чтобы создать ресурсы, выполните команду:

   ```bash
   terraform apply
   ```

1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

   Результат:

   ```text
   Outputs:

   function = "d4erep.......aq085f0"
   iot_core = "are.......ht10enkb3u"
   service_account = "ajestqfepa.......0l6"
   trigger = "a1sva8sse.......7kf6"
   ```

   Terraform создаст все требуемые ресурсы, а в терминале будут указаны идентификаторы созданных ресурсов. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

## Удалите созданные ресурсы {#clear-out}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Удалите реестр:
     1. Перейдите в свой рабочий [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
     1. Перейдите в сервис **IoT Core**.
     1. Справа от имени созданного реестра нажмите ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.
     1. Нажмите кнопку **Удалить**.
  1. Удалите устройства:
     1. Перейдите в свой рабочий каталог.
     1. Перейдите в сервис **IoT Core**.
     1. Выберите реестр.
     1. Перейдите на вкладку **Устройства**.
     1. Справа от имени созданного устройства нажмите ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.
     1. Нажмите кнопку **Удалить**.
  1. Удалите функцию:
     1. Перейдите в свой рабочий каталог.
     1. Перейдите в сервис **Cloud Functions**.
     1. Справа от имени созданной функции нажмите ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.
     1. Нажмите кнопку **Удалить**.
  1. Удалите триггер:
     1. Перейдите в свой рабочий каталог.
     1. Перейдите в сервис **Cloud Functions**.
     1. Перейдите на вкладку **Триггеры**.
     1. Справа от имени созданного триггера нажмите ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.
     1. Нажмите кнопку **Удалить**.
  1. Удалите сервисный аккаунт:
     1. Перейдите в свой рабочий каталог.
     1. Перейдите в сервис **Identity and Access Management**.
     1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты**.
     1. В строке с именем созданного сервисного аккаунта нажмите ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.
     1. Нажмите кнопку **Удалить**.

{% endlist %}