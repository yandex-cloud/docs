# Добавить сертификат от Let's Encrypt®

[Сертификат](../../concepts/managed-certificate.md) из {{ certificate-manager-name }} можно использовать только в [указанных сервисах](../../concepts/services.md) {{ yandex-cloud }}.

## Добавить новый сертификат {#add-certificate}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в который будет добавлен сертификат.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.certificate-manager.button_empty-action }}**.
  1. В открывшемся меню выберите **{{ ui-key.yacloud.certificate-manager.action_request }}**.
  1. В открывшемся окне в поле **{{ ui-key.yacloud.certificate-manager.metadata.field_name }}** введите имя сертификата.
  1. (Опционально) В поле **Описание** введите описание сертификата.
  1. В поле **{{ ui-key.yacloud.certificate-manager.request.field_domains }}** введите список доменов, для которых нужно выпустить сертификат.

     Имена доменов могут содержать маску, например `*.example.com`. В этом случае при выборе типа проверки прав на домен необходимо будет выбрать `DNS`. Подробнее см. в разделе [Проверка прав на домен](../../concepts/challenges.md#dns).
  1. Выберите [тип проверки прав на домен](../../concepts/challenges.md): `{{ ui-key.yacloud.certificate-manager.request.challenge-type_label_dns }}` или `{{ ui-key.yacloud.certificate-manager.request.challenge-type_label_http }}`.
  1. Нажмите кнопку **{{ ui-key.yacloud.certificate-manager.request.button_request }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

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
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

  После этого в указанном [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) будет создан сертификат. Проверить появление сертификата и его настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/index.md):

  ```bash
  yc certificate-manager certificate get <имя_сертификата>
  ```

- API {#api}

  Чтобы добавить сертификат, воспользуйтесь методом REST API [requestNew](../../api-ref/Certificate/requestNew.md) для ресурса [Certificate](../../api-ref/Certificate/index.md) или вызовом gRPC API [CertificateService/RequestNew](../../api-ref/grpc/Certificate/requestNew.md).

{% endlist %}

В списке сертификатов появится новый сертификат со статусом `Validating`. Этот статус означает, что создан запрос на выпуск сертификата от Let's Encrypt®. Для обработки запроса [подтвердите права на домены](cert-validate.md).

{% note info %}

Чтобы DNS-проверка прав на домен по записи `CNAME` прошла успешно, для поддомена `_acme-challenge` проверяемого доменного имени не должно быть других [ресурсных записей](../../../dns/concepts/resource-record.md), кроме `CNAME`. Например, для имени `_acme-challenge.example.com.` должна существовать только CNAME-запись и не должно быть TXT-записи.

{% endnote %}

## Посмотреть статус выпуска сертификата {#view-statuses}

Проверить статус создания сертификата и возможные ошибки при его выпуске можно в [консоли управления]({{ link-console-main }}):

1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
1. Выберите сертификат в списке.
   
   Напротив поля **{{ ui-key.yacloud.certificate-manager.overview.general_label_validation }}** будет указан текущий этап выпуска сертификата.
1. Чтобы посмотреть описание этапа и его результаты, нажмите ![receipt](../../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.certificate-manager.overview.button_validation_show-logs }}**.

   Подробнее об этапах выпуска сертификата см. в разделе [Сертификат от Let's Encrypt](../../concepts/managed-certificate.md#issue-statuses).

#### См. также {#see-also}

* [{#T}](cert-get-content.md).
* [{#T}](cert-validate.md).
* [{#T}](cert-update.md).