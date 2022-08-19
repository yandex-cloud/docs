# Управление жизненными циклами объектов в бакете

{{ objstorage-name }} позволяет управлять [жизненными циклами объектов](../../concepts/lifecycles.md) в бакете.

Изменения применяются к жизненным циклам раз в сутки, в 00:00 UTC.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в бакет, для которого хотите настроить жизненные циклы объектов.
  1. Выберите **Жизненный цикл**.
  1. Нажмите кнопку **Настроить**.
  1. На отобразившейся странице можно добавлять, удалять и редактировать правила конфигурации.

     {% include [storage-create-rule](../../_includes_service/storage-create-rule.md) %}

     Дополнительную информацию смотрите в разделе [{#T}](../../s3/api-ref/lifecycles/xml-config.md).

    {% note info %}

    Консоль управления не позволяет задать условия на удаление объектов и изменение класса хранилища объектов в одном правиле. Для каждого типа условий используйте отдельное правило.

    {% endnote %}

- AWS CLI

    Чтобы загрузить конфигурацию с помощью AWS CLI:
    1. Опишите конфигурацию жизненных циклов объектов в формате JSON. Например:

       ```json
       {
         "Rules": [
           {
             "ID": "DeleteOldBackups",
             "Filter": {
               "Prefix": "backup/"
             },
             "Status": "Enabled",
             "Expiration": {
               "Days": 180
             }
           }
         ]
       }
       ```

       Готовую конфигурацию можно поместить в файл, например, `lifecycles.json`.

    1. Загрузите конфигурацию в бакет, например, `backup-bucket`:

       ```bash
       aws s3api put-bucket-lifecycle-configuration \
         --bucket backup-bucket \
         --endpoint-url=https://{{ s3-storage-host }} \
         --lifecycle-configuration file://lifecycles.json
       ```

- {{ TF }}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Получите {% if audience != "internal" %}[статические ключи доступа](../../../iam/operations/sa/create-access-key.md){% else %}статические ключи доступа{% endif %} — секретный ключ и идентификатор ключа, используемые для аутентификации в {{ objstorage-short-name }}.

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     {% if product == "yandex-cloud" %}

     ```hcl
     provider "yandex" {
       cloud_id  = "<идентификатор облака>"
       folder_id = "<идентификатор каталога>"
       zone      = "<зона доступности>"
       token     = "<OAuth-токен>"
       }

     resource "yandex_storage_bucket" "bucket" {
       bucket     = "<имя бакета>"
       acl        = "private"
       access_key = "<идентификатор ключа>"
       secret_key = "<секретный ключ>"

       lifecycle_rule {
         id      = "log"
         enabled = true
         prefix = "log/"

         transition {
           days          = 30
           storage_class = "COLD"
         }

         expiration {
           days = 90
         }
       }

       lifecycle_rule {
         id      = "tmp"
         prefix  = "tmp/"
         enabled = true

         expiration {
           date = "2020-12-21"
         }
       }
     }

     resource "yandex_storage_bucket" "versioning_bucket" {
       bucket     = "<имя бакета>"
       acl        = "private"
       access_key = "<идентификатор ключа>"
       secret_key = "<секретный ключ>"

       versioning {
         enabled = true
       }

       lifecycle_rule {
         prefix  = "config/"
         enabled = true

         noncurrent_version_transition {
           days          = 30
           storage_class = "COLD"
         }

         noncurrent_version_expiration {
           days = 90
         }
       }
     }
     ```

     {% endif %}

     {% if product == "cloud-il" %}

     ```hcl
     provider "yandex" {
       cloud_id  = "<идентификатор облака>"
       folder_id = "<идентификатор каталога>"
       zone      = "<зона доступности>"
       endpoint  = "{{ api-host }}:443"
       token     = "<статический ключ сервисного аккаунта>"
       }

     resource "yandex_storage_bucket" "bucket" {
       bucket     = "<имя бакета>"
       acl        = "private"
       access_key = "<идентификатор ключа>"
       secret_key = "<секретный ключ>"

       lifecycle_rule {
         id      = "log"
         enabled = true
         prefix = "log/"

         transition {
           days          = 30
           storage_class = "COLD"
         }

         expiration {
           days = 90
         }
       }

       lifecycle_rule {
         id      = "tmp"
         prefix  = "tmp/"
         enabled = true

         expiration {
           date = "2020-12-21"
         }
       }
     }

     resource "yandex_storage_bucket" "versioning_bucket" {
       bucket     = "<имя бакета>"
       acl        = "private"
       access_key = "<идентификатор ключа>"
       secret_key = "<секретный ключ>"

       versioning {
         enabled = true
       }

       lifecycle_rule {
         prefix  = "config/"
         enabled = true

         noncurrent_version_transition {
           days          = 30
           storage_class = "COLD"
         }

         noncurrent_version_expiration {
           days = 90
         }
       }
     }
     ```

     {% endif %}

     Где:

     * `bucket` — имя бакета. Обязательный параметр.
     * `access_key` — идентификатор статического ключа доступа.
     * `secret_key` — значение секретного ключа доступа.

     Параметры `lifecycle_rule`:
     * `id` —  уникальный идентификатор правила. Должен быть меньше или равен 255 символам. Необязательный параметр.
     * `prefix` — префикс ключа объекта, идентифицирующий один или несколько объектов, к которым применяется правило. Необязательный параметр.
     * `enabled` — состояние правила. Обязательный параметр.
     * `abort_incomplete_multipart_upload_days` — количество дней после начала многострочной загрузки, когда она должна быть завершена. Необязательный параметр.
     * `expiration` — срок действия объекта для удаления неактивных версий объекта. Необязательный параметр.
     * `transition` — срок действия объекта для изменения класса хранилища со стандартного (`STANDARD`) на холодное (`COLD`). Необязательный параметр.
     * `noncurrent_version_expiration` — правило для удаления неактивных версий объекта. Необязательный параметр.
     * `noncurrent_version_transition` — правило для изменения класса хранилища неактивных версий объекта со стандартного (`STANDARD`) на холодное (`COLD`). Необязательный параметр.

     Необходимо указать хотя бы один из параметров `abort_incomplete_multipart_upload_days`, `expiration`, `transition`, `noncurrent_version_expiration`, `noncurrent_version_transition`.

     Параметры `expiration`:
     * `date` — дата, после которой вы хотите, чтобы действие вступило в силу. Необязательный параметр.
     * `days` — количество дней после создания объекта, когда действие правила вступает в силу. Необязательный параметр.

     Параметры `transition`:
     * `date` — дата, после которой вы хотите, чтобы действие вступило в силу. Необязательный параметр.
     * `days` — количество дней после создания объекта, когда действие правила вступает в силу. Необязательный параметр.
     * `storage_class` — класс хранилища, в который будет перенесен объект. Может быть только `COLD` или `STANDARD_IA`. Обязательный параметр.

     Параметры `noncurrent_version_expiration`:
     * `days` — количество дней истечения срока действия. Обязательный параметр.

     Параметры `noncurrent_version_transition`:
     * `days` — количество дней до перехода. Обязательный параметр.
     * `storage_class` — класс хранилища, в который будет перенесен объект. Может быть только `COLD` или `STANDARD_IA`. Обязательный параметр.

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/).

  1. Проверьте корректность конфигурационных файлов.
     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Разверните облачные ресурсы.
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

{% endlist %}
