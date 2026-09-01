# Creating a SAML app in {{ org-full-name }} for integration with Loop

[Loop](https://loop.ru/) is a corporate messenger with single sign-on support based on the SAML standard.

For the users of your [organization](../../../organization/concepts/organization.md) to be able to authenticate to Loop via SAML SSO, create a [SAML app](../../../organization/concepts/applications/saml.md) in {{ org-full-name }} and configure it both in {{ org-full-name }} and Loop.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

To give access to Loop to the users of your organization:

1. [Generate a key and certificate](#generate-key-cert).
1. [Create an app](#create-app).
1. [Set up the integration](#setup-integration).
1. [Add users](#add-users).
1. [Make sure the application works correctly](#validate).

## Generate a key and certificate {#generate-key-cert}

To encrypt and sign SAML responses, Loop requires a service provider (SP) certificate and private key. To generate it, use `openssl`:

```bash
openssl req -x509 -newkey rsa:2048 \
  -keyout private.key \
  -out certificate.crt \
  -days 365 -nodes \
  -subj "/CN=<instance_name>.loop.ru"
```

Where `<instance_name>` is your Loop instance name (subdomain on `loop.ru`).

This command will create two files, `private.key` and `certificate.crt`. Save them, as you will need them to configure SAML in Loop.

## Create an app {#create-app}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. Click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** and in the window that opens:
        1. Select the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.saml-title_kyofk }}** single sign-on method.
        1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for your new app: `loop-saml-app`.
        1. Optionally, add a description and [labels](../../../resource-manager/concepts/labels.md) for the app.
        1. Click **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.
    1. On the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.certificate_section_title }}**, click **{{ ui-key.yacloud_org.application.overview.certificate_action_download_cert }}** and save the new app’s certificate, `loop-saml-app.cer`; you will need it to configure SAML in Loop.

{% endlist %}

## Set up the integration {#setup-integration}

To configure Loop integration with the SAML app you created in {{ org-full-name }}, complete the configuration on both the {{ org-full-name }} side and in Loop.

### Configure endpoints and upload the service provider certificate {#sp-endpoints}

Specify the details of your Loop instance. To find out endpoint values, go to the Loop system console at `https://<instance_name>.loop.ru/admin_console/authentication/saml` and copy the `Entity ID` and `ACS URL` values from the SAML settings.

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, click ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select `loop-saml-app`.
    1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:
        1. Under **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.section-service-provider_83p1J }}**:
            1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** field, enter `Entity ID`, the unique service provider ID.
            1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** field, enter `ACS URL`, the address to which the service provider will send requests for user authentication.
            1. Optionally, add more `ACS URL` addresses by pressing **{{ ui-key.yacloud_org.organization.apps.SamlAppAcsUrlsField.add-acs-url_eMunC }}**.
            1. Optionally, in the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-logout-url_sLuRl }}** field, add the address to which the IdP will send the SAML response after the user successfully logs out.
            1. In the **{{ ui-key.yacloud_org.application.overview.saml_field_security_mode }}** field, select which parts of the SAML response will be signed:

                * `Assertions`: Sign only user data payloads (ID, attributes, and authentication timestamp).
                * `Response`: Sign the entire SAML response.
                * `Assertions and Response`: Sign both the user payloads and the entire response.
        1. Optionally, to only accept requests signed by one of the added certificates, enable **{{ ui-key.yacloud_org.application.overview.saml_field_request_signing_enabled }}** and add the certificate by clicking **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.RequestSigningSection.add-cert-action }}**.
        1. To ensure SAML response encryption using the selected certificate, enable **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.EncryptResponseSection.field-encrypt-response }}** and add the previously created certificate by clicking **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.RequestSigningSection.add-cert-action }}**.
        1. From the **{{ ui-key.yacloud_org.application.overview.saml_field_encrypt_response_data_algo }}** list, select **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.encrypt-key-algo-sha256 }}**.
        1. From the **{{ ui-key.yacloud_org.application.overview.saml_field_encrypt_response_key_algo }}** list, select **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.encrypt-key-algo-sha1 }}**.
        1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### Configure user attributes {#user-attributes}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, click ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select `loop-saml-app`.
    1. Navigate to the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.attributes_to71e }}** tab.
    1. Add an attribute for providing the username. At the top right, click **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_attribute }}** and in the window that opens:
        * In the **{{ ui-key.yacloud_org.organization.apps.GroupAttributeFormDialog.field_attribute_name_rPYTn }}** field, enter `username`.
        * In the **{{ ui-key.yacloud_org.organization.apps.AttributeFormDialogNew.field_attribute_value_dgUAv }}** field, select `SubjectClaims.preferred_username`.

        {% include [attribute-transformation](../../../_includes/tutorials/attribute-transformation.md) %}

        * Click **{{ ui-key.yacloud_org.organization.apps.AttributeTransformationsSection.action_add_transformation_bc8Cd }}**, and select the `ExtractBefore` transformation type. In the **{{ ui-key.yacloud_org.organization.apps.AttributeTransformationsSection.field_substring_siBpY }}** field, enter `@`. This will extract the part of email address up to the `@` symbol to serve as the username in the Loop.
        * Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

