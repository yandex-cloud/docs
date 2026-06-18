# Удаление устройства

{% note warning %}

Сервис Yandex IoT Core больше не доступен для новых пользователей. 

Текущие пользователи могут создавать ресурсы до 1 ноября 2026 года. После сервис перейдет в режим read-only, а 1 декабря 2026 года — прекратит работу. Подробнее о сроках и порядке закрытия читайте на странице [Закрытие сервиса](../../sunset.md).

{% endnote %}

Для обращения к [устройству](../../concepts/index.md#device) используйте его уникальный идентификатор или имя. Как узнать уникальный идентификатор или имя устройства, читайте в разделе [Получение информации об устройстве](device-list.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы удалить устройство:

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, из которого вы хотите удалить устройство.
   1. Перейдите в сервис **IoT Core**.
   1. Выберите в списке нужный реестр.
   1. В левой части окна выберите раздел **Устройства**.
   1. Справа от имени удаляемого устройства нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg), в выпадающем списке выберите **Удалить**.
   1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. Удалите устройство:

      ```bash
      yc iot device delete my-device
      ```

  1. Проверьте, что устройство действительно удалено:

      ```bash
      yc iot device list --registry-name my-registry
	    ```

	  Результат:
	  ```text
      +----+------+
      | ID | NAME |
      +----+------+
      +----+------+
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы удалить устройство, созданное с помощью Terraform:
  
  1. Откройте файл конфигурации Terraform и удалите фрагмент с описанием устройства.

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

      Проверить изменения можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc iot device list --registry-id <идентификатор_реестра>
      ```

- API {#api}

  Чтобы удалить устройство, воспользуйтесь методом REST API [delete](../../api-ref/Device/delete.md) для ресурса [Device](../../api-ref/Device/index.md) или вызовом gRPC API [DeviceService/Delete](../../api-ref/grpc/Device/delete.md).

{% endlist %}