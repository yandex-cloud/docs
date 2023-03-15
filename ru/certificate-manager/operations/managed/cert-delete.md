# Удалить сертификат от Let's Encrypt

Чтобы удалить [сертификат от Let's Encrypt](../../concepts/managed-certificate.md):

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором был создан сертификат.
  1. В списке сервисов выберите **{{ certificate-manager-name }}**.
  1. Найдите в списке сертификат, который необходимо удалить.
  1. Нажмите кнопку ![image](../../../_assets/options.svg).
  1. В открывшемся меню нажмите кнопку **Удалить**.
  1. В открывшемся окне нажмите кнопку **Удалить**.

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
     +----------------------+----------------------+-------------+-----------+---------+------------+
     |          ID          |         NAME         |   DOMAINS   | NOT AFTER |  TYPE   |   STATUS   |
     +----------------------+----------------------+-------------+-----------+---------+------------+
     | fpq6gvvm6piuegbb2nol | myupdatedmanagedcert | example.com |           | MANAGED | VALIDATING |
     +----------------------+----------------------+-------------+-----------+---------+------------+
     ```

  1. Выполните команду:

     ```bash
     yc certificate-manager certificates delete \
       --id fpq6gvvm6piuegbb2nol
     ```

     Где `--id` — идентификатор сертификата.

     Результат выполнения команды:

     ```bash
     id: fpq6gvvm6piuegbb2nol
     folder_id: b1g7gvsi89m34qmcm3ke
     created_at: "2020-09-15T08:49:11.533Z"
     ...
     - example.com
     status: VALIDATING
     updated_at: "2020-09-15T09:10:06.981Z"
     ```

- API

  Чтобы удалить сертификат, воспользуйтесь методом REST API [delete](../../api-ref/Certificate/delete.md) для ресурса [Certificate](../../api-ref/Certificate/) или вызовом gRPC API [CertificateService/Delete](../../api-ref/grpc/certificate_service.md#Delete).

{% endlist %}