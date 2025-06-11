# Creating an instance group from a {{ coi }} with multiple Docker containers

You can create an [instance group](../../compute/concepts/instance-groups/index.md) based on a [image](../../compute/concepts/image.md) [{{ coi }}](../../cos/concepts/index.md) with multiple Docker containers inside.

Docker containers are created based on the [Docker Compose](../../cos/concepts/coi-specifications.md#compose-spec) specification.

{% include [warning.md](../../_includes/instance-groups/warning.md) %}

## Getting started {#before-you-begin}

{% include [cli-install.md](../../_includes/cli-install.md) %}

{% include [default-catalogue.md](../../_includes/default-catalogue.md) %}

## Set up your environment {#prepare}

1. Create a [service account](../../iam/concepts/users/service-accounts.md) named `group-coi` and assign the `editor` [role](../../iam/concepts/access-control/roles.md) to it:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your service account.
     1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
     1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
     1. Enter the name: `group-coi`.
     1. To assign the service account the `editor` role for the current folder, click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select `editor`.
     1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

   - CLI {#cli}

     1. Create a service account:

        ```bash
        yc iam service-account create --name group-coi
        ```

        Result:

        ```text
        id: ajeabccde01d********
        folder_id: b0g12ga82bcv********
        created_at: "2023-03-13T14:32:18.900092Z"
        name: group-coi
        ```

     1. Assign the role to the service account:

        ```bash
        yc resource-manager folder add-access-binding b0g12ga82bcv******** \
          --role editor \
          --subject serviceAccount:ajeabccde01d********
        ```

   - API {#api}

     Use the [Create](../../iam/api-ref/ServiceAccount/create.md) method for the `ServiceAccount` resource.

   {% endlist %}

1. Create a [network](../../vpc/concepts/network.md#network) named `yc-auto-network` and a [subnet](../../vpc/concepts/network.md#subnet) in the same [availability zone](../../overview/concepts/geo-scope.md):

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the folder where you want to create your network.
     1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
     1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
     1. Enter the network name: `yc-auto-network`.
     1. Select the additional option: **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
     1. Click **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

   - CLI {#cli}

     1. Create a network:

        ```bash
        yc vpc network create --name yc-auto-network
        ```

        Result:

        ```text
        id: enpabce123hd********
        folder_id: b0g12ga82bcv********
        created_at: "2023-03-13T14:57:15Z"
        name: yc-auto-network
        ```

     1. Create a subnet in the `{{ region-id }}-a` availability zone:

        ```bash
        yc vpc subnet create --network-id enpabce123hd******** --range 192.168.1.0/24 --zone {{ region-id }}-a
        ```

        Result:

        ```text
        id: e1lnabc23r1c********
        folder_id: b0g12ga82bcv********
        created_at: "2023-03-13T16:23:12Z"
        network_id: enpabce123hd********
        zone_id: {{ region-id }}-a
        v4_cidr_blocks:
        - 192.168.1.0/24
        ```

   - API {#api}

     1. Create a network using the [Create](../../vpc/api-ref/Network/create.md) method for the `Networks` resource.
     1. Create a subnet in the `{{ region-id }}-a` availability zone using the [Create](../../vpc/api-ref/Subnet/create.md) method for the `Subnets` resource.

   {% endlist %}

## Create an instance group from a {{ coi }} with multiple Docker containers {#create}

1. {% include [get-latest-coi](../../_includes/container-registry/get-latest-coi.md) %}

1. Save the specification of the instance group with {{ coi }} and multiple Docker containers to the `specification.yaml` file:

   ```yaml
   name: group-coi-containers # VM group name, unique within the folder.
   service_account_id: ajeabccde01d******** # Service account ID.
   instance_template:
     service_account_id: ajeabccde01d******** # ID of the service account to access private Docker images.
     platform_id: standard-v3 # Platform ID.
     resources_spec:
       memory: 2G # Amount of memory (RAM).
       cores: 2 # Number of processor cores (vCPUs).
     boot_disk_spec:
       mode: READ_WRITE # Disk access mode (read and write).
       disk_spec:
         image_id: <latest_COI_version_ID>
         type_id: network-hdd # Disk type.
         size: 32G # Disk size. It must be at least 30 GB.
     network_interface_specs:
      - network_id: enpabce123hd******** # Network ID.
        subnet_ids:
          - e1lnabc23r1c******** # Subnet ID.
        primary_v4_address_spec: {
          one_to_one_nat_spec: {
            ip_version: IPV4 # IPv4 specification for public access to the VM.
          }
        }
     metadata: # Values to write to the VM metadata.
      docker-compose: |- # Key in the VM metadata that is used with the Docker Compose specification.
        version: '3.7'
        services:
          app1:
            container_name: nginx
            image: "nginx"
            ports:
              - "80:80"
            restart: always
          app2:
            container_name: redis
            image: "redis"
            restart: always
      ssh-keys: | # Parameter for providing an SSH key to the VM.
        yc-user:ssh-ed25519 ABC...d01 user@desktop.ru # Username for connecting to the VM.
   deploy_policy: # VM deployment policy for the group.
     max_unavailable: 1
     max_expansion: 0
   scale_policy: # Instance scaling policy for the group.
     fixed_scale:
       size: 2
   allocation_policy: # Instance allocation policy between availability zones.
     zones:
       - zone_id: {{ region-id }}-a
   ```

   {% note info %}

   You can provide an SSH key in the [VM metadata](../../compute/concepts/vm-metadata.md) using the `ssh-keys` parameter or in the `user-data` key with the user metadata. This tutorial uses the first option.

   {% endnote %}

1. Create an instance group named `group-coi-containers` using the `specification.yaml` specification:

   {% list tabs group=instructions %}

   - CLI {#cli}

     Run this command:

     ```bash
     yc compute instance-group create --file=specification.yaml
     ```

     Result:

     ```text
     done (48s)
     id: cl0q12abcd4e********
     folder_id: b0g12ga82bcv********
     ...
       target_size: "2"
     service_account_id: ajeabccde01d********
     status: ACTIVE
     ```

   - API {#api}

     Use the [CreateFromYaml](../../compute/instancegroup/api-ref/InstanceGroup/createFromYaml.md) method for the `InstanceGroup` resource.

   {% endlist %}

1. Make sure the instance group from the {{ coi }} and with multiple Docker containers was created:

   {% list tabs group=instructions %}

   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select the folder where you created the instance group.
     1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
     1. Navigate to **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
     1. Click the `group-coi-containers` instance group name.

   - CLI {#cli}

     ```bash
     yc compute instance-group list-instances group-coi-containers
     ```

     Result:

     ```text
     +----------------------+---------------------------+----------------------------------+-------------+------------------------+----------------+
     |     INSTANCE ID      |           NAME            |            EXTERNAL IP           | INTERNAL IP |         STATUS         | STATUS MESSAGE |
     +----------------------+---------------------------+----------------------------------+-------------+------------------------+----------------+
     | fhmabcv0de12******** | cl0q12abcs4g********-fmar | {{ external-ip-examples.0 }}                   | 10.130.0.14 | RUNNING_ACTUAL [2h35m] |                |
     | fhmab0cdqj12******** | cl0q12abcs4g********-fqeg | {{ external-ip-examples.1 }}                   | 10.130.0.47 | RUNNING_ACTUAL [2h35m] |                |
     +----------------------+---------------------------+----------------------------------+-------------+------------------------+----------------+
     ```

   - API {#api}

     View the list of created VM instances using the [List](../../compute/instancegroup/api-ref/InstanceGroup/list.md) method for the `InstanceGroup` resource.

   {% endlist %}

## Test the instance group based on the {{ coi }} with multiple Docker containers {#check}

1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to one of the instances via SSH.

   {% list tabs group=instructions %}

   - CLI {#cli}

     ```bash
     ssh yc-user@{{ external-ip-examples.0 }}
     ```

     Result:

     ```text
     Welcome to Ubuntu 20.04.1 LTS (GNU/Linux 5.4.0-54-generic x86_64)

      * Documentation:  https://help.ubuntu.com
      * Management:     https://landscape.canonical.com
      * Support:        https://ubuntu.com/advantage
     Last login: Mon Mar 13 15:23:28 2023 from 123.456.789.101
     ```

   {% endlist %}

1. View a list of Docker containers running on the VM:

   {% list tabs group=instructions %}

   - CLI {#cli}

     ```bash
     sudo docker ps -a
     ```

     Result:

     ```text
     CONTAINER ID  IMAGE  COMMAND                 CREATED             STATUS             PORTS               NAMES
     c0a125a1765a  redis  "docker-entrypoint.s…"  About a minute ago  Up About a minute  6379/tcp            redis
     01288d7e382f  nginx  "/docker-entrypoint.…"  About a minute ago  Up About a minute  0.0.0.0:80->80/tcp  nginx
     ```

   {% endlist %}