# Изменить имя контейнера

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится контейнер.
  1. Перейдите в сервис **Serverless Containers**.
  1. Выберите контейнер.
  1. Нажмите кнопку **Редактировать**.
  1. Измените имя контейнера. Формат имени:

      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы узнать имя или уникальный идентификатор контейнера, [получите](list.md) список контейнеров в каталоге.

  Чтобы изменить имя контейнера, выполните команду:

  ```
  yc serverless container \
    --name <имя_контейнера> \
    --new-name <новое_имя_контейнера>
  ```

  Результат:

  ```
  id: flh7r96juaqq********
  folder_id: aoek6qrs8tjh********
  created_at: "2021-08-17T07:53:10.219Z"
  name: my-beta-container
  description: my beta container description
  url: https://flh7r96juaqq********.containers.yandexcloud.net/
  status: ACTIVE
  ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы изменить имя контейнера, созданного с помощью Terraform:

  1. Откройте файл конфигурации Terraform и измените значение поля `name` в описании ресурса `yandex_serverless_container`:

     ```hcl
     ...
     resource "yandex_serverless_container" "test-container" {
       name               = "my-conrainer"
       description        = "my first container with description"
       memory             = 256
       service_account_id = "ajecvjv1lv01********"
       image {
           url = "cr.yandex/yc/test-image:v1"
       }
     }
     ...
     ```

   Подробнее о параметрах ресурса `yandex_serverless_container` в [документации провайдера](../../terraform/resources/serverless_container.md).

  1. Проверьте конфигурацию командой:
     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:
     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Примените изменения конфигурации:
     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

  Проверить изменение контейнера можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/index.md):

  ```
  yc serverless container get <имя_или_идентификатор_контейнера>
  ```

- API {#api}

  Чтобы изменить имя контейнера, воспользуйтесь методом REST API [update](../containers/api-ref/Container/update.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/Update](../containers/api-ref/grpc/Container/update.md).

{% endlist %}