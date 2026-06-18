# Проверить права на домены

Чтобы пройти процедуру [проверки прав на домены](../../concepts/challenges.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в который был добавлен [сертификат](../../concepts/managed-certificate.md).
  1. Перейдите в сервис **Certificate Manager**.
  1. Выберите сертификат, для которого необходимо пройти процедуру проверки и нажмите на него.
  1. В блоке **Проверка прав на домены** будет указана информация для прохождения процедуры проверки прав.
  1. После успешного прохождения проверки прав на домен, статус проверки домена в блоке **Проверка прав на домены** изменится на `Valid`.
  1. После того как статус проверки прав всех доменов изменится на `Valid`, сертификат будет выпущен и перейдет в статус `Issued`.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды:

     ```bash
     yc certificate-manager certificate get --help
     ```

  1. Выполните команду:

     ```bash
     yc certificate-manager certificate get \
       --id fpq6gvvm6piu******** \
       --full
     ```

     Где:
     * `--id` — идентификатор [сертификата](../../concepts/managed-certificate.md).
     * `--full` — показать список активных процедур проверки прав на домены.

     Результат:

     ```text
     id: fpq6gvvm6piu********
     folder_id: b1g7gvsi89m3********
     created_at: "2020-09-15T08:49:11.533771Z"
     name: mymanagedcert
     type: MANAGED
     domains:
     - example.com
     status: VALIDATING
     updated_at: "2020-09-15T08:49:11.533771Z"
     challenges:
     - domain: example.com
       type: HTTP
       created_at: "2020-09-15T08:49:11.533771Z"
       updated_at: "2020-09-15T08:51:44.991065Z"
       status: PENDING
       message: Create a file in your web server's base directory.
       http_challenge:
         url: http://example.com/.well-known/acme-challenge/3LiH-nrTC7GdMbRgVqttEvdTODeNeaD0TtX********
            content: 3LiH-nrTC7GdMbRgVqttEvdTODeNeaD0TtXteWgtAH8.ZHCju15sJiKBwT8G5FTl7UtfmJWp1gKNYYP********
     ```

  1. В блоке `http_challenge` указана информация для прохождения процедуры проверки прав.
  1. После успешного прохождения проверки прав на домен, статус проверки изменится на `Valid`:

     ```bash
     yc certificate-manager certificate get \
       --id fpq6gvvm6piu******** \
       --full
     ```

     Результат:

     ```text
     ...
     domains:
     - example.com
     status: VALID
     ...
     ```

  1. После того как статус проверки прав всех доменов изменится на `Valid`, сертификат будет выпущен и перейдет в статус `Issued`:

     ```bash
     yc certificate-manager certificate get \
       --id fpq6gvvm6piu******** \
       --full
     ```

     Результат:

     ```text
     ...
     domains:
     - example.com
     status: ISSUED
     ...
     ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  С помощью Terraform можно создать [DNS-запись](../../../dns/concepts/resource-record.md), необходимую для прохождения проверки прав на домен. Для этого:
  1. Опишите в конфигурационном файле Terraform параметры ресурсов, которые необходимо создать:

     ```hcl
     resource "yandex_cm_certificate" "le-certificate" {
       name    = "<имя_сертификата>"
       domains = ["<домен>"]

       managed {
         challenge_type = "DNS_CNAME"
       }
     }

     resource "yandex_dns_recordset" "validation-record" {
       zone_id = "<идентификатор_зоны>"
       name    = yandex_cm_certificate.le-certificate.challenges[0].dns_name
       type    = yandex_cm_certificate.le-certificate.challenges[0].dns_type
       data    = [yandex_cm_certificate.le-certificate.challenges[0].dns_value]
       ttl     = <время_жизни_записи_секунд>
     }

     data "yandex_cm_certificate" "example" {
       depends_on      = [yandex_dns_recordset.validation-record]
       certificate_id  = yandex_cm_certificate.le-certificate.id
       wait_validation = true
     }

     # Используйте data.yandex_cm_certificate.example.id, чтобы получить действительный сертификат.

     output "cert-id" {
       description = "Certificate ID"
       value       = data.yandex_cm_certificate.example.id
     }
     ```

     Где:
     * Параметры ресурса `yandex_cm_certificate`:
       * `domains` — домен, для которого нужно создать сертификат.
       * `challenge_type` — способ проверки владельца домена. Возможные значения:
         * `DNS_CNAME` — необходимо создать DNS-запись в формате [CNAME](../../../dns/concepts/resource-record.md#cname-cname) с указанным значением. Рекомендуемый способ для автоматического продления сертификата.
         * `DNS_TXT` — необходимо создать DNS-запись в формате [TXT](../../../dns/concepts/resource-record.md#txt) с указанным значением.
     * Параметры ресурса `yandex_dns_recordset`:
       * `zone_id` — идентификатор DNS-зоны, в которой будет находиться запись для проверки владельца.
       * `name` — имя записи.
       * `type` — тип DNS-записи.
       * `data` — значение записи.
       * `ttl` — время жизни записи (TTL, Time to live) в секундах до актуализации информации о значении записи.
       * `description` — описание набора записей. Необязательный параметр.
     * Параметры источника данных `yandex_cm_certificate`:
       * `depends_on` — указывает зависимость от другого ресурса Terraform.
       * `certificate_id` — идентификатор сертификата.
       * `wait_validation` — флаг ожидания валидации сертификата. Если значение `true`, операция не будет завершена, пока сертификат находится в статусе `VALIDATING`. Значение по умолчанию `false`.

     Подробную информацию о параметрах ресурсов см. в [документации провайдера Terraform](../../../terraform/index.md).
  1. Создайте ресурсы:

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

  После этого в указанном [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) будут созданы сертификат и DNS-запись. Проверить появление сертификата и его настройки можно в [консоли управления](https://console.yandex.cloud) или с помощью команд [CLI](../../../cli/index.md):

  ```bash
  yc certificate-manager certificate get <имя_сертификата> --full
  ```

- API {#api}

  Для получения информации, необходимой для прохождения процедуры проверки прав на домены, воспользуйтесь методом REST API [get](../../api-ref/Certificate/get.md) для ресурса [Certificate](../../api-ref/Certificate/index.md) или вызовом gRPC API [CertificateService/Get](../../api-ref/grpc/Certificate/get.md) с флагом `view=FULL`.

{% endlist %}

{% note info %}

Чтобы DNS-проверка прав на домен по записи `CNAME` прошла успешно, для поддомена `_acme-challenge` проверяемого доменного имени не должно быть других [ресурсных записей](../../../dns/concepts/resource-record.md), кроме `CNAME`. Например, для имени `_acme-challenge.example.com.` должна существовать только CNAME-запись и не должно быть TXT-записи.

{% endnote %}