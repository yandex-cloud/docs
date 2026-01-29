To work with {{ dataproc-name }} clusters:

1. [In the project settings](../../datasphere/operations/projects/update.md), specify these parameters:

   * [Default folder](../../resource-manager/concepts/resources-hierarchy.md#folder) for integrating with other {{ yandex-cloud }} services. It will house a {{ dataproc-name }} cluster based on the current cloud [quotas](../../data-proc/concepts/limits.md). A fee for using the cluster will be debited from your cloud billing account.
   * [Service account](../../iam/concepts/users/service-accounts.md) with the `vpc.user` [role](../../iam/concepts/access-control/roles.md). {{ ml-platform-name }} will use for this account to work with the {{ dataproc-name }} cluster network.
   * [Subnet](../../vpc/concepts/network.md#subnet) for {{ ml-platform-name }} to communicate with the {{ dataproc-name }} cluster. The subnet must be in the same [availability zone](../../overview/concepts/geo-scope.md) as the community you created. Since the {{ dataproc-name }} cluster needs to access the internet, make sure to [configure a NAT gateway](../../vpc/operations/create-nat-gateway.md) in this subnet. After you specify a subnet, the time for computing resource allocation may increase.

1. Create a [service agent](../../iam/concepts/service-control.md#service-agent):

   1. To allow a service agent to operate in {{ ml-platform-name }}, ask your cloud admin or owner to run the following command in the {{ yandex-cloud }} CLI:
   
      ```bash
      yc iam service-control enable datasphere --cloud-id <cloud_ID>
      ```
   
      Where `--cloud-id` is the [ID of the cloud](../../resource-manager/operations/cloud/get-id.md) you are going to use in the {{ ml-platform-name }} community.

   1. Create a service account with the following roles:

      * `dataproc.agent` to use {{ dataproc-name }} clusters.
      * `dataproc.admin` to create clusters from {{ dataproc-name }} templates.
      * `vpc.user` to use the {{ dataproc-name }} cluster network.
      * `iam.serviceAccounts.user` to create resources in the folder on behalf of the service account.

   1. Under **{{ ui-key.yc-ui-datasphere.spaces-page.data-processing-sa.title }}** in the community settings, click **{{ ui-key.yc-ui-datasphere.spaces-page.ssa.add-service-account.button }}** and select the service account you created.
   
{% note warning %}

The {{ dataproc-name }} persistent cluster must have the `livy:livy.spark.deploy-mode : client` setting.

{% endnote %}
