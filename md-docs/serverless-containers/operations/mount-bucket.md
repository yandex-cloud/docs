# Смонтировать бакеты в контейнер

Вы можете монтировать в контейнер [бакеты](../../storage/concepts/bucket.md) {{ objstorage-full-name }}. При монтировании бакета создается новая [ревизия](../concepts/container.md#revision) контейнера.

Чтобы смонтировать бакеты в контейнер:

{% list tabs group=instructions %}

- Консоль управления {#console}
    
  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
  1. Выберите контейнер.
  1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-containers.label_editor }}**.
  1. В блоке **{{ ui-key.yacloud.serverless-containers.section_parameters }}** выберите или создайте новый [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с ролью:
      * [`storage.viewer`](../../storage/security/index.md#storage-viewer), чтобы только читать данные из смонтированного [бакета](../../storage/concepts/bucket.md).
      * [`storage.uploader`](../../storage/security/index.md#storage-uploader), чтобы читать данные из смонтированного бакета и записывать их в него.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.title_mount-files }}**:

      1. Нажмите **{{ ui-key.yacloud.serverless-functions.item.editor.label_add-folder }}**.
      1. Укажите в поле:

          * **{{ ui-key.yacloud.serverless-functions.item.editor.label_mount-point-path }}** — абсолютный путь монтирования. Директория, к которой смонтируется бакет, будет доступна по указанному пути.

              По этому пути нельзя размещать ничего, кроме пустой директории, иначе при инициализации контейнера может возникнуть ошибка, и смонтированные бакеты будут недоступны.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.label_bucket }}** — бакет, который вы хотите смонтировать. При необходимости [создайте](../../storage/operations/buckets/create.md) новый бакет.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.label_bucket-prefix }}** — [папку](../../storage/concepts/object.md#folder) в бакете, которая будет смонтирована в контейнер. Если поле пустое, смонтируется весь бакет.
      1. Чтобы запретить запись в бакет, включите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_readonly }}**. Если опция включена, данные из смонтированного бакета будут доступны только для чтения.

      Чтобы смонтировать в контейнер дополнительный бакет, повторно нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.label_add-folder }}** и задайте необходимые параметры.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Выполните команду:

  ```bash
  yc serverless container revision deploy \
    --container-name <имя_контейнера> \
    --image <URL_Docker-образа> \
    --memory <объем_RAM> \
    --execution-timeout <максимальное_время_выполнения> \
    --service-account-id <идентификатор_сервисного_аккаунта> \
    --command '<команда_1>','<команда_2>' \
    --args '<ключ_1=значение_1>','<ключ_2=значение_2>' \
    --mount type=object-storage,mount-point=<путь_монтирования>,bucket=<имя_бакета>,prefix=<имя_папки>,mode=<режим_монтирования>
  ```

  Где:

  * `--container-name` — имя контейнера.
  * `--image` — URL Docker-образа, из которого вы создаете ревизию контейнера, в формате: `cr.yandex/<идентификатор_реестра>/<имя_Docker-образа>:<тег>`.
  * `--memory` — необходимый объем RAM.
  * `--execution-timeout` — максимальное время выполнения контейнера до таймаута.
  * `--service-account-id` — [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта. Для чтения данных из бакета сервисному аккаунту необходима [роль](../../storage/security/index.md#storage-viewer) `storage.viewer`, для чтения и записи — [роль](../../storage/security/index.md#storage-uploader) `storage.uploader`.
  * `--command` — команды, которые контейнер выполнит при запуске. Указываются через запятую. Соответствует инструкции `ENTRYPOINT` в Dockerfile.
  * `--args` — аргументы, соответствует инструкции `CMD` в Dockerfile. Указываются в формате `ключ = значение` через запятую. Если не указано, будет использоваться значение `CMD` по умолчанию из Docker-образа.
  * `--mount` — параметры монтирования [бакета](../../storage/concepts/bucket.md) {{ objstorage-name }}:
      * `type` — тип монтируемого хранилища. Для бакета значение всегда `object-storage`.
      * `mount-point` — абсолютный путь монтирования. Директория, к которой смонтируется бакет, будет доступна по заданному пути.
      * `bucket` — [имя](../../storage/concepts/bucket.md#naming) бакета.
      * `prefix` — [папка](../../storage/concepts/object.md#folder) в бакете, которая будет смонтирована в контейнер. Если поле не задано или пустое, смонтируется весь бакет.
      * `mode` — режим монтирования бакета: `ro` — только чтение, `rw` — чтение и запись.

      Чтобы смонтировать в контейнер одновременно несколько бакетов, задайте параметр `--mount` необходимое количество раз.

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Откройте файл конфигурации {{ TF }} и добавьте к описанию контейнера блок `mounts`:

      ```hcl
      resource "yandex_serverless_container" "test-container" {
        ...

        mounts {
          mount_point_path = "<точка_монтирования>"
          mode             = "<режим_монтирования>"
          object_storage {
            bucket = "<имя_бакета>"
            prefix = "<имя_папки>"
          }
        }
      }
      ```

      Где:

      * `mounts` — параметры монтирования [бакета](../../storage/concepts/bucket.md) {{ objstorage-name }}:
          * `mount_point_path` — абсолютный путь монтирования. Директория, к которой смонтируется [бакет](../../storage/concepts/bucket.md), будет доступна по указанному пути.
          * `mode` — режим монтирования бакета: `ro` — только чтение, `rw` — чтение и запись.
          * `object_storage` — параметры бакета:
              * `bucket` — [имя](../../storage/concepts/bucket.md#naming) бакета.
              * `prefix` — [папка](../../storage/concepts/object.md#folder) в бакете, которая будет смонтирована в контейнер. Если поле пустое, смонтируется весь бакет.

          Чтобы смонтировать в контейнер одновременно несколько бакетов, задайте блок `mounts` необходимое количество раз.

      Более подробную информацию о параметрах ресурса `yandex_serverless_container` см. в [документации провайдера]({{ tf-provider-resources-link }}/serverless_container).

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

  Проверить изменение ревизии контейнера и ее настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

  ```bash
  yc serverless container revision get <идентификатор_ревизии_контейнера>
  ```

- API {#api}

  Воспользуйтесь методом REST API [deployRevision](../containers/api-ref/Container/deployRevision.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/DeployRevision](../containers/api-ref/grpc/Container/deployRevision.md).

{% endlist %}

## См. также {#see-also}

* [{#T}](../concepts/mounting.md)
* [{#T}](../../functions/concepts/mounting.md)