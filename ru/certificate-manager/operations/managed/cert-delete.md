---
title: Как удалить сертификат от Let's Encrypt в {{ certificate-manager-full-name }}
description: Следуя данной инструкции, вы сможете удалить сертификат от Let's Encrypt.
---

# Удалить сертификат от Let's Encrypt

Чтобы удалить [сертификат от Let's Encrypt](../../concepts/managed-certificate.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в который был добавлен сертификат.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
  1. Найдите в списке сертификат, который необходимо удалить.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/ellipsis.svg).
  1. В открывшемся меню нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

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

     Результат:

     ```text
     +----------------------+----------------------+-------------+-----------+---------+------------+
     |          ID          |         NAME         |   DOMAINS   | NOT AFTER |  TYPE   |   STATUS   |
     +----------------------+----------------------+-------------+-----------+---------+------------+
     | fpq6gvvm6piu******** | myupdatedmanagedcert | example.com |           | MANAGED | VALIDATING |
     +----------------------+----------------------+-------------+-----------+---------+------------+
     ```

  1. Выполните команду:

     ```bash
     yc certificate-manager certificates delete \
       --id fpq6gvvm6piu********
     ```

     Где `--id` — идентификатор сертификата.

     Результат:

     ```text
     id: fpq6gvvm6piu********
     folder_id: b1g7gvsi89m3********
     created_at: "2020-09-15T08:49:11.533Z"
     ...
     - example.com
     status: VALIDATING
     updated_at: "2020-09-15T09:10:06.981Z"
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием сертификата:

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

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Проверить удаление сертификата можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

  ```bash
  yc certificate-manager certificate list
  ```

- API {#api}

  Чтобы удалить сертификат, воспользуйтесь методом REST API [delete](../../api-ref/Certificate/delete.md) для ресурса [Certificate](../../api-ref/Certificate/) или вызовом gRPC API [CertificateService/Delete](../../api-ref/grpc/Certificate/delete.md).

{% endlist %}