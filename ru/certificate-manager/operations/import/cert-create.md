# Добавить пользовательский сертификат

Добавление пользовательского сертификата рассмотрим на примере самоподписанного сертификата. Требования к пользовательскому сертификату приведены на странице [{#T}](../../concepts/imported-certificate.md).

## Создание файла самоподписанного сертификата {#create-file}

Чтобы создать самоподписанный сертификат с использованием библиотеки `OpenSSL`, выполните команду:

{% list tabs group=programming_language %}

- Bash {#bash}

  ```bash
  openssl req -x509 -newkey rsa:4096 -nodes \
    -keyout key.pem \
    -out cert.pem \
    -days 365 \
    -subj '/CN=example.com'
  ```

- PowerShell {#powershell}

  ```PowerShell
  openssl req -x509 -newkey rsa:4096 -nodes `
    -keyout key.pem `
    -out cert.pem `
    -days 365 `
    -subj '/CN=example.com'
  ```

{% endlist %}

Где:
* `-x509` — результатом работы команды будет файл сертификата.
* `-newkey` — будет создан новый файл приватного ключа.
* `rsa:4096` — алгоритм и длина ключа.
* `-nodes` — не шифровать файл приватного ключа.
* `-keyout` — имя файла, в котором будет сохранен приватный ключ.
* `-out` — имя файла сертификата.
* `-days` — срок действия сертификата.
* `-subj` — значение Common Name владельца сертификата.

Запущенная с указанными параметрами команда `req` выпустит самоподписанный сертификат, для которого она также сгенерирует приватный ключ.

## Добавление пользовательского самоподписанного сертификата {#create-certificate}

Чтобы добавить пользовательский сертификат в {{ certificate-manager-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в который будет добавлен пользовательский сертификат.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.certificate-manager.button_empty-action }}**.
  1. В открывшемся меню выберите **{{ ui-key.yacloud.certificate-manager.action_import }}**.
  1. В открывшемся окне в поле **{{ ui-key.yacloud.certificate-manager.metadata.field_name }}** введите имя пользовательского сертификата.
  1. (Опционально) В поле **Описание** введите описание пользовательского сертификата.
  1. В поле **{{ ui-key.yacloud.certificate-manager.import.field_certificate }}** нажмите кнопку **{{ ui-key.yacloud.certificate-manager.import.button_add-certificate }}**.
     1. Выберите способ добавления `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}`.
     1. Нажмите кнопку **Прикрепить файл**.
        1. В открывшемся окне выберите файл самоподписанного сертификата`cert.pem`.
     1. Нажмите кнопку **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.
  1. В поле **{{ ui-key.yacloud.certificate-manager.import.field_privateKey }}** нажмите кнопку **{{ ui-key.yacloud.certificate-manager.import.button_add-privateKey }}**.
     1. Выберите способ добавления `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}`.
     1. Нажмите кнопку **Прикрепить файл**.
        1. В открывшемся окне выберите файл приватного ключа `key.pem`.
     1. Нажмите кнопку **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды:

     ```bash
     yc certificate-manager certificate create --help
     ```

  1. Выполните команду:

     ```bash
     yc certificate-manager certificate create \
       --name mycert \
       --chain mycert.pem \
       --key mykey.pem
     ```

     Где:
     * `--name` — имя сертификата.
     * `--chain` — путь к файлу цепочки сертификатов.
     * `--key` — путь к файлу приватного ключа сертификата.

     Результат:

     ```text
     id: fpqmg47avvim********
     folder_id: b1g7gvsi89m3********
     created_at: "2020-09-15T06:54:44.916325Z"
     ...
     issued_at: "2020-09-15T06:54:44.916325Z"
     not_after: "2021-09-15T06:48:26Z"
     not_before: "2020-09-15T06:48:26Z"
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```hcl
     resource "yandex_cm_certificate" "user-certificate" {
       name    = "<имя_сертификата>"

       self_managed {
         certificate = <<-EOT
                       -----BEGIN CERTIFICATE-----
                       <содержимое_сертификата>
                       -----END CERTIFICATE-----
                       EOT
         private_key = <<-EOT
                       -----BEGIN PRIVATE KEY-----
                       <содержимое_приватного_ключа_сертификата>
                       -----END PRIVATE KEY-----
                       EOT
       }
     }
     ```

     Где:
     * `name` — имя сертификата.
     * `certificate` — содержимое файла с [сертификатом](../../concepts/imported-certificate.md).
     * `private_key` — содержимое файла с приватным ключом.

     Более подробную информацию о параметрах ресурса `yandex_cm_certificate` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/cm_certificate).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  После этого в указанный каталог будет добавлен сертификат. Проверить появление сертификата и его настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

    ```bash
     yc certificate-manager certificate get <имя_сертификата>
    ```

- API {#api}

  Чтобы добавить сертификат, воспользуйтесь методом REST API [create](../../api-ref/Certificate/create.md) для ресурса [Certificate](../../api-ref/Certificate/) или вызовом gRPC API [CertificateService/Create](../../api-ref/grpc/Certificate/create.md).

{% endlist %}

В списке сертификатов появится новый сертификат со статусом `Issued`.

## Хранение приватного ключа сертификата в {{ lockbox-full-name }} {#create-lockbox}

Чтобы не хранить приватный ключ пользовательского сертификата в открытом виде в конфигурационном файле {{ TF }}, запишите его в [{{ lockbox-name }}](../../../lockbox/):

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. [Создайте секрет](../../../lockbox/operations/secret-create.md) и запишите в него приватный ключ.
  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```hcl
     resource "yandex_cm_certificate" "example-lockbox" {
       name = "<имя_секрета>"

       self_managed {
         certificate = <<-EOT
                       -----BEGIN CERTIFICATE-----
                       <содержимое_сертификата>
                       -----END CERTIFICATE-----
                       EOT
         private_key_lockbox_secret {
           id  = "<идентификатор_секрета>"
           key = "<ключ_секрета>"
         }
       }
     }
     ```

     Где:
     * `name` — имя [секрета](../../../lockbox/concepts/secret.md) {{ lockbox-name }}.
     * `certificate` — содержимое файла с сертификатом.
     * `id` — идентификатор секрета {{ lockbox-name }}, в котором находится приватный ключ.
     * `key` — ключ секрета {{ lockbox-name }}, в котором находится приватный ключ.

     Более подробную информацию о параметрах ресурса `yandex_cm_certificate` см. в [документации провайдера]({{ tf-provider-resources-link }}/cm_certificate).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  После этого в указанный [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) будет добавлен сертификат. Проверить появление сертификата и его настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

  ```bash
  yc certificate-manager certificate get <имя_сертификата>
  ```

{% endlist %}

В списке сертификатов появится новый сертификат со статусом `Issued`.