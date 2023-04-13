# Creating {{ GP }} clusters

A {{ mgp-name }} cluster consists of master hosts that accept client requests and segment hosts that provide data processing and storage.

Available disk types [depend](../concepts/storage.md) on the selected [host class](../concepts/instance-types.md).

For more information, see [{#T}](../concepts/index.md).

## How to create a {{ mgp-name }} cluster {#create-cluster}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create a database cluster.
   1. Select **{{ mgp-name }}**.
   1. Click **Create cluster**.
   1. Enter a name for the cluster. It must be unique within the folder.
   1. (optional) Enter a cluster description.
   1. Select the environment where you want to create the cluster (you can't change the environment once the cluster is created):
      * `PRODUCTION`: For stable versions of your apps.
      * `PRESTABLE`: For testing, including the {{ mgp-full-name }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.
   1. Select the {{ GP }} version.

   
   1. (Optional) Select groups of [dedicated hosts](../../compute/concepts/dedicated-host.md) to host the cluster on.

      {% include [Dedicated hosts note](../../_includes/mdb/mgp/note-dedicated-hosts.md) %}

   1. Under **Network settings**:
      * Select the cloud network for the cluster.
      * In the **Security groups** parameter, specify the [security group](../operations/connect.md#configuring-security-groups) that contains the rules allowing all incoming and outgoing traffic over any protocol from any IP address.

         {% include [preview-pp.md](../../_includes/preview-pp.md) %}

         {% note alert %}

         For a {{ mgp-name }} cluster to work properly, at least one of its security groups must have rules allowing all incoming and outgoing traffic from any IP address.

         {% endnote %}


       * Select the availability zone and subnet for the cluster. To create a new subnet, click **Create new** subnet next to the availability zone.
       * Select **Public access** to allow connecting to the cluster from the internet.

   1. Specify the administrative user's settings. This is a special user that is needed to manage clusters and cannot be deleted. For more information, see [{#T}](../concepts/cluster-users.md).

      * **Username** may contain Latin letters, numbers, hyphens, and underscores, but can't begin with a hyphen. It can be between 1 and 32 characters long.

         {% note info %}

         Such names as `admin`, `gpadmin`, `mdb_admin`, `mdb_replication`, `monitor`, `none`, `postgres`, `public`, `repl` are reserved for {{ mgp-name }}. You cannot create users with these names.

         {% endnote %}

      * **Password** must be between 8 and 128 characters.

   1. If necessary, configure additional cluster settings:

      * {% include [Backup time](../../_includes/mdb/console/backup-time.md) %}
      * **Maintenance window**: [Maintenance window](../concepts/maintenance.md) settings:

         {% include [Maintenance window](../../_includes/mdb/console/maintenance-window-description.md) %}

      * {% include [Datalens access](../../_includes/mdb/console/datalens-access.md) %}
      * {% include [DataTransfer access](../../_includes/mdb/console/datatransfer-access.md) %}
      * {% include [Deletion protection](../../_includes/mdb/console/deletion-protection.md) %}

         {% include [Deletion protection limits db](../../_includes/mdb/deletion-protection-limits-db.md) %}

      * **Connection pooler**: Operation mode and parameters of the [connection pooler](../concepts/pooling.md):

         {% include [Pooling mode](../../_includes/mdb/mgp/pooling-mode.md) %}

   1. If required, configure [DBMS cluster-level settings](../concepts/settings-list.md#dbms-cluster-settings).

   1. Specify the master host parameters on the **Master** tab. For the recommended configuration, see [Calculating the cluster configuration](calculate-specs.md#master).

      * [Host class](../concepts/instance-types.md): Defines the technical properties of the virtual machines where a cluster's master hosts will be deployed.

      * Under **Storage**:
         * Select the [disk type](../concepts/storage.md).

            
            {% include [storages-step-settings](../../_includes/mdb/mgp/settings-storages.md) %}


   1. Specify the parameters of segment hosts on the **Segment** tab. For the recommended configuration, see [Calculating the cluster configuration](calculate-specs.md#segment).

      * The number of segment hosts.
      * The number of segments per host. The maximum value of this parameter depends on the host class.
      * [Host class](../concepts/instance-types.md): Defines the technical properties of the virtual machines where a cluster's segment hosts will be deployed.
      * Under **Storage**:
         * Select the [disk type](../concepts/storage.md).

            
            {% include [storages-step-settings](../../_includes/mdb/mgp/settings-storages.md) %}


   1. Click **Create**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a cluster:

   
   1. Check whether the folder has any subnets for the cluster hosts:

      ```bash
      yc vpc subnet list
      ```

      If there are no subnets in the folder, [create the required subnets](../../vpc/operations/subnet-create.md) in {{ vpc-short-name }}.


   1. View a description of the CLI's create cluster command:

      ```bash
      {{ yc-mdb-gp }} cluster create --help
      ```

   1. Specify cluster parameters in the create command (the list of supported parameters in the example is not exhaustive):

      
      ```bash
      {{ yc-mdb-gp }} cluster create <cluster name> \
         --greenplum-version=<{{ GP }} version: {{ versions.cli.str }}> \
         --environment=<environment: PRESTABLE or PRODUCTION> \
         --network-name=<network name> \
         --user-name=<username> \
         --user-password=<user password> \
         --master-config resource-id=<host class>,`
                        `disk-size=<storage size, GB>,`
                        `disk-type=<disk type> \
         --segment-config resource-id=<host class>,`
                        `disk-size=<storage size, GB>,`
                        `disk-type=<disk type> \
         --zone-id=<availability zone> \
         --subnet-id=<subnet ID> \
         --assign-public-ip=<access to hosts via public IP address: true or false> \
         --security-group-ids=<list of security group IDs> \
         --deletion-protection=<cluster deletion protection: true or false>
      ```

      {% note info %}

      The cluster name must be unique within a folder. It may contain Latin letters, numbers, hyphens, and underscores. The maximum name length is 63 characters.

      {% endnote %}

      Where:

      * `--greenplum-version`: {{ GP }} version.
      * `--environment`: Environment:
         * `PRODUCTION`: For stable versions of your apps.
         * `PRESTABLE`: For testing, including the {{ GP }} service itself. The Prestable environment is first updated with new features, improvements, and bug fixes. However, not every update ensures backward compatibility.
      * `--network-name`: [Name of the network](../../vpc/concepts/network.md#network).
      * `--user-name`: Username. It may contain Latin letters, numbers, hyphens, and underscores, but must start with a letter, a number, or an underscore. It can be between 1 and 32 characters long.
      * `--user-password`: Password, which must be from 8 to 128 characters long.
      * `--master-config` and `--segment-config`: Master and segment host configurations:
         * `resource-id`: [Host class](../concepts/instance-types.md).
         * `disk-size`: Storage size in GB.
         * `disk-type`: The [type of disk](../concepts/storage.md):
            * `network-hdd`
            * `network-ssd`
            * `local-ssd`
            * `network-ssd-nonreplicated`

      * `zone-id`: [Availability zone](../../overview/concepts/geo-scope.md).
      * `subnet-id`: [Subnet ID](../../vpc/concepts/network.md#subnet). It is required if the selected availability zone includes 2 or more subnets.
      * `--assign-public-ip`: The flag that is specified if the hosts need a [public IP address](../../vpc/concepts/address.md#public-addresses).
      * `--security-group-ids`: list of [security group](../../vpc/concepts/security-groups.md) IDs.
      * `--deletion-protection`: Cluster deletion protection.


           {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

   1. To set a backup start time, pass the desired value in `HH:MM:SS` format in `--backup-window-start`:

      ```bash
      {{ yc-mdb-gp }} cluster create <cluster name> \
         ...
         --backup-window-start=<backup start time>
      ```

   
   1. To create a cluster deployed on groups of [dedicated hosts](../../compute/concepts/dedicated-host.md), specify host IDs as a comma-separated list in the `--host-group-ids` parameter:

      ```bash
      {{ yc-mdb-gp }} cluster create <cluster name> \
         ...
         --host-group-ids=<IDs of groups of dedicated hosts>
      ```

      {% include [Dedicated hosts note](../../_includes/mdb/mgp/note-dedicated-hosts.md) %}


   1. To set up a [maintenance window](../concepts/maintenance.md) (including for disabled clusters), pass the required value in the `--maintenance-window` parameter when creating your cluster:

      ```bash
      {{ yc-mdb-gp }} cluster create <cluster name> \
         ...
         --maintenance-window type=<maintenance type: anytime or weekly>,`
                             `day=<day of week for weekly>,`
                             `hour=<hour for weekly>
      ```

      Where:

      * `type`: Maintenance type:
         * `anytime`: Any time.
         * `weekly`: On a schedule.
      * `day`: Day of the week in `DDD` format for `weekly`. For example, `MON`.
      * `hour`: Hour in `HH` format for `weekly`. For example, `21`.

   1. To allow access from [{{ datalens-full-name }}](../../datalens/concepts/index.md) or [{{ data-transfer-full-name }}](../../data-transfer/), pass the `true` value in the corresponding parameters when creating a cluster:

      ```bash
      {{ yc-mdb-gp }} cluster create <cluster name> \
         ...
         --datalens-access=<access from {{ datalens-full-name }}: true or false> \
         --datatransfer-access=<access from {{ data-transfer-full-name }}: true or false>
      ```

- {{ TF }}

      {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   To create a cluster:

   1. Using the command line, navigate to the folder that will contain the {{ TF }} configuration files with an infrastructure plan. Create the directory if it does not exist.

   
   1. If you don't have {{ TF }} yet, [install it and create a configuration file with provider settings](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   2. Create a configuration file describing the [cloud network](../../vpc/concepts/network.md#network) and [subnets](../../vpc/concepts/network.md#subnet).

      The cluster is hosted on a cloud network. If you already have a suitable network, you don't need to describe it again.

      Cluster hosts are located on subnets of the selected cloud network. If you already have suitable subnets, you don't need to describe them again.

      Example structure of a configuration file that describes a cloud network with a single subnet:

      ```hcl
      resource "yandex_vpc_network" "<network name in {{ TF }}>" { name = "<network name>" }

      resource "yandex_vpc_subnet" "<name of subnet in {{ TF }}>" {
        name           = "<subnet name>"
        zone           = "<availability zone>"
        network_id     = yandex_vpc_network.<network name in {{ TF }}>.id
        v4_cidr_blocks = ["<subnet>"]
      }
      ```


   1. Create a configuration file with a description of the cluster and its hosts.

      Example of the configuration file structure:

      
      ```hcl
      resource "yandex_mdb_greenplum_cluster" "<cluster name in {{ TF }}>" {
        name                = "<cluster name>"
        environment         = "<environment>"
        network_id          = yandex_vpc_network.<network name in {{ TF }}>.id
        zone                = "<availability zone>"
        subnet_id           = yandex_vpc_subnet.<network name in {{ TF }}>.id
        assign_public_ip    = <getting a public IP: true or false>
        deletion_protection = <cluster deletion protection: true or false>
        version             = "<{{ GP }} version>"
        master_host_count   = <number of master hosts: 1 or 2>
        segment_host_count  = <number of segment hosts: from 2 to 32>
        segment_in_host     = <number of segments per host>

        master_subcluster {
          resources {
            resource_preset_id = "<host class>"
            disk_size          = <storage size, GB>
            disk_type_id       = "<disk type>"
          }
        }

        segment_subcluster {
          resources {
            resource_preset_id = "<host class>"
            disk_size          = <storage size, GB>
            disk_type_id       = "<disk type>"
          }
        }

        user_name     = "<username>"
        user_password = "<password>"

        security_group_ids = ["<list of security group IDs>"]
      }
      ```


      Cluster deletion protection will not prevent a manual connection to delete the contents of a database.

      For more information on resources that you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-mgp }}).

   1. Check the {{ TF }} configuration files for errors:

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Create a cluster:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

- API

   Use the [create](../api-ref/Cluster/create.md) API method and include the following information in the request:

   * ID of the folder where the cluster should be placed, in the `folderId` parameter.
   * Cluster name in the `name` parameter.
   * Cluster environment in the `environment` parameter.
   * {{ GP }} version in the `config.version` parameter.
   * Username in the `userName` parameter.
   * User password in the `userPassword` parameter.
   * Network ID in the `networkId` parameter.
      * [Security group](../concepts/network.md#security-groups) identifiers, in the `securityGroupIds` parameter.
   * Configuration of master hosts, in the `masterConfig` parameter.
   * Configuration of segment hosts, in the `segmentConfig` parameter.

   If necessary, pass additional cluster settings:

   * Public access settings, in the `assignPublicIp` parameter.
   * Backup window settings, in the `config.backupWindowStart` parameter.
   * Settings for access from [{{ datalens-full-name }}](../../datalens/concepts/index.md), in the `config.access.dataLens` parameter.
   * Settings for access from [{{ data-transfer-full-name }}](../../data-transfer/), in the `config.access.dataTransfer` parameter.
   * Settings for the [maintenance window](../concepts/maintenance.md) (including for disabled clusters) in the `maintenanceWindow` parameter.
   * [DBMS settings](../concepts/settings-list.md#dbms-cluster-settings) in the `configSpec.greenplumConfig_<version>` parameter.
   * Cluster deletion protection settings in the `deletionProtection` parameter.

      {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

{% endlist %}

## Examples {#examples}

### Creating an cluster {#create-example}

{% list tabs %}

- CLI

   Create a {{ mgp-name }} cluster with test characteristics:

   
   * Named `gp-cluster`.
   * Versions `{{ versions.cli.latest }}`.
   * In the `PRODUCTION` environment.
   * In the `default` network.
   * With the `user1` user.
   * With the password `user1user1`.
   * With master and segment hosts:

      * `S2.medium` class.
      * With 100 GB of local SSD storage (`local-ssd`).

   * In the `{{ region-id }}-a` availability zone, in the `{{ subnet-id }}` subnet.
   * With public access to hosts.
   * In the security group `{{ security-group }}`.
   * With protection against accidental cluster deletion.


   Run the following command:

   
   ```bash
   {{ yc-mdb-gp }} cluster create \
      --name=gp-cluster \
      --sqlserver-version={{ versions.cli.latest }} \
      --environment=PRODUCTION \
      --network-name=default \
      --user-name=user1 \
      --user-password=user1user1 \
      --master-config resource-id=s2.medium,`
                     `disk-size=100,`
                     `disk-type=local-ssd \
      --segment-config resource-id=s2.medium,`
                      `disk-size=100,`
                      `disk-type=local-ssd \
      --zone-id={{ region-id }}-a \
      --subnet-id={{ subnet-id }} \
      --assign-public-ip=true \
      --security-group-ids={{ security-group }} \
      --deletion-protection=true
   ```


{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
