# Running a Docker image on a VM


This example describes the steps required to run a Docker image on a VM using a registry.

1. Create a service account and assign it the role `container-registry.images.puller` for the registry from the [example](../quickstart/index.md):

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select a folder where you wish to create a service account.
      1. Go to the **Service accounts** tab.
      1. Click **Create service account**.
      1. Enter the service account name and click **Create**.
      1. In the list of services, select **{{ container-registry-name }}**.
      1. To the right of the registry name, click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) and select **Configure ACL**.
      1. In the window that opens, select the service account and click **Add**.
      1. In the **Permissions** drop-down list, select the role `container-registry.images.puller`.
      1. Click **Save**.

   - CLI

      1. Create a service account:

         {% include [cli-install](../../_includes/cli-install.md) %}

         {% include [default-catalogue](../../_includes/default-catalogue.md) %}

         ```bash
         yc iam service-account create --name service-acc
         ```

         Result:

         ```bash
         id: ajelabcde12f33nol1v5
         folder_id: b0g12ga82bcv0cdeferg
         created_at: "2020-11-30T14:32:18.900092Z"
         name: service-acc
         ```

      1. Assign the role to the service account:

         ```bash
         yc <service name> <resource> add-access-binding <resource name>|<resource ID> \
           --role <role ID> \
           --subject serviceAccount:<service account ID>
         ```

         Where:

         * `<service name>`: Name of a `container` service.
         * `<resource>`: Category of the `registry` resource.
         * `<resource name>`: Name of the resource that the role is assigned for. You can specify a resource by its name or ID.
         * `<resource ID>`: ID of the `crpc9qeoft236r8tfalm` registry the role is assigned for.
         * `<role ID>`: ID of the `container-registry.images.puller` role.
         * `<service account ID>`: ID of the `ajelabcde12f33nol1v5` service account that is assigned the role.

   - API

      Use the `updateAccessBindings` method for the `registry` resource.

   {% endlist %}

