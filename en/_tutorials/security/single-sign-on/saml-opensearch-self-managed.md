# Creating a SAML app in {{ org-full-name }} for integration with {{ OS }}

[{{ OS }}](https://opensearch.org/) is a highly scalable open-source system of search and analysis tools. {{ OS }} comes with the [{{ OS }} Dashboards](https://docs.opensearch.org/latest/dashboards/) data visualization UI. 

To authenticate your [organization's](../../../organization/concepts/organization.md) users to {{ OS }} via [SAML](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language) SSO, create a [SAML app](../../../organization/concepts/applications.md#saml) in {{ org-name }} and configure it appropriately both in {{ org-name }} and in {{ OS }}.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

For the users of your organization to be able to access {{ OS }}:

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

To configure {{ OS }} integration with the SAML app you created in {{ org-name }}, complete the configuration both on the {{ OS }} cluster side and in {{ org-name }}.

1. Get the metadata for the [new app](#create-app):

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the new SAML app.
    1. On the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, copy the `Issuer / IdP EntityID` value you have to set on the {{ OS }} cluster side.
    1. On the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, click **{{ ui-key.yacloud_org.application.overview.idp_section_download_metadata_action }}**.

      The downloaded [XML](https://en.wikipedia.org/wiki/XML) file contains the required metadata and a certificate used for SAML response signature verification.

1. Set up SAML authentication for your {{ OS }} cluster.

    To do this, edit the`config.yml` and `roles_mapping.yml` configuration files for **{{ OS }} Security Plugin** in the default `/etc/opensearch/opensearch-security/` directory, and the `opensearch_dashboards.yml` file for **{{ OS }} Dashboards** in the default `/etc/opensearch-dashboards/` directory.

    1. Place the previously downloaded `idp-metadata.xml` file in the **{{ OS }} Security Plugin** directory, e.g., `/etc/opensearch/opensearch-security/saml/`. 
   
    1. Make sure the {{ OS }} user, usually `opensearch`, has read access to this file.
   
        ```bash
        sudo chown opensearch:opensearch /etc/opensearch/opensearch-security/saml/idp-metadata.xml
   
        sudo chmod 644 /etc/opensearch/opensearch-security/saml/idp-metadata.xml
        ```

    1. Generate an `exchange_key` to sign **JSON web tokens (JWTs)**. 

        {% note tip %}

        The **JWT** key must be a string generated with the HMAC256 algorithm. You can use online generators or command-line tools that produce cryptographically secure strings with support for this algorithm.

        {% endnote %}

    1. Add a new SAML authentication domain named `yandex_saml_auth_domain` to the `authc` section of the `config.yml` file and configure it as shown below.

        ```yaml
        authc:
         # ... (keep the current basic_internal_auth for the service user) ...

         # SAML authentication domain for {{ org-full-name }}
         yandex_saml_auth_domain:
           order: 1 # What we recommend: 1 or 2
           http_enabled: true
           transport_enabled: false
           http_authenticator:
             type: saml
             challenge: true
             config:
               # --- IdP settings ({{ org-full-name }}) ---
               idp:
                 # Path to the uploaded XML metadata file 
                 metadata_file: "/etc/opensearch/opensearch-security/saml/idp-metadata.xml"

               # --- SP settings ({{ OS }}) ---
               sp:
                 # This parameter must match the SP EntityID specified in {{ org-full-name }}
                 entity_id: "opensearch-saml-sso" 
        
               # Your Dashboards URL
               kibana_url: "https://<your-dashboards-url>/"
          
               # Key to sign JWTs
               exchange_key: "5efe29a39306bed6bd4f67af06d54d813ff8b05692ef480204c917602ffdd9a9"

               # --- Configuring access groups ---
               # Name of the SAML response attribute containing groups
               roles_key: "groups" 
         
        # ... 
        ```
        {% note tip %}

        In the latest **{{ OS }} Security Plugin** versions, you can use the `metadata_url` parameter to load the metadata file directly from {{ org-full-name }}. If your version supports it, you do not need to upload the metadata file to the server. To set it up, simply replace `metadata_file` with `metadata_url` in `config.yml`.
    
        ```yaml
        # ... 

        # --- IdP settings ({{ org-full-name }}) ---
        idp:
          # XML metadata file URL 
          metadata_url: "https://auth.yandex.cloud/saml/metadata/ek0vbjom..." 

        # ... 
        ```
      
        {% endnote %}

    1. To map {{ org-full-name }} user groups to internal {{ OS }} roles during SAML authentication, edit the `roles_mapping.yml` file for **{{ OS }} Security Plugin**. Add the required [groups](../../../organization/concepts/groups.md) from {{ org-name }} to the `backend_roles` section of the relevant {{ OS }} roles, as shown below.

        ```yaml
        # ...
 
        # The opensearch-users group from {{ org-full-name }} 
        # maps to the all_access role in {{ OS }}
        all_access:
          reserved: false
          backend_roles:
            - "admin"
            - "opensearch-users" # group created in {{ org-name }} 
          description: "Allow full access for opensearch-users group from {{ org-name }}"
  
        # ... 
        ```

        {% note tip %}

        You can alternatively map roles through the {{ OS }} Dashboards web UI.

        {% endnote %}
        
        {% cut "Mapping roles through the {{ OS }} Dashboards web UI" %}
        
        1. Log in to {{ OS }} Dashboards using the `admin` credentials.
        1. In the left-hand menu, navigate to **Management** → **Security**.
        1. In the left-hand panel, select **Roles**.
        1. Configure role mapping:
            1. Click the name of the role you need, e.g., `all_access`.
            1. Go to the **Mapped users** tab.
            1. Click **Manage mapping**.
            1. In the **Backend roles** field, specify the {{ org-name }} [user group](../../../organization/concepts/groups.md) to map with the {{ OS }} role, e.g., `opensearch-users`.
            1. Click **Map**.

        {% endcut %}

    1. After making changes to the `config.yml` and `roles_mapping.yml` files, apply the new configuration to your {{ OS }} cluster by running the `securityadmin.sh` script.
   
        ```bash
        # Make sure to provide the correct paths to the certificates and keys
        # and run securityadmin.sh with administrator privileges.

        sudo "/usr/share/opensearch/plugins/opensearch-security/tools/securityadmin.sh" \
            -cd "/etc/opensearch/opensearch-security" \
            -icl \
            -key "<path_to_your_key>" \
            -cert "<path_to_your_certificate>" \
            -cacert "<path_to_root_CA_certificate>" \
            -nhnv
        ```

    1. Edit the `opensearch_dashboards.yml` configuration file for {{ OS }}Dashboards as follows:

        ```yaml
        # ...

        # Enable multi-factor authentication
        opensearch_security.auth.multiple_auth_enabled: true

        # Provide the available authentication types
        # (keep basic authentication for the service user)
        opensearch_security.auth.type: [basicauth, saml]

        # ... 
        ```

    1. Restart the {{ OS }} services.
   
        ```bash
        sudo systemctl restart opensearch
        sudo systemctl restart opensearch-dashboards
        ```

### Set up the SAML application in {{ org-full-name }} {#setup-idp}

#### Set up service provider endpoints {#sp-endpoints}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, click ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select your SAML app.
  1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:  
      1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-sp-entity-id_snAsX }}** field, specify `opensearch-saml-sso`.
      1. In the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-acs-urls_eQcJr }}** field, enter this address: `https://<your-dashboards-url>/_opendistro/_security/saml/acs`.
      1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

