# {{ k8s }} cluster backups in {{ objstorage-full-name }}

Data in {{ managed-k8s-name }} clusters is stored securely and replicated within the {{ yandex-cloud }} infrastructure. However, whenever you want, you can back up data from {{ k8s }} cluster node groups and store them in [{{ objstorage-name }}](../../storage/) or other storage.

You can back up:

* Data from {{ k8s }} cluster node groups using [Velero](https://velero.io/).

* Persistent [volumes](../concepts/volume.md) using [restic](https://restic.net/). Learn more about configuring restic in the [Velero documentation](https://velero.io/docs/v1.5/restic/#backup).

  restic copies data from Persistent Volumes as files, so we recommend backing up the database using the application itself. For example, for the {{ CH }} DBMS, use the clickhouse-backup utility, for the {{ MY }} DBMS, the MySQLdump utility, for {{ PG }}, pg_dump.

## Requirements {#requirements}

The {{ k8s }} cluster node group must have [internet access](../concepts/index.md#kubernetes-cluster). You can only grant internet access during [node group creation](../operations/node-group/node-group-create.md).

## Backups {#backup}

To back up cluster group data:

1. Choose [the latest version of Velero](https://github.com/vmware-tanzu/velero/releases) for your platform.

1. Download Velero, unpack the archive, and install the program. Learn more about installing the program in the [Velero documentation](https://velero.io/docs/v1.5/basic-install/#install-the-cli).

1. View a description of any Velero command using the `--help` flag. For example:

   {% list tabs %}

   - CLI

     ```bash
     velero --help
     ```

   {% endlist %}

1. In {{ objstorage-name }}, create a [bucket](../../storage/concepts/bucket.md) that will store the backup:

   {% list tabs %}

   - Management console
     1. In [management console]({{ link-console-main }}), select the folder where you want to create a bucket.
     1. Select **{{ objstorage-name }}**.
     1. Click **Create bucket**.
     1. On the **New bucket** page:
        1. Enter the bucket **Name** following the [naming conventions](../../storage/concepts/bucket.md#naming).

           For example, `velero-backup`.

        1. If necessary, limit the **Maximum size** of the bucket.

           {% include [storage-no-max-limit](../../storage/_includes_service/storage-no-max-limit.md) %}

        1. Select the type of [Access](../../storage/concepts/bucket.md#bucket-access).

        1. Select the default [storage class](../../storage/concepts/storage-class.md): **Standard**.

        1. Click **Create bucket** to complete the operation.

   {% endlist %}

1. Create a service account that bucket access will be assigned to:

   {% list tabs %}

   - Management console

     1. In [management console]({{ link-console-main }}), select the folder where you want to create a service account.

     1. Go to the **Service accounts** tab.

     1. Click **Create service account**.

     1. Enter a service account **Name**. For example, `velero-sa`.

        {% include [name-format](../../_includes/name-format.md) %}

     1. Click **Create**.

   - CLI

     {% include [cli-install](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     Create a service account:

     ```bash
     yc iam service-account create --name velero-sa
     ```

     Where:
     * `name`: Service account name.

     Execution result:

     ```bash
     id: abcdo12h3j04odg56def
     folder_id: b1g23ga45ghf0cljderg
     created_at: "2020-10-19T12:59:56Z"
     name: velero-sa
     ```

   {% endlist %}

1. Create a [static access key](../../iam/concepts/authorization/access-key.md) for the service account `velero-sa`:

   {% list tabs %}

   - Management console

     1. In [management console]({{ link-console-main }}), select the folder that the `velero-sa` service account pertains to.

     1. Go to the **Service accounts** tab.

     1. Choose the `velero-sa` service account and click the line with its name.

     1. On the **Overview** page, click **Create new key** in the top panel.

     1. Click **Create static access key**.

     1. In the **New key** window that opens, click **Create**.

     1. Save the ID and private key.

        {% note alert %}

        After you close the window, the private key value will be unavailable.

        {% endnote %}

   - CLI

     1. Create a static access key for your service account:

        ```bash
        yc iam access-key create --service-account-name velero-sa
        ```

        Where:
        * `service-account-name`: Service account name.

        Execution result:

        ```bash
        access_key:
          id: abcdo12h3j04odg56def
          service_account_id: ajego12h3j03slk16upe
          created_at: "2020-10-19T13:22:29Z"
          key_id: y1qiM23o-Y3WeoP5oSdc
        secret: MLSeE12TYJZpjFkfgMeKJ3e7PR7z6dk3UyEeC7PJ
        ```

     1. Save the ID `key_id` and private key `secret`. You will not be able to get the key value again.

   {% endlist %}

1. Create a file with a static access key.

   For example, you can create a file with the ` credentials` filename and save it in the home directory.

   To create static access keys that are compatible with the AWS API, the file contents must look as follows:

   ```
   [default]
   aws_access_key_id=y1qiM23o-Y3WeoP5oSdc
   aws_secret_access_key=MLSeE12TYJZpjFkfgMeKJ3e7PR7z6dk3UyEeC7PJ
   ```

1. Grant the `velero-sa` service account access to the bucket `velero-backup`. {{ objstorage-name }} supports access control using [ACL](../../storage/concepts/acl.md).

   {% list tabs %}

   - Management console
     1. In [management console]({{ link-console-main }}), select the folder where the `velero-backup` bucket was created.
     1. Select **{{ objstorage-name }}**.
     1. To edit the ACL, click ![image](../../_assets/horizontal-ellipsis.svg) to the right of the bucket name and select **Bucket ACL**.
      1. In the **ACL editing** window that opens:
         1. Select the `velero-sa` user.
         1. Grant the user **READ + WRITE** permission.
      1. Click **Add**.
      1. Click **Save**.

   {% endlist %}

1. Install Velero in the {{ k8s }} cluster where the data needs to be backed up from:

   {% list tabs %}

   - CLI

     ```bash
     velero install \
       --backup-location-config s3Url=https://storage.yandexcloud.net,region=ru-central1 \
       --bucket velero-backup \
       --plugins velero/velero-plugin-for-aws:v1.0.0 \
       --provider aws \
       --secret-file ./credentials \
       --use-restic \
       --use-volume-snapshots false
     ```

     Where:
     * `backup-location-config`: Configuration of the backup storage address. URL of {{ objstorage-name }} storage and [availability zones](../../overview/concepts/geo-scope.md).
     * `bucket`: Name of the backup storage bucket.
     * `plugins`: Image plugin to enable compatibility with AWS API.
     * `provider`: Name of the {{ objstorage-name }} object storage provider.
     * `secret-file`: Name of the file with a static access key and the path to it.
     * `use-restic`: Parameter for backing up Persistent Volumes with restic.
     * `use-volume-snapshots`: Parameter to prevent automatically creating storage snapshots.

     Execution result:

     ```bash
     CustomResourceDefinition/backups.velero.io: attempting to create resource
     CustomResourceDefinition/backups.velero.io: already exists, proceeding
     CustomResourceDefinition/backups.velero.io: created
     ...
     DaemonSet/restic: already exists, proceeding
     DaemonSet/restic: created
     Velero is installed! ⛵ Use 'kubectl logs deployment/velero -n velero' to view the status.
     ```

   {% endlist %}

1. Back up data from the {{ k8s }} cluster node group:

   {% list tabs %}

   - CLI

     ```bash
     velero backup create my-backup --default-volumes-to-restic
     ```

     Where:
     * `default-volumes-to-restic`: Copying Persistent Volumes from the `default` namespace with restic.

     Execution result:

     ```bash
     Backup request "my-backup" submitted successfully.
     Run `velero backup describe my-backup` or `velero backup logs my-backup` for more details.
     ```

   {% endlist %}

1. Wait for the backup to complete. The `STATUS` will be `Completed`.

   {% list tabs %}

   - CLI

     ```bash
     velero backup get
     ```

     Execution result:

     ```bash
     NAME        STATUS      ERRORS   WARNINGS   CREATED                         EXPIRES   STORAGE LOCATION   SELECTOR
     my-backup   Completed   0        0          2020-10-19 17:13:25 +0300 MSK   29d       default            <none>
     ```

   {% endlist %}

## Restoring data from backups {#restoring}

To restore data from the {{ k8s }} cluster node group:

1. Create a {{ k8s }} cluster.

   {% cut "How to create a cluster {{ k8s }}" %}

   {% list tabs %}

   - Management console

     {% include [create-cluster](../../_includes/managed-kubernetes/cluster-create.md) %}

   - CLI

     Run the command:

     ```
     yc managed-kubernetes cluster create \
       --name cluster-from-backup \
       --network-name network \
       --node-service-account-name docker \
       --service-account-name k8s \
       --zone ru-central1-a
     ```

     Where:
     * `name`: The {{ k8s }} cluster name.
     * `network-name`: The name of the network.
     * `node-service-account-id`: The unique ID of the service account for the nodes. Nodes will download the Docker images they require from the registry on behalf of this account.
     * `service-account-id`: The unique ID of the service account for the resources. The resources that the {{ k8s }} cluster needs will be created on behalf of this account.
     * `zone`: Availability zone.

     Execution result:

     ```
     done (6m9s)
     id: catab1c2f0fmb3d0ef94
     folder_id: b1g23ga82bcv0cdeferg
     created_at: "2020-10-19T17:41:28Z"
     name: cluster-from-backup
     status: RUNNING
     health: HEALTHY
     network_id: enpabc1rfondide2fflu3
     master:
       zonal_master:
         zone_id: ru-central1-a
         internal_v4_address: 10.0.0.32
       version: "1.17"
       endpoints:
         internal_v4_endpoint: https://10.0.0.32
       master_auth:
         cluster_ca_certificate: |
           -----BEGIN CERTIFICATE-----
           MIIAbCCCAbCgAwIBAgIBADANBgkqhkiG1w0BAQsFADAVMRMwEQYDVQQDEwdefWJl
           ...
           pi0jAbcDCLzCkfFuNimHejsSvVFN1N2bYYBCBMkhaYDzV5Ypfy/De0fHJ9U=
           -----END CERTIFICATE-----
       version_info:
         current_version: "1.17"
       maintenance_policy:
         auto_upgrade: true
         maintenance_window:
           anytime: {}
     ip_allocation_policy:
       cluster_ipv4_cidr_block: 10.112.0.0/16
       node_ipv4_cidr_mask_size: "24
       service_ipv4_cidr_block: 10.96.0.0/16
     service_account_id: ajeabcfldeftb1238n99
     node_service_account_id: ajea1b023cmndeft7t7j
     release_channel: REGULAR
     ```

   - API

     To create a {{ k8s }} cluster, use the [create](../api-ref/Cluster/create.md) method for the [Cluster](../api-ref/Cluster) resource.

   {% endlist %}

   {% endcut %}

1. Create a node group.

   When creating a node group, specify the public IP address so that the nodes have internet access.

   {% cut "How to create a node group" %}

   {% list tabs %}

   - Management console
     1. In [management console]({{ link-console-main }}), select the folder where you want to create your {{ k8s }} cluster.
     1. In the list of services, select **{{ managed-k8s-name }}**.
     1. Select the {{ k8s }} cluster to create a node group for.
     1. On the {{ k8s }} cluster page, go to the **Node groups** tab.
     1. Click **Create node group**.
     1. Enter a name and description for the node group.
     1. Specify the **{{ k8s }} version** for the nodes.
     1. Specify the number of nodes in the node group.
     1. In the **Scalability** section:
        * Select the scaling policy type.
        * Specify the number of nodes in the node group.
     1. Under **Allow when creating and updating**, specify the maximum number of instances that you can exceed and reduce the size of the group by.
     1. Under **Computing resources**:
        * Choose a [platform](../../compute/concepts/vm-platforms.md).
        * Specify the required number of vCPUs, [guaranteed vCPU performance](../../compute/concepts/performance-levels.md), and RAM.
     1. Under **Storage**:
        * Specify the **Disk type**:
          * **HDD**: Standard network drive. Network block storage on an HDD.
          * **SSD**: Fast network drive. Network block storage on an SSD.
        * Specify the disk size.
     1. Under **Network settings**:
        * In the **Public IP** field, choose a method for assigning an IP address:
          * **Auto**: Assign a random IP address from the {{ yandex-cloud }} IP pool.
        * Specify how nodes should be distributed across availability zones and networks.
     1. Under **Access**, specify the information required to access the node:
        * Enter the username in the **Login** field.
        * In the **SSH key** field, paste the contents of the [public key file](../../managed-kubernetes/operations/node-connect-ssh.md#creating-ssh-keys).
     1. Under **Maintenance window settings**:
        * In the **Maintenance frequency / Disable** field, choose the maintenance window:
          * **Disabled**: Automatic updates are disabled.
          * **Anytime**: Maintenance is allowed at any time.
          * **Daily**: Maintenance is performed during the interval specified in the **Time (UTC) and duration** field.
          * **On selected days**: Maintenance is performed during the interval specified in the **Schedule by day** field.
     1. Click **Create node group**.

   - CLI

     Run the command:

     ```
     yc managed-kubernetes node-group create \
       --cluster-name cluster-from-backup \
       --fixed-size 1 \
       --public-ip
     ```

     Where:
     * `cluster-name`: The name of the {{ k8s }} cluster where the node group is created.
     * `fixed-size`: The number of nodes in the group.
     * `public-ip`: Flag specified if the node group needs a public IP address.

     Execution result:

     ```
     done (2m31s)
     id: catabcio1iq2sdefial3
     cluster_id: catab1c2f0fmb3d0ef94
     created_at: "2020-10-19T17:43:54Z"
     status: RUNNING
     node_template:
       platform_id: standard-v2
       resources_spec:
         memory: "4294967296"
         cores: "2"
         core_fraction: "100"
       boot_disk_spec:
         disk_type_id: network-hdd
         disk_size: "103079215104"
       v4_address_spec:
         one_to_one_nat_spec:
           ip_version: IPV4
       scheduling_policy: {}
     scale_policy:
       fixed_scale:
         size: "1"
     allocation_policy:
       locations:
       - zone_id: ru-central1-a
         subnet_id: e1bm23abcs81edef6dqg
     deploy_policy:
       max_expansion: "3"
     instance_group_id: cl1ca2bch3lde1fi2tk7
     node_version: "1.17"
     version_info:
       current_version: "1.17"
     maintenance_policy:
       auto_upgrade: true
       auto_repair: true
       maintenance_window:
         anytime: {}
     ```

   - API

     To create a node group, use the [create](../api-ref/NodeGroup/create.md) method for the [NodeGroup](../api-ref/NodeGroup) resource.

   {% endlist %}

   {% endcut %}

1. Install Velero in the {{ k8s }} cluster to restore the data in:

   {% list tabs %}

   - CLI

     ```bash
     velero install \
       --backup-location-config s3Url=https://storage.yandexcloud.net,region=ru-central1 \
       --bucket velero-backup \
       --plugins velero/velero-plugin-for-aws:v1.0.0 \
       --provider aws \
       --secret-file ./credentials \
       --use-restic \
       --use-volume-snapshots false
     ```

     Where:
     * `backup-location-config`: Configuration of the backup storage address. URL of {{ objstorage-name }} storage and all [availability zones](../../overview/concepts/geo-scope.md).
     * `bucket`: Name of the backup storage bucket.
     * `plugins`: Image plugin to enable compatibility with AWS API.
     * `provider`: Name of the {{ objstorage-name }} object storage provider.
     * `secret-file`: Name of the file with a static access key and the path to it.
     * `use-restic`: Use restic to back up Persistent Volumes.
     * `use-volume-snapshots`: Option to create storage snapshots. Possible values: `false` — don't create, `true` — create. Default value: `true`.

     Execution result:

     ```bash
     CustomResourceDefinition/backups.velero.io: attempting to create resource
     CustomResourceDefinition/backups.velero.io: already exists, proceeding
     CustomResourceDefinition/backups.velero.io: created
     ...
     DaemonSet/restic: already exists, proceeding
     DaemonSet/restic: created
     Velero is installed! ⛵ Use 'kubectl logs deployment/velero -n velero' to view the status.
     ```

   {% endlist %}

1. Make sure that the data backup is displayed in the created {{ k8s }} cluster:

   {% list tabs %}

   - CLI

     ```bash
     velero backup get
     ```

     Execution result:

     ```bash
     NAME        STATUS      ERRORS   WARNINGS   CREATED                         EXPIRES   STORAGE LOCATION   SELECTOR
     my-backup   Completed   0        0          2020-10-19 17:13:25 +0300 MSK   29d       default            <none>
     ```

   {% endlist %}

1. Restore data from the backup:

   {% list tabs %}

   - CLI

     ```bash
     velero restore create create --exclude-namespaces velero --from-backup my-backup
     ```

     Where:
     * `exclude-namespaces`: Parameter that allows users not to restore objects from the `velero` namespace.
     * `from-backup`: Name of the bucket where the backup is stored.

     Execution result:

     ```bash
     Restore request "create" submitted successfully.
     Run `velero restore describe create` or `velero restore logs create` for more details.
     ```

   {% endlist %}

1. Wait for the backup restoration to complete. The `STATUS` will be `Completed`.

   {% list tabs %}

   - CLI

     ```bash
     velero get restore
     ```

     Execution result:

     ```bash
     NAME     BACKUP    STATUS      STARTED                         COMPLETED                       ERRORS   WARNINGS   CREATED                         SELECTOR
     create   my-backup   Completed   2020-10-20 14:04:55 +0300 MSK   2020-10-20 14:05:22 +0300 MSK   0        23         2020-10-20 14:04:55 +0300 MSK   <none>
     ```

   {% endlist %}

