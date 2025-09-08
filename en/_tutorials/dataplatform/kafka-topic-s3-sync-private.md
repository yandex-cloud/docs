# Syncing data from {{ KF }} topics to a {{ objstorage-full-name }} bucket without using the internet



{% note info %}

The VPC Private Endpoints feature in {{ vpc-full-name }} is at the [Preview](../../overview/concepts/launch-stages.md) stage. To get access to the feature, contact your account manager.

{% endnote %}


You can synchronize data from {{ KF }} topics to a {{ objstorage-full-name }} bucket without using the internet via a service connection in the user network hosting the {{ mkf-name }} cluster. To do this:

1. [Send data to the topic](#send-data).
1. [Make sure the bucket is not accessible from the external network](#check-bucket-access).
1. [Check if there is data in the bucket](#check-bucket-data).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost for this solution includes:

* Fee for an {{ objstorage-name }} bucket: Covers data storage and bucket operations (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).
* {{ mkf-name }} cluster fee: Covers the use of computating resources allocated to hosts and disk space (see [{{ mkf-name }} pricing](../../managed-kafka/pricing.md)).
* Fee for using public IP addresses for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).


## Getting started {#before-you-begin}


1. Set up the infrastructure:

    {% list tabs group=resources %}

    - Manually {#manual}

        1. [Create a network](../../vpc/operations/network-create.md) named `my-private-network`. Disable **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** when creating it.
        1. [Create a subnet](../../vpc/operations/subnet-create.md) in any availability zone.
        1. [Create a service connection to {{ objstorage-name }}](../../vpc/operations/private-endpoint-create.md) in `my-private-network` and write down its ID.
        1. [Create a service account](../../iam/operations/sa/create.md#create-sa) named `storage-pe-admin` with the `storage.admin` role. The {{ mkf-name }} cluster will use it to access the bucket.
        1. [Create a static access key](../../iam/operations/authentication/manage-access-keys.md#create-access-key) for the `storage-pe-admin` service account.
        1. [Create a {{ objstorage-full-name }} bucket](../../storage/operations/buckets/create.md) and configure its bucket policy:

            * **Result**: `Allow`.
            * **Action**: `All actions`.
            * **Resource**: `<bucket_name>` and `<bucket_name>/*`.
            * **Condition**: Select the `yc:private-endpoint-id` key from the list and specify the ID of the created service connection as its value.

        1. [Create a {{ mkf-name }} cluster](../../managed-kafka/operations/cluster-create.md) of any suitable [configuration](../../managed-kafka/concepts/instance-types.md) and the following settings:

            * Broker hosts: One
            * Access to cluster hosts: Public
            * Network: `my-private-network`

        
        1. If using security groups in your cluster, make sure they are [configured correctly](../../managed-kafka/operations/connect/index.md#configuring-security-groups) and allow connecting to the cluster.


        1. [In the cluster, create a topic](../../managed-kafka/operations/cluster-topics.md#create-topic) named `my-private-topic`.
        1. [In the cluster, create a user](../../managed-kafka/operations/cluster-accounts.md#create-account) named `mkf-user` with the `ACCESS_ROLE_PRODUCER` access permission for the new topic.
        1. [In the cluster, create a connector](../../managed-kafka/operations/cluster-connector.md#create) with the following settings:

            * Under **{{ ui-key.yacloud.kafka.section_properties }}**, specify the connector properties:
               * `key.converter`: `org.apache.kafka.connect.storage.StringConverter`
               * `value.converter`: `org.apache.kafka.connect.converters.ByteArrayConverter`
               * `format.output.fields.value.encoding`: `none`
            * Select the **S3 Sink** connector type.
            * In the **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-topics }}** field, specify `my-private-topic`.
            * Under **{{ ui-key.yacloud.kafka.field_connector-s3-connection }}**, specify the following settings:
               * **{{ ui-key.yacloud.kafka.field_connector-bucket-name }}**: Bucket you created previously.
               * **{{ ui-key.yacloud.kafka.field_connector-endpoint }}**: `storage.pe.yandexcloud.net`.
               * **{{ ui-key.yacloud.kafka.field_connector-access-key-id }}**, **{{ ui-key.yacloud.kafka.field_connector-secret-access-key }}**: ID and secret key of the previously created static access key.

        1. [Create a VM](../../compute/operations/vm-create/create-linux-vm.md) with a public IP address in the created `my-private-network` to connect to the bucket.

    - {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

        1. Download the [kafka-objstorage-sync-private-network.tf](https://github.com/yandex-cloud-examples/yc-sync-kafka-to-s3-private-endpoint/blob/main/kafka-objstorage-sync-private-network.tf) configuration file to the same working directory.

            This file describes:

            * [Network](../../vpc/concepts/network.md#network).
            * [Subnet](../../vpc/concepts/network.md#subnet).
            * [Service connection](../../vpc/concepts/private-endpoint.md).
            * [Security group](../../vpc/concepts/security-groups.md) required for cluster connection.
            * Service account for creating and accessing the bucket.
            * {{ objstorage-name }} bucket.
            * {{ mkf-name }} cluster.
            * {{ KF }} topic.
            * {{ KF }} user.
            * {{ KF }} connector.
            * VM to read data from the bucket.

        1. In the `kafka-objstorage-sync-private-network.tf` file, specify the following:

            * `tf_account_name`: Service account name, the same as the one in the provider settings.
            * `bucket_name`: Bucket name consistent with the [naming conventions](../../storage/concepts/bucket.md#naming).
            * `mkf_version`: {{ KF }} version.
            * `mkf_user_password`: {{ KF }} user password.
            * `vm_image_id`: ID of the public [image](../../compute/operations/images-with-pre-installed-software/get-list.md).
            * `vm_username` and `vm_ssh_key`: Username and absolute path to the [public key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys), for access to the VM.

        1. Validate your {{ TF }} configuration files using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    {% endlist %}

1. Make sure that {{ dns-full-name }} has the `*.storage.pe.yandexcloud.net` record in the `.` [service zone](../../dns/concepts/dns-zone.md#service-zones) of the new network.
1. Install [kafkacat](https://github.com/edenhill/kcat) to write data to the {{ KF }} topic.

    ```bash
    sudo apt update && sudo apt install --yes kafkacat
    ```

    Make sure you can use it to [connect to the previously created {{ mkf-name }} cluster over SSL](../../managed-kafka/operations/connect/clients.md#bash-zsh).

## Send data to the topic {#send-data}

1. Send test data to `my-private-topic` using `kafkacat`:

   ```bash
   for i in $(echo {1..50})
       do
          echo "test message_"$i | kafkacat -P \
             -b <broker_host_FQDN>:9091 \
             -t my-private-topic \
             -k key \
             -X security.protocol=SASL_SSL \
             -X sasl.username="<username_in_source_cluster>" \
             -X sasl.password="<user_password_in_source_cluster>" \
             -X ssl.ca.location={{ crt-local-dir }}{{ crt-local-file }} -Z
       done
   ```

1. Make sure data is replicated to the bucket. To do this, [open the bucket upload statistics](../../storage/operations/buckets/get-stats.md#storage-ui) and check the **Modify Requests** chart for requests.

## Make sure the bucket is not accessible from the external network {#check-bucket-access}

1. {% include [aws-cli-install](../../_includes/aws-cli-install.md) %}
1. Run this command to get a list of bucket objects at a public network address:

   ```bash
   aws s3 ls s3://<bucket_name> \
       --endpoint-url=https://storage.yandexcloud.net \
       --recursive
   ```

   Result:

   ```text
   An error occurred (AccessDenied) when calling the ListObjectsV2 operation: Access Denied
   ```

1. Run this command to get a list of bucket objects at a private network address:

   ```bash
   aws s3 ls s3://<bucket_name> \
       --endpoint-url=https://storage.pe.yandexcloud.net \
       --recursive
   ```

   Result:

   ```text
   Could not connect to the endpoint URL: "https://storage.pe.yandexcloud.net/<bucket_name>?list-type=2&prefix=&encoding-type=url"
   ```

## Check if there is data in the bucket via the service connection {#check-bucket-data}

[Connect](../../compute/operations/vm-connect/ssh.md) to the previously created VM over SSH and do the following:

1. [Install and configure the AWS CLI](../../storage/tools/aws-cli.md).
1. Run this command to get a list of bucket objects at a private network address:

    ```bash
    aws s3 ls s3://<bucket_name> \
        --endpoint-url=https://storage.pe.yandexcloud.net \
        --recursive
    ```

    Result:

    ```text
    2025-08-01 14:38:23         20 my-private-topic-1-0
    2025-08-01 14:38:23        587 my-private-topic-1-1
    2025-08-01 14:38:24        440 my-private-topic-1-29
    ```

This result means {{ KF }} topic data has been successfully synchronized via the service connection.

## Delete the resources you created {#clear-out}

Some resources incur charges. To avoid paying for them, delete the resources you no longer need:

{% list tabs group=resources %}

- Manually {#manual}

    * [Delete](../../managed-kafka/operations/cluster-delete.md) the {{ mkf-name }} cluster.
    * [Delete](../../storage/operations/buckets/delete.md) the {{ objstorage-name }} bucket. Before deleting the bucket, [delete](../../storage/operations/objects/delete.md) all its objects.
    * [Delete](../../compute/operations/vm-control/vm-delete.md) the VM.

- {{ TF }} {#tf}

    First, [delete](../../storage/operations/objects/delete.md) all objects from the bucket you created [previously](#before-you-begin).

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}