### Set up SAML authentication in Loop {#setup-sp}

1. Log in to the Loop system console at `https://<instance_name>.loop.ru/admin_console/authentication/saml`.
1. Under **Authentication**:
   1. Activate the **Enable SAML 2.0 login** option.
   1. In the **IdP metadata URL** field, enter the address to which Loop sends its metadata request.

      {% cut "How to find out the address of the app metadata file" %}

      1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
      1. In the left-hand panel, navigate to ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select `loop-saml-app`.
      1. Under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, copy the **{{ ui-key.yacloud_org.application.overview.saml_field_metadata }}** field value.

      {% endcut %}

   1. In the **SAML SSO URL** field, enter the address to which Loop sends the SAML request to initiate the login flow.

      {% cut "How to find out the authentication request address" %}

      1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
      1. In the left-hand panel, navigate to ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select `loop-saml-app`.
      1. Under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, copy the **{{ ui-key.yacloud_org.application.overview.saml_field_login }}** field value.

      {% endcut %}

   1. In the **IdP issuer URL** field, enter the address used for SAML requests.

      {% cut "How to find out the IdP issuer URL" %}

      1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
      1. In the left-hand panel, navigate to ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select `loop-saml-app`.
      1. Under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, copy the **{{ ui-key.yacloud_org.application.overview.saml_field_issuer }}** field value.

      {% endcut %}

   1. Under **CA public certificate**, upload the `loop-saml-app.cer` certificate file.
   1. Enable **Signature verification**.
   1. In the **Service provider sign-in URL** field, enter `https://<instance_name>.loop.ru/login/sso/saml`. Also specify this address in the **Service provider ID** field.
   1. Activate the **Enable encryption** option.
   1. Under **Service provider private key**, upload the `private.key` file.
   1. Under **Service provider public certificate**, upload the `certificate.crt` file.
   1. In the **Signature algorithm** list, select the `RSAwithSHA512` request signature algorithm.
   1. In the **Canonicalization algorithm** list, select `Exclusive XML Canonicalization 1.0 (skip comments)`.
   1. In the **Email attribute** field, specify `emailaddress`.
   1. In the **Username attribute** field, specify `username`.
   1. Optionally, in the **Name attribute** field, specify the `givenname` attribute to populate the user’s first name in Loop.
   1. Optionally, in the **Last name attribute** field, specify the `surname` attribute to populate the user’s last name in Loop.
   1. Optionally, in the **Login button text** field, enter the sign-in button text to display on the login page. The default text is `Sign in with SAML`.
1. Click **Save**.

## Add users {#add-users}

To enable user authentication in Loop, add the required users and/or [user groups](../../../organization/concepts/groups.md) to your {{ org-full-name }} SAML application.

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

To make sure both your SAML app and integration with Loop work correctly, log in to Loop as one of the users you added to the app. Proceed as follows:

1. In your browser, open the login page of your Loop instance: `https://<instance_name>.loop.ru`.
1. Select **Sing in with SAML**.
1. Authenticate in {{ yandex-cloud }} under a user account from your organization.
1. Make sure you have signed in to Loop following a successful authentication.
