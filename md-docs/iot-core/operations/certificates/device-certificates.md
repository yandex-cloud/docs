# Управление сертификатами устройства

{% note warning %}

Сервис Yandex IoT Core больше не доступен для новых пользователей. 

Текущие пользователи могут создавать ресурсы до 1 ноября 2026 года. После сервис перейдет в режим read-only, а 1 декабря 2026 года — прекратит работу. Подробнее о сроках и порядке закрытия читайте на странице [Закрытие сервиса](../../sunset.md).

{% endnote %}

Чтобы начать обмен данными и командами между устройствами и реестрами, необходимо [авторизоваться](../../concepts/authorization.md). В данном разделе описано, как управлять сертификатами устройства для соответствующего способа авторизации.

{% note info %}

Если X.509 сертификат используется вместе с паролем, приоритет пароля выше.

{% endnote %}

* [Посмотреть список сертификатов устройства](device-certificates.md#list-cert)
* [Добавить сертификат устройству](device-certificates.md#add-cert)
* [Удалить сертификат устройства](device-certificates.md#delete-cert)

Для обращения к [устройству](../../concepts/index.md#device) используйте его уникальный идентификатор или имя. Как узнать уникальный идентификатор или имя устройства, читайте в разделе [Получение информации об устройстве](../device/device-list.md).

## Получить список сертификатов {#device-certificates-list}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится устройство.
   1. Перейдите в сервис **IoT Core**.
   1. Выберите реестр, в котором находится устройство.
   1. Перейдите на вкладку **Устройства**.
   1. Выберите устройство.
   1. На странице **Обзор** перейдите к разделу **Сертификаты**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Посмотрите список сертификатов устройства:

  ```bash
  yc iot device certificate list --device-name my-device
  ```

  Результат:

  ```text
  +------------------------------------------+---------------------+
  |               FINGERPRINT                |     CREATED AT      |
  +------------------------------------------+---------------------+
  | df3cc4f337eba01a264803d15b119e2d******** | 2019-05-29 17:14:36 |
  | 65e5b050069da5ca5996a4a8a9251409******** | 2019-05-29 17:14:18 |
  +------------------------------------------+---------------------+
  ```

- API {#api}

  Чтобы получить список сертификатов устройства, воспользуйтесь методом REST API [listCertificates](../../api-ref/Device/listCertificates.md) для ресурса [Device](../../api-ref/Device/index.md) или вызовом gRPC API [DeviceService/ListCertificates](../../api-ref/grpc/Device/listCertificates.md).

{% endlist %}

## Добавить сертификат {#add-cert}

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы добавить сертификат устройства:

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в который вы хотите добавить сертификат устройства.
   1. Перейдите в сервис **IoT Core**.
   1. Нажмите на имя нужного реестра.
   1. Перейдите в раздел **Устройства**.
   1. Выберите в списке нужное устройство.
   1. На странице **Обзор** перейдите к разделу **Сертификаты** и нажмите кнопку **Добавить сертификат**.

      - Чтобы добавить файл:

         1. Выберите способ `Файл`.
         1. Нажмите **Прикрепить файл**.
         1. Укажите файл сертификата на вашем компьютере, нажмите **Открыть**.
         1. Нажмите **Добавить**.

      - Чтобы добавить текст:

         1. Выберите способ `Текст`.
         1. Вставьте тело сертификата в поле **Содержимое**.
         1. Нажмите **Добавить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  Добавьте сертификат устройству:

  ```bash
  yc iot device certificate add \
    --device-name my-device \ # Имя устройства.
    --certificate-file device-cert.pem # Путь к публичной части сертификата.
  ```

  Результат:
  ```text
  device_id: b9135goeh1uc********
  fingerprint: 65e5b050069da5ca5996a4a8a9251409********
  certificate_data: |
    -----BEGIN CERTIFICATE-----
    MIIE/jCCAuagAwI...
    -----END CERTIFICATE-----
  created_at: "2019-05-29T17:14:18.804Z"
  ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).
  
  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы добавить сертификат устройству, созданному с помощью Terraform:
  
  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     * `yandex_iot_core_device` — параметры устройства:
       * `registry_id` — [идентификатор реестра](../registry/registry-list.md#registry-list), в котором создается устройство.
       * `name` — [имя устройства](../device/device-list.md#device-list).
       * `description` — описание устройства.
       * `certificates` — список сертификатов для аутентификации с помощью [сертификатов](../../concepts/authorization.md#certs).

      Пример описания устройства в конфигурации Terraform:

      ```hcl
      resource "yandex_iot_core_device" "my_device" {
        registry_id = "<идентификатор_реестра>"
        name        = "<имя_устройства>"
        description = "test device for terraform provider documentation"
      ...
        certificates = [
          file("<путь_к_файлу_c_сертификатом>")
        ]
      ...
      }
      ```

      Более подробную информацию о параметрах ресурса `yandex_iot_core_device` в Terraform, см. в [документации провайдера](../../../terraform/resources/iot_core_device.md).
  1. В командной строке перейдите в папку, где вы отредактировали конфигурационный файл.
  1. Проверьте корректность конфигурационного файла с помощью команды:

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

      Проверить сертификаты устройства можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot device certificate list --device-name <имя_устройства>
      ```

- API {#api}

  Чтобы добавить сертификат устройству, воспользуйтесь методом REST API [addCertificate](../../api-ref/Device/addCertificate.md) для ресурса [Device](../../api-ref/Device/index.md) или вызовом gRPC API [DeviceService/AddCertificate](../../api-ref/grpc/Device/addCertificate.md).

{% endlist %}

## Удалить сертификат {#delete-cert}

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы удалить сертификат устройства:

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, из которого вы хотите удалить сертификат устройства.
   1. Перейдите в сервис **IoT Core**.
   1. Нажмите на имя нужного реестра.
   1. Перейдите в раздел **Устройства**.
   1. Выберите в списке нужное устройство.
   1. На странице **Обзор** перейдите к разделу **Сертификаты**.
   1. В строке с нужным сертификатом нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg), в выпадающем списке выберите **Удалить**.
   1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. Удалите сертификат устройства:

      ```bash
      yc iot device certificate delete --device-name my-device --fingerprint 65...
      ```

  1. Проверьте, что сертификат действительно удален:

      ```bash
      yc iot device certificate list --device-name my-device
	    ```

	    Результат:
	  
	    ```text
      +-------------+------------+
      | FINGERPRINT | CREATED AT |
      +-------------+------------+
      +-------------+------------+
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).
  
  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы удалить сертификат устройства, созданного с помощью Terraform:
  
  1. Откройте файл конфигурации Terraform и удалите значение нужного сертификата в блоке `certificates`, во фрагменте с описанием устройства. Чтобы удалить все сертификаты, удалите блок `certificates` целиком.

      Пример описания устройства в конфигурации Terraform:

      ```hcl
      resource "yandex_iot_core_device" "my_device" {
        registry_id = "<идентификатор_реестра>"
        name        = "<имя_устройства>"
        description = "test device for terraform provider documentation"
      ...
        certificates = [
          file("<путь_к_файлу_c_сертификатом>")
        ]
      ...
      }
      ```

      Более подробную информацию о параметрах ресурса `yandex_iot_core_device` в Terraform, см. в [документации провайдера](../../../terraform/resources/iot_core_device.md).
  1. В командной строке перейдите в папку, где вы отредактировали конфигурационный файл.
  1. Проверьте корректность конфигурационного файла с помощью команды:

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

      Проверить сертификаты устройства можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot device certificate list --device-name <имя_устройства>
      ```

- API {#api}

  Чтобы удалить сертификат устройства, воспользуйтесь методом REST API [deleteCertificate](../../api-ref/Device/deleteCertificate.md) для ресурса [Device](../../api-ref/Device/index.md) или вызовом gRPC API [DeviceService/DeleteCertificate](../../api-ref/grpc/Device/deleteCertificate.md).

{% endlist %}