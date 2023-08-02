# Изменить сертификат от Let's Encrypt

После выпуска и добавления в {{ certificate-manager-name }} [сертификата от Let's Encrypt](../../concepts/managed-certificate.md) вы можете изменить его название или описание. Чтобы изменить сертификат:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в который был добавлен сертификат.
  1. В списке сервисов выберите **{{ certificate-manager-name }}**.
  1. Выберите в списке сертификат, который необходимо изменить.
  1. В открывшемся окне нажмите кнопку **Изменить**.
  1. Измените название или описание сертификата.
  1. Нажмите кнопку **Сохранить**.

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
     | fpq6gvvm6piuegbb2nol | mymanagedcert | example.com |           | MANAGED | VALIDATING |
     +----------------------+---------------+-------------+-----------+---------+------------+
     ```

  1. Выполните команду:

     ```bash
     yc certificate-manager certificates update \
       --id fpq6gvvm6piuegbb2nol \
       --new-name myupdatedmanagedcert \
       --description "description of myupdatedmanagedcert"
     ```

     Где:
     * `--id` — идентификатор сертификата.
     * `--new-name` — новое имя сертификата.
     * `--description` — описание сертификата.

     Результат выполнения команды:

     ```bash
     id: fpq6gvvm6piuegbb2nol
     folder_id: b1g7gvsi89m34qmcm3ke
     created_at: "2020-09-15T08:49:11.533Z"
     ...
     - example.com
     status: VALIDATING
     updated_at: "2020-09-15T09:10:06.981875Z"
     ```

- API

  Чтобы изменить сертификат, воспользуйтесь методом REST API [update](../../api-ref/Certificate/update.md) для ресурса [Certificate](../../api-ref/Certificate/) или вызовом gRPC API [CertificateService/Update](../../api-ref/grpc/certificate_service.md#Update).

{% endlist %}