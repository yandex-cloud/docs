# Изменить сертификат от Let's Encrypt

После выпуска и добавления в {{ certificate-manager-name }} [сертификата от Let's Encrypt](../../concepts/managed-certificate.md) вы можете изменить его название или описание. Чтобы изменить сертификат:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в который был добавлен сертификат.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
  1. Выберите в списке сертификат, который необходимо изменить.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.certificate-manager.overview.action_edit-meta }}**.
  1. Измените название или описание сертификата.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды:

     ```bash
     yc certificate-manager certificate update --help
     ```

  1. Посмотрите список сертификатов:

     ```bash
     yc certificate-manager certificate list
     ```

     Результат выполнения команды:

     ```bash
     +----------------------+---------------+-------------+-----------+---------+------------+
     |          ID          |     NAME      |   DOMAINS   | NOT AFTER |  TYPE   |   STATUS   |
     +----------------------+---------------+-------------+-----------+---------+------------+
     | fpq6gvvm6piu******** | mymanagedcert | example.com |           | MANAGED | VALIDATING |
     +----------------------+---------------+-------------+-----------+---------+------------+
     ```

  1. Выполните команду:

     ```bash
     yc certificate-manager certificates update \
       --id fpq6gvvm6piu******** \
       --new-name myupdatedmanagedcert \
       --description "description of myupdatedmanagedcert"
     ```

     Где:
     * `--id` — идентификатор сертификата.
     * `--new-name` — новое имя сертификата.
     * `--description` — описание сертификата.

     Результат выполнения команды:

     ```bash
     id: fpq6gvvm6piu********
     folder_id: b1g7gvsi89m3********
     created_at: "2020-09-15T08:49:11.533Z"
     ...
     - example.com
     status: VALIDATING
     updated_at: "2020-09-15T09:10:06.981875Z"
     ```

- {{ TF }}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}
  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}
  
  1. Откройте файл конфигурации {{ TF }} и измените фрагмент с описанием сертификата:

      {% cut "Пример описания сертификата" %}

      ```hcl
      ...
      resource "yandex_cm_certificate" "le-certificate" {
        name        = "managed-certificate-for-dns"
        description = "this is a certificate for tls"
        domains     = ["my-domain.ru"]

        managed {
        challenge_type = "DNS_CNAME"
        }
      }
      ...
      ```

      {% endcut %}

  1. Примените изменения:
  
      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

  Проверить изменение сертификата и его настроек можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

    ```bash
    yc certificate-manager certificate get <имя_сертификата>
    ```

- API

  Чтобы изменить сертификат, воспользуйтесь методом REST API [update](../../api-ref/Certificate/update.md) для ресурса [Certificate](../../api-ref/Certificate/) или вызовом gRPC API [CertificateService/Update](../../api-ref/grpc/certificate_service.md#Update).

{% endlist %}
