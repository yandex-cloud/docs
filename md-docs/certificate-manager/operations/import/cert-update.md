# Обновить пользовательский сертификат

{{ certificate-manager-name }} не управляет [пользовательскими сертификатами](../../concepts/imported-certificate.md). Чтобы обеспечить бесперебойную работу ресурсов с сертификатом, своевременно обновляйте его.

Чтобы получить новую версию пользовательского сертификата:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в который был добавлен сертификат.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
  1. Выберите сертификат, который необходимо обновить.
  1. Нажмите кнопку ![arrows-rotate](../../../_assets/console-icons/arrows-rotate-right.svg) **{{ ui-key.yacloud.certificate-manager.overview.action_reimport }}**.
  1. В открывшемся окне в поле **{{ ui-key.yacloud.certificate-manager.import.field_certificate }}** нажмите кнопку **{{ ui-key.yacloud.certificate-manager.import.button_add-certificate }}**.
     1. Выберите способ добавления: `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}` или `{{ ui-key.yacloud.component.file-content-dialog.value_manual }}`.
     1. Нажмите кнопку **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.
  1. В поле **{{ ui-key.yacloud.certificate-manager.import.field_chain }}** нажмите кнопку **{{ ui-key.yacloud.certificate-manager.import.button_add-chain }}**.
     1. Выберите способ добавления: `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}` или `{{ ui-key.yacloud.component.file-content-dialog.value_manual }}`.
     1. Нажмите кнопку **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.
  1. В поле **{{ ui-key.yacloud.certificate-manager.import.field_privateKey }}** нажмите кнопку **{{ ui-key.yacloud.certificate-manager.import.button_add-privateKey }}**.
     1. Выберите способ добавления: `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}` или `{{ ui-key.yacloud.component.file-content-dialog.value_manual }}`.
     1. Нажмите кнопку **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.button_update }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды:

     ```bash
     yc certificate-manager certificate update --help
     ```

  1. Посмотрите список сертификатов:

     ```bash
     yc certificate-manager certificate list
     ```

     Результат:

     ```text
     +----------------------+--------+-------------+---------------------+----------+--------+
     |          ID          |  NAME  |   DOMAINS   |      NOT AFTER      |   TYPE   | STATUS |
     +----------------------+--------+-------------+---------------------+----------+--------+
     | fpqmg47avvim******** | mycert | example.com | 2021-09-15 06:48:26 | IMPORTED | ISSUED |
     +----------------------+--------+-------------+---------------------+----------+--------+
     ```

  1. Выполните команду:

     ```bash
     yc certificate-manager certificate update \
       --id fpqmg47avvim******** \
       --chain myupdatedcert.pem \
       --key myupdatedkey.pem
     ```

     Где:
     * `--id` — идентификатор сертификата, который необходимо обновить.
     * `--chain` — путь к файлу новой цепочки сертификатов.
     * `--key` — путь к файлу нового закрытого ключа сертификата.

     Результат:

     ```text
     id: fpqmg47avvim********
     folder_id: b1g7gvsi89m3********
     created_at: "2020-09-15T06:54:44.916Z"
     ...
     issued_at: "2020-09-15T08:23:50.147668Z"
     not_after: "2021-09-15T08:12:57Z"
     not_before: "2020-09-15T08:12:57Z"
     ```

- {{ TF }} {#tf}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Откройте файл конфигурации {{ TF }} и измените параметры `certificate` и `private_key` сертификата:

     {% cut "Пример описания сертификата в конфигурации {{ TF }}" %}

     ```hcl
     ...
     resource "yandex_cm_certificate" "imported-certificate" {
       name        = "my-certificate"
       description = "this is a test certificate"

       self_managed {
         certificate = <<-EOT
                       -----BEGIN CERTIFICATE-----
                       MIIF...
                       -----END CERTIFICATE-----
                       EOT
         private_key = <<-EOT
                       -----BEGIN PRIVATE KEY-----
                       MIIJ...
                       -----END PRIVATE KEY-----
                       EOT
       }
     }
     ...
     ```

     {% endcut %}

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

  Проверить изменение сертификата можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/index.md):

  ```bash
  yc certificate-manager certificate get <имя_сертификата>
  ```

- API {#api}

  Чтобы обновить сертификат, воспользуйтесь методом REST API [update](../../api-ref/Certificate/update.md) для ресурса [Certificate](../../api-ref/Certificate/index.md) или вызовом gRPC API [CertificateService/Update](../../api-ref/grpc/Certificate/update.md).

{% endlist %}