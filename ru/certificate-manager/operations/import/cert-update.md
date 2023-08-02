# Обновить пользовательский сертификат

{{ certificate-manager-name }} не управляет [пользовательскими сертификатами](../../concepts/imported-certificate.md). Чтобы обеспечить бесперебойную работу ресурсов с сертификатом, своевременно обновляйте его.

Чтобы получить новую версию пользовательского сертификата:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в который был добавлен сертификат.
  1. В списке сервисов выберите **{{ certificate-manager-name }}**.
  1. Выберите в списке сертификат, который необходимо обновить.
  1. В открывшемся окне нажмите кнопку **Обновить сертификат**.
  1. В открывшемся окне в поле **Сертификат** нажмите кнопку **Добавить сертификат**.
     1. Выберите способ добавления: **Файл** или **Текст**.
     1. Нажмите кнопку **Добавить**.
  1. В поле **Цепочка промежуточных сертификатов** нажмите кнопку **Добавить цепочку**.
     1. Выберите способ добавления: **Файл** или **Текст**.
     1. Нажмите кнопку **Добавить**.
  1. В поле **Приватный ключ** нажмите кнопку **Добавить приватный ключ**.
     1. Выберите способ добавления: **Файл** или **Текст**.
     1. Нажмите кнопку **Добавить**.
  1. Нажмите кнопку **Создать**.

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
     +----------------------+--------+-------------+---------------------+----------+--------+
     |          ID          |  NAME  |   DOMAINS   |      NOT AFTER      |   TYPE   | STATUS |
     +----------------------+--------+-------------+---------------------+----------+--------+
     | fpqmg47avvimp7rvmp30 | mycert | example.com | 2021-09-15 06:48:26 | IMPORTED | ISSUED |
     +----------------------+--------+-------------+---------------------+----------+--------+
     ```

  1. Выполните команду:

     ```bash
     yc certificate-manager certificate update \
       --id fpqmg47avvimp7rvmp30 \
       --chain myupdatedcert.pem \
       --key myupdatedkey.pem
     ```

     Где:
     * `--id` — идентификатор сертификата, который необходимо обновить.
     * `--chain` — путь к файлу новой цепочки сертификатов.
     * `--key` — путь к файлу нового закрытого ключа сертификата.

     Результат выполнения команды:

     ```bash
     id: fpqmg47avvimp7rvmp30
     folder_id: b1g7gvsi89m34qmcm3ke
     created_at: "2020-09-15T06:54:44.916Z"
     ...
     issued_at: "2020-09-15T08:23:50.147668Z"
     not_after: "2021-09-15T08:12:57Z"
     not_before: "2020-09-15T08:12:57Z"
     ```

- {{ TF }}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Откройте файл конфигурации {{ TF }} и измените параметры `certificate` и `private_key` сертификата:

     {% cut "Пример описания сертификата в конфигурации {{ TF }}" %}

     ```
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

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

  Проверить изменение сертификата можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

    ```bash
    yc certificate-manager certificate get <имя_сертификата>
    ```

- API

  Чтобы обновить сертификат, воспользуйтесь методом REST API [update](../../api-ref/Certificate/update.md) для ресурса [Certificate](../../api-ref/Certificate/) или вызовом gRPC API [CertificateService/Update](../../api-ref/grpc/certificate_service.md#Update).

{% endlist %}