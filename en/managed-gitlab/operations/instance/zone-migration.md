---
title: Migrating a {{ mgl-full-name }} instance to a different availability zone
description: In this article, you will learn how to migrate a {{ mgl-name }} instance to a different availability zone.
---

# Migrating an instance to a different availability zone

{% note info %}

This feature is in the [Preview](../../../overview/concepts/launch-stages.md) stage and can be enabled upon request.

{% endnote %}

VMs with {{ mgl-name }} instances reside in {{ yandex-cloud }} [availability zones](../../../overview/concepts/geo-scope.md). To change the availability zone:

1. If you do not yet have a subnet in the target availability zone, [create one](../../../vpc/operations/subnet-create.md).
1. If the [instance security group](../configure-security-group.md) is configured for a subnet in the source availability zone, reconfigure the group for the new subnet. To do so, replace the source subnet CIDR with the new subnet CIDR in the security group rules.
1. Change the instance availability zone:

    {% list tabs group=instructions %}

    - Management console {#console}

        1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
        1. Click the instance name and select the **{{ ui-key.yacloud.gitlab.title_migration }}** tab.
        1. If you do not have access to the migration feature, request it.

            Once your request is approved, you will receive an email notification. To continue, refresh the page in your browser.

        1. Specify the target availability zone and subnet.
        1. Click **{{ ui-key.yacloud.gitlab.button_start-migration }}**.

            The instance will start upgrading. Wait for the instance to change its status back to `Running`. This will take a few minutes for a small instance or at least 30 minutes for instances with a disk size of 200 GB or larger. After a few more minutes, the {{ GL }} instance will start. 

        1. To test the instance performance, select the ![image](../../../_assets/console-icons/flag.svg) **{{ ui-key.yacloud.common.overview }}** tab and click the link in the **{{ ui-key.yacloud.gitlab.field_domain }}** field.
        1. In the **{{ ui-key.yacloud.gitlab.title_migration }}** tab:

            * If the instance works properly, click **{{ ui-key.yacloud.gitlab.button_finish-migration }}**.
            * If the instance is unavailable, click **{{ ui-key.yacloud.gitlab.button_rollback-migration }}** to move it back to the initial availability zone or contact [support]({{ link-console-support }}).

    {% endlist %}
