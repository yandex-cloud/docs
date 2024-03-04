---
title: "Как изменить пользовательский сертификат в {{ certificate-manager-full-name }}"
description: "Следуя данной инструкции, вы сможете изменить пользовательский сертификат."
---

# Изменить пользовательский сертификат

После добавления в {{ certificate-manager-name }} [пользовательского сертификата](../../concepts/imported-certificate.md) вы можете изменить его название или описание. Чтобы изменить сертификат:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в который был добавлен сертификат.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
  1. Выберите в списке сертификат, который необходимо изменить.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.certificate-manager.overview.action_edit-meta }}**.
  1. Измените название или описание сертификата.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

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

     Результат:

     ```text
     +----------------------+--------+-------------+---------------------+----------+--------+
     |          ID          |  NAME  |   DOMAINS   |      NOT AFTER      |   TYPE   | STATUS |
     +----------------------+--------+-------------+---------------------+----------+--------+
     | fpqmg47avvim******** | mycert | example.com | 2021-09-15 08:12:57 | IMPORTED | ISSUED |
     +----------------------+--------+-------------+---------------------+----------+--------+
     ```

  1. Выполните команду:

     ```bash
     yc certificate-manager certificates update \
       --id fpqmg47avvim******** \
       --new-name myupdatedcert \
       --description "description of myupdatedcert"
     ```

     Где:
     * `--id` — идентификатор сертификата.
     * `--new-name` — новое имя сертификата.
     * `--description` — описание сертификата.

     Результат:

     ```text
     id: fpqmg47avvim********
     folder_id: b1g7gvsi89m3********
     created_at: "2020-09-15T06:54:44.916Z"
     ...
     issued_at: "2020-09-15T08:23:50.147Z"
     not_after: "2021-09-15T08:12:57Z"
     not_before: "2020-09-15T08:12:57Z"
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и измените имя или описание сертификата:

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

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Проверить изменение сертификата можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

  ```bash
  yc certificate-manager certificate get <имя_сертификата>
  ```

- API {#api}

  Чтобы изменить сертификат, воспользуйтесь методом REST API [update](../../api-ref/Certificate/update.md) для ресурса [Certificate](../../api-ref/Certificate/) или вызовом gRPC API [CertificateService/Update](../../api-ref/grpc/certificate_service.md#Update).

{% endlist %}