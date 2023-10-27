To use {{ dataproc-name }} clusters, [set the following project parameters](../../datasphere/operations/projects/update.md):
* [Default folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to enable integration with other {{ yandex-cloud }} services. A {{ dataproc-name }} cluster will be deployed in this folder based on the current cloud [quotas](../../data-proc/concepts/limits.md). A fee for using the cluster will be debited from your cloud billing account.
* [Service account](../../iam/concepts/users/service-accounts.md) to be used by {{ ml-platform-name }} for creating and managing clusters. The service account needs the following roles:
   * `dataproc.agent` to use {{ dataproc-name }} clusters.
   * `dataproc.admin` to create clusters from {{ dataproc-name }} templates.
   * `vpc.user` to use the {{ dataproc-name }} cluster network.
   * `iam.serviceAccounts.user` to create resources in the folder on behalf of the service account.
* [Subnet](../../vpc/concepts/network.md#subnet) for {{ ml-platform-name }} to communicate with the {{ dataproc-name }} cluster. Since the {{ dataproc-name }} cluster needs to access the internet, make sure to [configure a NAT gateway](../../vpc/operations/create-nat-gateway.md) in the subnet.

   {% include [subnet-create](../../_includes/subnet-create.md) %}
