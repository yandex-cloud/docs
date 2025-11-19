# Creating a SAML app in {{ org-full-name }} for integration with Zabbix

{% include [note-preview](../../../_includes/note-preview.md) %}

[Zabbix](https://www.zabbix.com/) is an open-source, enterprise-level monitoring system for tracking the performance and health of servers, networks, apps, and other IT resources. Zabbix supports SAML authentication to provide secure SSO for your organization's users.

To authenticate your [organization's](../../../organization/concepts/organization.md) users to Zabbix via [SAML](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language) SSO, create a [SAML app](../../../organization/concepts/applications.md#saml) in {{ org-name }} and configure it appropriately both in {{ org-name }} and Zabbix.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

For the users of your organization to be able to access Zabbix:

1. [Create an app](#create-app).
1. [Set up the integration](#setup-integration).
1. [Make sure the application works correctly](#validate).

## Create an app {#create-app}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. In the top-right corner, click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** and in the window that opens:
        1. Select the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.saml-title_kyofk }}** single sign-on method.
        1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for your new app: `zabbix-app`.

        1. Optionally, in the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** field, enter a description for the new app.
        1. Optionally, add [labels](../../../resource-manager/concepts/labels.md):

            1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Enter a label in `key: value` format.
            1. Press **Enter**.
        1. Click **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

## Set up the integration {#setup-integration}

To integrate Zabbix with the SAML app you created in {{ org-name }}, complete the setup both on the Zabbix side and in {{ org-name }}.

### Set up the SAML application in Zabbix {#setup-sp}

{% note info %}

To set up the SAML application in Zabbix, the user needs  the **Super admin role**. 

{% endnote %}

#### Configure SAML authentication in Zabbix {#setup-za}

1. To configure SAML authentication in Zabbix, in the left-hand panel, navigate to **Users** and then to **Authentication**.
1. In the main window, go to the **SAML Settings** tab. After the form opens, complete the steps below:

    1. Activate the **Enable SAML authentication** option.
    1. Activate the **Enable JIT provisioning** option.

        {% note info %}

        **Enable JIT provisioning** controls automatic creation of users in Zabbix when authenticating with SSO. If this option is disabled, only users who already have a Zabbix account will be able to authenticate. 

        {% endnote %}

    1. Configure a link between Zabbix and {{ org-name }}:

        1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
        1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
        1. Under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, in the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, copy the following field values: **{{ ui-key.yacloud_org.application.overview.saml_field_issuer }}**, **{{ ui-key.yacloud_org.application.overview.saml_field_login }}**, and **{{ ui-key.yacloud_org.application.overview.saml_field_logout }}**.
        1. Return to Zabbix and paste the copied addresses into these fields: **IdP entity ID**, **SSO service URL**, and **SLO service URL**. 

            {% note info %}

            If you do not specify the address in **SLO service URL**, on logout of Zabbix, the user will be redirected to the Zabbix authentication form, not the {{ org-name }} authentication form.

            {% endnote %}

    1. In the **Username attribute** field, specify `login`.

        {% note info %}

        This attribute is used as username when authenticating in Zabbix. You can specify any attribute name you want, but it must match the name of the user attribute which has the `SubjectClaims.preferred_username` value in your {{ org-name }} app.

        {% endnote %}

    1. In the **SP entity ID** field, specify `zabbix`.
    
        {% note warning %}

        The **SP entity ID** value must be exactly the same in both Zabbix and your {{ org-name }} application. 
        
        {% endnote %}

    1. In the **Sign** and **Encrypt** sections, leave all options disabled.
    
        {% note tip %}

        {{ org-full-name }} does not currently support request signature verification, so we recommend you leave the **Sign** and **Encrypt** section options disabled.

        {% endnote %}

    1. Enable the **Case-sensitive login** option if you want the login to be case-sensitive.

    1. If the **Enable JIT provisioning** option is on, configure the automatic user creation settings in Zabbix. To do this, enable the **Configure JIT provisioning** option and follow these steps:

        1. In the **Group name attribute** field, specify `groups`: this attribute defines a user group in your {{ org-name }} app, which provides access to Zabbix.

        1. In the **User name attribute** field, enter `givenname`.

        1. In the **User last name attribute** field, enter `surname`.
         
        1. Under **User group mapping**, map your {{ org-name }} app's user group to the appropriate group and role in Zabbix. This will enable new users to automatically get their assigned group and role in Zabbix. To do this, click **Add** and follow these steps:

            1. In the **SAML group pattern** field, specify a pattern to search for SAML app group names.

                {% note info %}

                The **SAML group pattern** field supports wildcard characters with `*`. 
                
                {% endnote %}

            1. In the **User groups** field, specify the Zabbix groups to which new users will be automatically added on their first authentication. 
            
            1. In the **User role** field, specify the Zabbix role to assign to users when they first log in. 

        1. Optionally, under **Media type mapping**, configure mapping of your SAML app’s user attributes to receive notifications from Zabbix.

        1. Leave the **Enable SCIM provisioning** option disabled.

            {% note tip %}

            Currently, {{ org-full-name }} does not support the SCIM protocol for automatic user management in other apps, so we recommend leaving the **Enable SCIM provisioning** option disabled.

            {% endnote %}

1. In the main window, go to the **Authentication** tab. After the form opens, in the **Deprovisioned users group** field, select the `Disabled` group.

    {% note warning %}

    If the **Enable JIT provisioning** option is on, you must specify the **Deprovisioned users group** on the **Authentication** tab. This group is where deactivated users will be moved.

    {% endnote %}

1. Save the settings by clicking **Update**.

#### Migrate the SAML app certificate and configure Zabbix {#setup-zc}

To migrate the SAML app certificate and configure Zabbix, follow these steps:

1. Download the identity provider (IdP) certificate:

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
    1. On the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.certificate_section_title }}**, click **{{ ui-key.yacloud_org.application.overview.certificate_action_download_cert }}** and save the file to your device.

1. Copy the resulting certificate file to the `/usr/share/zabbix/ui/conf/certs` folder on the Zabbix server. 
1. Configure access permissions.
    ```bash
    chmod 644 /usr/share/zabbix/ui/conf/certs/<your_cert>.crt
    ```
1. Open the `/usr/share/zabbix/ui/conf/zabbix.conf.php` Zabbix configuration file and specify the path to the IdP certificate.
    ```php
    $SSO['IDP_CERT'] = 'conf/certs/<your_cert>.crt';
    ```

### Set up the SAML application in {{ org-full-name }} {#setup-idp}

#### Set up service provider endpoints {#sp-endpoints}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
  1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:  
      1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** field, specify `zabbix`.
      1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** field, enter this address: `https://<your-domain>/zabbix/index_sso.php?acs`.
      1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

#### Configure user attributes {#user-attributes}

{% note warning %}

For integration with Zabbix, users must have the `login` attribute.

{% endnote %}

If users do not have the `login` attribute, add it:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the desired app.
    1. Navigate to the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.attributes_to71e }}** tab.
    1. In the top-right corner, click ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_attribute }}** and in the window that opens:

        1. In the **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_name }}** field, enter `login`.
        1. In the **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_value }}** field, select `SubjectClaims.preferred_username`.
        1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

