---
title: "Deleting an ARL profile"
description: "Follow this guide to delete an ARL profile."
---

# Deleting an ARL profile

Before deleting an ARL profile, you need to delete it from the associated security profiles.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the [ARL profile](../concepts/arl.md).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Go to the ![image](../../_assets/smartwebsecurity/arl.svg) **ARL profiles** tab.
  1. Select the profile you want to delete.
  1. In the **Connected security profiles** section, select the security profile.
  1. At the top right, click **Edit**.
  1. Select a different ARL profile from the **ARL profile** list or click **Clear**.
  1. Click **{{ ui-key.yacloud.common.save }}**.
  1. Similarly, delete the ARL profile from all associated security profiles.
  1. Go back to the ARL profile page.
  1. Click ![options](../../_assets/console-icons/ellipsis.svg) at the top right and select **{{ ui-key.yacloud.common.delete }}**.
  1. Confirm the deletion.

{% endlist %}
