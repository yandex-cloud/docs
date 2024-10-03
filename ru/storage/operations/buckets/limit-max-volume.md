# Ограничение максимального размера бакета

{{ objstorage-name }} позволяет ограничить максимальный размер бакета.

Если вы, например, предоставляете пользователям вашего сервиса возможность самостоятельно загружать объекты в {{ objstorage-name }}, то ограничение максимального объема позволит лучше контролировать действия пользователей и избежать лишних трат.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Выберите сервис **{{ objstorage-name }}**.
  1. Нажмите на имя необходимого бакета.
  1. Перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. Задайте значение поля **{{ ui-key.yacloud.storage.bucket.settings.field_size-limit }}**.

      {% include [storage-no-max-limit](../../_includes_service/storage-no-max-limit.md) %}
  1. Нажмите **{{ ui-key.yacloud.storage.bucket.settings.button_save }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

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
      +------------------+----------------------+----------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       | MAX SIZE | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+----------+-----------------------+---------------------+
      | first-bucket     | b1gmit33ngp6******** | 0        | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+----------+-----------------------+---------------------+
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

  {% include [terraform-role](../../../_includes/storage/terraform-role.md) %}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}


  {% include [terraform-install](../../../_includes/terraform-install.md) %}


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
     * `secret_key` — значение секретного ключа доступа.
     * `max_size` — максимальный размер бакета в байтах.

     Более подробную информацию о параметрах ресурса `yandex_storage_bucket` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/storage_bucket#bucket-max-size).

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

     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:

     ```
     terraform apply
     ```

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение бакета можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Чтобы ограничить максимальный размер бакета, воспользуйтесь методом REST API [update](../../api-ref/Bucket/update.md) для ресурса [Bucket](../../api-ref/Bucket/index.md) или вызовом gRPC API [BucketService/Update](../../api-ref/grpc/bucket_service.md#Update).

{% endlist %}
