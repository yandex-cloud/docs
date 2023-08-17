# Добавить сертификат от Let's Encrypt

Сертификат из {{ certificate-manager-name }} можно использовать только в [указанных](../../concepts/services.md) сервисах {{ yandex-cloud }}.

Чтобы добавить новый [сертификат](../../concepts/managed-certificate.md) от Let's Encrypt:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в который будет добавлен сертификат.
  1. В списке сервисов выберите **{{ certificate-manager-name }}**.
  1. Нажмите кнопку **Добавить сертификат**.
  1. В открывшемся меню выберите **Сертификат от Let's Encrypt**.
  1. В открывшемся окне в поле **Имя** введите имя сертификата.
  1. (Опционально) В поле **Описание** введите описание сертификата.
  1. В поле **Домены** введите список доменов, для которых нужно выпустить сертификат.
  1. Выберите [тип проверки прав на домен](../../concepts/challenges.md): `DNS` или `HTTP`.
  1. Нажмите кнопку **Создать**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды:

     ```bash
     yc certificate-manager certificate request --help
     ```

  1. Выполните команду:

     ```bash
     yc certificate-manager certificate request \
       --name mymanagedcert \
       --domains example.com
     ```

     Где:
     * `--name` — имя сертификата.
     * `--domains` — домены сертификатов.

     Результат выполнения команды:

     ```bash
     id: fpq6gvvm6piu********
     folder_id: b1g7gvsi89m3********
     created_at: "2020-09-15T08:49:11.533771Z"
     ...
     - example.com
     status: VALIDATING
     updated_at: "2020-09-15T08:49:11.533771Z"
     ```

- {{ TF }}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  Подробнее о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  1. Опишите в конфигурационном файле {{ TF }} параметры ресурса, который необходимо создать:

      ```hcl
      resource "yandex_cm_certificate" "le-certificate" {
        name    = "<имя_сертификата>"
        domains = ["<домен>"]

        managed {
        challenge_type = "<тип_проверки_владельца_домена>"
        }
      }
      ```

      Где:

      * `domains` — список доменов, для которых нужно создать сертификат.
      * `challenge_type` — [тип проверки прав на домен](../../concepts/challenges.md), которую нужно [пройти](cert-validate.md) владельцу домена. Возможные значения:

        * `DNS_CNAME` — необходимо создать DNS-запись в формате CNAME с указанным значением. Рекомендуемый способ для автоматического продления сертификата.
        * `DNS_TXT` — необходимо создать DNS-запись в формате TXT с указанным значением.
        * `HTTP` — необходимо поместить указанное значение в указанный URL.

      Подробную информацию о параметрах ресурса `yandex_cm_certificate` см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/cm_certificate).

  1. Создайте ресурсы:
  
      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

  После этого в указанном каталоге будет создан сертификат. Проверить появление сертификата и его настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

    ```bash
    yc certificate-manager certificate get <имя_сертификата>
    ```

- API

  Чтобы добавить сертификат, воспользуйтесь методом REST API [requestNew](../../api-ref/Certificate/requestNew.md) для ресурса [Certificate](../../api-ref/Certificate/) или вызовом gRPC API [CertificateService/RequestNew](../../api-ref/grpc/certificate_service.md#RequestNew).

{% endlist %}

В списке сертификатов появится новый сертификат со статусом `Validating`. Этот статус означает, что запрос на выпуск сертификата от Let's Encrypt создан, и для его успешной обработки вам необходимо пройти [процедуру проверки прав на домены](cert-validate.md).