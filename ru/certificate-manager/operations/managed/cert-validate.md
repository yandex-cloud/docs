# Проверить права на домены

Чтобы пройти процедуру проверки прав на домены:

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в который был добавлен сертификат.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
    1. Выберите в списке сертификат, для которого необходимо пройти процедуру проверки и нажмите на него.
    1. В открывшемся окне в блоке **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}** будет указана информация для прохождения процедуры проверки прав. Подробнее читайте в разделе [{#T}](../../concepts/challenges.md).
    1. После успешного прохождения проверки прав на домен, статус проверки домена в блоке **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}** изменится на `Valid`.
    1. После того, как статус проверки прав всех доменов изменится на `Valid`, сертификат будет выпущен и перейдет в статус `Issued`.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

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

          - `--id` — идентификатор сертификата.
          - `--full` — показать список активных процедур проверки прав на домены.

        Результат:

        ```bash
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
            url: http://example.com/.well-known/acme-challenge/3LiH-nrTC7GdMbRgVqttEvdTODeNeaD0TtXteWgtAH8
            content: 3LiH-nrTC7GdMbRgVqttEvdTODeNeaD0TtXteWgtAH8.ZHCju15sJiKBwT8G5FTl7UtfmJWp1gKNYYPLcVtVL44
        ```

    1. В блоке `http_challenge` указана информация для прохождения процедуры проверки прав. Подробнее читайте в разделе [{#T}](../../concepts/challenges.md).

    1. После успешного прохождения проверки прав на домен, статус проверки изменится на `Valid`:

        ```bash
        yc certificate-manager certificate get --id fpq6gvvm6piu******** --full
        ...
        domains:
        - example.com
        status: VALID
        ...
        ```

    1. После того, как статус проверки прав всех доменов изменится на `Valid`, сертификат будет выпущен и перейдет в статус `Issued`:

        ```bash
        yc certificate-manager certificate get --id fpq6gvvm6piuegbb2nol --full
        ...
        domains:
        - example.com
        status: ISSUED
        ...
        ```

- {{ TF }}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  Подробнее о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  С помощью {{ TF }} можно создать DNS-запись, необходимую для прохождения проверки прав на домен. Для этого:

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:

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
        depends_on      = [yandex_dns_recordset.example]
        certificate_id  = yandex_cm_certificate.example.id
        wait_validation = true
      }

      # Use data.yandex_cm_certificate.example.id to get validated certificate

      output "cert-id" {
        description = "Certificate ID"
        value       = data.yandex_cm_certificate.example.id
      }
      ```

      Где:

      * Параметры ресурса `yandex_cm_certificate`:

          * `domains` — домен, для которого нужно создать сертификат.
          * `challenge_type` — способ проверки владельца домена. Возможные значения:

            * `DNS_CNAME` — необходимо создать DNS-запись в формате CNAME с указанным значением. Рекомендуемый способ для автоматического продления сертификата.
            * `DNS_TXT` — необходимо создать DNS-запись в формате TXT с указанным значением.

      * Параметры ресурса `yandex_dns_recordset`:

          * `zone_id` — идентификатор DNS-зоны, в которой будет находиться запись для проверки владельца.
          * `name` — имя записи.
          * `type` — тип DNS-записи.
          * `data` — значение записи.
          * `ttl` — время жизни записи (TTL, Time to live) в секундах до актуализации информации о значении записи.

      * Параметры источника данных `yandex_dns_recordset`:
          * `depends_on` — указывает зависимость от другого ресурса {{ TF }}.
          * `certificate_id` — идентификатор сертификата.
          * `wait_validation` — флаг ожидания валидация сертификата. Если значение `true`, то операция не будет завершена, пока сертификат находится в статусе `VALIDATING`. Значение по умолчанию `false`.

      Подробную информацию о параметрах ресурсов см. в [документации провайдера {{ TF }}]({{ tf-provider-link }}).

  1. Создайте ресурсы:
  
      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

  После этого в указанном каталоге будут созданы сертификат и DNS-запись. Проверить появление сертификата и его настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команд [CLI](../../../cli/quickstart.md):

    ```bash
    yc certificate-manager certificate get <имя_сертификата>
    ```

- API

    Для получения информации, необходимой для прохождения процедуры проверки прав на домены, воспользуйтесь методом REST API [get](../../api-ref/Certificate/get.md) для ресурса [Certificate](../../api-ref/Certificate/) или вызовом gRPC API [CertificateService/Get](../../api-ref/grpc/certificate_service.md#Get) с флагом `view=FULL`.

{% endlist %}

{% note info %}

{% include [checking-domain-rights-cname](../../../_includes/certificate-manager/checking-domain-rights-cname.md) %}

{% endnote %}