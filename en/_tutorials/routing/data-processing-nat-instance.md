# Configuring a network for {{ dataproc-name }}


In this tutorial, you will learn how to create a {{ dataproc-name }} cluster and set up subnets and a NAT gateway.


## Required paid resources {#paid-resources}

The support cost includes:

* {{ dataproc-name }} cluster fee: using VM computing resources and {{ compute-name }} network disks, and {{ cloud-logging-name }} for log management (see [{{ dataproc-name }} pricing](../../data-proc/pricing.md)).
* Fee for a NAT gateway (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* Fee for an {{ objstorage-name }} bucket: data storage and operations (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).


## Create resources {#deploy-infrastructure}

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a network](../../vpc/operations/network-create.md) named `data-proc-network` with the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** option disabled.
    1. In `data-proc-network`, [create a subnet](../../vpc/operations/subnet-create.md) with the following settings:

        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}**: `data-proc-subnet-a`
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}**: `{{ region-id }}-a`
        * **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}**: `192.168.1.0/24`

    1. [Create a NAT gateway](../../vpc/operations/create-nat-gateway.md) and a route table named `data-proc-route-table` in `data-proc-network`. Associate the table with `data-proc-subnet-a`.

    1. In `data-proc-network`, [create a security group](../../vpc/operations/security-group-create.md) named `data-proc-security-group` with the following rules:

        * One rule for inbound and another one for outbound control plane traffic:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**/**{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}`

        * Rule for outbound HTTPS traffic:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

        * Rule that allows access to NTP servers for time syncing:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `123`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_udp }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

        {% include [sg-rules-connect](../../_includes/data-processing/note-sg-rules.md) %}

    1. [Create a service account](../../iam/operations/sa/create.md) named `data-proc-sa` with the following roles:

        * [dataproc.agent](../../data-proc/security/index.md#dataproc-agent)
        * [dataproc.provisioner](../../data-proc/security/index.md#dataproc-provisioner)
        * [storage.uploader](../../storage/security/index.md#storage-uploader)
        * [storage.viewer](../../storage/security/index.md#storage-viewer)

    1. [Create an {{ objstorage-full-name }} bucket](../../storage/operations/buckets/create.md) with restricted access.

    1. [Create a {{ dataproc-name }} cluster](../../data-proc/operations/cluster-create.md) of any suitable configuration with the following settings:

        * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}**: `data-proc-sa`.
        * **{{ ui-key.yacloud.mdb.forms.config_field_form-bucket-type }}**: `{{ ui-key.yacloud.forms.label_form-list }}`.
        * **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}**: Select the bucket you created earlier.
        * **{{ ui-key.yacloud.mdb.forms.config_field_network }}**: `data-proc-network`.
        * **{{ ui-key.yacloud.mdb.forms.field_security-group }}**: `data-proc-security-group`.

- {{ TF }} {#tf}

    1. {% include [terraform-install](../../_includes/terraform-install.md) %}
    1. [Get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) and specify the {{ yandex-cloud }} provider installation source (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), Step 1).
    1. [Download the cluster configuration file](https://github.com/yandex-cloud-examples/yc-data-proc-configure-network/blob/main/data-proc-nat-gateway.tf) to the same working directory.

        This file describes:

        * Network.
        * Subnet.
        * NAT gateway and route table.
        * Security group.
        * Service account to work with cluster resources.
        * Service account for bucket management.
        * Static access key required to grant the service account the required permissions for the bucket.
        * Bucket to store job dependencies and results.
        * {{ dataproc-name }} cluster.

        {% include [sg-rules-connect](../../_includes/data-processing/note-sg-rules.md) %}

    1. In the configuration file, specify all the relevant parameters.

    1. Run the `terraform init` command in the working directory with the configuration files. This command initializes the provider specified in the configuration files and enables you to use the provider’s resources and data sources.

    1. Check that the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        If there are any errors in the configuration files, {{ TF }} will point them out.

    1. Create the required infrastructure:

        1. Run the command to view the planned changes:

            ```bash
            terraform plan
            ```

            If you described the configuration correctly, the terminal will display a list of the resources to update and their parameters. This is a verification step that does not apply changes to your resources.

        1. If everything looks correct, apply the changes:

            1. Run this command:

                ```bash
                terraform apply
                ```

            1. Confirm updating the resources.

            1. Wait for the operation to complete.

    All the resources you need will be created in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-cloud }}).

{% endlist %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Delete the {{ dataproc-name }} cluster](../../data-proc/operations/cluster-delete.md).
    1. If you reserved public static IP addresses for the clusters, release and [delete them](../../vpc/operations/address-delete.md).
    1. [Delete the subnet](../../vpc/operations/subnet-delete.md).
    1. [Delete the route table](../../vpc/operations/delete-route-table.md).
    1. [Delete the NAT gateway](../../vpc/operations/delete-nat-gateway.md).
    1. [Delete the network](../../vpc/operations/network-delete.md).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
