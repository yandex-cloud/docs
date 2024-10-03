---
title: Migrating a {{ mgl-full-name }} instance to a different availability zone
description: In this tutorial, you will learn how to migrate a {{ mgl-name }} instance to a different availability zone.
---

# Migrating a ru-central1-c instance to a different availability zone

{% note info %}

This feature is at the [Preview](../../../overview/concepts/launch-stages.md) stage and available upon request.

{% endnote %}

VMs with {{ mgl-name }} instances reside in {{ yandex-cloud }} [availability zones](../../../overview/concepts/geo-scope.md). If an instance is located in `ru-central1-c`, you can migrate it to a different zone. To do this:

1. If you do not have a subnet in the target availability zone, [create one](../../../vpc/operations/subnet-create.md).
1. If the [instance's security group](../configure-security-group.md) is set up for a subnet in the source availability zone, recongifure the group for the new subnet. To do so, replace the source subnet CIDR with the new subnet CIDR in the security group rules.
1. Change the instance's availability zone:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
      1. Click the instance name and select the **{{ ui-key.yacloud.gitlab.title_migration }}** tab.
      1. If unable to use the migration functionality, request access to it.

         When your request is approved, you will be notified by email. To continue, reload the page in your browser.

      1. Specify the target availability zone and subnet.
      1. Click **{{ ui-key.yacloud.gitlab.button_start-migration }}**.

         The instance will start to upgrade. Wait for the instance to change its status back to `Running`. This will take a few minutes for a small instance or at least 30 minutes if the instance is over 200 GB in size. After a few more minutes, the {{ GL }} instance will start.

      1. To test the instance's performance, select the ![image](../../../_assets/console-icons/flag.svg) **{{ ui-key.yacloud.common.overview }}** tab and click the link in the **{{ ui-key.yacloud.gitlab.field_domain }}** field.
      1. On the **{{ ui-key.yacloud.gitlab.title_migration }}** tab:

         * If the instance works properly, click **{{ ui-key.yacloud.gitlab.button_finish-migration }}**.
         * If the instance is inoperable, click **{{ ui-key.yacloud.gitlab.button_rollback-migration }}** to move it back to the initial availability zone, or contact [technical support]({{ link-console-support }}).

   {% endlist %}
