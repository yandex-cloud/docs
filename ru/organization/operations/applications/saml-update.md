---
title: Как изменить SAML-приложение в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете изменить SAML-приложение в {{ org-name }}.
---

# Изменить SAML-приложение в {{ org-full-name }}


{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

## Измените базовые настройки приложения {#update-basic-settings}

Чтобы изменить базовые настройки [SAML-приложения](../../concepts/applications.md#saml):

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
  1. Справа сверху нажмите кнопку ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** и в открывшемся окне:

      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-name_d22aF }}** измените имя приложения. Имя должно быть уникальным в пределах организации и соответствовать требованиям:

          {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-description_cjpok }}** измените описание приложения.
      1. В поле **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-labels_uT2D2 }}** добавьте новые [метки](../../../resource-manager/concepts/labels.md) с помощью кнопки **{{ ui-key.yacloud.component.label-set.button_add-label }}**. Чтобы удалить существующую метку, используйте значок ![xmark](../../../_assets/console-icons/xmark.svg).
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения SAML-приложения:

     ```bash
     yc organization-manager idp application saml application update --help
     ```
  
  1. Выполните команду:

     ```bash
     yc organization-manager idp application saml application update \
       --id <идентификатор_приложения> \
       --new-name <имя_приложения> \
       --description <описание_приложения> \
       --labels <ключ>=<значение>[,<ключ>=<значение>]
     ```

     Где:

     * `--id` — идентификатор SAML-приложения. Обязательный параметр.
     * `--new-name` — новое имя SAML-приложения. Имя должно быть уникальным в пределах организации и соответствовать требованиям:

       {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

     * `--description` — новое описание SAML-приложения.
     * `--labels` — новый список [меток](../../../resource-manager/concepts/labels.md). Можно указать одну или несколько меток через запятую в формате `<ключ1>=<значение1>,<ключ2>=<значение2>`.

     Результат:

     ```text
     id: ek0o663g4rs2********
     name: saml-app
     organization_id: bpf2c65rqcl8********
     group_claims_settings:
       group_distribution_type: NONE
     status: ACTIVE
     created_at: "2025-10-21T10:51:28.790866Z"
     updated_at: "2025-10-21T12:37:19.274522Z"
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле новые параметры SAML-приложения:

     ```hcl
     resource "yandex_organizationmanager_idp_application_saml_application" "saml_app" {
       organization_id = "<идентификатор_организации>"
       name            = "<новое_имя_приложения>"
       description     = "<новое_описание_приложения>"
       labels          = {
         "<ключ>" = "<значение>"
       }
     }
     ```

     Где:

     * `name` — новое имя SAML-приложения. Имя должно быть уникальным в пределах организации и соответствовать требованиям:

       {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

     * `description` — новое описание SAML-приложения.
     * `labels` — новые [метки](../../../resource-manager/concepts/labels.md).

     Более подробную информацию о параметрах ресурса `yandex_organizationmanager_idp_application_saml_application` см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_idp_application_saml_application).

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     Проверить изменения ресурсов и их настройки можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}).

- API {#api}

  Воспользуйтесь методом REST API [Application.Update](../../idp/application/saml/api-ref/Application/update.md) для ресурса [Application](../../idp/application/saml/api-ref/Application/index.md) или вызовом gRPC API [ApplicationService/Update](../../idp/application/saml/api-ref/grpc/Application/update.md).

{% endlist %}

## Измените конфигурацию поставщика услуг {#update-sp}

Чтобы изменить конфигурацию поставщика услуг в SAML-приложении:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
  1. {% include [saml-app-update-sp-settings](../../../_includes/organization/saml-app-update-sp-settings.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения конфигурации поставщика услуг:

     ```bash
     yc organization-manager idp application saml application update --help
     ```

  1. Выполните команду:

     ```bash
     yc organization-manager idp application saml application update \
       --id <идентификатор_приложения> \
       --sp-entity-id <идентификатор_поставщика_услуг> \
       --acs-urls <URL>[,<URL>] \
       --signature-mode <режим_подписи>
     ```

     Где:

     * `--id` — идентификатор SAML-приложения. Обязательный параметр.
     * `--sp-entity-id` — уникальный идентификатор поставщика услуг (Service Provider). Значение должно совпадать на стороне поставщика услуг и на стороне {{ org-name }}.
     * `--acs-urls` — URL-адрес или несколько адресов через запятую, на которые {{ org-name }} будет отправлять SAML-ответ. ACS URL должен соответствовать схеме `https`. Использовать протокол без шифрования допускается только в целях тестирования на локальном хосте (значения `http://127.0.0.1` и `http://localhost`).
     * `--signature-mode` — элементы SAML-ответа, которые будут подписываться электронной подписью. Возможные значения:
       * `assertion_only` — только передаваемые атрибуты пользователя;
       * `response_only` — весь SAML-ответ целиком;
       * `response_and_assertion` — целиком весь SAML-ответ и (отдельно) передаваемые атрибуты.

     Результат:

     ```text
     id: ek0o663g4rs2********
     name: saml-app
     organization_id: bpf2c65rqcl8********
     sp_entity_id: https://example.com/saml
     acs_urls:
       - url: https://example.com/saml/acs
     signature_mode: RESPONSE_AND_ASSERTION
     group_claims_settings:
       group_distribution_type: NONE
     status: ACTIVE
     created_at: "2025-10-21T10:51:28.790866Z"
     updated_at: "2025-10-21T12:37:19.274522Z"
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле новые параметры конфигурации поставщика услуг:

     ```hcl
     resource "yandex_organizationmanager_idp_application_saml_application" "saml_app" {
       organization_id = "<идентификатор_организации>"
       name            = "<имя_приложения>"

       service_provider = {
         entity_id = "<идентификатор_поставщика_услуг>"
         acs_urls  = [
           {
             url = "URL"
           }
         ]
         security_settings = {
           signature_mode = "RESPONSE_AND_ASSERTIONS"
         }
     }
     ```

     Где:

     * `entity_id` — новый уникальный идентификатор поставщика услуг (Service Provider). Значение должно совпадать на стороне поставщика услуг и на стороне {{ org-name }}.
     * `acs_urls` — новые URL-адреса, на которые {{ org-name }} будет отправлять SAML-ответ. ACS URL должен соответствовать схеме `https`. Использовать протокол без шифрования допускается только в целях тестирования на локальном хосте (значения `http://127.0.0.1` и `http://localhost`).
     * `signature_mode` — новые элементы SAML-ответа, которые будут подписываться электронной подписью. Возможные значения:
       * `ASSERTION_ONLY` — только передаваемые атрибуты пользователя;
       * `RESPONSE_ONLY` — весь SAML-ответ целиком;
       * `RESPONSE_AND_ASSERTION` — целиком весь SAML-ответ и (отдельно) передаваемые атрибуты.

     Более подробную информацию о параметрах ресурса `yandex_organizationmanager_idp_application_saml_application` см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_idp_application_saml_application).

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     Проверить изменения ресурсов и их настройки можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}).

