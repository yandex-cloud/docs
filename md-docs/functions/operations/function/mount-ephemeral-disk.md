# Смонтировать эфемерный диск в функцию

{% note info %}

Функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md). Чтобы получить доступ, обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Выберите функцию.
  1. В меню слева выберите ![image](../../../_assets/console-icons/pencil-to-square.svg)**{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}**.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.title_ephemeral-storage }}**:

      1. Нажмите **{{ ui-key.yacloud.serverless-functions.item.editor.label_add-ephemeral-storage }}**.
      1. Укажите в поле:

          * **{{ ui-key.yacloud.serverless-functions.item.editor.label_mount-point-name }}** — точку монтирования. Директория, к которой монтируется эфемерный диск, будет доступна по пути `/function/storage/<точка_монтирования>`.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.label_ephemeral-storage-size }}** — объем памяти, который вы хотите выделить для монтируемого эфемерного диска.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы смонтировать эфемерный диск в функцию, выполните команду:

  ```bash
  yc serverless function version create \
    --function-name=<имя_функции> \
    --runtime <среда_выполнения> \
    --entrypoint <точка_входа> \
    --memory <объем_RAM> \
    --execution-timeout <максимальное_время_выполнения> \
    --source-path <путь_к_ZIP-архиву> \
    --service-account-id <идентификатор_сервисного_аккаунта> \
    --mount type=ephemeral-disk,mount-point=<точка_монтирования>,size=<размер_диска>
  ```

  Где:

  * `--function-name` — имя функции.
  * `--runtime` — среда выполнения.
  * `--entrypoint` — точка входа, указывается в формате `<имя_файла_без_расширения>.<имя_обработчика>`.
  * `--memory` — объем RAM.
  * `--execution-timeout` — максимальное время выполнения функции до таймаута.
  * `--source-path` — ZIP-архив c кодом функции и необходимыми зависимостями.
  * `--service-account-id` — идентификатор сервисного аккаунта.
  * `--mount` — параметры монтирования эфемерного диска:
    * `type=ephemeral-disk` — тип монтируемой файловой системы.
    * `mount-point` — имя точки монтирования. Директория, к которой смонтируется диск, будет доступна по пути `/function/storage/<точка_монтирования>`.
    * `size` — размер эфемерного диска в ГБ. Например: `size=5GB`.

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Чтобы смонтировать эфемерный диск в функцию:

  1. Откройте файл конфигурации {{ TF }} и добавьте к описанию функции блок `mounts`:

      ```hcl
      resource "yandex_function" "ephemeral_storage_function" {
        name               = "<имя_функции>"
        user_hash          = "<хеш_функции>"
        runtime            = "<среда_выполнения>"
        entrypoint         = "<точка_входа>"
        memory             = "<объем_RAM>"
        execution_timeout  = "<максимальное_время_выполнения>"
        service_account_id = "<идентификатор_сервисного_аккаунта>"
        content {
          zip_filename = "<путь_к_ZIP-архиву>"
        }

        mounts {
          name = "<точка_монтирования>"
          ephemeral_disk {
            size_gb = <размер_диска>
          }
        }
      }
      ```

      Где:

      * `mounts` — параметры монтирования эфемерного диска:
        * `name` — имя точки монтирования. Директория, к которой смонтируется диск, будет доступна по пути `/function/storage/<точка_монтирования>`.
        * `size_gb` — размер эфемерного диска в ГБ. Например: `size=5GB`.

      Более подробную информацию о параметрах ресурса `yandex_function` см. в [документации провайдера]({{ tf-provider-resources-link }}/function).

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

  Проверить изменение функции и ее настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

  ```bash
  yc serverless function version get <идентификатор_версии_функции>
  ```

- API {#api}

  Чтобы смонтировать эфемерный диск в функцию, воспользуйтесь методом REST API [createVersion](../../functions/api-ref/Function/createVersion.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/CreateVersion](../../functions/api-ref/grpc/Function/createVersion.md).

{% endlist %}

## См. также {#see-also}

* [{#T}](../../concepts/mounting.md)
* [{#T}](../../../serverless-containers/concepts/mounting.md)