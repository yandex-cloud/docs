# Creating an instance group from a {{ coi }} with multiple Docker containers

You can create an instance group built on a [{{ coi }}](../../cos/concepts/index.md) with multiple {% if lang == "ru" %}[Docker containers](https://cloud.yandex.ru/blog/posts/2022/03/docker-containers){% else %}Docker containers{% endif %} inside.

Docker containers are created based on the [Docker Compose specification](../../cos/concepts/coi-specifications.md#compose-spec).

{% include [warning.md](warning.md) %}

## Before you begin {#before-you-begin}

{% include [cli-install.md](../cli-install.md) %}

{% include [default-catalogue.md](../default-catalogue.md) %}

## Prepare the environment {#prepare}

1. Create a [service account](../../iam/concepts/users/service-accounts.md) with the name `group-coi` and assign it the `editor` role:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select a folder where you wish to create a service account.
      1. Go to the **Service accounts** tab.
      1. Click **Create service account**.
      1. Enter the name: `group-coi`.
      1. To assign the service account a [role](../../iam/concepts/access-control/roles.md) for the current folder, click **Add role** and select the role `editor`.
      1. Click **Create**.

   - CLI

      1. Create a service account:

         ```bash
         yc iam service-account create --name group-coi
         ```

         Result:

         ```bash
         id: ajeabccde01d23efl1v5
         folder_id: b0g12ga82bcv0cdeferg
         created_at: "2021-02-08T14:32:18.900092Z"
         name: group-coi
         ```

      1. Assign the role to the service account:

         ```bash
         yc resource-manager folder add-access-binding b0g12ga82bcv0cdeferg \
           --role editor \
           --subject serviceAccount:ajeabccde01d23efl1v5
         ```

   - API

      Use the [Create](../../iam/api-ref/ServiceAccount/create.md) method for the `ServiceAccount` resource.

   {% endlist %}

1. Create a [network](../../vpc/concepts/network.md#network) named `yc-auto-network` and [subnet](../../vpc/concepts/network.md#subnet) in [availability zone](../../overview/concepts/geo-scope.md):

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where you want to create a network.
      1. Select **{{ vpc-name }}**.
      1. Click **Create network**.
      1. Enter the network name `yc-auto-network`.
      1. Select the additional option **Create subnets**.
      1. Click **Create network**.

   - CLI

      1. Create a network:

         ```bash
         yc vpc network create --name yc-auto-network
         ```

         Result:

         ```bash
         id: enpabce123hde4ft1r3t
         folder_id: b0g12ga82bcv0cdeferg
         created_at: "2020-11-30T14:57:15Z"
         name: yc-auto-network
         ```

      1. Create a subnet in the `{{ region-id }}-a` zone:

         ```bash
         yc vpc subnet create --network-id enpabce123hde4ft1r3t --range 192.168.1.0/24 --zone {{ region-id }}-a
         ```

         Result:

         ```bash
         id: e1lnabc23r1c9d0efoje
         folder_id: b0g12ga82bcv0cdeferg
         created_at: "2020-11-30T16:23:12Z"
         network_id: enpabce123hde4ft1r3t
         zone_id: {{ region-id }}-a
         v4_cidr_blocks:
         - 192.168.1.0/24
         ```

   - API

      1. Create a network using the method [Create](../../vpc/api-ref/Network/create.md) for the `Networks` resource.
      1. Create a subnet in the `{{ region-id }}-a` availability zone using the [Create](../../vpc/api-ref/Subnet/create.md) method for the `Subnets` resource.

   {% endlist %}

## Create an instance group from a {{ coi }} with multiple Docker containers {#create}

1. {% include [get-latest-coi](../container-registry/get-latest-coi.md) %}

1. Save the specification of the instance group with the {{ coi }} and multiple Docker containers to a file named `specification.yaml`:

   ```yaml
   name: group-coi-containers # The instance group name that must be unique within the folder.
   service_account_id: ajeabccde01d23efl1v5 # Service account ID.
   instance_template:
     service_account_id: ajeabccde01d23efl1v5 # ID of the service account to access private Docker images.
     platform_id: standard-v3 # Platform ID.
     resources_spec:
       memory: 2G # Amount of memory (RAM).
       cores: 2 # Number of processor cores (vCPUs).
     boot_disk_spec:
       mode: READ_WRITE # Disk access mode (read and write).
       disk_spec:
         image_id: <ID of latest COI version>
         type_id: network-hdd # Disk type.
         size: 32G # Disk size.
     network_interface_specs:
      - network_id: enpabce123hde4ft1r3t # Network ID.
        subnet_ids:
          - e1lnabc23r1c9d0efoje # Subnet ID.
        primary_v4_address_spec: {
          one_to_one_nat_spec: {
            ip_version: IPV4 # IPv4 specification for public access to the VM.
          }
        }
              metadata: # Values to pass to the VM metadata.
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
      ssh-keys: | # Parameter for sending an SSH key to the VM.
        yc-user:ssh-ed25519 ABC...d01 user@desktop.ru # Username for the VM connection.
   deploy_policy: # Deployment policy for instances in the group.
     max_unavailable: 1
     max_expansion: 0
   scale_policy: # Scaling policy for instances in the group.
     fixed_scale:
       size: 2
   allocation_policy: # Allocation policy of the instances by zones and regions.
     zones:
       - zone_id: {{ region-id }}-a
   ```

   {% note info %}

   You can send an SSH key to the [VM metadata](../../compute/concepts/vm-metadata.md#keys-processed-in-public-images) using the `ssh-keys` parameter or in the `user-data` string with the user metadata. This tutorial uses the first option.

   {% endnote %}

1. Create an instance group named `group-coi-containers` using the specification `specification.yaml`:

   {% list tabs %}

   - CLI

      Run the command:

      ```bash
      yc compute instance-group create --file=specification.yaml
      ```

      Result:

      ```bash
      done (48s)
      id: cl0q12abcd4ef8m966de
      folder_id: b0g12ga82bcv0cdeferg
      ...
        target_size: "2"
      service_account_id: ajeabccde01d23efl1v5
      status: ACTIVE
      ```

   - API

     Use the [CreateFromYaml](../../compute/api-ref/InstanceGroup/createFromYaml.md) method for the `InstanceGroup` resource.

   {% endlist %}

1. Make sure that the instance group from the {{ coi }} and with multiple Docker containers was created:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where you created the instance group.
      1. Select **{{ compute-name }}**.
      1. Go to **Instance groups**.
      1. Click the `group-coi-containers` instance group name.

   - CLI

      ```bash
      yc compute instance-group list-instances group-coi-containers
      ```

      Result:

      ```bash
      +----------------------+---------------------------+----------------+-------------+------------------------+----------------+
      |     INSTANCE ID      |           NAME            |  EXTERNAL IP   | INTERNAL IP |         STATUS         | STATUS MESSAGE |
      +----------------------+---------------------------+----------------+-------------+------------------------+----------------+
      | fhmabcv0de123fo50d0b | cl0q12abcs4gq8m966de-fmar | 84.201.128.110 | 10.130.0.14 | RUNNING_ACTUAL [2h35m] |                |
      | fhmab0cdqj12tcv18jou | cl0q12abcs4gq8m966de-fqeg | 84.252.131.221 | 10.130.0.47 | RUNNING_ACTUAL [2h35m] |                |
      +----------------------+---------------------------+----------------+-------------+------------------------+----------------+
      ```

   - API

     View a list of created instances using the [List](../../compute/api-ref/InstanceGroup/list.md) method for the `InstanceGroup` resource.

   {% endlist %}

## Test the instance group based on the {{ coi }} with multiple Docker containers {#check}

1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to one of the instances via {% if lang == "ru" and audience != internal %}[SSH](../../glossary/ssh-keygen.md){% else %}SSH{% endif %}:

   {% list tabs %}

   - CLI

      ```bash
      ssh yc-user@84.201.128.110
      ```

      Result:

      ```bash
      Welcome to Ubuntu 20.04.1 LTS (GNU/Linux 5.4.0-54-generic x86_64)

       * Documentation:  https://help.ubuntu.com
       * Management:     https://landscape.canonical.com
       * Support:        https://ubuntu.com/advantage
      Last login: Mon Feb  8 15:23:28 2021 from 123.456.789.101
      ```

   {% endlist %}

1. View a list of Docker containers running on the VM:

   {% list tabs %}

   - CLI

      ```bash
      sudo docker ps -a
      ```

      Result:

      ```bash
      CONTAINER ID   IMAGE   COMMAND                  CREATED              STATUS              PORTS                NAMES
      c0a125a1765a   redis   "docker-entrypoint.s…"   About a minute ago   Up About a minute   6379/tcp             redis
      01288d7e382f   nginx   "/docker-entrypoint.…"   About a minute ago   Up About a minute   0.0.0.0:80->80/tcp   nginx
      ```

   {% endlist %}
