# Creating a SAML app in {{ org-full-name }} for integration with Time

[Time](https://time-messenger.ru/) is a corporate messenger with single sign-on support based on the [SAML](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language) standard.

For your [organization's](../../../organization/concepts/organization.md) users to be able to authenticate to Time via SAML SSO, create a [SAML app](../../../organization/concepts/applications/saml.md) in {{ org-full-name }} and configure it both in {{ org-full-name }} and Time.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

To provide your organization's with access to Time:

1. [Generate a key and certificate](#generate-key-cert).
1. [Create an app](#create-app).
1. [Set up the integration](#setup-integration).
1. [Add users](#add-users).
1. [Make sure the application works correctly](#validate).

## Generate a key and certificate {#generate-key-cert}

To encrypt and sign SAML responses, Time requires the service provider's (SP) certificate and private key. Generate it using `openssl`:

```bash
openssl req -x509 -newkey rsa:2048 \
  -keyout private.key \
  -out certificate.crt \
  -days 365 -nodes \
  -subj "/CN=<instance_name>.time‑messenger.ru"
```

Where `<instance_name>` is the name of the Time instance (subdomain on `time‑messenger.ru`).

This will create two files: `private.key` and `certificate.crt`. Save them, as you will need them when setting up SAML in Time.

## Create an app {#create-app}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. Click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** and do the following in the window that opens:
        1. Select the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.saml-title_kyofk }}** single sign-on method.
        1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for your new app: `time‑saml‑app`.
        1. Optionally, add a description and [labels](../../../resource-manager/concepts/labels.md) for the app.
        1. Click **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.
    1. On the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.certificate_section_title }}**, click **{{ ui-key.yacloud_org.application.overview.certificate_action_download_cert }}** and save the `time‑saml‑app.cer` certificate you created, as you will need it when setting up SAML in Time.

{% endlist %}

## Set up the integration {#setup-integration}

To configure Time integration with the SAML app you created in {{ org-full-name }}, complete the configuration both on the {{ org-full-name }} side and in Time.

### Configure endpoints and upload the service provider certificate {#sp-endpoints}

Provide your Time instance details. To find the endpoint values, go to the Time system console at `https://<instance_name>.loop.ru/admin_console/authentication/saml` and copy the values ​​of the `Entity ID` and `ACS URL` fields from the SAML settings.

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, click ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select `time‑saml‑app`.
    1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:
        1. Under **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.section-service-provider_83p1J }}**:
            1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** field, enter `Entity ID`, the unique service provider ID.
            1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** field, enter `ACS URL`, the address to which the service provider will send requests for user authentication.
            1. Optionally, add more `ACS URL` by pressing **{{ ui-key.yacloud_org.organization.apps.SamlAppAcsUrlsField.add-acs-url_eMunC }}** if needed.
            1. Optionally, in the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-logout-url_sLuRl }}** field, add the address to which the IdP will send the SAML response after the user successfully logs out.
            1. In the **{{ ui-key.yacloud_org.application.overview.saml_field_security_mode }}** field, select which parts of the SAML response will be signed:

                * `Assertions`: Only statements about the user (ID, attributes, authentication time) are signed.
                * `Response`: The entire SAML response is signed.
                * `Assertions and Response`: Both the statements and the entire response are signed.
        1. Optionally, to only accept requests signed by one of the added certificates, enable **{{ ui-key.yacloud_org.application.overview.saml_field_request_signing_enabled }}** and add the certificate using **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.RequestSigningSection.add-cert-action }}**.
        1. To ensure that the SAML response is encrypted using the selected certificate, enable **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.EncryptResponseSection.field-encrypt-response }}** and add the previously created certificate using **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.RequestSigningSection.add-cert-action }}**.
        1. From the **{{ ui-key.yacloud_org.application.overview.saml_field_encrypt_response_data_algo }}** list, select **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.encrypt-key-algo-sha256 }}**.
        1. From the **{{ ui-key.yacloud_org.application.overview.saml_field_encrypt_response_key_algo }}** list, select **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.encrypt-key-algo-sha1 }}**.
        1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### Configure user attributes {#user-attributes}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, click ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select `time‑saml‑app`.
    1. Navigate to the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.attributes_to71e }}** tab.
    1. Add an attribute to provide the username. At the top right, click **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_attribute }}** and in the window that opens:
        * In the **{{ ui-key.yacloud_org.organization.apps.GroupAttributeFormDialog.field_attribute_name_rPYTn }}** field, enter `username`.
        * In the **{{ ui-key.yacloud_org.organization.apps.AttributeFormDialogNew.field_attribute_value_dgUAv }}** field, select `SubjectClaims.preferred_username`.

        {% include [attribute-transformation](../../../_includes/tutorials/attribute-transformation.md) %}

        * Click **{{ ui-key.yacloud_org.organization.apps.AttributeTransformationsSection.action_add_transformation_bc8Cd }}** and select the `ExtractBefore` transformation type; in the **{{ ui-key.yacloud_org.organization.apps.AttributeTransformationsSection.field_substring_siBpY }}** field, enter `@`. This transformation will extract the part of the email address up to the `@` char. This value will be used as the username in Time.
        * Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

