# Configuring networks for {{ dataproc-name }}


In this tutorial, you will learn how to create a {{ dataproc-name }} cluster and set up subnets and a NAT gateway.

## Create resources {#deploy-infrastructure}

You have to create:

* Network.
* Subnet.
* NAT gateway and routing table.
* Security group for the cluster.
* Service account for the cluster.
* Bucket to store job dependencies and results.
* {{ dataproc-name }} cluster.

{% list tabs group=instructions %}

- Manually {#manual}

   1. [Create a network](../../vpc/operations/network-create.md) named `data-proc-network` with the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** option disabled.
   1. In `data-proc-network`, [create a subnet](../../vpc/operations/subnet-create.md) with the following parameters:

      * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}**: `data-proc-subnet-a`
      * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}**: `{{ region-id }}-a`
      * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}**: `192.168.1.0/24`

   1. [Create a NAT gateway](../../vpc/operations/create-nat-gateway.md) and a routing table named `data-proc-route-table` in `data-proc-network`. Associate the routing table with the `data-proc-subnet-a` subnet.

   1. In the `data-proc-network` subnet, [create a security group](../../vpc/operations/security-group-create.md) named `data-proc-security-group` with the following rules:

      * One rule for inbound and another one for outbound service traffic:

         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**/**{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}`

      * Rule for outgoing HTTPS traffic:

         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

      * Rule that allows access to NTP servers for time syncing:

         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `123`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_udp }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
         * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

      {% include [sg-rules-connect](../../_includes/data-proc/note-sg-rules.md) %}

   1. [Create a service account](../../iam/operations/sa/create.md) named `data-proc-sa` with the following roles:

      * [dataproc.agent](../../data-proc/security/index.md#dataproc-agent)
      * [storage.uploader](../../storage/security/index.md#storage-uploader)
      * [storage.viewer](../../storage/security/index.md#storage-viewer)

   1. [Create a {{ objstorage-full-name }} bucket](../../storage/operations/buckets/create.md) with restricted access.

   1. [Create a {{ dataproc-name }} cluster](../../data-proc/operations/cluster-create.md) with any suitable configuration with the following settings:

      * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}**: `data-proc-sa`.
      * **{{ ui-key.yacloud.mdb.forms.config_field_form-bucket-type }}**: `{{ ui-key.yacloud.forms.label_form-list }}`.
      * **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}**: Select the created bucket.
      * **{{ ui-key.yacloud.mdb.forms.config_field_network }}**: `data-proc-network`.
      * **{{ ui-key.yacloud.mdb.forms.field_security-group }}**: `data-proc-security-group`.

- {{ TF }} {#tf}

   1. {% include [terraform-install](../../_includes/terraform-install.md) %}
   1. [Download the file with the provider settings](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. [Download the cluster configuration file](https://github.com/yandex-cloud-examples/yc-data-proc-configure-network/blob/main/data-proc-nat-gateway.tf) to the same working directory.

      The file describes:

      * Network.
      * Subnet.
      * NAT gateway and route table.
      * Security group.
      * Service account to work with cloud resources.
      * Bucket to store job dependencies and results.
      * {{ dataproc-name }} cluster.

      {% include [sg-rules-connect](../../_includes/data-proc/note-sg-rules.md) %}

   1. In the configuration file, specify all the relevant parameters.

   1. Run the `terraform init` command in the working directory hosting the configuration files. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.

   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

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

         1. Confirm updating the resources.

         1. Wait for the operation to complete.

   All the required resources will be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-cloud }}).

{% endlist %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs group=instructions %}

- Manually {#manual}

   1. [Delete the {{ dataproc-name }} cluster](../../data-proc/operations/cluster-delete.md).
   1. If you reserved public static IP addresses for the clusters, release and [delete them](../../vpc/operations/address-delete.md).
   1. [Delete the subnet](../../vpc/operations/subnet-delete.md).
   1. Delete the routing table and NAT gateway.
   1. [Delete the network](../../vpc/operations/network-delete.md).

- {{ TF }} {#tf}

   To delete the infrastructure [created with {{ TF }}](#deploy-infrastructure):

   1. In the terminal window, go to the directory containing the infrastructure plan.

   1. Delete the `data-proc-nat-gateway.tf` configuration file.

   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point them out.

   1. Confirm updating the resources.

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

      1. Confirm updating the resources.

      1. Wait for the operation to complete.

   All the resources described in the configuration file will be deleted.

{% endlist %}
