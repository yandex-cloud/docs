1. [Get your cloud ready](#before-you-begin).
1. [Create a registry in {{ container-registry-name }}](#create-registry).
1. [Create a service account](#create-sa).
1. [Create your {{ compute-name }} VM](#create-vm).
1. [Build and push the Docker image to {{ container-registry-name }}](#create-image).
1. [Upload the Docker image to the VM](#run).
1. [Check the result](#check-out).

If you no longer need the resources you created, [delete them](#clear-out).


## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/run-docker-on-vm/paid-resources.md) %}


### Create an SSH key pair {#create-ssh}

{% include [create-ssh](../_tutorials_includes/run-docker-on-vm/create-ssh.md) %}


### Install and configure Docker {#configure-docker}

{% include [configure-docker](../../_includes/container-registry/configure-docker.md) %}


## Create a registry in {{ container-registry-name }} {#create-registry}

[Create a registry](../../container-registry/operations/registry/registry-create.md) in {{ container-registry-name }}.

{% list tabs group=instructions %}

- Management console {#console}

  {% include [create-registry-console](../../_includes/container-registry/create-registry-console.md) %}

- CLI {#cli}

  {% include [create-registry-cli](../../_includes/container-registry/create-registry-cli.md) %}

- API {#api}

  {% include [create-registry-api](../../_includes/container-registry/create-registry-api.md) %}

{% endlist %}


## Create a service account {#create-sa}

Create a [service account](../../iam/concepts/users/service-accounts.md) and assign to it the `{{ roles-cr-puller }}` [role](../../iam/concepts/access-control/roles.md) for the registry created earlier:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your service account.
  1. At the top of the screen, navigate to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Enter `images-puller` as the service account name and click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
  1. At the top of the screen, navigate to the **{{ ui-key.yacloud.iam.folder.switch_dashboard }}** tab.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Select the registry and click the row with its name.
  1. Navigate to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
  1. In the top-right corner, click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.acl.update-dialog.button_select-subject }}** and add the service account by providing its ID.
  1. Click **{{ ui-key.yacloud.component.acl.update-dialog.button_add-role }}** and select `{{ roles-cr-puller }}`.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. View a description of the CLI command to create a service account:

      ```bash
      yc iam service-account create --help
      ```

  1. Create a service account:

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      ```bash
      yc iam service-account create --name images-puller
      ```

      Result:

      ```text
      id: ajelabcde12f********
      folder_id: b0g12ga82bcv********
      created_at: "2020-11-30T14:32:18.900092Z"
      name: myservice-acc
      ```

  1. Assign the `{{ roles-cr-puller }}` role to the service account:

      ```bash
      yc container registry add-access-binding <registry_name_or_ID> \
        --role {{ roles-cr-puller }} \
        --subject serviceAccount:<service_account_ID>
      ```

      Where `--subject` is the ID of the service account getting the role, e.g., `ajelabcde12f********`.

- API {#api}

  1. To create a service account, use the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call.

  1. To assign the service account a role for the registry, use the [updateAccessBindings](../../container-registry/api-ref/Registry/updateAccessBindings.md) REST API method for the [Registry](../../container-registry/api-ref/Registry/index.md) resource or the [RegistryService/UpdateAccessBindings](../../container-registry/api-ref/grpc/Registry/updateAccessBindings.md) gRPC API call.

{% endlist %}


## Create a {{ compute-name }} VM {#create-vm}

Create a VM with a public IP address and link the service account you created to it:

{% list tabs group=instructions %}

- Management console {#console}

  1. On the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) dashboard of the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. Select **{{ ui-key.yacloud.compute.instances.create.option_create-form-extended-title }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select an [image](../../compute/operations/images-with-pre-installed-software/get-list.md) and a Linux-based OS version.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the [availability zone](../../overview/concepts/geo-scope.md) to create your VM in. If you are not sure which one to choose, leave the default.
  1. Optionally, under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, specify the required boot [disk](../../compute/concepts/disk.md) [type](../../compute/concepts/disk.md#disks-types) and size.

      To add a new secondary disk or connect an existing one, click **{{ ui-key.yacloud.common.add }}**.

      You can also [create a VM from an existing disk](../../compute/operations/vm-create/create-from-disks.md).

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select the network and subnet to connect your VM to. If the required [network](../../vpc/concepts/network.md#network) or [subnet](../../vpc/concepts/network.md#subnet) is not there, [create it](../../vpc/operations/subnet-create.md).
      * Under **{{ ui-key.yacloud.component.compute.network-select.field_external }}**, leave `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` to assign a random external IP address from the {{ yandex-cloud }} pool to your VM. Alternatively, select a static address from the list if you reserved one. If you prefer not to assign a public IP address, select `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`.
      * Expand **{{ ui-key.yacloud.component.compute.network-select.section_additional }}** and enable DDoS protection, if required.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access data:

      * Under **{{ ui-key.yacloud.compute.instances.create.field_user }}**, enter the username. Do not use `root` or other reserved usernames. To perform operations requiring root privileges, use the `sudo` command.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name. Follow these naming requirements:

      {% include [name-format](../../_includes/name-format.md) %}

      {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_additional }}**, select the [service account](../../iam/concepts/users/service-accounts.md) you created in the previous step.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- CLI {#cli}

  1. View the description of the CLI command to create a VM:

      ```bash
      yc compute instance create --help
      ```

  1. Prepare a key pair (public and private keys) for SSH access to your VM.
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
      | b0c6n43f9lgh******** | default-{{ region-id }}-d     | enpe3m3fa00u******** |                | {{ region-id }}-d     | [10.130.0.0/24] |
      | e2l2da8a20b3******** | default-{{ region-id }}-b     | enpe3m3fa00u******** |                | {{ region-id }}-b     | [10.129.0.0/24] |
      | e9bnlm18l70a******** | default-{{ region-id }}-a     | enpe3m3fa00u******** |                | {{ region-id }}-a     | [10.128.0.0/24] |
      +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
      ```

  1. Create a VM in the default folder:

      ```bash
      yc compute instance create \
        --name first-instance \
        --zone {{ region-id }}-b \
        --network-interface subnet-name=default-{{ region-id }}-b,nat-ip-version=ipv4 \
        --create-boot-disk image-folder-id=standard-images,image-family=centos-7 \
        --ssh-key ~/.ssh/id_ed25519.pub
        --service-account-name service-acc
      ```

      Where:

      * `--name`: VM name.

        {% include [name-fqdn](../../_includes/compute/name-fqdn.md) %}

      * `--zone`: Availability zone matching the selected subnet.
      * `subnet-name`: Name of the selected subnet.
      * `image-family`: [Image family](../../compute/concepts/image.md#family), e.g., `centos-7`. This option allows you to install the latest version of the operating system from the specified image family.
      * Public IP. To create a VM without a public IP address, disable the `nat-ip-version=ipv4` option.
      * `--ssh-key`: Public SSH key path. The VM will automatically create a user named `yc-user` for this key.
      * `--service-account-name`: Name of the service account created in the previous step.

      This will create a VM called `first-instance`.

- API {#api}

  Create a VM using the [Create](../../compute/api-ref/Instance/create.md) REST API method for the [Instance](../../compute/api-ref/Instance/index.md) resource:

  1. Prepare a key pair (public and private keys) for SSH access to your VM.
  1. Get a [{{ iam-full-name }} token](../../iam/concepts/authorization/iam-token.md) used for authentication in the examples:

      * [Guide](../../iam/operations/iam-token/create.md) for users with a Yandex account.
      * [Guide](../../iam/operations/iam-token/create-for-sa.md) for service accounts.

  1. [Get the ID](../../resource-manager/operations/folder/get-id.md) of the folder.
  1. Get information about the image to create your VM from (image ID and minimum disk size):

      * If you know the [image family](../../compute/concepts/image.md#family), get info on the latest image in that family:

          ```bash
          export IAM_TOKEN=CggaATEVAgA...
          export FAMILY=ubuntu-1804
          curl --header "Authorization: Bearer ${IAM_TOKEN}" \
            "https://compute.{{ api-host }}/compute/v1/images:latestByFamily?folderId=standard-images&family=${FAMILY}"
          ```

      * You can get information on the image from the [list of public images](../../compute/operations/images-with-pre-installed-software/get-list.md).

  1. Get the subnet ID and availability zone ID. Specify the ID of the folder where the subnet was created in your request:

      ```bash
      export IAM_TOKEN=CggaATEVAgA...
      export FOLDER_ID=b1gvmob95yys********
      curl --header "Authorization: Bearer ${IAM_TOKEN}" \
        "https://vpc.{{ api-host }}/vpc/v1/subnets?folderId=${FOLDER_ID}"
      {
        "subnets": [
          {
            "v4CidrBlocks": [
              "10.130.0.0/24"
            ],
          "id": "b0c6n43ftldh********",
          "folderId": "b1gvmob95yys********",
          "createdAt": "2018-09-23T12:15:00Z",
          "name": "default-{{ region-id }}-b",
          "description": "Auto-created default subnet for zone {{ region-id }}-b",
          "networkId": "enpe3m3faglu********",
          "zoneId": "{{ region-id }}-b"
        },
        ...
        ]}
      ```

  1. Create a file named `body.json` with the body of the request to create a VM:

      ```json
      {
        "folderId": "b1gvmob95yys********",
        "name": "instance-demo-no-pwauth",
        "zoneId": "{{ region-id }}-b",
        "platformId": "standard-v3",
        "resourcesSpec": {
          "memory": "2147483648",
          "cores": "2"
        },
        "metadata": {
          "user-data": "#cloud-config\nusers:\n  - name: user\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ssh-ed25519 AAAAB3N... user@example.com"
        },
        "bootDiskSpec": {
          "diskSpec": {
            "size": "2621440000",
            "imageId": "fd8rc75pn12f********"
          }
        },
        "networkInterfaceSpecs": [
          {
            "subnetId": "b0c6n43ftldh********",
            "primaryV4AddressSpec": {
              "oneToOneNatSpec": {
                "ipVersion": "IPV4"
              }
            }
          }
        ],
        "serviceAccountId": "ajelabcde12f********"
      }
      ```

      Where:

      * `folderId`: Folder ID.
      * `name`: Name the VM will get when created.
      * `zoneId`: Availability zone matching the selected subnet.
      * `platformId`: [Platform](../../compute/concepts/vm-platforms.md).
      * `resourceSpec`: Resources available to the VM. The values must match the selected platform.
      * `metadata`: In metadata, provide the public key for accessing the VM via SSH. For more information, see [{#T}](../../compute/concepts/vm-metadata.md).
      * `bootDiskSpec`: Boot disk settings. Specify the selected image ID and disk size. The disk size must not be less than the minimum value specified in the image info.
      * `networkInterfaceSpecs`: Network settings:

        * `subnetId`: ID of the selected subnet.
        * `primaryV4AddressSpec`: IP address to assign to the VM. To add a [public IP address](../../vpc/concepts/address.md#public-addresses) to your VM, specify the following:

            ```yaml
            "primaryV4AddressSpec": {
              "oneToOneNatSpec": {
                "ipVersion": "IPV4"
              }
            }
            ```

      * `serviceAccountId`: ID of the service account created in the previous step.

      For more information about the request body format, see the [API reference](../../compute/api-ref/Instance/create.md).

  1. Create a VM:

      ```bash
      export IAM_TOKEN=CggaATEVAgA...
      curl --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '@body.json' \
        https://compute.{{ api-host }}/compute/v1/instances
      ```

{% endlist %}

After creating the VM, [build and upload the Docker image to {{ container-registry-name }}](#create-image). 


## Build and push the Docker image to {{ container-registry-name }} {#create-image}

{% include [bash-windows-note-single](../../_includes/translate/bash-windows-note-single.md) %}

{% include [create-image](../_tutorials_includes/run-docker-on-vm/create-image.md) %}


## Push the Docker image to the VM {#run}

{% include [run](../_tutorials_includes/run-docker-on-vm/run.md) %}


## Check the result {#check-out}

{% include [test](../_tutorials_includes/run-docker-on-vm/test.md) %}


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete](../../compute/operations/vm-control/vm-delete.md) the VM.
1. [Delete](../../vpc/operations/address-delete.md) the static public IP address if you reserved one.
1. [Delete the Docker image](../../container-registry/operations/docker-image/docker-image-delete.md).
1. [Delete](../../container-registry/operations/registry/registry-delete.md) the registry.