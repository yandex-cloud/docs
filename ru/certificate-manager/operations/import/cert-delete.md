# Удалить пользовательский сертификат

Чтобы удалить [пользовательский сертификат](../../concepts/imported-certificate.md):

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в который был добавлен сертификат.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
  1. Найдите в списке сертификат, который необходимо удалить.
  1. Нажмите кнопку ![image](../../../_assets/options.svg).
  1. В открывшемся меню нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды:

     ```bash
     yc certificate-manager certificates delete --help
     ```

  1. Посмотрите список сертификатов:

     ```bash
     yc certificate-manager certificate list
     ```

     Результат выполнения команды:

     ```bash
     +----------------------+---------------+-------------+---------------------+----------+--------+
     |          ID          |     NAME      |   DOMAINS   |      NOT AFTER      |   TYPE   | STATUS |
     +----------------------+---------------+-------------+---------------------+----------+--------+
     | fpqmg47avvim******** | myupdatedcert | example.com | 2021-09-15 08:12:57 | IMPORTED | ISSUED |
     +----------------------+---------------+-------------+---------------------+----------+--------+
     ```

  1. Выполните команду:

     ```bash
     yc certificate-manager certificates delete \
       --id fpqmg47avvim********
     ```

     Где `--id` — идентификатор сертификата.

     Результат выполнения команды:

     ```bash
     id: fpqmg47avvim********
     folder_id: b1g7gvsi89m3********
     created_at: "2020-09-15T06:54:44.916Z"
     ...
     issued_at: "2020-09-15T08:23:50.147Z"
     not_after: "2021-09-15T08:12:57Z"
     not_before: "2020-09-15T08:12:57Z"
     ```

- {{ TF }}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием сертификата:

     {% cut "Пример описания сертификата в конфигурации {{ TF }}" %}

     ```
     ...
     resource "yandex_cm_certificate" "imported-certificate" {
       name    = "my-certificate"

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

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

  Проверить удаление сертификата можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

    ```bash
    yc certificate-manager certificate list
    ```

- API

  Чтобы удалить сертификат, воспользуйтесь методом REST API [delete](../../api-ref/Certificate/delete.md) для ресурса [Certificate](../../api-ref/Certificate/) или вызовом gRPC API [CertificateService/Delete](../../api-ref/grpc/certificate_service.md#Delete).

{% endlist %}