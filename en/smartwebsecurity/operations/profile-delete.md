---
title: How to delete a {{ sws-full-name }} security profile
description: Follow this guide to delete a {{ sws-full-name }} security profile.
---

# Deleting a security profile

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the [security profile](../concepts/profiles.md).
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
   1. In the profile row, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
   1. Confirm the deletion.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View the description of the [CLI](../../cli/quickstart.md) command for deleting a [security profile](../concepts/profiles.md):

      ```bash
      yc smartwebsecurity security-profile delete --help
      ```

   1. To view a list of current security profiles in the default folder, run this command:

      {% include [security-profile-list-command](../../_includes/smartwebsecurity/security-profile-list-command.md) %}

   1. To delete a security profile, run this command, specifying the profile name or ID:

      ```bash
      yc smartwebsecurity security-profile delete <security_profile_name_or_ID>
      ```

   1. To make sure the security profile is deleted, re-run this command:

      ```bash
      yc smartwebsecurity security-profile list
      ```

      {% note info %}

      Deleting a security profile may affect access to the virtual hosts it is connected to.

      {% endnote %}

   For more information about the `yc smartwebsecurity security-profile delete` command, see the [CLI reference](../../cli/cli-ref/managed-services/smartwebsecurity/security-profile/delete.md).

- API {#api}

   Use the [delete](../api-ref/SecurityProfile/delete.md) REST API method for the [SecurityProfile](../api-ref/SecurityProfile/) resource or the [SecurityProfileService/Delete](../api-ref/grpc/security_profile_service.md#Delete) gRPC API call.

{% endlist %}
