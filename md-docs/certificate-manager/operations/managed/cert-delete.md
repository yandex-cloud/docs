[Документация Yandex Cloud](../../../index.md) > [Yandex Certificate Manager](../../index.md) > [Пошаговые инструкции](../index.md) > Сертификат от Let's Encrypt > Удаление сертификата

# Удалить сертификат от Let's Encrypt

Чтобы удалить [сертификат от Let's Encrypt](../../concepts/managed-certificate.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в который был добавлен сертификат.
  1. Перейдите в сервис **Certificate Manager**.
  1. В строке с нужным сертификатом нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash](../../../_assets/console-icons/trash-bin.svg) **Удалить**.
  1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Откройте файл конфигурации Terraform и удалите фрагмент с описанием сертификата:

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
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

  Проверить удаление сертификата можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/index.md):

  ```bash
  yc certificate-manager certificate list
  ```

- API {#api}

  Чтобы удалить сертификат, воспользуйтесь методом REST API [delete](../../api-ref/Certificate/delete.md) для ресурса [Certificate](../../api-ref/Certificate/index.md) или вызовом gRPC API [CertificateService/Delete](../../api-ref/grpc/Certificate/delete.md).

{% endlist %}