---
title: How to update a SAML app in {{ org-full-name }}
description: Follow this guide to update a a SAML app in {{ org-name }}.
---

# Updating a SAML app in {{ org-full-name }}

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

## Update the app's basic settings {#update-basic-settings}

To update the [SAML app's basic settings](../../concepts/applications.md#saml):

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
  1. On the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:

      1. Change the app's name in the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-name_d22aF }}** field. The name must be unique within the organization and follow the naming requirements:

          {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

      1. Change the app's description in the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-description_cjpok }}** field.
      1. Add new [labels](../../../resource-manager/concepts/labels.md) by clicking **{{ ui-key.yacloud.component.label-set.button_add-label }}** in the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-labels_uT2D2 }}** field. Click ![xmark](../../../_assets/console-icons/xmark.svg) to delete an existing label.
      1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for updating a SAML app:

     ```bash
     yc organization-manager idp application saml application update --help
     ```
  
  1. Run this command:

     ```bash
     yc organization-manager idp application saml application update \
       --id <app_ID> \
       --new-name <application_name> \
       --description <application_description> \
       --labels <key>=<value>[,<key>=<value>]
     ```

     Where:

     * `--id`: SAML application ID. This is a required setting.
     * `--new-name`: New SAML app name. The name must be unique within the organization and follow the naming requirements:

       {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

     * `--description`: New SAML app description.
     * `--labels`: New list of [labels](../../../resource-manager/concepts/labels.md). You can specify one or more labels separated by commas in `<key1>=<value1>,<key2>=<value2>` format.

     Result:

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

  1. Describe the new SAML application parameters in the configuration file:

     ```hcl
     resource "yandex_organizationmanager_idp_application_saml_application" "saml_app" {
       organization_id = "<organization_ID>"
       name            = "<new_application_name>"
       description     = "<new_application_description>"
       labels          = {
         "<key>" = "<value>"
       }
     }
     ```

     Where:

     * `name`: New SAML app name. The name must be unique within the organization and follow the naming requirements:

       {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

     * `description`: New SAML app description.
     * `labels`: New [labels](../../../resource-manager/concepts/labels.md).

     For more information about `yandex_organizationmanager_idp_application_saml_application` properties, see [this provider guide]({{ tf-provider-resources-link }}/organizationmanager_idp_application_saml_application).

  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     You can check the changes to the resources and their settings in [{{ org-full-name }}]({{ link-org-cloud-center }}).

- API {#api}

  Use the [Application.Update](../../idp/application/saml/api-ref/Application/update.md) REST API method for the [Application](../../idp/application/saml/api-ref/Application/index.md) resource or the [ApplicationService/Update](../../idp/application/saml/api-ref/grpc/Application/update.md) gRPC API call.

{% endlist %}

## Update the service provider configuration {#update-sp}

To update the service provider configuration in a SAML app:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
  1. {% include [saml-app-update-sp-settings](../../../_includes/organization/saml-app-update-sp-settings.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for updating the service provider configuration:

     ```bash
     yc organization-manager idp application saml application update --help
     ```

  1. Run this command:

     ```bash
     yc organization-manager idp application saml application update \
       --id <app_ID> \
       --sp-entity-id <service_provider_ID> \
       --acs-urls <URL>[,<URL>] \
       --signature-mode <signature_mode>
     ```

     Where:

     * `--id`: SAML application ID. This is a required setting.
     * `--sp-entity-id`: Unique service provider ID. The value must be the same on the service provider's and {{ org-name }} side.
     * `--acs-urls`: URL or comma-separated URLs to which {{ org-name }} will send the SAML response. The ACS URL must follow the `https` schema. You can only use an encryption-free protocol for testing purposes on a local host (`http://127.0.0.1` and `http://localhost` values).
     * `--signature-mode`: SAML response elements that will be digitally signed. The possible values are:
       * `assertion_only`: Only the provided user attributes.
       * `response_only`: Full SAML response.
       * `response_and_assertion`: Full SAML response and, separately, the provided attributes.

     Result:

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

  1. Describe the new service provider configuration parameters in the configuration file:

     ```hcl
     resource "yandex_organizationmanager_idp_application_saml_application" "saml_app" {
       organization_id = "<organization_ID>"
       name            = "<application_name>"

       service_provider = {
         entity_id = "<service_provider_ID>"
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

     Where:

     * `entity_id`: New unique service provider ID. The value must be the same on the service provider's and {{ org-name }} side.
     * `acs_urls`: New URLs {{ org-name }} will send the SAML response to. The ACS URL must follow the `https` schema. You can only use an encryption-free protocol for testing purposes on a local host (`http://127.0.0.1` and `http://localhost` values).
     * `signature_mode`: New SAML response elements that will be digitally signed. The possible values are:
       * `ASSERTION_ONLY`: Only the provided user attributes.
       * `RESPONSE_ONLY`: Full SAML response.
       * `RESPONSE_AND_ASSERTION`: Full SAML response and, separately, the provided attributes.

     For more information about `yandex_organizationmanager_idp_application_saml_application` properties, see [this provider guide]({{ tf-provider-resources-link }}/organizationmanager_idp_application_saml_application).

  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     You can check the changes to the resources and their settings in [{{ org-full-name }}]({{ link-org-cloud-center }}).

- API {#api}

  Use the [Application.Update](../../idp/application/saml/api-ref/Application/update.md) REST API method for the [Application](../../idp/application/saml/api-ref/Application/index.md) resource or the [ApplicationService/Update](../../idp/application/saml/api-ref/grpc/Application/update.md) gRPC API call.

{% endlist %}

## Update a digital signature verification key certificate {#update-cert}

{% include [saml-app-cert-intro-phrase](../../../_includes/organization/saml-app-cert-intro-phrase.md) %}

You can issue any number of new digital signature verification key certificates for the SAML app at any time. To do so:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
  1. Under **{{ ui-key.yacloud_org.application.overview.certificate_section_title }}**, click **{{ ui-key.yacloud_org.application.overview.certificate_action_manage_certs }}** on the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab and in the window that opens:

      1. Click **{{ ui-key.yacloud_org.cloud-components.manage-cert-dialog.action-generate-new-certificate }}**. This will create a new certificate which will appear in the list.
      1. To activate the new certificate, enable **{{ ui-key.yacloud_org.cloud-components.manage-cert-dialog.table.column-active }}** next to it.

          {% include [saml-app-cert-update-warn](../../../_includes/organization/saml-app-cert-update-warn.md) %}

      1. To download the new certificate, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) next to it and select ![arrow-down-to-line](../../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud.common.download }}**.
      1. To delete the certificate, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) next to it and select ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**, then confirm the deletion. You can only delete inactive certificates.
      1. Click **{{ ui-key.yacloud.common.close }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for creating a new certificate:

     ```bash
     yc organization-manager idp application saml signature-certificate create --help
     ```

  1. Create a new certificate:

     ```bash
     yc organization-manager idp application saml signature-certificate create \
       --application-id <app_ID>
     ```

     Where:

     * `--application-id`: SAML application ID.

     Result:

     ```text
     id: ajeq9jfrmc5t********
     application_id: ek0o663g4rs2********
     created_at: "2025-10-21T10:14:17.861652377Z"
     ```

     Save the certificate ID because you will need it to activate the certificate.

  1. View the list of app certificates:

     ```bash
     yc organization-manager idp application saml signature-certificate list \
       --application-id <app_ID>
     ```

  1. Activate a new certificate:

     ```bash
     yc organization-manager idp application saml signature-certificate update \
       --id <certificate_ID> \
       --active true
     ```

     Where:

     * `--id`: Certificate ID you got when creating the certificate.
     * `--active`: Set to `true` to activate the certificate.

     {% include [saml-app-cert-update-warn](../../../_includes/organization/saml-app-cert-update-warn.md) %}

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Describe the resource for creating a new certificate in the configuration file:

     ```hcl
     resource "yandex_organizationmanager_idp_application_saml_signature_certificate" "cert" {
       application_id = "<app_ID>"
       name           = "<certificate_name>"
     }
     ```

     Where:

     * `application_id`: SAML application ID.
     * `name`: Certificate name.

     For more information about `yandex_organizationmanager_idp_application_saml_signature_certificate` properties, see [this provider guide]({{ tf-provider-resources-link }}/organizationmanager_idp_application_saml_signature_certificate).

  1. Create a resource:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  1. To activate a new certificate, add it to the SAML application configuration by specifying the certificate ID in the `yandex_organizationmanager_idp_application_saml_application` resource description under `signature_certificate_ids`.
  
  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     You can check the changes to the resources and their settings in [{{ org-full-name }}]({{ link-org-cloud-center }}).

- API {#api}

  Use the [SignatureCertificate.Create](../../idp/application/saml/api-ref/SignatureCertificate/create.md) REST API method for the [SignatureCertificate](../../idp/application/saml/api-ref/SignatureCertificate/index.md) resource or the [SignatureCertificateService/Create](../../idp/application/saml/api-ref/grpc/SignatureCertificate/create.md) gRPC API call.

{% endlist %}

## Update user and group attributes {#update-attributes}

To update the attributes {{ org-name }} will transmit to the service provider:

{% include [saml-app-update-assertions](../../../_includes/organization/saml-app-update-assertions.md) %}

## Update the list of app users and groups {#users-and-groups}

Update the list of your [organization's](../../concepts/organization.md) users permitted to authenticate in external app with a SAML application:

{% include [saml-app-update-users-groups](../../../_includes/organization/saml-app-update-users-groups.md) %}

#### See also {#see-also}

* [{#T}](./saml-create.md)
* [{#T}](./saml-deactivate-remove.md)
* [{#T}](../add-account.md)
* [{#T}](../../concepts/applications.md#saml)
* [{#T}](../manage-groups.md)