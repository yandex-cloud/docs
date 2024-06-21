---
title: "Deleting a security profile"
description: "Follow this guide to delete a security profile."
---

# Deleting a security profile

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to delete a [security profile](../concepts/profiles.md).
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
   1. Next to the profile to delete, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
   1. Confirm the deletion.

- API {#api}

   Use the [delete](../api-ref/SecurityProfile/delete.md) REST API method for the [SecurityProfile](../api-ref/SecurityProfile/) resource or the [SecurityProfileService/Delete](../api-ref/grpc/security_profile_service.md#Delete) gRPC API call.

{% endlist %}
