{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. [Log in]({{ link-passport-login }}) as an organization user with the `organization-manager.viewer` [role](../../organization/security/index.md#organization-manager-viewer) or higher for the organization.
  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![person-gear](../../_assets/console-icons/person-gear.svg) **CIEM**.
  1. Click ![person-plus](../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.page.acl-diagnostics.action_select-subject }}** and in the window that opens:
  
      1. Select the [user](../../overview/roles-and-resources.md#users), [service account](../../iam/concepts/users/accounts.md#sa), [user group](../../organization/concepts/groups.md), [system group](../../iam/concepts/access-control/system-group.md), or [public group](../../iam/concepts/access-control/public-group.md) you need.

          Use search, if required.
      1. Click **{{ ui-key.yacloud.common.select }}**.
  
  This will open a list of accesses assigned to the selected subject. For each access, the list indicates the resource name/ID and type, [role](../../iam/concepts/access-control/roles.md) assigned to the subject for that resource, and information about whether the role was assigned to the subject directly or inherited from a group to which the subject belongs.
  
  If the selected subject has multiple accesses, only some of them will be displayed. To display the remaining access permissions, click **Load more** at the bottom of the page.
  
  Use filtering by resource ID, role ID, or access assignment method (`{{ ui-key.yacloud_org.iam-bindings.subject.value_role-source-filter_direct }}` or `{{ ui-key.yacloud_org.iam-bindings.subject.value_role-source-filter_group }}`) as needed.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. See the description of the CLI command to get a list of subject’s accesses:

     ```bash
     yc iam access-analyzer list-subject-access-bindings --help
     ```

  1. Get the ID of a [user](../../organization/operations/users-get.md), [service account](../../iam/operations/sa/get-id.md), or [user group](../../organization/operations/group-get-id.md) to view their list of accesses.

  1. Use the `yc iam access-analyzer list-subject-access-bindings` command to get a list of subject’s accesses:

     ```bash
     yc iam access-analyzer list-subject-access-bindings \
        --organization-id=<organization_ID> \
        --subject-id=<subject_ID>
     ```

     Where:

     * `--organization-id`: [Organization ID](../../organization/operations/organization-get-id.md).
     * `--subject-id`: ID of a [subject](../../iam/concepts/access-control/index.md#subject), i.e., a [user](../../overview/roles-and-resources.md#users), [service account](../../iam/concepts/users/accounts.md#sa), [user group](../../organization/concepts/groups.md), [system group](../../iam/concepts/access-control/system-group.md), or [public group](../../iam/concepts/access-control/public-group.md).

     Result:

     ```text
     +---------+-------------------------+----------------------+----------+
     | ROLE ID |      RESOURCE TYPE      |     RESOURCE ID      | GROUP ID |
     +---------+-------------------------+----------------------+----------+
     | admin   | resource-manager.cloud  | b1g2c5615qja******** |          |
     | admin   | resource-manager.folder | b1gq979gqitb******** |          |
     +---------+-------------------------+----------------------+----------+
     ```
  
     You will get the list of accesses as a table. For each access, the list indicates a role assigned to the subject for a resource as well as the resource type and ID. If the subject has not been assigned any role directly, but has inherited it from a group, the list will indicate the group ID.

{% endlist %}