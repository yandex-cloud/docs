# Setting up cloud access permissions

{% note warning %}

{% include [access-control-vs-roles-notice](../../../_includes/iam/access-control-vs-roles-notice.md) %}

{% endnote %}

To grant a user access to [cloud](../../concepts/resources-hierarchy.md#cloud) resources, assign the user a [role](../../../iam/concepts/access-control/roles.md) for the cloud.

## Assigning a role for a cloud {#access-to-user}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [set-access-binding-user-cloud-console](../../../_includes/resource-manager/set-access-binding-user-cloud-console.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View a description of the command to assign a role for a cloud:

      ```bash
      yc resource-manager cloud add-access-binding --help
      ```

  1. Get a list of available clouds:

      ```bash
      yc resource-manager cloud list
      ```

      Result:

      ```text
      +----------------------+----------+
      |          ID          |   NAME   |
      +----------------------+----------+
      | b1gg8sgd16g7******** | my-cloud |
      +----------------------+----------+
      ```

  1. Get a list of available roles:

      ```bash
      yc iam role list
      ```

      Result:

      ```text
      +--------------------------------+-------------+
      |               ID               | DESCRIPTION |
      +--------------------------------+-------------+
      | admin                          |             |
      | compute.images.user            |             |
      | editor                         |             |
      | ...                            |             |
      +--------------------------------+-------------+
      ```

  1. Find out the user ID from the login or email address.

      ```bash
      yc iam user-account get test-user
      ```

      Result:

      ```text
      id: gfei8n54hmfh********
      yandex_passport_user_account:
          login: test-user
          default_email: test-user@yandex.ru
      ```

  1. Assign the user a role for the cloud. In the subject, specify the `userAccount` type and user ID:

      ```bash
      yc resource-manager cloud add-access-binding my-cloud \
        --role editor \
        --subject userAccount:<user_ID>
      ```

      Where:

      * `--role`: ID of the role you need to assign, e.g., `{{ roles-cloud-owner }}`.
      * `--subject`: [Subject](../../../iam/concepts/access-control/index.md#subject) getting the role.

          {% cut "Subject designations" %}

          {% include [subjects-designations-cli](../../../_includes/iam/subjects-designations-cli.md) %}

          {% endcut %}

  To assign a role to a [service account](../../../iam/concepts/users/service-accounts.md), [user group](../../../organization/concepts/groups.md), or [system group](../../../iam/concepts/access-control/system-group.md) instead of a user, see [these examples](../../../iam/operations/roles/grant.md#cloud-or-folder).

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Describe the roles you are assigning in the configuration file:

      Here is an example of the configuration file structure:

      ```hcl
      data "yandex_resourcemanager_cloud" "project1" {
        name = "Project 1"
      }

      resource "yandex_resourcemanager_cloud_iam_member" "editor" {
        cloud_id = "${data.yandex_resourcemanager_cloud.project1.id}"
        role     = "<role>"
        member   = "userAccount:<user_ID>"
      }
      ```

      Where:

      * `cloud_id`: Cloud ID. You can get a list of available clouds using the [CLI](../../../cli/quickstart.md) command: `yc resource-manager cloud list`. This is a required setting.
      * `role`: Role you need to assign. You can get a list of roles using the [CLI](../../../cli/quickstart.md) command: `yc iam role list`. In one `yandex_resourcemanager_cloud_iam_member` resource, only one role can be assigned. This is a required setting.
      * `member`: [Subject](../../../iam/concepts/access-control/index.md#subject) getting the role. This is a required setting.

          {% cut "Subject designations" %}

          {% include [subjects-designations-terraform](../../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

      For more on the properties of the `yandex_resourcemanager_cloud_iam_member` in {{ TF }}, see [this provider guide]({{ tf-provider-resources-link }}/resourcemanager_cloud_iam_member).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      This will assign access permissions for the cloud.

- API {#api}

  Use the [updateAccessBindings](../../api-ref/Cloud/updateAccessBindings.md) REST API method for the [Cloud](../../api-ref/Cloud/index.md) resource or the [CloudService/UpdateAccessBindings](../../api-ref/grpc/Cloud/updateAccessBindings.md) gRPC API call.

  You will need the cloud ID and the ID of the user who is assigned the role for the cloud.

  1. Find out the cloud ID using the [list](../../api-ref/Cloud/list.md) REST API method:

      ```bash
      curl \
        --header "Authorization: Bearer <IAM_token>" \
        https://resource-manager.{{ api-host }}/resource-manager/v1/clouds
      ```

      Result:

      ```text
      {
       "clouds": [
        {
         "id": "b1gg8sgd16g7********",
         "createdAt": "2018-09-23T12:14:45Z",
         "name": "cloud-b1gg8sgd16g7qc"
        }
       ]
      }
      ```

  1. Find out the user ID by login using the [getByLogin](../../../iam/api-ref/YandexPassportUserAccount/getByLogin.md) REST API method:

      ```bash
      curl \
        --header "Authorization: Bearer <IAM_token>" \
        https://iam.{{ api-host }}/iam/v1/yandexPassportUserAccounts:byLogin?login=test-user
      ```

      Result:

      ```text
      {
       "id": "gfei8n54hmfh********",
       "yandexPassportUserAccount": {
        "login": "test-user",
        "defaultEmail": "test-user@yandex.ru"
       }
      }
      ```

  1. Assign the user a role for the cloud. In the `action` property, enter `ADD` and specify the `userAccount` type and user ID under `subject`.

      ```bash
      curl \
        --request POST \
        --header 'Content-Type: application/json' \
        --header "Authorization: Bearer <IAM_token>" \
        --data '{
          "accessBindingDeltas": [
            {
              "action": "ADD",
              "accessBinding": {
                "roleId": "<role>",
                "subject": {
                  "id": "<user_ID>",
                  "type": "userAccount"
                }
              }
            }
          ]
        }' \
        https://resource-manager.{{ api-host }}/resource-manager/v1/clouds/<cloud_ID>:updateAccessBindings
      ```

      Where:

      * `roleId`: Role.
      * `subject`: [Subject](../../../iam/concepts/access-control/index.md#subject) getting the role.

          {% cut "Subject designations" %}

          {% include [subjects-designations-api](../../../_includes/iam/subjects-designations-api.md) %}

          {% endcut %}

{% endlist %}


## Assigning multiple roles {#multiple-roles}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [set-access-binding-multiple-users-cloud-console](../../../_includes/resource-manager/set-access-binding-multiple-users-cloud-console.md) %}

- CLI {#cli}

  The `add-access-binding` command allows you to add only one role. You can assign multiple roles using the `set-access-bindings` command.

  {% include [set-access-bindings-cli](../../../_includes/iam/set-access-bindings-cli.md) %}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Make sure the resource has no important roles assigned before proceeding:

      ```bash
      yc resource-manager cloud list-access-bindings <cloud_name_or_ID>
      ```

  1. To assign a role, run this command:

      ```bash
      yc resource-manager cloud set-access-bindings <cloud_name_or_ID> \
        --access-binding role=<role>,subject=<subject_type>:<subject_ID>
      ```

      Where:

      * `role`: ID of the role you need to assign.
      * `subject`: [Subject](../../../iam/concepts/access-control/index.md#subject) getting the role.

          {% cut "Subject designations" %}

          {% include [subjects-designations-terraform](../../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

      Provide a separate `--access-binding` parameter for each role. Here is an example:

      ```bash
      yc resource-manager cloud set-access-bindings my-cloud \
        --access-binding role=editor,subject=userAccount:gfei8n54hmfh******** \
        --access-binding role=viewer,subject=userAccount:helj89sfj80a********
      ```

  To assign a role to a [service account](../../../iam/concepts/users/service-accounts.md), [user group](../../../organization/concepts/groups.md), or [system group](../../../iam/concepts/access-control/system-group.md) instead of a user, see [these examples](../../../iam/operations/roles/grant.md#multiple-roles).

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Describe the cloud access permission parameters in the configuration file.

      Here is an example of the configuration file structure:

      ```hcl
      data "yandex_resourcemanager_cloud" "project1" {
        name = "Project 1"
      }

      resource "yandex_resourcemanager_cloud_iam_member" "member1" {
        cloud_id = "${data.yandex_resourcemanager_cloud.project1.id}"
        role     = "<role_1>"
        member   = "userAccount:<user_ID>"
      }

      resource "yandex_resourcemanager_cloud_iam_member" "member2" {
        cloud_id = "${data.yandex_resourcemanager_cloud.project1.id}"
        role     = "<role_2>"
        member   = "userAccount:<user_ID>"
      }
      ```

      Where:

      * `cloud_id`: Cloud ID. You can get a list of available clouds using the [CLI](../../../cli/quickstart.md) command: `yc resource-manager cloud list`. This is a required setting.
      * `role`: Role you need to assign. You can get a list of roles using the [CLI](../../../cli/quickstart.md) command: `yc iam role list`. In one `yandex_resourcemanager_cloud_iam_member` resource, only one role can be assigned. This is a required setting.
      * `member`: [Subject](../../../iam/concepts/access-control/index.md#subject) getting the role. This is a required setting.

          {% cut "Subject designations" %}

          {% include [subjects-designations-terraform](../../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      This will assign access permissions for the cloud.

- API {#api}

  Assign roles to the users:


  ```bash
  curl \
    --request POST \
    --header 'Content-Type: application/json' \
    --header "Authorization: Bearer <IAM_token>" \
    --data '{
      "accessBindingDeltas": [
        {
          "action": "ADD",
          "accessBinding": {
            "roleId": "<role_1>",
            "subject": {
              "id": "<user_ID>",
              "type": "userAccount"
            }
          }
        },
        {
          "action": "ADD",
          "accessBinding": {
            "roleId": "<role_2>",
            "subject": {
              "id": "<user_ID>",
              "type": "userAccount"
            }
          }
        }
      ]
    }' \
    https://resource-manager.{{ api-host }}/resource-manager/v1/clouds/<cloud_ID>:updateAccessBindings
  ```

  Where:

  * `roleId`: Role.
  * `subject`: [Subject](../../../iam/concepts/access-control/index.md#subject) getting the role.

      {% cut "Subject designations" %}

      {% include [subjects-designations-api](../../../_includes/iam/subjects-designations-api.md) %}

      {% endcut %}

  You can also assign roles using the [setAccessBindings](../../api-ref/Cloud/setAccessBindings.md) REST API method for the [Cloud](../../api-ref/Cloud/index.md) resource or the [CloudService/SetAccessBindings](../../api-ref/grpc/Cloud/setAccessBindings.md) gRPC API call.

  {% include [set-access-bindings-api](../../../_includes/iam/set-access-bindings-api.md) %}

{% endlist %}


## Cloud access for service accounts {#access-to-sa}

A service account can be [assigned](../../../iam/operations/sa/assign-role-for-sa.md#binding-role-resource) roles for any cloud and folder within the organization it belongs to.

Allow the `test-sa` service account to manage `my-cloud` and its resources:

{% list tabs group=instructions %}

- Management console {#console}

  You assign roles to a service account the same way as to a user account.

  To assign a service account a role for a cloud:

  {% include [set-accessbinding-sa-cloud-console](../../../_includes/iam/set-accessbinding-sa-cloud-console.md) %}

- CLI {#cli}

  1. Find out the ID of the service account you want to assign the role to. To do this, get a list of available service accounts:

      ```bash
      yc iam service-account list
      ```

      Result:

      ```text
      +----------------------+----------+------------------+
      |          ID          |   NAME   |   DESCRIPTION    |
      +----------------------+----------+------------------+
      | ajebqtreob2d******** | test-sa  | test-description |
      +----------------------+----------+------------------+
      ```

  1. Assign the role to the service account using its ID:

      ```bash
      yc resource-manager cloud add-access-binding my-cloud \
        --role <role> \
        --service-account-id <service_account_ID>
      ```

      Where:

      * `--role`: ID of the role you need to assign, e.g., `{{ roles-cloud-owner }}`.
      * `--service-account-id`: Service account ID. You can also use the `--service-account-name` parameter and specify the service account name instead of the ID.

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. In the configuration file, describe the resources you want to create:

      Here is an example of the configuration file structure:

      ```hcl
      resource "yandex_resourcemanager_cloud_iam_member" "editor" {
        cloud_id = "<cloud_ID>"
        role     = "<role>"
        member   = "serviceAccount:<service_account_ID>"
      }
      ```

      Where:

      * `cloud_id`: Cloud ID. This is a required setting.
      * `role`: Role. You can find the description of the roles in the {{ iam-full-name }} documentation in the [{{ yandex-cloud }} role reference](../../../iam/roles-reference.md). This is a required setting.
      * `member`: [Subject](../../../iam/concepts/access-control/index.md#subject) getting the role. For a service account, specify `serviceAccount:<service_account_ID>`. This is a required setting.

          {% cut "Subject designations" %}

          {% include [subjects-designations-terraform](../../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      This will assign access permissions for the cloud.

- API {#api}

  1. Find out the ID of the service account you want to assign the role to. To do this, get a list of available service accounts:

      ```bash
      curl \
        --header "Authorization: Bearer <IAM_token>" \
        https://iam.{{ api-host }}/iam/v1/serviceAccounts?folderId=<folder_ID>
      ```

      Result:

      ```text
      {
       "serviceAccounts": [
        {
         "id": "ajebqtreob2d********",
         "folderId": "b1gvmob95yys********",
         "createdAt": "2018-10-18T13:42:40Z",
         "name": "test-sa",
         "description": "test-description"
        }
       ]
      }
      ```

  1. Assign the role for the cloud to the service account. In the `subject` property, specify the `serviceAccount` type and the service account ID. In the request URL, specify the cloud ID as the resource:

      ```bash
      curl \
        --request POST \
        --header 'Content-Type: application/json' \
        --header "Authorization: Bearer <IAM_token>" \
        --data '{
          "accessBindingDeltas": [
            {
              "action": "ADD",
              "accessBinding": {
                "roleId": "<role>",
                "subject": {
                  "id": "<service_account_ID>",
                  "type": "serviceAccount"
                }
              }
            }
          ]
        }' \
        https://resource-manager.{{ api-host }}/resource-manager/v1/clouds/<cloud_ID>:updateAccessBindings
      ```

      Where:

      * `roleId`: Role.
      * `subject`: [Subject](../../../iam/concepts/access-control/index.md#subject) getting the role.

          {% cut "Subject designations" %}

          {% include [subjects-designations-api](../../../_includes/iam/subjects-designations-api.md) %}

          {% endcut %}

{% endlist %}


## What's next {#what-is-next}

* [{#T}](../folder/create.md)
* [{#T}](../folder/set-access-bindings.md)
* [{#T}](../../concepts/resources-hierarchy.md)
