# Creating a SAML app in {{ org-full-name }} for integration with {{ mos-name }}

[{{ OS }}](https://opensearch.org/) is a highly scalable open-source system of search and analysis tools. {{ OS }} comes with the [{{ OS }} Dashboards](https://docs.opensearch.org/latest/dashboards/) data visualization UI. [{{ mos-full-name }}](../../../managed-opensearch/) is an OpenSearch cluster management service for the Yandex Cloud infrastructure. {{ mos-name }} supports SAML authentication for secure single sign-on for users across your organization.

To authenticate your [organization's](../../../organization/concepts/organization.md) users to {{ mos-name }} via [SAML](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language) SSO, create a [SAML app](../../../organization/concepts/applications.md#saml) in {{ org-name }} and configure it appropriately both in {{ org-name }} and {{ OS }}.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

## Getting started {#before-you-begin}

Make sure you can [access {{ OS }} Dashboards](../../../managed-opensearch/operations/connect.md#dashboards) using the `admin` user credentials. For information on how to create and configure an {{ OS }} cluster, see [Creating an {{ OS }} cluster](../../../managed-opensearch/operations/cluster-create.md).

In this tutorial, we will use the following URL to access the {{ OS }} Dashboards web interface:

```url
https://c-{{ cluster-id }}.rw.{{ dns-zone }}/
```

For the users of your organization to be able to access {{ mos-name }}:

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
        1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for your new app: `opensearch-app`.
        1. Optionally, in the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** field, enter a description for the new app.
        1. Optionally, add [labels](../../../resource-manager/concepts/labels.md):
            1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Enter a label in `key: value` format.
            1. Press **Enter**.
        1. Click **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

## Set up the integration {#setup-integration}

To configure {{ mos-name }} integration with the SAML app you created in {{ org-name }}, complete the configuration both on the {{ OS }} cluster side and in {{ org-name }}.

1. Get the metadata for the [new app](#create-app):

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the new SAML app.
    1. On the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, copy the `Issuer / IdP EntityID` value you have to set on the {{ OS }} cluster side.
    1. On the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, click **{{ ui-key.yacloud_org.application.overview.idp_section_download_metadata_action }}**.

      The downloaded [XML](https://en.wikipedia.org/wiki/XML) file contains the required metadata and a certificate used for SAML response signature verification.

1. Set up SSO for the {{ OS }} cluster.

    {% note tip %}

    Below are the steps for the management console; however you may [use other available {{ yandex-cloud }}](../../../managed-opensearch/operations/saml-authentication.md#configuration-sso) interfaces.

    {% endnote %}

    To set up a {{ org-name }} authentication source:

    1. In the [management console]({{ link-console-main }}), go to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Click the cluster name and select the **{{ ui-key.yacloud.opensearch.auth.section_auth }}** tab.
    1. Click **{{ ui-key.yacloud.opensearch.auth.button_settings }}**.
    1. Specify the required values for these settings:

        * **{{ ui-key.yacloud.opensearch.auth.field_idp-entity-id }}**: Provider ID. Enter the previously saved `Issuer / IdP EntityID` value.

        * **idp_metadata_file**: Select and upload the previously downloaded metadata file.

        * **{{ ui-key.yacloud.opensearch.auth.field_sp-entity-id }}**: Service provider ID.
        
            This ID must match the URL used to connect to {{ OS }} Dashboards:

            ```url
            https://c-{{ cluster-id }}.rw.{{ dns-zone }}/
            ```

        * **{{ ui-key.yacloud.opensearch.auth.field_dashboards-url }}**: URL to connect to {{ OS }} Dashboards.

        * **{{ ui-key.yacloud.opensearch.auth.field_roles-key }}**: Attribute that stores a list of roles. Set it to `groups`.

        * **{{ ui-key.yacloud.opensearch.auth.field_subject-key }}**: Leave the field empty.

        * **{{ ui-key.yacloud.opensearch.auth.field_jwt-default-expiration-timeout }}**: Leave the `0` value.

        * **{{ ui-key.yacloud.opensearch.auth.field_enabled }}**: Make sure to enable this option.

    1. Click **{{ ui-key.yacloud.opensearch.auth.button_save }}**. Wait for the cluster status to change to `Running`. It may take a few minutes to apply settings.

1. Configure role mapping in {{ OS }}.

    To ensure that {{ org-name }} user groups are mapped to {{ OS }} roles during authentication:

    1. Connect to {{ OS }} Dashboards as the `admin` user.
    1. In the left-hand menu, select **{{ OS }} Plugins** → **Security**.
    1. In the left-hand panel, select **Roles**.
    1. Configure role mapping:
        1. Click the role name. In this guide, it is `kibana_user`.
        1. Go to the **Mapped users** tab.
        1. Click **Manage mapping**.
        1. Under **Backend roles**, enter the name of the {{ org-name }} [user group](../../../organization/concepts/groups.md) a role will be mapped to in {{ OS }}, e.g., `opensearch-users`.
        1. Click **Map**.
    
    Now your organization's users added to the `opensearch-users` group will be getting the `kibana_user` role upon successful authentication in {{ OS }} Dashboards.

### Set up the SAML application in {{ org-full-name }} {#setup-idp}

#### Set up service provider endpoints {#sp-endpoints}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
  1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:  
      1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** field, enter the URL for connection to {{ OS }} Dashboards.
      1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** field, specify the ACS URL.

        The ACS URL must be in the following format:

        ```url
        https://c-{{ cluster-id }}.rw.{{ dns-zone }}/_opendistro/_security/saml/acs
        ```
      1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

#### Add a user groups attribute {#group-attribute}

{{ OS }} users have to get one of the basic roles upon login. For this to work, the {{ org-name }} authentication source must provide in its SAML response a list of user groups that will have roles mapped in {{ OS }}. Proceed as follows:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. In the top-right corner, click ![circles-3-plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_group_attribute }}** and in the window that opens.
    1. In the **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_name }}** field, leave `groups`.
    1. In the **{{ ui-key.yacloud_org.attributes.update_dialog.field_group_attribute_value }}** field, select `{{ ui-key.yacloud_org.field-data.attributes.update_dialog.field_group_assigned }}`.
    1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

For more information about configuring attributes, see [Configure user and group attributes](../../../organization/operations/applications/saml-create.md#setup-attributes).

### Add users {#add-users}

For your organization's users to be able to authenticate in {{ OS }} Dashboards with the {{ org-name }} SAML app, you need to explicitly add these users and user groups to the SAML app.

{% note info %}

Users and groups added to a SAML application can be managed by a user with the `organization-manager.samlApplications.userAdmin` [role](../../../organization/security/index.md#organization-manager-samlApplications-userAdmin) or higher.

{% endnote %}

1. If you have configured role mapping in {{ mos-name }}, [create](../../../organization/operations/create-group.md) the groups as needed:

    {% list tabs group=instructions %}

    - {{ cloud-center }} UI {#cloud-center}

        1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
        1. In the left-hand panel, select ![groups](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}**.
        1. In the top-right corner of the page, click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.entity.group.action_create }}**.
        1. Enter a name, e.g., `opensearch-users`. The group name must exactly match the user group name specified when mapping to the {{ OS }} role.
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

To make sure both your SAML app and {{ mos-name }} integration work correctly, authenticate to {{ OS }} Dashboards as one of the users you added to the app. Proceed as follows:

1. In your browser, navigate to the address of your {{ OS }} Dashboards instance.
1. If logged in to {{ OS }} Dashboards, log out.
1. On the {{ OS }} Dashboards authentication page, click **Log in with single sign-on**.
1. On the {{ yandex-cloud }} authentication page, enter your email address and user password. The user must be a member of a group added to the app.
1. Make sure you are logged in to {{ OS }} Dashboards.
1. If you have configured role mapping:
     1. Click the user icon in {{ OS }} Dashboards.
     1. Go to **View roles and identities**.
     1. Make sure the **Roles** section displays the `kibana_user` role and the **Backend roles** section displays the `opensearch-users` role.