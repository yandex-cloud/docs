---
title: How to change project settings in {{ ml-platform-full-name }}
description: Follow this guide to update your project settings.
---

# Changing project settings

On the project editing page, you can change the project name and description, set consumption limits, and configure integration with other {{ yandex-cloud }} services:

1. {% include [include](../../../_includes/datasphere/ui-find-project.md) %}
1. To change the project name or description, click ![pencil](../../../_assets/console-icons/pencil-to-line.svg) next to its current name. In the window that opens:
   * **{{ ui-key.yc-ui-datasphere.edit-project-page.name }}**: Specify the project name.
   * You can click **{{ ui-key.yc-ui-datasphere.edit-project-page.add-description }}** and add a description, if required.
   * Click **{{ ui-key.yc-ui-datasphere.common.save }}**.
1. To change other settings, go to the **{{ ui-key.yc-ui-datasphere.project-page.tab.settings }}** tab.
1. Click **![pencil](../../../_assets/console-icons/pencil-to-line.svg) {{ ui-key.yc-ui-datasphere.common.edit }}** in the relevant settings section.

   * Under **{{ ui-key.yc-ui-datasphere.common.general }}**:

      * **{{ ui-key.yc-ui-datasphere.edit-project-page.dedicated-vm-inactivity-timeout }}**: Specify the time within which the VM will be stopped and deleted from the project if not running any computations.
      * **{{ ui-key.yc-ui-datasphere.external-ide.external-ide-vm-configuration }}**: Select the VM configuration that will be created when connecting to the local IDE.

   * Under **{{ ui-key.yc-ui-datasphere.edit-project-page.advanced-settings }}**:

      * **{{ ui-key.yc-ui-datasphere.project-page.settings.default-folder }}**: Specify the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) to store [node](../../concepts/deploy/index.md#node) logs.
      * **{{ ui-key.yc-ui-datasphere.project-page.settings.service-account }}**: Specify the [service account](../../../iam/concepts/users/service-accounts.md) for {{ ml-platform-name }} to create {{ dataproc-name }} clusters and perform other actions in {{ yandex-cloud }} services under. The service account must have the required [roles](../../../iam/concepts/access-control/roles).
      * **{{ ui-key.yc-ui-datasphere.project-page.settings.subnet }}**: Specify a [subnet](../../../vpc/concepts/network.md#subnet) in the `{{ region-id }}-a` [availability zone](../../../overview/concepts/geo-scope.md) if you need one to connect to other {{ yandex-cloud }} services. Along with the subnet, you must specify a service account with the `{{ roles-vpc-user }}` role. To retain access to the internet and pip repositories in the project, the specified subnet must have a set up [NAT gateway](../../../vpc/concepts/gateways.md), and the service account must have the `vpc.gateways.user` role.

      {% include [subnet-create](../../../_includes/subnet-create.md) %}

      * **{{ ui-key.yc-ui-datasphere.edit-project-page.security-group }}**: Specify a [security group](../../../vpc/concepts/security-groups.md), if used in your organization.
      * **{{ ui-key.yc-ui-datasphere.edit-project-page.dataproc-cluster }}**: Select the [{{ dataproc-name }} cluster](../../../data-proc/operations/cluster-create.md), if required.

   * Under **{{ ui-key.yc-ui-datasphere.project-page.settings.limits }}**, you can set up [restrictions](restrictions.md) for your project.

   * Click **{{ ui-key.yc-ui-datasphere.common.save }}**.

#### See also {#see-also}

* [{#T}](restrictions.md)
* [{#T}](install-dependencies.md)
* [{#T}](control-compute-resources.md)
* [{#T}](../user-images.md)

