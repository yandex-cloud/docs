# Открытие публичного доступа к операциям с бакетом

По умолчанию бакеты создаются с ограниченным [доступом](../../concepts/bucket.md#bucket-access). С помощью консоли управления вы можете открыть публичный доступ:

{% include [storage-public-operations](../../_includes_service/storage-public-operations.md) %}

{% list tabs %}

- Консоль управления
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Выберите сервис **{{ objstorage-name }}**.
  1. Нажмите на имя необходимого бакета.
  1. Перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. Выберите тип доступа к операциям с бакетом.
  1. Нажмите **{{ ui-key.yacloud.storage.bucket.settings.button_save }}**.

- {{ yandex-cloud }} CLI

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
      +------------------+----------------------+-------------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      ```
   
   1. Сохраните имя бакета (столбец `NAME`), к которому нужно открыть публичный доступ.
   1. Откройте публичный доступ к операциям с бакетом:

      ```bash
      yc storage bucket update \
        --name <имя_бакета> \
        --public-read \
        --public-list \
        --public-config-read
      ```

      Где:
      * `--name` — имя бакета, к которому нужно открыть публичный доступ.
      * `--public-read` — флаг для включения публичного доступа на чтение объектов в бакете.
      * `--public-list` — флаг для включения публичного доступа на просмотр списка объектов в бакете.
      * `--public-config-read` — флаг для включения публичного доступа на чтение настроек в бакете.

      `name` — обязательный парметр. Остальные параметры необязательны. По умолчанию публичный доступ к бакету выключен.

      Результат:

      ```yaml
      name: first-bucket
      folder_id: b1gmit33ngp6********
      anonymous_access_flags:
        read: true
        list: true
        config_read: true
      default_storage_class: STANDARD
      versioning: VERSIONING_DISABLED
      max_size: "53687091200"
      acl: {}
      created_at: "2022-12-16T13:58:18.933814Z" 
      ```

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  
  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


  Чтобы открыть публичный доступ к операциям с бакетом:

  1. Откройте файл конфигурации {{ TF }} и добавьте блок `anonymous_access_flags` во фрагмент с описанием бакета.

     ```hcl
     resource "yandex_storage_bucket" "log_bucket" {
       access_key = "<идентификатор_статического_ключа>"
       secret_key = "<секретный_ключ>"
       bucket     = "my-tf-log-bucket"

       anonymous_access_flags {
         read = true
         list = false
       }
     }
     ```

     Где:
     * `access_key` — идентификатор статического ключа доступа.
     * `secret_key` — значение секретного ключа доступа.
     * `read` — доступ на чтение объектов в бакете.
	 * `list` — доступ к списку объектов в бакете.

     Более подробную информацию о параметрах ресурса `yandex_storage_bucket` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/storage_bucket#bucket-anonymous-access-flags).

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

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

        После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).
  
- API

  Чтобы открыть публичный доступ к операциям с бакетом, воспользуйтесь методом REST API [update](../../api-ref/Bucket/update.md) для ресурса [Bucket](../../api-ref/Bucket/index.md) или вызовом gRPC API [BucketService/Update](../../api-ref/grpc/bucket_service.md#Update).

{% endlist %}