### Set up SAML authentication in Time {#setup-sp}

1. Log in to the Time system console at `https://<instance_name>.time‑messenger.ru/admin_console/authentication/saml`.
1. Under **Authentication**:
   1. Enable the **Enable SAML 2.0 login** option.
   1. In the **Identity provider metadata URL** field, enter the address to which Time sends its request for metadata.

      {% cut "How to find the address of an application's metadata file" %}

      1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
      1. In the left-hand panel, navigate to ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select `time‑saml‑app`.
      1. Under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, copy the **{{ ui-key.yacloud_org.application.overview.saml_field_metadata }}** field value.

      {% endcut %}

   1. In the **SAML SSO URL** field, enter the address to which Time sends the SAML request to start the login sequence.

      {% cut "How to find the address for authentication requests" %}

      1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
      1. In the left-hand panel, navigate to ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select `time‑saml‑app`.
      1. Under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, copy the **{{ ui-key.yacloud_org.application.overview.saml_field_login }}** field value.

      {% endcut %}

   1. In the **Identity provider issuer URL** field, enter the address used for SAML requests.

      {% cut "How to find the publisher address of an account provider" %}

      1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
      1. In the left-hand panel, navigate to ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select `time‑saml‑app`.
      1. Under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, copy the **{{ ui-key.yacloud_org.application.overview.saml_field_issuer }}** field value.

      {% endcut %}

   1. Under **Certification authority public certificate**, upload the `time‑saml‑app.cer` certificate file.
   1. Enable the **Signature verification** option.
   1. In the **Login address via service provider** field, enter an address in the following format: `https://<instance_name>.time‑messenger.ru/login/sso/saml`. Duplicate this address in the **Service provider ID** field.
   1. Enable the **Enable encryption** option.
   1. Under **Service provider private key**, upload the `private.key` file.
   1. Under **Service provider public certificate**, upload the `certificate.crt` file.
   1. In the **Signature algorithm** list, select the `RSAwithSHA512` algorithm to sign the request.
   1. In the **Canonicalization algorithm** list, select `Exclusive XML Canonicalization 1.0 (skip comments)`.
   1. In the **Email attribute** field, enter `emailaddress`.
   1. In the **Username attribute** field, enter `username`.
   1. Optionally, in the **Name attribute** field, specify `givenname`, the attribute to populate the username in Time.
   1. Optionally, in the **Last name attribute** field, specify `surname`, the attribute to populate the user last name in Time.
   1. Optionally, in the **Login button text** field, enter the text that will appear on the login button on the login page. The default is `Using SAML`.
1. Click **Save**.

## Add users {#add-users}

To authenticate with Time, add the required users and/or [user groups](../../../organization/concepts/groups.md) to your {{ org-full-name }} SAML application.

{% include [saml-manage-users](../../../_includes/organization/saml-manage-users.md) %}

To add users to a SAML application:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the required app.
    1. Navigate to the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}** tab.
    1. Click ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
    1. In the window that opens, select the required users.
    1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [auth-policy-applications-tip](../../../_includes/organization/auth-policy-applications-tip.md) %}

## Make sure your application works correctly {#validate}

To ensure your SAML application and integration with Time are working correctly, log in to Time using one of the added users. Proceed as follows:

1. In your browser, open the login page of your Time instance: `https://<instance_name>.time‑messenger.ru`.
1. Select **Using SAML** to sign in.
1. Authenticate in {{ yandex-cloud }} under a user account from your organization.
1. Make sure you have signed in to Time following a successful authentication.
