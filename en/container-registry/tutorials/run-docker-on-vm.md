# Running a Docker image on a VM

This tutorial describes the steps required to run a [Docker image](../../container-registry/concepts/docker-image.md) on a [VM](../../compute/concepts/vm.md) using the [{{ cos-full-name }}](../../cos/) registry.

To run a Docker image on a VM using the registry:
1. [Prepare your cloud](#before-begin).
1. [Create a service account](#create-sa).
1. [Create a VM](#create-vm).
1. [Build and upload the Docker image to {{ container-registry-name }}](#create-image).
1. [Download the Docker image to a VM](#run).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).

You can also deploy an infrastructure for running a Docker image on a VM via {{ TF }} using a [ready-made configuration file](#terraform).

## Getting started {#before-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of this infrastructure includes:
* Fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using a dynamic or static [external IP address](../../vpc/concepts/address.md) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* A fee for storing the Docker image in the registry and for outgoing traffic (see [{{ cos-full-name }} pricing](../../cos/pricing.md)).


### Configure the environment {#prepare}

1. [Install](../../cli/operations/install-cli.md) the {{ yandex-cloud }} command line interface.
1. [Prepare](../../compute/operations/vm-connect/ssh.md) an SSH key for VM access.
1. [Create](../../container-registry/operations/registry/registry-create.md) a registry in {{ cos-name }} to store the Docker image.
1. [Install](https://www.docker.com) Docker.

## Create a service account {#create-sa}

1. Create a [service account](../../iam/concepts/users/service-accounts.md) and grant it the `container-registry.images.puller` [role](../../iam/concepts/access-control/roles.md) for the previously created registry:

   {% list tabs %}

   - Management console

     1. In the [management console]({{ link-console-main }}), select a folder where you wish to create a service account.
     1. Go to the **Service accounts** tab.
     1. Click **Create service account**.
     1. Enter the service account name and click **Create**.
     1. In the list of services, select **{{ container-registry-name }}**.
     1. Select the registry and click the row with its name.
     1. Click the **Access bindings** tab.
     1. In the top right-hand corner, click **Assign roles**.
     1. Click **+ Select subject** and add the service account by supplying its ID.
     1. Click **Add role** and select `container-registry.images.puller`.
     1. Click **Save**.

   - CLI

     {% include [cli-install](../../_includes/cli-install.md) %}

     1. View a description of the CLI command to create a service account:

        ```bash
        yc iam service-account create --help
        ```

     1. Create a service account:

        {% include [default-catalogue](../../_includes/default-catalogue.md) %}

        ```bash
        yc iam service-account create --name <service_account_name>
        ```

        Result:

        ```text
        id: ajelabcde12f33nol1v5
        folder_id: b0g12ga82bcv0cdeferg
        created_at: "2020-11-30T14:32:18.900092Z"
        name: myservice-acc
        ```

     1. Assign the role to the service account:

        ```bash
        yc <service_name> <resource> add-access-binding <resource_name>|<resource_ID> \
          --role <role_ID> \
          --subject serviceAccount:<service_account_ID>
        ```

        Where:
        * `<service_name>`: `container` service name.
        * `<resource>`: Category of the `registry` resource.
        * `<resource_name>`: Name of the resource to grant the role to. You can specify a resource by its name or ID.
        * `<resource_ID>`: `crpc9qeoft236r8tfalm` registry ID to assign the role to.
        * `<role_ID>`: `container-registry.images.puller` role ID.
        * `<service_account_ID>`: ID of the service account (such as `ajelabcde12f33nol1v5`) being granted the role.

   - {{ TF }}

      See section [{#T}](#terraform).

   - API

     Use the `updateAccessBindings` method for the `registry` resource.

   {% endlist %}

## Create a VM {#create-vm}

1. Create a VM with a public IP address and link the service account you created to it:

   {% list tabs %}

   - Management console

     1. In the [management console]({{ link-console-main }}), select the folder to create your VM in.
     1. In the list of services, select **{{ compute-name }}**.
     1. Click **Create VM**.
     1. Under **Basic parameters**:
        * Enter a name and description for the VM. The naming requirements are as follows:

          {% include [name-format](../../_includes/name-format.md) %}

          {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

        * Select the recently created [service account](../../iam/concepts/users/service-accounts.md).
        * Select an [availability zone](../../overview/concepts/geo-scope.md) to place the VM in.
     1. Under **Images from {{ marketplace-name }}**, select an [image](../../compute/operations/images-with-pre-installed-software/get-list.md) and a Linux-based OS version.
     1. (optional) Configure the boot disk under **Disks**:
        * Specify the required [disk](../../compute/concepts/disk.md) size.
        * Select the [disk type](../../compute/concepts/disk.md#disks_types).

          If you wish to create a VM from an existing disk, under **Disks**, [add a disk](../../compute/operations/vm-create/create-from-disks.md).
     1. Under **Computing resources**:
        * Choose a [platform](../../compute/concepts/vm-platforms.md).
        * Specify the [guaranteed share](../../compute/concepts/performance-levels.md) and the required number of vCPUs, as well as the amount of RAM.
        * If required, make your VM [preemptible](../../compute/concepts/preemptible-vm.md).
     1. Under **Network settings**:
        * Enter a subnet ID or select a [cloud network](../../vpc/concepts/network.md#network) from the list. If you don't have a network, click **Create a new network** to create one:
          * In the window that opens, enter a name for the new network and choose a subnet to connect the VM to. Each network should have a minimum of one [subnet](../../vpc/concepts/network.md#subnet) (if there are no subnets, create one). and click **Create**.
        * In the **Public IP** field, choose a method for assigning an IP address:
          * **Auto**: Assign a random IP address from the {{ yandex-cloud }} IP pool.
          * **List**: Select a public IP address from the list of previously reserved static addresses. For more information, see [{#T}](../../vpc/operations/set-static-ip.md).
          * **No address**: Do not assign a public IP address.


          * (optional) Enable [DDoS protection](../../vpc/ddos-protection/).


     1. Under **Access**, specify the information required to access the instance:
        * Enter the username in the **Login** field.

          {% note alert %}

          Do not use the `root` username or other names reserved by the operating system. To perform operations that require superuser permissions, use the `sudo` command.

          {% endnote %}

        * In the **SSH key** field, paste the contents of the [public key](../../compute/operations/vm-connect/ssh#creating-ssh-keys) file.
     1. Click **Create VM**.

   - CLI

     1. View a description of the CLI create VM command:

        ```bash
        yc compute instance create --help
        ```

     1. Prepare the key pair (public and private keys) for SSH access to the VM.
     1. Select in {{ marketplace-name }} a public [image](../../compute/operations/images-with-pre-installed-software/get-list.md) based on a Linux OS (for example, [CentOS 7](/marketplace/products/yc/centos-7)).

        {% include [standard-images](../../_includes/standard-images.md) %}

     1. View a list of available subnets:

        ```bash
        yc vpc subnet list
        ```

        Result:

        ```text
        +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
        |          ID          |           NAME            |      NETWORK ID      | ROUTE TABLE ID |       ZONE        |      RANGE      |
        +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
        | b0c6n43f9lgh3695v2k2 | default-{{ region-id }}-c | enpe3m3fa00udao8g5lg |                | {{ region-id }}-c | [10.130.0.0/24] |
        | e2l2da8a20b33g7o73bv | default-{{ region-id }}-b | enpe3m3fa00udao8g5lg |                | {{ region-id }}-b | [10.129.0.0/24] |
        | e9bnlm18l70ao30pvfaa | default-{{ region-id }}-a | enpe3m3fa00udao8g5lg |                | {{ region-id }}-a | [10.128.0.0/24] |
        +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
        ```

     1. Create a VM in the default folder:

        ```bash
        yc compute instance create \
          --name first-instance \
          --zone {{ region-id }}-a \
          --network-interface subnet-name=default-{{ region-id }}-a,nat-ip-version=ipv4 \
          --create-boot-disk image-folder-id=standard-images,image-family=centos-7 \
          --ssh-key ~/.ssh/id_ed25519.pub
          --service-account-name service-acc
        ```

        Where:
        * `name`: VM name.

          {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

        * `zone`: Availability zone that corresponds to the selected subnet.
        * `subnet-name`: Name of the selected subnet.
        * `image-family`: An [image family](../../compute/concepts/image.md#family), such as `centos-7`. This option lets you install the latest version of the operating system from the specified family.
        * Public IP. To create a VM without a public IP address, disable the `nat-ip-version=ipv4` option.
        * `ssh-key`: Path to the public SSH key. The VM will automatically create a user named `yc-user` for this key.
        * `service-account-name`: Name of the service account created in the previous step.

        This will create a VM called `first-instance`.

   - {{ TF }}

     See section [{#T}](#terraform).

   - API

     Create a VM using the [Create](../../compute/api-ref/Instance/create.md) method for the `Instance` resource:
     1. Prepare the key pair (public and private keys) for SSH access to the VM.
     1. Get an [IAM token](../../iam/concepts/authorization/iam-token.md) used for authentication in the examples:


        * [Instructions](../../iam/operations/iam-token/create.md) for users with a Yandex account.


        * [Instructions](../../iam/operations/iam-token/create-for-sa.md) for a service account.
     1. [Get the ID](../../resource-manager/operations/folder/get-id.md) of the folder.
     1. Fetch information about the image to create your VM from (image ID and minimum disk size):
        * If you know the [image family](../../compute/concepts/image.md#family), get information about the latest image in this family:

          ```bash
          export IAM_TOKEN=CggaATEVAgA...
          export FAMILY=ubuntu-1804
          curl -H "Authorization: Bearer ${IAM_TOKEN}" \
            "https://compute.{{ api-host }}/compute/v1/images:latestByFamily?folderId=standard-images&family=${FAMILY}"
          ```

        * To learn more about the image, see the [list of public images](../../compute/operations/images-with-pre-installed-software/get-list.md).
     1. Get the subnet ID and availability zone ID. Specify the ID of the folder where the subnet was created in your request:

        ```bash
        export IAM_TOKEN=CggaATEVAgA...
        export FOLDER_ID=b1gvmob95yysaplct532
        curl -H "Authorization: Bearer ${IAM_TOKEN}" \
          "https://vpc.{{ api-host }}/vpc/v1/subnets?folderId=${FOLDER_ID}"
        {
          "subnets": [
            {
              "v4CidrBlocks": [
                "10.130.0.0/24"
              ],
            "id": "b0c6n43ftldh30l0vfg2",
            "folderId": "b1gvmob95yysaplct532",
            "createdAt": "2018-09-23T12:15:00Z",
            "name": "default-{{ region-id }}-a",
            "description": "Auto-created default subnet for zone {{ region-id }}-a",
            "networkId": "enpe3m3fagludao8aslg",
            "zoneId": "{{ region-id }}-a"
          },
          ...
          ]}
        ```

     1. Create a file named `body.json` with the body of the request to create a VM:

        ```json
        {
          "folderId": "b1gvmob95yysaplct532",
          "name": "instance-demo-no-pwauth",
          "zoneId": "{{ region-id }}-a",
          "platformId": "standard-v3",
          "resourcesSpec": {
            "memory": "2147483648",
            "cores": "2"
          },
          "metadata": {
            "user-data": "#cloud-config\nusers:\n  - name: user\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ssh-ed25519 AAAAB3N... user@example.com"
          },
          "bootDiskSpec": {
            "diskSpec": {
              "size": "2621440000",
              "imageId": "fd8rc75pn12fe3u2dnmb"
            }
          },
          "networkInterfaceSpecs": [
            {
              "subnetId": "b0c6n43ftldh30l0vfg2",
              "primaryV4AddressSpec": {
                "oneToOneNatSpec": {
                  "ipVersion": "IPV4"
                }
              }
            }
          ],
          "serviceAccountId": "ajelabcde12f33nol1v5"
        }
        ```

        Where:
        * `folderId`: ID of the folder.
        * `name`: Name to assign the VM on creation.
        * `zoneId`: Availability zone that corresponds to the selected subnet.
        * `platformId`: The [platform](../../compute/concepts/vm-platforms.md).
        * `resourceSpec`: Resources available to the VM. The values must match the selected platform.
        * `metadata`: In the metadata, pass the public key for VM access via SSH. For more information, see [{#T}](../../compute/concepts/vm-metadata.md).
        * `bootDiskSpec`: Boot disk settings. Specify the ID of the selected image and disk size. The disk size must not be below the minimum value specified in the image details.
        * `networkInterfaceSpecs`: Network setting.
          * `subnetId`: ID of the selected subnet.
          * `primaryV4AddressSpec`: IP address to assign to the VM. To add a [public IP](../../vpc/concepts/address.md#public-addresses) to your VM, specify:

            ```yaml
            "primaryV4AddressSpec": {
              "oneToOneNatSpec": {
                "ipVersion": "IPV4"
              }
            }
            ```

        * `serviceAccountId`: ID of the service account created in the previous step.

        Read more about the request body format in the [API reference](../../compute/api-ref/Instance/create.md).
     1. Create a VM:

        ```bash
        export IAM_TOKEN=CggaATEVAgA...
        curl -X POST \
          -H "Content-Type: application/json" \
          -H "Authorization: Bearer ${IAM_TOKEN}" \
          -d '@body.json' \
          https://compute.{{ api-host }}/compute/v1/instances
        ```

   {% endlist %}

## Build and upload the Docker image to {{ container-registry-name }} {#create-image}

1. To make command execution easier, add the following variables:
   * Username and your VM's public IP as `${PUBLIC_IP}`:

     ```bash
     export PUBLIC_IP=<username>@<VM_public_IP_address>
     ```

   * ID of the previously created registry in `crpc9qeoft236r8tfalm` format as `${REGISTRY_ID}`:

     ```bash
     export REGISTRY_ID=<registry_ID>
     ```

1. Authenticate as yourself:

   {% list tabs %}


   - Using an OAuth token

     1. If you do not have an OAuth token yet, get one by following [this link]({{ link-cloud-oauth }}).
     1. Run the following command:

        ```bash
        echo <oauth token> | docker login --username oauth --password-stdin {{ registry }}
        ```

        Result:

        ```text
        Login succeeded
        ```


   - Using an IAM token

     {% note info %}

     {% include [iam-token-note](../../_includes/iam/iam-token-note.md) %}

     {% endnote %}

     1. [Get](../../iam/operations/iam-token/create.md) an IAM token.
     1. Run the following command:

        ```bash
        yc iam create-token | docker login --username iam --password-stdin {{ registry }}
        ```

        Result:

        ```text
        ...
        Login succeeded
        ```

   - Using a Docker Credential helper

     1. If you don't have a YC CLI profile yet, [create one](../../cli/quickstart.md#initialize).
     1. Configure Docker to use `docker-credential-yc`:

        ```bash
        yc container registry configure-docker
        ```

        Result:

        ```text
        Credential helper is configured in '/home/<user>/.docker/config.json'
        ```

        Settings are saved in the current user's profile.

        {% note warning %}

        Credential helper only works when using Docker without `sudo`. You can learn how to configure Docker to run under current user without `sudo` in the [official documentation](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user).

        {% endnote %}

     1. Make sure that Docker is configured.

        The `/home/<user>/.docker/config.json` configuration file must include the following line:

        ```json
        "{{ registry }}": "yc"
        ```

     1. You can now use Docker, for example, to [push Docker images](../operations/docker-image/docker-image-push.md). You don't need to run `docker login` for that.

   {% endlist %}

1. Create a file called Dockerfile:

   ```bash
   touch .dockerfile
   ```

1. Open Dockerfile in a text editor, such as:

   ```bash
   nano .dockerfile
   ```

1. Add the lines below to the file:

   ```text
   FROM ubuntu:latest
   CMD echo "Hi, I'm inside"
   ```

1. Build a Docker image:

   ```bash
   docker build . -t {{ registry }}/${REGISTRY_ID}/ubuntu:hello -f .dockerfile
   ```

   Result:

   ```text
   ...
   Successfully built b68ee9b6b1af
   Successfully tagged {{ registry }}/crpmnjr98tm54bejc46m/ubuntu:hello
   ```

1. Push the built Docker image to {{ container-registry-name }}:

   ```bash
   docker push {{ registry }}/${REGISTRY_ID}/ubuntu:hello
   ```

   Result:

   ```text
   The push refers to repository [{{ registry }}/crpc9qeoft236r8tfalm/ubuntu]
   cc9d18e90faa: Pushed
   0c2689e3f920: Pushed
   47dde53750b4: Pushed
   hello: digest: sha256:42068479274f1d4c7ea095482430dcba24dcfe8c23ebdf6d32305928e55071cf size: 943
   ```

## Download the Docker image on the VM {#run}

1. [Use SSH to connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM.
1. [Authenticate](../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm) under the service account tied to the machine:

   ```bash
   curl -H Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token | \
   cut -f1 -d',' | \
   cut -f2 -d':' | \
   tr -d '"' | \
   sudo docker login --username iam --password-stdin {{ registry }}
   ```

   Result:

   ```text
   Login succeeded
   ```

1. Download the Docker image to the VM:

   ```bash
   docker pull {{ registry }}/${REGISTRY_ID}/ubuntu:hello
   ```

   Result:

   ```text
   hello: Pulling from crpc9qeoft236r8tfalm/ubuntu
   6a5697faee43: Pulling fs layer
   ba13d3bc422b: Pulling fs layer
   ...
   Digest: sha256:42068479274f1d4c7ea095482430dcba24dcfe8c23ebdf6d32305928e55071cf
   Status: Downloaded newer image for {{ registry }}/crpc9qeoft236r8tfalm/ubuntu:hello
   {{ registry }}/crpc9qeoft236r8tfalm/ubuntu:hello
   ```

## Check the result {#check-result}

Run the Docker image on the VM:

```bash
docker run {{ registry }}/${REGISTRY_ID}/ubuntu:hello
```

Result:

```text
Hi, I'm inside
```

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
* [Delete](../../compute/operations/vm-control/vm-delete.md) the VM.
* [Delete](../../vpc/operations/address-delete.md) the static public IP if you reserved one.
* [Delete](../../container-registry/operations/docker-image/docker-image-delete.md) the Docker image.
* [Delete](../../container-registry/operations/registry/registry-delete.md) the registry.

## How to create an infrastructure using {{ TF }} {#terraform}

{% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

To create an infrastructure for running a Docker image on a VM using the registry:
1. [Install](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) {{ TF }} and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Prepare a file with the infrastructure description:

   {% list tabs %}

   - Ready-made archive

     1. Create a directory for the file with the infrastructure description.
     1. Download the [archive](https://{{ s3-storage-host }}/doc-files/run-docker-on-vm-terraform.zip) (1.5 KB).
     1. Unpack the archive to the directory. As a result, it should contain the `run-docker-on-vm.tf` configuration file.

   - Creating files manually

     1. Create a directory for the file with the infrastructure description.
     1. In the directory, create a configuration file named `run-docker-on-vm.tf`:

        {% cut "Contents of the run-docker-on-vm.tf file" %}

        {% include [run-docker-on-vm-tf-config](../../_includes/container-registry/run-docker-on-vm-tf-config.md) %}

        {% endcut %}

   {% endlist %}

1. Under `locals`, set the parameters for resources to create:
   * `zone`: [Availability zone](../../overview/concepts/geo-scope.md) that will host the VM.
   * `username`: Name of a user to be created on the VM.
   * `ssh_key_path`: Path to the file with a public SSH key to authenticate the user on the VM. For details, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
   * `target_folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) to host the VM.
   * `registry_name`: {{ container-registry-name }} registry name.
   * `sa_name`: Service account name.
   * `network_name`: Name of the cloud network.
   * `subnet_name`: Name of the subnet.
   * `vm_name`: VM name.
   * `image_id`: ID of the image to create the VM from, such as `fd81hgrcv6lsnkremf32` for Ubuntu 20.04 LTS. For details, see [{#T}](../../compute/operations/images-with-pre-installed-software/get-list.md).
1. Create resources:

   {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

1. [{#T}](#create-image).
1. [{#T}](#run).
1. [{#T}](#check-result).
