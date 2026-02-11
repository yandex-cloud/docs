{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the required app.
  1. Navigate to the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}** tab.
  1. To add a user or user group to a SAML app:

      1. Click ![person-plus](../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
      1. In the window that opens, select the required user or user group.
      1. Click **{{ ui-key.yacloud.common.add }}**.
  1. To delete a user or user group from a SAML app:

      1. In the list of users and groups, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}** next to the user or user group.
      1. Confirm the deletion.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Get the [user ID](../../organization/operations/users-get.md) or [user group ID](../../organization/operations/group-get-id.md).

  1. To add a user or user group to the app:
   
     1. See the description of the CLI command for adding users to an app:
   
        ```bash
        yc organization-manager idp application saml application add-assignments --help
        ```
   
     1. Run this command:
   
        ```bash
        yc organization-manager idp application saml application add-assignments \
          --id <app_ID> \
          --subject-id <user_or_group_ID>
        ```
   
        Where:
   
        * `--id`: App ID.
        * `--subject-id`: User or user group ID.
   
        Result:
   
        ```text
        assignment_deltas:
          - action: ADD
            assignment:
              subject_id: ajetvnq2mil8********
        ```

  1. To delete a user or user group from the app:

     1. See the description of the CLI command for removing users from an app:
   
        ```bash
        yc organization-manager idp application saml application remove-assignments --help
        ```
   
     1. Run this command:
   
        ```bash
        yc organization-manager idp application saml application remove-assignments \
          --id <app_ID> \
          --subject-id <user_or_group_ID>
        ```
   
        Where:
   
        * `--id`: SAML application ID.
        * `--subject-id`: User or user group ID.
   
        Result:
   
        ```text
        assignment_deltas:
          - action: REMOVE
            assignment:
              subject_id: ajetvnq2mil8********
        ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Describe the parameters of the SAML application with users and groups in the configuration file:

     ```hcl
     resource "yandex_organizationmanager_idp_application_saml_application_assignment" "example_assignment" {
       application_id = "<SAML_app_ID>"
       subject_id     = "<user_or_group_ID>"
     }
     ```

     Where:

     * `application_id`: SAML application ID.
     * `subject-id`: ID of the user or user group that will have access to the SAML application. To get the user ID, follow [this guide](../../organization/operations/users-get.md). To get the user group ID, follow [this guide](../../organization/operations/group-get-id.md).

     For more information about `yandex_organizationmanager_idp_application_saml_application_assignment` properties, see [this provider guide]({{ tf-provider-resources-link }}/organizationmanager_idp_application_saml_application_assignment).

  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     You can check the changes to the resources and their settings in [{{ org-full-name }}]({{ link-org-cloud-center }}).

- API {#api}

  Use the [Application.UpdateAssignments](../../organization/idp/application/saml/api-ref/Application/updateAssignments.md) REST API method for the [Application](../../organization/idp/application/saml/api-ref/Application/index.md) resource or the [ApplicationService/UpdateAssignments](../../organization/idp/application/saml/api-ref/grpc/Application/updateAssignments.md) gRPC API call.

{% endlist %}