#### Add a user groups attribute {#group-attribute}

To set up automatic user-to-role mapping upon {{ OS }} login, add the user group attribute. Proceed as follows:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. In the top-right corner, click ![circles-3-plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.action_add_group_attribute }}** and in the window that opens.
    1. In the **{{ ui-key.yacloud_org.attributes.update_dialog.field_attribute_name }}** field, leave `groups`.
    1. In the **{{ ui-key.yacloud_org.attributes.update_dialog.field_group_attribute_value }}** field, select `{{ ui-key.yacloud_org.field-data.attributes.update_dialog.field_group_assigned }}`.
    1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

For more information about configuring attributes, see [Configure user and group attributes](../../../organization/operations/applications/saml-create.md#setup-attributes).

### Add users {#add-users}

For your organization's users to be able to authenticate in {{ OS }} Dashboards with the {{ org-name }} SAML app, you need to explicitly add these users and groups to that app.

{% note info %}

Users and groups added to a SAML application can be managed by a user with the `organization-manager.samlApplications.userAdmin` [role](../../../organization/security/index.md#organization-manager-samlApplications-userAdmin) or higher.

{% endnote %}

1. Once you set up role mapping in {{ OS }}, [create](../../../organization/operations/create-group.md) the relevant [groups](../../../organization/concepts/groups.md):

    {% list tabs group=instructions %}

    - {{ cloud-center }} UI {#cloud-center}

        1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
        1. In the left-hand panel, select ![groups](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}**.
        1. In the top-right corner of the page, click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.entity.group.action_create }}**.
        1. Enter the group name, e.g., `opensearch-users`. Make sure it matches the group name mapped to the role in {{ OS }}.
        1. Click **{{ ui-key.yacloud_org.groups.action_create-group }}**.
        1. Add users to the group:
            1. Navigate to the **{{ ui-key.yacloud_org.entity.group.title_tab-members }}** tab.  
            1. Click **{{ ui-key.yacloud_org.entity.group.action_add-member }}**.
            1. In the window that opens, select the users.
            1. Click **{{ ui-key.yacloud_org.component.subject-select-dialog.action_apply }}**.

    {% endlist %}

1. Add users to the application:

    {% list tabs group=instructions %}

    - {{ cloud-center }} UI {#cloud-center}

        1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
        1. In the left-hand panel, click ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select your app.
        1. Navigate to the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}** tab.
        1. Click ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
        1. In the window that opens, select the user or user group.
        1. Click **{{ ui-key.yacloud.common.add }}**.

    {% endlist %}

## Make sure your application works correctly {#validate}

To make sure both your SAML app and its integration with {{ OS }} work correctly, authenticate to {{ OS }} Dashboards as one of the users you added to the app. Proceed as follows:

1. In your browser, navigate to the address of your {{ OS }} Dashboards instance.
1. If logged in to {{ OS }} Dashboards, log out.
1. On the {{ OS }} Dashboards authentication page, click **Log in with single sign-on**.
1. On the {{ yandex-cloud }} authentication page, enter your email address and user password. The user must be a member of a group added to the app.
1. Make sure you are logged in to {{ OS }} Dashboards.
1. If you have configured role mapping:
     1. Click the user icon in {{ OS }} Dashboards.
     1. Go to **View roles and identities**.
     1. Make sure the **Roles** section displays the `all_access` role and the **Backend roles** section displays the `opensearch-users` role.