1. Create a VM with a public IP address and link the service account you created to it:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder to create your VM in.
      1. In the list of services, select **{{ compute-name }}**.
      1. Click **Create VM**.
      1. Under **Basic parameters**:
         * Enter a name and description for the VM. Naming requirements:

            {% include [name-format](../../_includes/name-format.md) %}

            {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

         * Select the recently created [service account](../../iam/concepts/users/service-accounts.md).
         * Select an [availability zone](../../overview/concepts/geo-scope.md) to place the VM in.
      1. Under **Images from {{ marketplace-name }}**, select an [image](../../compute/operations/images-with-pre-installed-software/get-list.md) and a Linux-based OS version.
      1. (optional) Configure the boot disk under **Disks**:
         * Specify the necessary disk size.
         * Select the [disk type](../../compute/concepts/disk.md#disks_types).

            If you wish to create a VM from an existing disk, under **Disks**, [add a disk](../../compute/operations/vm-create/create-from-disks.md).
      1. Under **Computing resources**:
         * Choose a [platform](../../compute/concepts/vm-platforms.md).
         * Specify the [guaranteed share](../../compute/concepts/performance-levels.md) and the required number of vCPUs, as well as the amount of RAM.
         * If required, make your VM [preemptible](../../compute/concepts/preemptible-vm.md).
      1. Under **Network settings**:
         * Enter a subnet ID or select a [cloud network](../../vpc/concepts/network.md#network) from the list. If you don't have a network, click **Create a new network** to create one:
            * In the window that opens, enter a name for the new network and choose a subnet to connect the VM to. Each network should have a minimum of one [subnet](../../vpc/concepts/network.md#subnet) (if there are no subnets, create one). Then click **Create**.
         * In the **Public IP** field, choose a method for assigning an IP address:
            * **Auto**: Assign a random IP address from the {{ yandex-cloud }} IP pool.
            * **List**: Select a public IP address from the list of previously reserved static addresses. For more information, see [{#T}](../../vpc/operations/set-static-ip.md).
            * **No address**: Don't assign a public IP address.

         * (optional) Enable [DDoS protection](../../vpc/ddos-protection/).

      1. Under **Access**, specify the information required to access the instance:
         * Enter the username in the **Login** field.

            {% note alert %}

            Don't use the username `root` or other names reserved by the operating system. To perform operations that require superuser permissions, use the command `sudo`.

            {% endnote %}

         * In the **SSH key** field, paste the contents of the [public key](../../compute/operations/vm-connect/ssh#creating-ssh-keys) file.
      1. Click **Create VM**.

   - CLI

      1. View a description of the CLI create VM command:

         ```bash
         yc compute instance create --help
         ```

      1. Prepare the key pair (public and private keys) for SSH access to the VM.
      1. Select in the {{ marketplace-name }} a public [image](../../compute/operations/images-with-pre-installed-software/get-list.md) based on a Linux OS (for example, [CentOS 7](/marketplace/products/yc/centos-7)).

         {% include [standard-images](../../_includes/standard-images.md) %}

      1. Select a subnet:

         ```bash
         yc vpc subnet list
         ```

         Result:

         ```bash
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
           --ssh-key ~/.ssh/id_rsa.pub
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
         * `service-account-name`: The name of the service account created in the previous step.

         A VM called `first-instance` will be created.

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
             "user-data": "#cloud-config\nusers:\n  - name: user\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ssh-rsa AAAAB3N... user@example.com"
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

1. Add variables for convenience:
   * Your VM's public IP address in `${PUBLIC_IP}`:

      ```bash
      export PUBLIC_IP=<username>@<VM_public_IP_address>
      ```

   * Registry ID from the [example](../quickstart/index.md) in the `${REGISTRY_ID}` variable:

      ```bash
      export REGISTRY_ID=crpc9qeoft236r8tfalm
      ```

1. Log in to the registry under your username:

   {% list tabs %}

   - With an OAuth token

   1. If you don't have an OAuth token, get one by following this [link]({{ link-cloud-oauth }}).
   1. Run the command:

      ```bash
      echo <oauth token> | docker login --username oauth --password-stdin {{ registry }}
      ```

      Result:

      ```bash
      Login Succeeded
      ```

      
   - Using an IAM token

      {% note info %}

      {% include [iam-token-note](../../_includes/iam/iam-token-note.md) %}

      {% endnote %}

      1. [Get](../../iam/operations/iam-token/create.md) an IAM token.
      1. Run the command:

         ```bash
         yc iam create-token | docker login --username iam --password-stdin {{ registry }}
         ```

         Result:

         ```bash
         Login succeeded
         ```

   - Using a Docker Credential helper

      1. If you don't have a YC CLI profile yet, [create one](../../cli/quickstart.md#initialize).
      1. Configure Docker to use `docker-credential-yc`:

         ```bash
         yc container registry configure-docker
         ```

         Result:

         ```bash
         Credential helper is configured in '/home/<user>/.docker/config.json'
         ```

         Settings are saved in the current user's profile.

         {% note warning %}

         The Credential helper only works when using Docker without `sudo`. Configuring Docker to run as the current user without using `sudo` is described in the [official documentation](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user).

         {% endnote %}

      1. Make sure that Docker is configured.

         The `/home/<user>/.docker/config.json` configuration file must include the following line:

         ```json
         "{{ registry }}": "yc"
         ```

      1. You can now use Docker, for example, to [push Docker images](../operations/docker-image/docker-image-push.md). You don't need to run `docker login` for that.

   {% endlist %}

1. Create a file named Dockerfile and add the following lines to it:

   ```bash
   FROM ubuntu:latest
   CMD echo "Hi, I'm inside"
   ```

1. Build a Docker image:

   ```bash
   docker build . -t {{ registry }}/${REGISTRY_ID}/ubuntu:hello
   ```

1. Push the built Docker image to {{ container-registry-name }}:

   ```bash
   docker push {{ registry }}/${REGISTRY_ID}/ubuntu:hello
   ```

   Result:

   ```bash
   The push refers to repository [{{ registry }}/crpc9qeoft236r8tfalm/ubuntu]
   cc9d18e90faa: Pushed
   0c2689e3f920: Pushed
   47dde53750b4: Pushed
   hello: digest: sha256:42068479274f1d4c7ea095482430dcba24dcfe8c23ebdf6d32305928e55071cf size: 943
   ```

1. [Log in to the VM via SSH](../../compute/operations/vm-connect/ssh.md#vm-connect) and authenticate as the service account associated with this machine:

   ```bash
   ssh ${PUBLIC_IP} \
   curl -H Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token | cut -f1 -d',' | cut -f2 -d':' | tr -d '"' | sudo docker login --username iam --password-stdin {{ registry }}
   ```

   Result:

   ```bash
   Login succeeded
   ```

1. Download the Docker image to the VM:

   ```bash
   ssh ${PUBLIC_IP} docker pull {{ registry }}/${REGISTRY_ID}/ubuntu:hello
   ```

   Result:

   ```bash
   hello: Pulling from crpc9qeoft236r8tfalm/ubuntu
   6a5697faee43: Pulling fs layer
   ba13d3bc422b: Pulling fs layer
   ...
   Digest: sha256:42068479274f1d4c7ea095482430dcba24dcfe8c23ebdf6d32305928e55071cf
   Status: Downloaded newer image for {{ registry }}/crpc9qeoft236r8tfalm/ubuntu:hello
   {{ registry }}/crpc9qeoft236r8tfalm/ubuntu:hello
   ```

1. Run the Docker image on the VM:

   ```bash
   ssh ${PUBLIC_IP} docker run {{ registry }}/${REGISTRY_ID}/ubuntu:hello
   ```

   Result:

   ```bash
   Hi, I'm inside
   ```
