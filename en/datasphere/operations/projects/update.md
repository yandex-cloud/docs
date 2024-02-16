---
title: "How to change project settings in {{ ml-platform-full-name }}"
description: "Follow this guide to update your project settings."
---

# Changing project settings

{% include [serverless-deprecation-note](../../../_includes/datasphere/serverless-deprecation-note.md) %}

On the project editing page, you can change the project name and description, set consumption limits, and configure integration with other {{ yandex-cloud }} services:

1. {% include [include](../../../_includes/datasphere/ui-find-project.md) %}
1. To change the project name or description, click ![pencil](../../../_assets/console-icons/pencil-to-line.svg) next to its current name. In the window that opens, specify **{{ ui-key.yc-ui-datasphere.edit-project-page.name }}** and, if required, the project **{{ ui-key.yc-ui-datasphere.edit-project-page.description }}** and click **{{ ui-key.yc-ui-datasphere.common.save }}**.
1. To change other settings, go to the **{{ ui-key.yc-ui-datasphere.project-page.tab.settings }}** tab.
1. Click **![pencil](../../../_assets/console-icons/pencil-to-line.svg) {{ ui-key.yc-ui-datasphere.common.edit }}** in the relevant settings section.

   * Under **{{ ui-key.yc-ui-datasphere.common.general }}**, select the [project operating mode](../../concepts/project.md#mode) in the **{{ ui-key.yc-ui-datasphere.edit-project-page.default-mode }}** field:
      * `{{ ui-key.yc-ui-datasphere.common.serverless }}`: The project will start in the [{{ ds }} mode](../../concepts/project.md#serverless) and automatically allocate computing resources.
      * `{{ ui-key.yc-ui-datasphere.common.dedicated }}`: The project will start in the [{{ dd }} mode](../../concepts/project.md#dedicated). A VM will be assigned to the project when you first start your computations.
      * `{{ ui-key.yc-ui-datasphere.project-page.ask-when-opening }}`: You can select the startup mode whenever you open your project in {{ jlab }}Lab.

      Depending on the selected operating mode, set up the project parameters:

      * **{{ ui-key.yc-ui-datasphere.edit-project-page.period-of-inactivity }}**: Specify how soon the cells with a CPU or GPU load less than 1% will stop running in {{ ds }} mode (the default value is `{{ ui-key.yc-ui-datasphere.common.never }}`).
      * Enable the **{{ ui-key.yc-ui-datasphere.autosave-commit-mode.title }}** option to select [automatic state saving](../../concepts/save-state.md#auto-save) in the {{ ds }} mode.
      * **Stop idle VM in**: Specify the time within which the VM will be stopped and removed from the project if it is not running any computations in the {{ dd }} mode.
      * Click **{{ ui-key.yc-ui-datasphere.common.save }}**.

   * Under **{{ ui-key.yc-ui-datasphere.edit-project-page.advanced-settings }}**:

      * **{{ ui-key.yc-ui-datasphere.project-page.settings.default-folder }}**: Specify the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) to store [node](../../concepts/deploy/index.md#node) logs.
      * **{{ ui-key.yc-ui-datasphere.project-page.settings.service-account }}**: Specify the [service account](../../../iam/concepts/users/service-accounts.md) for {{ ml-platform-name }} to create {{ dataproc-name }} clusters and perform other actions in {{ yandex-cloud }} services under. The service account must have the required [roles](../../../iam/concepts/access-control/roles).
      * **{{ ui-key.yc-ui-datasphere.project-page.settings.subnet }}**: Specify a [subnet](../../../vpc/concepts/network.md#subnet) in the `{{ region-id }}-a` [availability zone](../../../overview/concepts/geo-scope.md) if you need one to connect to other {{ yandex-cloud }} services. Along with the subnet, make sure to specify a service account with the `{{ roles-vpc-user }}` role or higher.

      {% include [subnet-create](../../../_includes/subnet-create.md) %}

      * **{{ ui-key.yc-ui-datasphere.edit-project-page.security-group }}**: Specify a [security group](../../../vpc/concepts/security-groups.md) if you use them in your organization.
      * **{{ ui-key.yc-ui-datasphere.edit-project-page.dataproc-cluster }}**: Select the [cluster](../../../data-proc/operations/cluster-create.md) if needed.
      * Click **{{ ui-key.yc-ui-datasphere.common.save }}**.

   * Under **{{ ui-key.yc-ui-datasphere.project-page.settings.limits }}**, you can set up [constraints](restrictions.md) for your project.

#### See also {#see-also}

* [{#T}](restrictions.md)
* [{#T}](install-dependencies.md)
* [{#T}](control-compute-resources.md)
* [{#T}](../user-images.md)