- API {#api}

  Воспользуйтесь методом REST API [Application.Update](../../idp/application/saml/api-ref/Application/update.md) для ресурса [Application](../../idp/application/saml/api-ref/Application/index.md) или вызовом gRPC API [ApplicationService/Update](../../idp/application/saml/api-ref/grpc/Application/update.md).

{% endlist %}

## Измените сертификат ключа проверки электронной подписи {#update-cert}

{% include [saml-app-cert-intro-phrase](../../../_includes/organization/saml-app-cert-intro-phrase.md) %}

В любой момент вы можете выпустить любое количество новых сертификатов ключа проверки электронной подписи для SAML-приложения. Для этого:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное SAML-приложение.
  1. На вкладке **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** в блоке **{{ ui-key.yacloud_org.application.overview.certificate_section_title }}** нажмите кнопку **{{ ui-key.yacloud_org.application.overview.certificate_action_manage_certs }}** и в открывшемся окне:

      1. Нажмите кнопку **{{ ui-key.yacloud_org.cloud-components.manage-cert-dialog.action-generate-new-certificate }}**. В результате будет создан новый сертификат, который отобразится в списке.
      1. Чтобы активировать новый сертификат, в строке с этим сертификатом включите опцию **{{ ui-key.yacloud_org.cloud-components.manage-cert-dialog.table.column-active }}**.

          {% include [saml-app-cert-update-warn](../../../_includes/organization/saml-app-cert-update-warn.md) %}

      1. Чтобы скачать новый сертификат, в строке с этим сертификатом нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![arrow-down-to-line](../../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud.common.download }}**.
      1. Чтобы удалить сертификат, в строке с этим сертификатом нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**, после чего подтвердите удаление. Удалить можно только неактивный сертификат.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.close }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания нового сертификата:

     ```bash
     yc organization-manager idp application saml signature-certificate create --help
     ```

  1. Создайте новый сертификат:

     ```bash
     yc organization-manager idp application saml signature-certificate create \
       --application-id <идентификатор_приложения>
     ```

     Где:

     * `--application-id` — идентификатор SAML-приложения.

     Результат:

     ```text
     id: ajeq9jfrmc5t********
     application_id: ek0o663g4rs2********
     created_at: "2025-10-21T10:14:17.861652377Z"
     ```

     Сохраните идентификатор сертификата — он потребуется для активации сертификата.

  1. Посмотрите список сертификатов приложения:

     ```bash
     yc organization-manager idp application saml signature-certificate list \
       --application-id <идентификатор_приложения>
     ```

  1. Активируйте новый сертификат:

     ```bash
     yc organization-manager idp application saml signature-certificate update \
       --id <идентификатор_сертификата> \
       --active true
     ```

     Где:

     * `--id` — идентификатор сертификата, полученный при создании.
     * `--active` — установите `true` для активации сертификата.

     {% include [saml-app-cert-update-warn](../../../_includes/organization/saml-app-cert-update-warn.md) %}

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле ресурс для создания нового сертификата:

     ```hcl
     resource "yandex_organizationmanager_idp_application_saml_signature_certificate" "cert" {
       application_id = "<идентификатор_приложения>"
       name           = "<имя_сертификата>"
     }
     ```

     Где:

     * `application_id` — идентификатор SAML-приложения.
     * `name` — имя сертификата.

     Более подробную информацию о параметрах ресурса `yandex_organizationmanager_idp_application_saml_signature_certificate` см. в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_idp_application_saml_signature_certificate).

  1. Создайте ресурс:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  1. Чтобы активировать новый сертификат, добавьте его в конфигурацию SAML-приложения, указав идентификатор сертификата в описании ресурса `yandex_organizationmanager_idp_application_saml_application` в блоке `signature_certificate_ids`.
  
  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     Проверить изменения ресурсов и их настройки можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}).

- API {#api}

  Воспользуйтесь методом REST API [SignatureCertificate.Create](../../idp/application/saml/api-ref/SignatureCertificate/create.md) для ресурса [SignatureCertificate](../../idp/application/saml/api-ref/SignatureCertificate/index.md) или вызовом gRPC API [SignatureCertificateService/Create](../../idp/application/saml/api-ref/grpc/SignatureCertificate/create.md).

{% endlist %}

## Измените атрибуты пользователей и групп {#update-attributes}

Чтобы изменить атрибуты, которые будут передаваться из {{ org-name }} поставщику услуг:

{% include [saml-app-update-assertions](../../../_includes/organization/saml-app-update-assertions.md) %}

## Измените список пользователей и групп приложения {#users-and-groups}

Измените список пользователей вашей [организации](../../concepts/organization.md), которые могут аутентифицироваться во внешнем приложении с помощью SAML-приложения:

{% include [saml-app-update-users-groups](../../../_includes/organization/saml-app-update-users-groups.md) %}

#### См. также {#see-also}

* [{#T}](./saml-create.md)
* [{#T}](./saml-deactivate-remove.md)
* [{#T}](../add-account.md)
* [{#T}](../../concepts/applications.md#saml)
* [{#T}](../manage-groups.md)