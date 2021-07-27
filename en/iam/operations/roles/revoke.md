---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Revoke a role for a resource

If you want to prohibit a [subject](../../concepts/access-control/index.md#subject) from accessing a resource, revoke the subject's roles for that resource or the resources that the access rights are inherited from. For more information, see [{#T}](../../concepts/access-control/index.md).

{% note info %}

If you need to temporarily revoke all access rights from a user with a Yandex account, you can revoke just the `{{ roles-cloud-member }}` role. Although the user keeps all the other roles, they can't perform any operations with the cloud resources. When you add the user to the cloud again, the access rights will already be configured.

{% endnote %}

## Revoke a role {#revoke-one-role}

{% list tabs %}

- Management console

  In the management console, you can only revoke a cloud or folder role:
  1. {% include [grant-role-console-first-steps](../../../_includes/iam/grant-role-console-first-steps.md) %}
  1. {% include [configure-roles-console](../../../_includes/iam/configure-roles-console.md) %}
  1. Click the x next to the role to remove it. In the **Roles in the cloud <cloud name>** section, you can delete the roles assigned to the user in this cloud. In the **Roles in folders** section, you can delete folder roles assigned to the user.

- CLI

  To revoke a role from a subject, delete the corresponding access binding for the appropriate resource:
  1. View roles and their assignees:

        {% include [include](../../../_includes/iam/list-access-bindings-via-cli.md) %}

  1. To delete an access binding, run:

      ```
      yc <SERVICE-NAME> <RESOURCE> remove-access-binding <RESOURCE-NAME>|<RESOURCE-ID> \
          --role <ROLE-ID> \
          --subject <SUBJECT-TYPE>:<SUBJECT-ID>
      ```

      where:
      * `<ROLE-ID>` is the ID of the role to revoke (such as `{{ roles-cloud-owner }}`).
      * `<SUBJECT-TYPE>` is the type of [subject](../../concepts/access-control/index.md#subject) to revoke the role from.
      * `<SUBJECT-ID>` is the subject ID.

      For example, to revoke a role from a user with the ID `aje6o61dvog2h6g9a33s`:

      ```
      $ yc resource-manager folder remove-access-binding default \
          --role viewer \
          --subject userAccount:aje6o61dvog2h6g9a33s
      ```

- API

  To revoke a resource role from a subject, delete the corresponding access binding:

  1. {% include [include](../../../_includes/iam/list-access-bindings-via-api.md) %}

  1. Create a request body, for example, in a `body.json` file. In the request body, specify which access binding to delete. For example, revoke the `editor` role from user `ajei8n54hmfhuk5nog0g`:

      **body.json:**

      ```json
      {
          "accessBindingDeltas": [{
              "action": "REMOVE",
              "accessBinding": {
                  "roleId": "editor",
                  "subject": {
                      "id": "ajei8n54hmfhuk5nog0g",
                      "type": "userAccount"
                      }
                  }
              }
          ]
      }
      ```

  1. Revoke the role by deleting the specified access binding:

      {% include [grant-role-folder-via-curl](../../../_includes/iam/grant-role-folder-via-curl.md) %}

{% endlist %}