If you have configured automatic user creation in Zabbix, add the user group attribute. Proceed as follows:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. In the top-right corner, click ![circles-3-plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_group_attribute }}** and in the window that opens.
    1. In the **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_name }}** field, specify `groups`.
    1. In the **{{ ui-key.yacloud_org.attributes.update_dialog.field_group_attribute_value }}** field, select `{{ ui-key.yacloud_org.field-data.attributes.update_dialog.field_group_assigned }}`.
    1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

For more information about configuring attributes, see [Configure user and group attributes](../../../organization/operations/applications/saml-create.md#setup-attributes).

### Add users {#add-users}

For your organization's users to be able to authenticate in Zabbix with {{ org-name }}'s SAML app, you need to explicitly add these users and/or [user groups](../../../organization/concepts/groups.md) to the SAML app:

{% note info %}

Users and groups added to a SAML application can be managed by a user with the `organization-manager.samlApplications.userAdmin` [role](../../../organization/security/index.md#organization-manager-samlApplications-userAdmin) or higher.

{% endnote %}

1. If you have configured automatic user creation in Zabbix, [create](../../../organization/operations/create-group.md) the relevant [group](../../../organization/concepts/groups.md):

    {% list tabs group=instructions %}

    - {{ cloud-center }} UI {#cloud-center}

        1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
        1. In the left-hand panel, select ![groups](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}**.
        1. In the top-right corner of the page, click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.entity.group.action_create }}**.
        1. Enter the name: `zabbix-users`.
        1. Click **{{ ui-key.yacloud_org.groups.action_create-group }}**.
        1. Add users to the group:
            1. Navigate to the **{{ ui-key.yacloud_org.entity.group.title_tab-members }}** tab.  
            1. Click **{{ ui-key.yacloud_org.entity.group.action_add-member }}**.
            1. In the window that opens, select the required users.
            1. Click **{{ ui-key.yacloud_org.component.subject-select-dialog.action_apply }}**.

    {% endlist %}
 
1. Add users to the application:

    {% list tabs group=instructions %}

    - {{ cloud-center }} UI {#cloud-center}

        1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
        1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the required app.
        1. Navigate to the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}** tab.
        1. Click ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
        1. In the window that opens, select the required user or user group.
        1. Click **{{ ui-key.yacloud.common.add }}**.

    {% endlist %}

## Make sure your application works correctly {#validate}

To make sure both your SAML app and Zabbix integration work correctly, authenticate to Zabbix as one of the users you added to the app. Proceed as follows:

1. In your browser, navigate to the address of your Zabbix instance, e.g., `https://<your-domain>/zabbix/`.
1. If you were logged in to Zabbix, log out.
1. On the Zabbix authentication page, click **Sign in with Single Sign-On (SAML)**.
1. On the {{ yandex-cloud }} authentication page, enter your email address and user password. The user or group they belong to must be added to the application.
1. Make sure you are logged in to Zabbix.
