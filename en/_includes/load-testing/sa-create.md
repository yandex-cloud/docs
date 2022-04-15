1. [Create](../../iam/operations/sa/create.md) a service account named `sa-loadtest` in the folder to host the agent that will generate the load.
1. [Assign](../../iam/operations/roles/grant.md) the following roles to the service account:
    * [`loadtesting.generatorClient`](../../load-testing/security/index.md#roles-list): Allows running the agent, performing tests on the agent, and uploading the results to storage.
    * [`compute.admin`](../../compute/security/index.md#service-roles): Allows managing VMs in {{ compute-name }}.
    * [`vpc.user`](../../vpc/security/index.md#choosing-roles): Allows connecting to {{ vpc-name }} network resources and using them.

