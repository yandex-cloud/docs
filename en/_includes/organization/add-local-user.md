{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, select ![userpool](../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** and select the [user pool](../../organization/concepts/user-pools.md).
  1. Go to the **{{ ui-key.yacloud_org.organization.userpools.title_userpool_members }}** tab and click ![person-plus](../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.userpools.action_create-user }}**.
  1. In the **{{ ui-key.yacloud_org.organization.userpools.field_username }}** field, enter the user login and select the [domain](../../organization/concepts/domains.md) from the list. The login must be unique for the current user pool.
  
      If the domain is not on the list, [create a new one](../../organization/operations/user-pools/add-domain.md).
  1. In the **{{ ui-key.yacloud_org.organization.userpools.field_full-name }}** field, specify the user first and last name in any format.  
  1. Optionally, add the user’s email.
  1. In the **{{ ui-key.yacloud_org.organization.userpools.field_password }}** field, you can view the automatically generated user password and generate a new one.
  
      The user must change this password on their first login to {{ yandex-cloud }}.
  1. Enable **{{ ui-key.yacloud_org.organization.userpools.field_active }}** if you need to activate the user immediately upon adding them. Activated users gain access to the organization resources.
  1. Optionally, expand the **{{ ui-key.yacloud_org.organization.userpools.title_personal-info }}** section and specify the user's first name, last name, and phone number.
  1. Click **{{ ui-key.yacloud_org.organization.userpools.action_create-user }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. See the description of the CLI command for adding a user to a [pool](../../organization/concepts/user-pools.md):

     ```bash
     yc organization-manager idp user create --help
     ```
  1. {% include [cli-list-userpools](./cli-list-userpools.md) %}
  1. To create a new user, run this command:

     ```bash
     yc organization-manager idp user create \
       --userpool-id <pool_ID> \
       --username <login_and_domain> \
       --full-name <name_and_last_name> \
       --given-name <name> \
       --family-name <last_name> \
       --email <email> \
       --phone-number <phone_number> \
       --password <password>
     ```

     Where:
     
     * `--userpool-id`: ID of the user pool you need to add the user to.
     * `--username`: User login and domain in `login@domain` format. The login must be unique for the current user pool.
     * `--full-name`: User first and last name in any format.
     * `--given-name`: Username. This is an optional parameter.
     * `--family-name`: User last name. This is an optional parameter.
     * `--email`: User email. This is an optional parameter.
     * `--phone-number`: User phone number. This is an optional parameter.
     * `--password`: Password. This is an optional parameter. If no password is set, it will be generated automatically. The user must change this password on their first login to {{ yandex-cloud }}.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}
 
  {% include [terraform-install](../terraform-install.md) %}
 
  1. Describe the user parameters in the configuration file:
 
     ```hcl
     resource "yandex_organizationmanager_idp_user" "example_user" {
       userpool_id  = <pool_ID>
       username     = "<login_and_domain>"
       full_name    = "<name_and_last_name>"
       given_name   = "<name>"
       family_name  = "<last_name>"
       email        = "<email>"
       phone_number = "<phone_number>"
       is_active    = true
       password_spec = {
         password = "<password>"
       }
     }
     ```
 
     Where:
 
     * `userpool_id`: ID of the [user pool](../../organization/concepts/user-pools.md) you need to add the new user to.
     * `username`: User login and domain in `login@domain` format. The login must be unique for the current user pool.
     * `full_name`: User first and last name in any format.
     * `given_name`: Username. This is an optional parameter.
     * `family_name`: User last name. This is an optional parameter.
     * `email`: User email. This is an optional parameter.
     * `phone_number`: User phone number. This is an optional parameter.
     * `password`: Password. This is an optional parameter. If no password is set, it will be generated automatically. The user must change this password on their first login to {{ yandex-cloud }}.
     * `is_active`: Activation flag. Set to `true` to activate the user.
 
     For more information about `yandex_organizationmanager_idp_user` properties, see the [relevant provider documentation]({{ tf-provider-resources-link }}/organizationmanager_idp_user).
 
  1. Create the resources:
 
     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
 
     {{ TF }} will create all the required resources. You can check the new resources and their settings either in [{{ org-full-name }}]({{ link-org-cloud-center }}) or using this [CLI](../../cli/) command:
 
     ```bash
     yc organization-manager idp user list --userpool-id <pool_ID>
     ```

- API {#api}

  Use the [User.Create](../../organization/idp/api-ref/User/create.md) REST API method for the [User](../../organization/idp/api-ref/User/index.md) resource or the [UserService/Create](../../organization/idp/api-ref/grpc/User/create.md) gRPC API call.

{% endlist %}