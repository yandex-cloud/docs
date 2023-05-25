# Change project settings

On the project editing page, you can change the project name and description, set consumption limits, and configure integration with other {{ yandex-cloud }} services:

1. {% include [include](../../../_includes/datasphere/ui-find-project.md) %}
1. To change the project name or description, click ![pencil](../../../_assets/pencil-line.svg) next to its current name. In the window that opens, specify **{{ ui-key.yc-ui-datasphere.edit-project-page.name }}** and, if required, the project **{{ ui-key.yc-ui-datasphere.edit-project-page.description }}** and click **{{ ui-key.yc-ui-datasphere.common.save }}**.
1. To change other settings, go to the **{{ ui-key.yc-ui-datasphere.project-page.tab.settings }}** tab.
1. Click **![pencil](../../../_assets/pencil-line.svg) {{ ui-key.yc-ui-datasphere.common.edit }}** in the relevant settings section.

   * Under **{{ ui-key.yc-ui-datasphere.common.general }}**:

      * **{{ ui-key.yc-ui-datasphere.edit-project-page.period-of-inactivity }}**: Specify how soon the cells with a CPU or GPU load less than 1% will stop running (the default value is `{{ ui-key.yc-ui-datasphere.common.never }}`).
      * Enable the **{{ ui-key.yc-ui-datasphere.autosave-commit-mode.title }}** option to select the [save state](../../concepts/save-state.md#auto-save) mode.
      * Click **{{ ui-key.yc-ui-datasphere.common.save }}**.

   * Under **{{ ui-key.yc-ui-datasphere.edit-project-page.advanced-settings }}**:

      * **{{ ui-key.yc-ui-datasphere.project-page.settings.default-folder }}**: Specify the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) to store [node](../../concepts/deploy/index.md#node) logs.
      * **{{ ui-key.yc-ui-datasphere.project-page.settings.service-account }}**: Specify the [service account](../../../iam/concepts/users/service-accounts.md) to create S3 connectors or {{ dataproc-name }} clusters under. The service account must have the required [roles](../../../iam/concepts/access-control/roles).
      * **{{ ui-key.yc-ui-datasphere.project-page.settings.subnet }}**: Specify a [subnet](../../../vpc/concepts/network.md#subnet) if you need one to connect to other {{ yandex-cloud }} services. Along with the subnet, be sure to specify a service account with the minimum role `{{ roles-vpc-user }}`.

      {% include [subnet-create](../../../_includes/subnet-create.md) %}

      * **{{ ui-key.yc-ui-datasphere.edit-project-page.security-group }}**: Specify a [security group](../../../vpc/concepts/security-groups.md) if you use them in your organization.
      * Click **{{ ui-key.yc-ui-datasphere.common.save }}**.


#### See also {#see-also}

* [{#T}](restrictions.md)
* [{#T}](install-dependencies.md)
* [{#T}](control-compute-resources.md)

