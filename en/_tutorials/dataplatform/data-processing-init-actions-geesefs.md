# Mounting {{ objstorage-full-name }} buckets to the file system of {{ dataproc-full-name }} hosts


In {{ dataproc-full-name }}, you can use [initialization actions](../../data-proc/concepts/init-action.md) to configure hosts.

With them, you can automate the installation and setup of [GeeseFS](../../storage/tools/geesefs.md), the software enabling {{ dataproc-full-name }} cluster hosts to mount {{ objstorage-full-name }} buckets via [FUSE](https://en.wikipedia.org/wiki/Filesystem_in_Userspace).

To set up GeeseFS:

1. [Prepare the initialization action](#prepare-init-scripts).
1. [Create a cluster that uses the initialization action](#create-cluster).
1. [Check bucket availability](#check-availability).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost includes:

* {{ dataproc-name }} cluster fee (see [{{ dataproc-name }} pricing](../../data-proc/pricing.md)).
* NAT gateway fee (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* {{ objstorage-name }} bucket fee: Storing data and performing operations with it (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).
* Fee for public IP addresses for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).


## Getting started {#before-you-begin}

Set up your infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

  1. [Create a service account](../../iam/operations/sa/create.md) with the `dataproc.agent` and `dataproc.provisioner` roles.

  1. [Create an {{ objstorage-name }} bucket](../../storage/operations/buckets/create.md).

  1. Grant the service account read access to the bucket. To do this, use one of the following methods:

      * [Set up the bucket's ACL](../../storage/operations/buckets/edit-acl.md) and grant `READ` access to the service account.

          The service account will get read access only to the specified bucket.

      * [Assign the service account](../../iam/operations/sa/assign-role-for-sa.md) the `storage.viewer` role.

          The service account will get read access to all buckets in the folder.

  1. Create a [NAT gateway](../../vpc/operations/create-nat-gateway) for the subnet you want to create your {{ dataproc-name }} cluster in.

- {{ TF }} {#tf}

  1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
  1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
  1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
  1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

  1. Download the [data-processing-init-actions-geesefs.tf](https://github.com/yandex-cloud-examples/yc-data-processing-init-actions/blob/main/data-processing-init-actions-geesefs.tf) configuration file to the same working directory.

      This file describes:

      * [Network](../../vpc/concepts/network.md#network).
      * [Subnet](../../vpc/concepts/network.md#subnet).
      * [Route table](../../vpc/concepts/routing.md#rt-vpc).
      * [NAT gateway](../../vpc/concepts/gateways.md).
      * [Security group](../../vpc/concepts/security-groups.md) and rules required to connect to the {{ dataproc-name }} cluster.
      * [Service account](../../iam/concepts/users/service-accounts.md) with the roles required to work with the {{ objstorage-name }} bucket and {{ dataproc-name }} cluster.
      * [Static key](../../iam/concepts/authorization/access-key.md) for the service account to manage the {{ objstorage-name }} bucket.
      * [{{ objstorage-name }} bucket](../../storage/concepts/bucket.md).
      * [{{ dataproc-name }} cluster](../../data-proc/concepts/index.md).

  1. In the `data-processing-init-actions-geesefs.tf` file, specify the following settings:

      * `dp_network_name`: Name of the network for your {{ dataproc-name }} cluster.
      * `dp_subnet_name`: Name of the subnet for your {{ dataproc-name }} cluster.
      * `dp_sg_name`: Name of the security group for your {{ dataproc-name }} cluster.
      * `dp_sa_folder_id`: ID of the folder to create your infrastructure and {{ dataproc-name }} cluster in.
      * `dp_sa_name`: Name of the service account for your {{ dataproc-name }} cluster and {{ objstorage-name }} bucket.
      * `dp_bucket_name`: {{ objstorage-name }} bucket name.
      * `dataproc_name`: {{ dataproc-name }} cluster name.
      * `ssh-path`: Path to the public SSH key file for your {{ dataproc-name }} cluster.

  1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

  1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Prepare the initialization action {#prepare-init-scripts}

1. Create the initialization action file named `geesefs_mount.sh` taking two positional arguments: the name of the {{ objstorage-name }} bucket and the host's file system directory where you are going to mount it.

    ```bash
    #!/bin/bash

    set -e

    BUCKET=$1
    MOUNT_POINT=$2

    # Downloading GeeseFS
    wget https://github.com/yandex-cloud/geesefs/releases/latest/download/geesefs-linux-amd64 -O /opt/geesefs
    chmod a+rwx /opt/geesefs
    mkdir -p "${MOUNT_POINT}"

    # Preparing a script to run on every boot
    BOOT_SCRIPT="/var/lib/cloud/scripts/per-boot/80-geesefs-mount.sh"
    echo "#!/bin/bash" >> ${BOOT_SCRIPT}
    echo "/opt/geesefs -o allow_other --iam ${BUCKET} ${MOUNT_POINT}" >> ${BOOT_SCRIPT}
    chmod 755 ${BOOT_SCRIPT}

    # Running the script
    ${BOOT_SCRIPT}
    ```

1. [Upload](../../storage/operations/objects/upload.md) the `geesefs_mount.sh` file to the previously created {{ objstorage-name }} bucket.

## Create a cluster that will use the initialization action {#create-cluster}

{% list tabs group=instructions %}

- Manually {#manual}

  [Create a {{ dataproc-name }} cluster](../../data-proc/operations/cluster-create.md) with the following settings:

  * In the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field, select `2.0`.
  * In the **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** field, select the service account you [previously created](#before-you-begin).
  * In the **{{ ui-key.yacloud.mdb.forms.config_field_initialization-action }}** field, click **{{ ui-key.yacloud.mdb.forms.button_add-initialization-action }}** and set the script parameters:

      * In the **{{ ui-key.yacloud.mdb.forms.field_initialization-action-uri }}** field, specify the path to the script file in the bucket, such as:

          ```http
          s3a://<bucket_name>/geesefs_mount.sh
          ```

      * In the **{{ ui-key.yacloud.mdb.forms.field_initialization-action-args }}** field, specify the name of the [previously created](#before-you-begin) bucket and `/mnt/test` as your mount point. Specify arguments on separate lines:

          ```text
          <bucket_name>
          /mnt/test
          ```

  * In the **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}** field, select the [previously created](#before-you-begin) bucket.

  * In the **{{ ui-key.yacloud.mdb.forms.section_subclusters }}** menu, enable **{{ ui-key.yacloud.mdb.forms.field_assign-public-ip }}** in the settings. This will enable you to connect to subcluster hosts without an intermediate virtual machine.

- {{ TF }} {#tf}

  1. In the `data-processing-init-actions-geesefs.tf` file, set the value for this variable as follows: `create_cluster` = `1`.

  1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

  1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Check {#check-availability} bucket availability.

1. After the cluster status changes to **Alive**, [connect](../../data-proc/operations/connect.md#data-proc-ssh) over SSH to any of its hosts as the `ubuntu` user.

1. To make sure the bucket has been mounted successfully, run this command:

    ```bash
    ls /mnt/test
    ```

    It will output the list of objects stored in the bucket’s root folder. In this case, the name of the `geesefs_mount.sh` file.

## Delete the resources you created {#clear-out}

{% note tip %}

Before deleting the infrastructure, manually delete all objects from the bucket.

{% endnote %}

Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

- Manually {#manual}

  1. [Delete the {{ dataproc-name }} cluster](../../data-proc/operations/cluster-delete.md).
  1. If you used static public IP addresses to access the cluster hosts, release and [delete them](../../vpc/operations/address-delete.md).
  1. [Delete the {{ objstorage-name }} bucket](../../storage/operations/buckets/delete.md).
  1. [Delete the service account](../../iam/operations/sa/delete.md).

- {{ TF }} {#tf}

  1. In the terminal, navigate to the working directory with the `data-processing-init-actions-geesefs.tf` configuration file.
  1. Delete the resources using this command:

      ```bash
      terraform destroy
      ```

  1. Type `yes` and press **Enter**.

      This will delete all resources described in the `data-processing-init-actions-geesefs.tf` configuration file.

{% endlist %}
