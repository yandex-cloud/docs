# Deleting origin groups

## Deleting one origin group {#deletion-group-single}

To delete an [origin group](../../concepts/origins.md):

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create a resource group.
   1. Select **Cloud CDN**.
   1. On the left-hand panel, select ![image](../../../_assets/cdn/origin-groups.svg) **Origin groups** and select the group you wish to delete.
   1. Click **Delete** on the bottom panel.
   1. Confirm the deletion.

- CLI

   {% include [include](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI origin group delete command below:

      ```
      yc cdn origin-group delete --help
      ```

   1. Get a list of all origin groups in the default folder:

      ```
      yc cdn origin-group list --format yaml
      ```

      Result:

      ```
      - id: "90209"
        folder_id: b1g86q4m5vej8lkljme5
        name: test-group-1
        use_next: true
        origins:
        - id: "561547"
          origin_group_id: "90209"
          source: www.example2.com
          enabled: true
          backup: true
        - id: "561546"
          origin_group_id: "90209"
          source: www.example1.com
          enabled: true
      - id: "90208"
        folder_id: b1g86q4m5vej8lkljme5
        name: test-group
        use_next: true
        origins:
        - id: "561545"
          origin_group_id: "90208"
          source: www.a2.com
          enabled: true
          backup: true
        - id: "561544"
          origin_group_id: "90208"
          source: www.a1.com
          enabled: true
      ```

   1. Delete a group of origins in the default folder:

      ```
      yc cdn origin-group delete --id <origin group ID>
      ```

      For more information about the `yc cdn origin-group delete` command, see the [CLI reference](../../../cli/cli-ref/managed-services/cdn/origin-group/delete.md).

- {{ TF }}

   For more information about {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   If you created an origin group using {{ TF }}, you can delete it:

   1. In the command line, go to the directory with the {{ TF }} configuration file.

   1. Delete the description of the desired group from the configuration file.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

   1. Delete the origin group.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

{% endlist %}

## Deleting multiple origin groups {#summ-deletion-groups}

To delete multiple origin groups:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to delete several resource groups.
   1. Select **Cloud CDN**.
   1. On the left-hand panel, select ![image](../../../_assets/cdn/origin-groups.svg) **Origin group** and select the groups you wish to delete.

      To delete all the groups, select the relevant option in the table header next to the **Name** field.
   1. Click **Delete** on the bottom panel.
   1. Confirm the deletion.

{% endlist %}
