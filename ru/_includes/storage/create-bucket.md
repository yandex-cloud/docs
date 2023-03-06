Минимально необходимая роль для создания бакета — `storage.editor`. См. [описание роли](../../storage/security/#storage-editor).

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать [бакет](../../storage/concepts/bucket.md).
  1. Выберите сервис **{{ objstorage-name }}**.
  1. Нажмите кнопку **Создать бакет**.
  1. На странице создания бакета:
      1. Введите имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).

         По умолчанию бакет с точкой в имени доступен только по протоколу HTTP. Чтобы поддержать для бакета протокол HTTPS, [загрузите собственный сертификат безопасности](../../storage/operations/hosting/certificate.md) в {{ objstorage-name }}.

      1. При необходимости ограничьте максимальный размер бакета.

         {% include [storage-no-max-limit](../../storage/_includes_service/storage-no-max-limit.md) %}

      1. Выберите тип [доступа](../../storage/concepts/bucket.md#bucket-access).
      1. Выберите [класс хранилища](../../storage/concepts/storage-class.md) по умолчанию.
      1. Нажмите кнопку **Создать бакет** для завершения операции.

- {{ yandex-cloud }} CLI

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания бакета:

      ```bash
      yc storage bucket create --help
      ```

  1. Создайте бакет в каталоге по умолчанию:

      ```bash
      yc storage bucket create \
        --name <имя_бакета> \
        --default-storage-class <класс_хранилища> \
        --max-size <максимальный_размер_бакета> \
        --public-read \
        --public-list \
        --public-config-read
      ```

      Где:

      * `--name` — имя бакета. Подробнее см. [Правила именования бакетов](../../storage/concepts/bucket.md#naming). 

        По умолчанию бакет с точкой в имени доступен только по протоколу HTTP. Чтобы поддержать для бакета протокол HTTPS, [загрузите](../../storage/operations/hosting/certificate.md) собственный сертификат безопасности в {{ objstorage-name }}.
      * `--default-storage-class` — [класс хранилища](../../storage/concepts/storage-class.md). Доступные значения:
        * `standard` — стандартное хранилище;
        * `cold` — холодное хранилище;
        * `ice` — ледяное хранилище.
      * `--max-size` — максимальный размер бакета в байтах. `0` — без ограничений.
      * `--public-read` — флаг для включения публичного доступа на чтение объектов в бакете.
      * `--public-list` — флаг для включения публичного доступа на просмотр списка объектов в бакете.
      * `--public-config-read` — флаг для включения публичного доступа на чтение настроек в бакете.

      `name` — обязательный парметр. Остальные параметры необязательны. По умолчанию значение параметра `--max-size` — `0`, публичный доступ к бакету выключен.

      Результат:

      ```yaml
      name: first-bucket
      folder_id: b1gmit33ngp6cv2mhjmo
      anonymous_access_flags:
        read: false
        list: false
      default_storage_class: STANDARD
      versioning: VERSIONING_DISABLED
      max_size: "53687091200"
      acl: {}
      created_at: "2022-12-16T14:05:12.196007Z"
      ```

- {{ TF }}

  Если у вас ещё нет {{ TF }}, {% if audience != "internal" %}[установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform){% else %}установите его и настройте провайдер {{ yandex-cloud }}{% endif %}.

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     {% if product == "yandex-cloud" %}

     ```
     terraform {
       required_providers {
         yandex = {
           source = "yandex-cloud/yandex"
         }
       }
       required_version = ">= 0.13"
     }

     provider "yandex" {
       token     = "<IAM-_или_OAuth-токен>"
       cloud_id  = "<идентификатор_облака>"
       folder_id = "<идентификатор_каталога>"
       zone      = "{{ region-id }}-a"
     }

     resource "yandex_iam_service_account" "sa" {
       name = "<имя_сервисного_аккаунта>"
     }

     // Назначение роли сервисному аккаунту
     resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
       folder_id = "<идентификатор_каталога>"
       role      = "storage.editor"
       member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
     }

     // Создание статического ключа доступа
     resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
       service_account_id = yandex_iam_service_account.sa.id
       description        = "static access key for object storage"
     }

     // Создание бакета с использованием ключа
     resource "yandex_storage_bucket" "test" {
       access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
       secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
       bucket     = "<имя_бакета>"
     }
     ```

     {% endif %}

     {% if product == "cloud-il" %}

     ```
     provider "yandex" {
       endpoint         = "{{ api-host }}:443"
       token            = "<IAM-токен>"
       cloud_id         = "<идентификатор_облака>"
       folder_id        = "<идентификатор_каталога>"
       zone             = "{{ region-id }}-a"
       storage_endpoint = "{{ s3-storage-host }}"
     }

     resource "yandex_iam_service_account" "sa" {
       name = "<имя_сервисного_аккаунта>"
     }

     // Назначение роли сервисному аккаунту
     resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
       folder_id = "<идентификатор_каталога>"
       role      = "storage.editor"
       member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
     }

     // Создание статического ключа доступа
     resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
       service_account_id = yandex_iam_service_account.sa.id
       description        = "static access key for object storage"
     }

     // Создание бакета с использованием ключа
     resource "yandex_storage_bucket" "test" {
       access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
       secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
       bucket     = "<имя_бакета>"
     }
     ```

     {% endif %}

     Где:

     * `yandex_iam_service_account` — описание сервисного аккаунта, который создаст бакет и будет работать с ним:
       * `name` — имя сервисного аккаунта.
     * `yandex_storage_bucket` — описание бакета:
       * `bucket` — имя бакета.

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/storage_bucket).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:
        ```
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:
        ```
        terraform apply
        ```

     1. Подтвердите создание ресурсов.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

{% endlist %}
