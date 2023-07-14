# Configuring networks for {{ dataproc-name }}

In this tutorial, you'll learn how to create a {{ dataproc-name }} cluster and set up subnets and NAT gateway.

## Create resources {#deploy-infrastructure}

You have to create:

* Network.
* Subnet.
* NAT gateway and routing table.
* Security group for the cluster.
* Service account for the cluster.
* Bucket to store job dependencies and results.
* {{ dataproc-name }} cluster.

{% list tabs %}

- Manually

   1. [Create a network](../../vpc/operations/network-create.md) named `data-proc-network` with the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** option disabled.
   1. In `data-proc-network`, [create a subnet](../../vpc/operations/subnet-create.md) with the following parameters:

      * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}**: `data-proc-subnet-a`.
      * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}**: `{{ region-id }}-a`.
      * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}**: `192.168.1.0/24`.

   1. [Create an NAT gateway](../../vpc/operations/create-nat-gateway.md) and routing table named `data-proc-route-table` in `data-proc-network`. Assign the routing table to the `data-proc-subnet-a` subnet.

   1. In the `data-proc-network` subnet, [create a security group](../../vpc/operations/security-group-create.md) named `data-proc-security-group` with the following rules:

      * One rule for inbound and another one for outbound service traffic:

         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`.
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**/**{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}`.

      * Rule for outgoing HTTPS traffic:

         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}`.
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`.
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

   1. [Create a service account](../../iam/operations/sa/create.md) `data-proc-sa` with the roles:

      * [mdb.dataproc.agent](../../iam/concepts/access-control/roles.md#mdb-dataproc-agent).
      * [storage.uploader](../../iam/concepts/access-control/roles.md#storage-uploader).
      * [storage.viewer](../../iam/concepts/access-control/roles.md#storage-viewer).

   1. [Create a {{ objstorage-full-name }} bucket](../../storage/operations/buckets/create.md) with restricted access.

   1. [Create a {{ dataproc-name }} cluster](../../data-proc/operations/cluster-create.md) with any suitable configuration with the following settings:

      * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}**: `data-proc-sa`.
      * **{{ ui-key.yacloud.mdb.forms.config_field_form-bucket-type }}**: `{{ ui-key.yacloud.forms.label_form-list }}`.
      * **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}**: Select the created bucket.
      * **{{ ui-key.yacloud.mdb.forms.config_field_network }}**: `data-proc-network`.
      * **{{ ui-key.yacloud.mdb.forms.field_security-group }}**: `data-proc-security-group`.

- Using {{ TF }}

   1. If you do not have {{ TF }} yet, [set up and configure](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) it.
   1. [Download the file with the provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. [Download the cluster configuration file](https://github.com/yandex-cloud/examples/blob/master/tutorials/terraform/data-proc-nat-gateway.tf) to the same working directory.

      The file describes:

      * Network.
      * Subnet.
      * NAT gateway and routing table.
      * Security groups.
      * Service account to access cloud resources.
      * Bucket to store job dependencies and results.
      * {{ dataproc-name }} cluster.

   1. In the configuration file, specify all the relevant parameters.

   1. Run the `terraform init` command in the working directory hosting the configuration files. This command initializes the provider specified in the configuration files and enables you to use the provider's resources and data sources.

   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point to them.

   1. Create the required infrastructure:

      1. Run the command to view planned changes:

         ```bash
         terraform plan
         ```

         If the resource configuration descriptions are correct, the terminal will display a list of the resources to modify and their parameters. This is a test step. No resources are updated.

      1. If you are happy with the planned changes, apply them:

         1. Run this command:

            ```bash
            terraform apply
            ```

         1. Confirm the resources have been updated.

         1. Wait for the operation to complete.

   All the required resources will be created in the specified folder. You can check that the resources are there and their settings are correct using the [management console]({{ link-console-cloud }}).

{% endlist %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs %}

- Manually

   1. [Delete the {{ dataproc-name }} cluster](../../data-proc/operations/cluster-delete.md).
   1. If you reserved public static IP addresses for the clusters, release and [delete them](../../vpc/operations/address-delete.md).
   1. [Delete the subnet](../../vpc/operations/subnet-delete.md).
   1. Delete the routing table and NAT gateway.
   1. [Delete the network](../../vpc/operations/network-delete.md).

- Using {{ TF }}

   To delete the infrastructure [created with {{ TF }}](#deploy-infrastructure):

   1. In the terminal window, switch to the directory containing the infrastructure plan.

   1. Delete the `data-proc-nat-gateway.tf` configuration file.

   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point them out.

   1. Confirm the resources have been updated.

      1. Run the command to view planned changes:

         ```bash
         terraform plan
         ```

         If the resource configuration descriptions are correct, the terminal will display a list of the resources to modify and their parameters. This is a test step. No resources are updated.

   1. If you are happy with the planned changes, apply them:

      1. Run this command:

         ```bash
         terraform apply
         ```

      1. Confirm the resources have been updated.

      1. Wait for the operation to complete.

   All resources described in the configuration file will be deleted.

{% endlist %}
