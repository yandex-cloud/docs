# Change project settings

On the project editing page, you can change the project name and description, set consumption limits, and configure integration with other {{ yandex-cloud }} services:

1. {% include [include](../../../_includes/datasphere/ui-find-project.md) %}
1. Go to the **Settings** tab and click **![pencil](../../../_assets/pencil.svg) Edit**.
1. Add or change the values in the relevant fields, if required:

   * **Name** and **Description** of the project.
   * **Period of inactivity**: How soon the cells with a CPU or GPU load less than 1% will stop running (the default value is `Never`).
   * Default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) to store [node](../../concepts/deploy/index.md#node) logs.
   * [Service account](../../../iam/concepts/users/service-accounts.md) on behalf of which S3 connectors or Data Proc clusters will be created. The service account must have the required [roles](../../../iam/concepts/access-control/roles).
   * [Subnet](../../../vpc/concepts/network#subnet) if you need it to connect to other {{ yandex-cloud }} services. Along with the subnet, make sure to specify a service account with the `{{ roles-vpc-user }}` role or higher.

      {% include [subnet-create](../../../_includes/subnet-create.md) %}

   * [Security groups](../../../vpc/concepts/security-groups.md) if you use them in your organization.

1. Click **Save**.

In the project settings, you can also select the [save state](../../concepts/save-state.md#auto-save) mode.

#### See also {#see-also}

* [{#T}](restrictions.md)
* [{#T}](install-dependencies.md)
* [{#T}](control-compute-resources.md)

