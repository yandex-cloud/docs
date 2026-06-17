# Изменение устройства

{% note warning %}

Сервис Yandex IoT Core больше не доступен для новых пользователей. 

Текущие пользователи могут создавать ресурсы до 1 ноября 2026 года. После сервис перейдет в режим read-only, а 1 декабря 2026 года — прекратит работу. Подробнее о сроках и порядке закрытия читайте на странице [Закрытие сервиса](../../sunset.md).

{% endnote %}

Вы можете изменить [имя](device-update.md#update-name) или [описание](device-update.md#update-description) устройства.

Для обращения к устройству используйте его уникальный идентификатор или имя. Как узнать уникальный идентификатор или имя устройства, читайте в разделе [Получение информации об устройстве](device-list.md).

## Изменить имя устройства {#update-name}

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы изменить имя устройства:

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы хотите изменить имя устройства.
   1. Перейдите в сервис **IoT Core**.
   1. Выберите в списке нужный реестр.
   1. В левой части окна выберите раздел **Устройства**.
   1. Справа от имени нужного устройства нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg), в выпадающем списке выберите **Редактировать**.
   1. Измените поле **Имя**.
   1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  Измените имя устройства:

  ```bash
  yc iot device update my-device --new-name test-device
  ```

  Результат:
  ```text
  id: b9135goeh1uc********
  registry_id: b91ki3851hab********
  created_at: "2019-05-28T16:08:30.938Z"
  name: test-device
  ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).
  
  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы изменить имя устройства, созданного с помощью Terraform:
  
  1. Откройте файл конфигурации Terraform и измените значение параметра `name` во фрагменте с описанием устройства:

      Пример описания устройства в конфигурации Terraform:

      ```hcl
      resource "yandex_iot_core_device" "my_device" {
        registry_id = "<идентификатор_реестра>"
        name        = "test-device"
        description = "test device for terraform provider documentation"
      ...
      }
      ```

      Подробнее о параметрах ресурса `yandex_iot_core_device` в [документации провайдера](../../../terraform/resources/iot_core_device.md).
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

      Проверить измененное имя устройства можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot device list --registry-id <идентификатор_реестра>
      ```

- API {#api}

  Чтобы изменить имя устройства, воспользуйтесь методом REST API [update](../../api-ref/Device/update.md) для ресурса [Device](../../api-ref/Device/index.md) или вызовом gRPC API [DeviceService/Update](../../api-ref/grpc/Device/update.md).

{% endlist %}

## Изменить описание устройства {#update-description}

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы изменить описание устройства:

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы хотите изменить описание устройства.
   1. Перейдите в сервис **IoT Core**.
   1. Выберите в списке нужный реестр.
   1. В левой части окна выберите раздел **Устройства**.
   1. Справа от имени нужного устройства нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg), в выпадающем списке выберите **Редактировать**.
   1. Измените поле **Описание**.
   1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  Измените описание устройства:

  ```bash
  yc iot device update my-device --description "My first device."
  ```

  Результат:
  
  ```bash
  id: b9135goeh1uc********
  registry_id: b91ki3851hab********
  created_at: "2019-05-28T16:08:30.938Z"
  name: my-device
  description: My first device.
  ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).
  
  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы изменить описание устройства, созданного с помощью Terraform:
  
  1. Откройте файл конфигурации Terraform и измените значение параметра `description` во фрагменте с описанием устройства.

      Пример описания устройства в конфигурации Terraform:

      ```hcl
      resource "yandex_iot_core_device" "my_device" {
        registry_id = "<идентификатор_реестра>"
        name        = "test-device"
        description = "test device for terraform provider documentation"
      ...
      }
      ```

      Подробнее о параметрах ресурса `yandex_iot_core_device` в [документации провайдера](../../../terraform/resources/iot_core_device.md).
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

      Проверить измененное описание устройства можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot device get <имя_устройства>
      ```

- API {#api}

  Чтобы изменить описание устройства, воспользуйтесь методом REST API [update](../../api-ref/Device/update.md) для ресурса [Device](../../api-ref/Device/index.md) или вызовом gRPC API [DeviceService/Update](../../api-ref/grpc/Device/update.md).

{% endlist %}