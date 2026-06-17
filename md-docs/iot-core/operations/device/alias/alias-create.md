# Создание алиаса в Yandex IoT Core

{% note warning %}

Сервис Yandex IoT Core больше не доступен для новых пользователей. 

Текущие пользователи могут создавать ресурсы до 1 ноября 2026 года. После сервис перейдет в режим read-only, а 1 декабря 2026 года — прекратит работу. Подробнее о сроках и порядке закрытия читайте на странице [Закрытие сервиса](../../../sunset.md).

{% endnote %}

Алиас привязан к конкретному устройству, поэтому для создания алиаса вам надо [узнать идентификатор или имя устройства](../device-list.md).

{% note info %}

Для топика `$monitoring/<идентификатор_устройства>/json` можно использовать только [системный алиас](../../../concepts/topic/usage.md#mealias) `$me`.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы создать алиас:

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы хотите создать алиас.
   1. Перейдите в сервис **IoT Core**.
   1. Выберите в списке нужный реестр.
   1. В левой части окна выберите раздел **Устройства**.
   1. Нажмите значок ![image](../../../../_assets/console-icons/ellipsis.svg) справа от имени нужного устройства, в выпадающем списке выберите **Редактировать**.
   1. Добавьте алиас:
      1. Нажмите кнопку **Добавить алиас**.
      1. Заполните поля: введите алиас (например, `events`) и тип топика после `$devices/<идентификатор_устройства>` (например, `events`).<br/>Вы сможете использовать алиас `events` вместо топика `$devices/<идентификатор_устройства>/events`.
      1. Повторите действия для каждого добавляемого алиаса.
   1. Нажмите кнопку **Сохранить**.

- CLI {#cli}
    
    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).
    
    По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
    
    Создайте алиас: 
    
    ```bash
    yc iot device add-topic-aliases arenak5ciqss********
      --topic-aliases commands='$devices/arenak5ciqss********/commands'
    ```

	  Результат:
	  
    ```bash
    id: arenak5ciqss********
    registry_id: arenou2oj4ct********
    created_at: "2019-09-16T12:32:48.911Z"
    name: second
    topic_aliases:
      commands: $devices/arenak5ciqss********/commands
    ``` 

    Также вы можете добавить алиас при [создании устройства](../device-create.md). Для этого вместо уникального идентификатора в топике устройства указывается `{id}`, так как уникальный идентификатор еще неизвестен:
    
    ```bash
    yc iot device create
      --registry-name <имя_реестра>
      --name <имя_устройства>
      --topic-aliases <имя_алиаса>='$devices/{id}/<events,_state,_commands_или_config>'
    ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../../terraform/authentication.md) соответствующим способом.

  Чтобы добавить алиас устройству, созданному с помощью Terraform:

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     * `yandex_iot_core_device` — параметры устройства:
       * `registry_id` — [идентификатор реестра](../../registry/registry-list.md#registry-list), в котором создано устройство.
       * `name` — [имя устройства](../device-list.md#device-list).
       * `description` — описание устройства.
       * `aliases` — алиасы топиков.

      Пример структуры ресурса в конфигурационном файле:

      ```hcl
      resource "yandex_iot_core_device" "my_device" {
        registry_id = "<идентификатор_реестра>"
        name        = "<имя_устройства>"
        description = "test device for terraform provider documentation"

        aliases = {
          "some-alias1/subtopic" = "$devices/{id}/events/somesubtopic",
          "some-alias2/subtopic" = "$devices/{id}/events/aaa/bbb",
        }
      ...
      }
      ```

      Подробнее о параметрах ресурса `yandex_iot_core_device` в [документации провайдера](../../../../terraform/resources/iot_core_device.md).
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

      Проверить алиасы устройства можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../../cli/quickstart.md):

      ```bash
      yc iot device get <имя_устройства>
      ```

- API {#api}

  Чтобы создать алиас, воспользуйтесь методом REST API [create](../../../api-ref/Device/create.md) для ресурса [Device](../../../api-ref/Device/index.md) или вызовом gRPC API [DeviceService/Create](../../../api-ref/grpc/Device/create.md).

{% endlist %}