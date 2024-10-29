# Добавить сертификат от Let's Encrypt®

[Сертификат](../../concepts/managed-certificate.md) из {{ certificate-manager-name }} можно использовать только в [указанных сервисах](../../concepts/services.md) {{ yandex-cloud }}.

Чтобы добавить новый сертификат от Let's Encrypt®:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в который будет добавлен сертификат.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.certificate-manager.button_empty-action }}**.
  1. В открывшемся меню выберите **{{ ui-key.yacloud.certificate-manager.action_request }}**.
  1. В открывшемся окне в поле **{{ ui-key.yacloud.certificate-manager.metadata.field_name }}** введите имя сертификата.
  1. (Опционально) В поле **Описание** введите описание сертификата.
  1. В поле **{{ ui-key.yacloud.certificate-manager.request.field_domains }}** введите список доменов, для которых нужно выпустить сертификат.

     Имена доменов могут содержать маску, например `*.example.com`. В этом случае при выборе типа проверки прав на домен необходимо будет выбрать `DNS`. Подробнее см. в разделе [Проверка прав на домен](../../concepts/challenges.md#dns).
  1. Выберите [тип проверки прав на домен](../../concepts/challenges.md): `{{ ui-key.yacloud.certificate-manager.request.challenge-type_label_dns }}` или `{{ ui-key.yacloud.certificate-manager.request.challenge-type_label_http }}`.
  1. Нажмите кнопку **{{ ui-key.yacloud.certificate-manager.request.button_request }}**.

- CLI {#cli}

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

     Результат:

     ```text
     id: fpq6gvvm6piu********
     folder_id: b1g7gvsi89m3********
     created_at: "2020-09-15T08:49:11.533771Z"
     ...
     - example.com
     status: VALIDATING
     updated_at: "2020-09-15T08:49:11.533771Z"
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурса, который необходимо создать:

     ```hcl
     resource "yandex_cm_certificate" "le-certificate" {
       name    = "<имя_сертификата>"
       domains = ["<домен>"]

       managed {
       challenge_type = "<тип_проверки>"
       }
     }
     ```

     Где:
     * `domains` — список доменов, для которых нужно создать сертификат.
     * `challenge_type` — [тип проверки прав на домен](../../concepts/challenges.md), которую нужно [пройти](cert-validate.md) владельцу домена. Возможные значения:
       * `DNS_CNAME` — необходимо создать [DNS-запись](../../../dns/concepts/resource-record.md) в формате [CNAME](../../../dns/concepts/resource-record.md#cname-cname) с указанным значением. Рекомендуемый способ для автоматического продления сертификата.
       * `DNS_TXT` — необходимо создать DNS-запись в формате [TXT](../../../dns/concepts/resource-record.md#txt) с указанным значением.
       * `HTTP` — необходимо поместить указанное значение в указанный URL.

     Подробную информацию о параметрах ресурса `yandex_cm_certificate` см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/cm_certificate).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  После этого в указанном [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) будет создан сертификат. Проверить появление сертификата и его настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

  ```bash
  yc certificate-manager certificate get <имя_сертификата>
  ```

- API {#api}

  Чтобы добавить сертификат, воспользуйтесь методом REST API [requestNew](../../api-ref/Certificate/requestNew.md) для ресурса [Certificate](../../api-ref/Certificate/) или вызовом gRPC API [CertificateService/RequestNew](../../api-ref/grpc/Certificate/requestNew.md).

{% endlist %}

В списке сертификатов появится новый сертификат со статусом `Validating`. Этот статус означает, что запрос на выпуск сертификата от Let's Encrypt® создан, и для его успешной обработки вам необходимо пройти [процедуру проверки прав на домены](cert-validate.md).

{% note info %}

{% include [checking-domain-rights-cname](../../../_includes/certificate-manager/checking-domain-rights-cname.md) %}

{% endnote %}

#### См. также {#see-also}

* [{#T}](cert-get-content.md).
* [{#T}](cert-validate.md).
* [{#T}](cert-update.md).