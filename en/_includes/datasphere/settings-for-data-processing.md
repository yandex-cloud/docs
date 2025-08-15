To use {{ dataproc-name }} clusters, [specify the following parameters in your project settings](../../datasphere/operations/projects/update.md):
* [Default folder](../../resource-manager/concepts/resources-hierarchy.md#folder) for integrating with other {{ yandex-cloud }} services. It will house a {{ dataproc-name }} cluster based on the current cloud [quotas](../../data-proc/concepts/limits.md). A fee for using the cluster will be debited from your cloud billing account.
* [Service account](../../iam/concepts/users/service-accounts.md) {{ ml-platform-name }} will use for creating and managing clusters. The service account will need the following roles:
   * `dataproc.agent` to use {{ dataproc-name }} clusters.
   * `dataproc.admin` to create clusters from {{ dataproc-name }} templates.
   * `vpc.user` to use the {{ dataproc-name }} cluster network.
   * `iam.serviceAccounts.user` to create resources in the folder on behalf of the service account.
* [Subnet](../../vpc/concepts/network.md#subnet) for {{ ml-platform-name }} to communicate with the {{ dataproc-name }} cluster. Since the {{ dataproc-name }} cluster needs to access the internet, make sure to [configure a NAT gateway](../../vpc/operations/create-nat-gateway.md) in this subnet.

  {% include [subnet-create](../../_includes/subnet-create.md) %}

{% note warning %}

The {{ dataproc-name }} persistent cluster must have the `livy:livy.spark.deploy-mode : client` setting.

{% endnote %}
