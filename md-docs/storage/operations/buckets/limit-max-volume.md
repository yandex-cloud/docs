# Ограничение максимального размера бакета

{{ objstorage-name }} позволяет ограничить максимальный размер бакета.

Если вы, например, предоставляете пользователям вашего сервиса возможность самостоятельно загружать объекты в {{ objstorage-name }}, то ограничение максимального объема позволит лучше контролировать действия пользователей и избежать лишних трат.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Выберите бакет, максимальный размер которого вы хотите ограничить.
  1. На панели слева выберите ![image](../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. Выберите вкладку **{{ ui-key.yacloud.storage.bucket.switch_general-settings }}**.
  1. Задайте значение поля **{{ ui-key.yacloud.storage.bucket.settings.field_size-limit }}**.

      Размер `0` означает отсутствие ограничений и аналогичен включенной опции **{{ ui-key.yacloud.storage.bucket.settings.label_size-limit-disabled }}**.
      
  1. Нажмите **{{ ui-key.yacloud.storage.bucket.settings.button_save }}**.

- {{ yandex-cloud }} CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения бакета:

      ```bash
      yc storage bucket update --help
      ```

  1. Получите список бакетов в каталоге по умолчанию:
     
     ```bash
     yc storage bucket list
     ```
     
     Результат:
     
     ```text
     +------------------+----------------------+-------------+-----------------------+---------------------+
     |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
     +------------------+----------------------+-------------+-----------------------+---------------------+
     | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
     +------------------+----------------------+-------------+-----------------------+---------------------+
     ```
  1. Сохраните имя бакета (столбец `NAME`), размер которого нужно ограничить.
  1. Ограничьте максимальный размера бакета:

      ```bash
      yc storage bucket update \
        --name <имя_бакета> \
        --max-size <максимальный_размер_бакета>
      ```

      Где:
      * `--name` — имя бакета, размер которого нужно ограничить.
      * `--max-size` — максимальный размер бакета в байтах. `0` — без ограничений.

      Результат:

      ```text
      name: first-bucket
      older_id: b1gmit33ngp6********
      default_storage_class: STANDARD
      versioning: VERSIONING_DISABLED
      max_size: "26843545600"
      acl: {}
      created_at: "2022-12-16T13:58:18.933814Z"
      ```

- {{ TF }} {#tf}

  {% note info %}
  
  Если вы работаете с {{ objstorage-name }} через {{ TF }} от имени [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту нужную [роль](../../security/index.md#roles-list), например `storage.admin`, на каталог, в котором будут создаваться ресурсы.
  
  {% endnote %}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  
  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.



  Чтобы ограничить максимальный размер бакета:

  1. Откройте файл конфигурации {{ TF }} и добавьте параметр `max_size` в описании бакета:

     ```hcl
     ...
     resource "yandex_storage_bucket" "test" {
       access_key = "<идентификатор_статического_ключа>"
       secret_key = "<секретный_ключ>"
       bucket     = "tf-test-bucket"
	   max_size   = 1048576
     }
     ...
     ```

     Где:
     * `access_key` — идентификатор статического ключа доступа.

        {% note info %}
        
        Кроме статических ключей доступа для аутентификации в {{ objstorage-name }} можно использовать IAM-токен. Подробнее смотрите в разделе [{#T}](create.md) и в [документации провайдера]({{ tf-provider-resources-link }}/storage_object). 
        
        {% endnote %}

     * `secret_key` — значение секретного ключа доступа.
     * `max_size` — максимальный размер бакета в байтах.

     Более подробную информацию о параметрах ресурса `yandex_storage_bucket` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/storage_bucket#bucket-max-size).

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

     Проверить изменение можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Чтобы ограничить максимальный размер бакета, воспользуйтесь методом REST API [update](../../api-ref/Bucket/update.md) для ресурса [Bucket](../../api-ref/Bucket/index.md) или вызовом gRPC API [BucketService/Update](../../api-ref/grpc/Bucket/update.md).

{% endlist %}