In this tutorial, you will deploy a [Docker image](../../cloud-registry/concepts/docker-image.md) from a [registry](../../cloud-registry/concepts/registry.md) in {{ cloud-registry-full-name }} and run a container on a {{ compute-full-name }} VM instance.

To run a Docker image on a VM:

1. [Get your cloud ready](#before-you-begin).
1. [Create a {{ cloud-registry-name }}](#create-registry).
1. [Create a service account](#create-sa).
1. [Create an authorized key for the service account](#create-authorized-key).
1. [Create a cloud network with a subnet](#create-network).
1. [Create a VM](#create-vm).
1. [Build a Docker image and push it to {{ cloud-registry-name }}](#create-image).
1. [Push the Docker image to the VM](#run).

If you no longer need the resources you created, [delete them](#clear-out).


## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of resources for running a Docker image includes:

* Fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for storing created images (see [{{ cloud-registry-full-name }} pricing](../../cloud-registry/pricing.md)).
* Fee for outbound traffic from {{ yandex-cloud }} to the internet (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).


### Create an SSH key pair {#create-ssh}

{% include [create-ssh](../_tutorials_includes/run-docker-on-vm/create-ssh.md) %}


### Install and configure Docker {#configure-docker}

{% include [configure-docker](../../_includes/container-registry/configure-docker.md) %}


## Create a registry in {{ cloud-registry-name }} {#create-registry}

Create a registry for storing Docker images.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a registry in.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-registry }}**.
  1. Click **{{ ui-key.yacloud.cloud-registry.action_registry-create }}**.
  1. Select ![image](../../_assets/console-icons/logo-docker.svg) **{{ ui-key.yacloud.cloud-registry.registries.registry-kind_docker }}** for the format.
  1. Set the registry type to **Local**.
  1. Enter a name for the registry. Follow these naming requirements:

      {% include [name-format-ycr](../../_includes/name-format-ycr.md) %}

  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for creating a registry:

      ```bash
      yc cloud-registry registry create --help
      ```

  1. Create a registry:

      ```bash
      yc cloud-registry registry create \
        --name docker-ycr \
        --description "Created with CLI" \
        --registry-kind docker \
        --registry-type local
      ```

      Result:

      ```text
      id: cn191rncdrhd********
      folder_id: b1g681qpemb4********
      name: docker-ycr
      kind: DOCKER
      type: LOCAL
      status: ACTIVE
      description: Created with CLI
      created_at: "2025-12-12T04:56:32.681439Z"
      modified_at: "2025-12-12T04:56:34.171714Z"
      ```

- API {#api}

  Use the [create](../../cloud-registry/api-ref/Registry/create.md) REST API method for the [Registry](../../cloud-registry/api-ref/Registry/index.md) resource or the [RegistryService/Create](../../cloud-registry/api-ref/grpc/Registry/create.md) gRPC API call.

{% endlist %}


## Create a service account {#create-sa}

Create a [service account](../../iam/concepts/users/service-accounts.md) you will use to pull the Docker image to the VM. Assign it the `cloud-registry.artifacts.puller` [role](../../cloud-registry/security/index.md#cloud-registry-artifacts-puller) for the created registry.

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. At the top of the screen, navigate to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Specify the service account name: `docker-puller`.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-registry }}**.
  1. Select the previously created registry.
  1. Navigate to the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
  1. Click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. In the window that opens, select the `docker-puller` service account.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select `cloud-registry.artifacts.puller`.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  1. Create a service account:

      ```bash
      yc iam service-account create --name docker-puller
      ```

      Result:

      ```text
      id: ajelabcde12f********
      folder_id: b0g12ga82bcv********
      created_at: "2020-11-30T14:32:18.900092Z"
      name: docker-puller
      ```

  1. Assign the `cloud-registry.artifacts.puller` role to the service account:

      ```bash
      yc cloud-registry registry add-access-binding <registry_name_or_ID> \
        --role cloud-registry.artifacts.puller \
        --subject serviceAccount:<service_account_ID>
      ```

      Where `--subject` is the `docker-puller` service account ID.

      Result:

      ```text
      ...1s...done (5s)
      ```

- API {#api}

  1. To create a service account, use the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource.
  1. To assign the service account a role for the registry, use the [updateAccessBindings](../../cloud-registry/api-ref/Registry/updateAccessBindings.md) REST API method for the [Registry](../../cloud-registry/api-ref/Registry/index.md) resource.

{% endlist %}

## Create an authorized key for the service account {#create-authorized-key}

Create an [authorized key](../../iam/concepts/authorization/key.md) for the `docker-puller` service account An authorized key will allow the service account to get an IAM token for authentication in the {{ yandex-cloud }} API.

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the list that opens, select `docker-puller`.
  1. In the top panel, click ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** and select `{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_key }}`.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.iam.folder.service-account.overview.action_download-keys-file }}** and then **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_close }}**

  The action will download to your computer a file named `authorized_key.json` containing the authorized key. You will need this key later to set up Docker on your VM.

- CLI {#cli}

  Run this command:

  ```bash
  yc iam key create \
    --service-account-name docker-puller \
    -o authorized_key.json
  ```

  Result:

  ```text
  id: ajetn5b1efv2********
  service_account_id: ajefbp899mcl********
  created_at: "2025-12-17T04:57:16.241850455Z"
  key_algorithm: RSA_2048
  ```

  The action will download to your computer a file named `authorized_key.json` containing the authorized key. You will need this key later to set up Docker on your VM.

- API {#api}

  Use the [create](../../iam/api-ref/Key/create.md) REST API method for the [Key](../../iam/api-ref/Key/index.md) resource or the [KeyService/Create](../../iam/api-ref/grpc/Key/create.md) gRPC API call.

{% endlist %}


## Create a cloud network and subnet {#create-network}

Create a [cloud network](../../vpc/concepts/network.md) with a [subnet](../../vpc/concepts/network.md#subnet) to host the VM.

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. In the **{{ ui-key.yacloud.vpc.networks.create.field_name }}** field, specify `docker-ycr-network`.
  1. In the **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** field, disable **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. Select `vipnet-network`.
  1. Click ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.network.overview.button_create_subnetwork }}** at the top right.
  1. In the **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** field, specify `docker-ycr-subnet-{{ region-id }}-b`.
  1. In the **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** field, select `{{ region-id }}-b`.
  1. In the **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** field, specify `192.168.1.0/24`.
  1. Click **{{ ui-key.yacloud.vpc.subnetworks.create.button_create }}**.

- CLI {#cli}

  1. Create a cloud network named `docker-ycr-network`:

      ```bash
      yc vpc network create docker-ycr-network
      ```

      Result:

      ```text
      id: enp1gg8kr3pv********
      folder_id: b1gt6g8ht345********
      created_at: "2023-12-20T20:08:11Z"
      name: docker-ycr-network
      default_security_group_id: enppne4l2eg5********
      ```

      For more information about the `yc vpc network create` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/network/create.md).

  1. Create a subnet in the `{{ region-id }}-b` [availability zone](../../overview/concepts/geo-scope.md):

      ```bash
      yc vpc subnet create docker-ycr-subnet-{{ region-id }}-b \
        --zone {{ region-id }}-b \
        --network-name docker-ycr-network \
        --range 192.168.1.0/24
      ```

      Result:

      ```text
      id: e2li9tcgi7ii********
      folder_id: b1gt6g8ht345********
      created_at: "2023-12-20T20:11:16Z"
      name: docker-ycr-subnet-{{ region-id }}-b
      network_id: enp1gg8kr3pv********
      zone_id: {{ region-id }}-b
      v4_cidr_blocks:
        - 192.168.1.0/24
      ```

      For more information about the `yc vpc subnet create` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/subnet/create.md).

- API {#api}

  1. To create a cloud network, use the [create](../../vpc/api-ref/Network/create.md) REST API method or the [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md) gRPC API call.
  1. To create a subnet, use the [create](../../vpc/api-ref/Subnet/create.md) REST API method or the [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md) gRPC API call.

{% endlist %}


## Create a VM {#create-vm}

Create a VM with a public IP address and associate it with the service account you created.

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select an image and a Linux-based OS version.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../overview/concepts/geo-scope.md) for your VM.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select the previously created network and subnet.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, leave the **{{ ui-key.yacloud.component.compute.network-select.switch_auto }}** value to assign a random external IP address from the {{ yandex-cloud }} pool.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the VM access credentials:
      * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter the username.
      * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the [public key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `docker-vm`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_additional }}**, select the `docker-puller` service account you created earlier.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- CLI {#cli}

  Create a VM in the default folder:

  ```bash
  yc compute instance create \
    --name docker-vm \
    --zone {{ region-id }}-b \
    --network-interface subnet-name=docker-ycr-subnet-{{ region-id }}-b,nat-ip-version=ipv4 \
    --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2004-lts \
    --ssh-key <public_SSH_key_file_path> \
    --service-account-name docker-puller
  ```

  Where:

  * `--name`: VM name.
  * `--zone`: Availability zone matching the subnet.
  * `subnet-name`: Name of the subnet you created earlier.
  * `image-family`: [Image family](../../compute/concepts/image.md#family).
  * `--ssh-key`: Public SSH key path.
  * `--service-account-name`: Service account name.

  Result:

  ```text
  id: epd6kj8giu79********
  folder_id: b1g681qpemb4********
  created_at: "2025-12-12T16:14:50Z"
  name: docker-vm
  zone_id: ru-central1-b
  platform_id: standard-v2
  resources:
    memory: "2147483648"
    cores: "2"
    core_fraction: "100"
  status: RUNNING
  metadata_options:
    gce_http_endpoint: ENABLED
    aws_v1_http_endpoint: ENABLED
    gce_http_token: ENABLED
    aws_v1_http_token: DISABLED
  boot_disk:
    mode: READ_WRITE
    device_name: epdvqn83lud9********
    auto_delete: true
    disk_id: epdvqn83lud9********
  network_interfaces:
    - index: "0"
      mac_address: d0:0d:**:**:**:**
      subnet_id: e2l8hdblgki4********
      primary_v4_address:
        address: 192.168.1.7
        one_to_one_nat:
          address: 158.***.**.***
          ip_version: IPV4
  serial_port_settings:
    ssh_authorization: OS_LOGIN
  gpu_settings: {}
  fqdn: epd6kj8giu79********.auto.internal
  scheduling_policy: {}
  service_account_id: ajes3g9rg94s********
  network_settings:
    type: STANDARD
  placement_policy: {}
  hardware_generation:
    legacy_features:
      pci_topology: PCI_TOPOLOGY_V2
  application: {}
  ```

- API {#api}

  Use the [Create](../../compute/api-ref/Instance/create.md) REST API method for the [Instance](../../compute/api-ref/Instance/index.md) resource or the [InstanceService/Create](../../compute/api-ref/grpc/Instance/create.md) gRPC API call.

{% endlist %}


## Build a Docker image and push it to {{ cloud-registry-name }} {#create-image}

Build a Docker image and push it to the registry.

{% list tabs group=programming_language %}

- Bash {#bash}

  1. [Get authenticated](../../cloud-registry/operations/docker/authentication.md) in {{ cloud-registry-name }}.
  1. Create a file called Dockerfile:

      ```bash
      echo "FROM ubuntu:latest" > Dockerfile
      echo "CMD echo 'Hello World'" >> Dockerfile
      ```

  1. Build the Docker image:

      ```bash
      docker build . -t {{ cloud-registry }}/<registry_ID>/ubuntu:hello
      ```

      Where `<registry_ID>` is the ID of the registry you created [earlier](#create-registry).

      Result:

      ```text
      ...
      Successfully built db45********
      Successfully tagged {{ cloud-registry }}/cn1k31pgpovl********/ubuntu:hello
      ```

  1. Push the Docker image to the registry:

      ```bash
      docker push {{ cloud-registry }}/<registry_ID>/ubuntu:hello
      ```

      Result:

      ```text
      e8bc********: Pushed 
      hello: digest: sha256:96d... size: 529
      ```

{% endlist %}


## Push the Docker image to the VM {#run}

Set up the environment on the VM, pull the Docker image, and run it.

{% list tabs group=programming_language %}

- Bash {#bash}

  1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH.
  1. [Install](../../cli/quickstart.md#install) the CLI and restart the terminal:

      ```bash
      curl -sSL https://{{ s3-storage-host-cli }}{{ yc-install-path }} | bash
      exec -l $SHELL
      ```

  1. Create a file named `key.json` and paste the contents of the `docker-puller` service account key file to it:

      ```bash
      sudo nano key.json
      ```

  1. Configure the CLI for the service account:

      ```bash
      yc config profile create docker-puller
      yc config set service-account-key key.json
      yc config set folder-id <folder_ID>
      ```

      For `folder-id`, specify the ID of the folder containing the registry.

      Result:

      ```text
      Profile 'docker-puller' created and activated
      ```

  1. Install Docker:

      ```bash
      sudo apt update
      sudo apt install docker.io
      ```

  1. Add the current user to the `docker` group and disconnect from the VM:

      ```bash
      sudo usermod -aG docker $USER
      exit
      ```

  1. [Reconnect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH.
  1. Set up Docker:

      ```bash
      mkdir -p ~/.docker
      cat > ~/.docker/config.json <<'EOF'
      {
        "credHelpers": {
          "{{ cloud-registry }}": "yc"
        }
      }
      EOF

      sudo tee /usr/local/bin/docker-credential-yc >/dev/null <<'EOF'
      #!/usr/bin/env bash
      exec yc cloud-registry docker-credential "$@"
      EOF

      sudo chmod +x /usr/local/bin/docker-credential-yc
      ```

  1. Push the Docker image to the VM:

      ```bash
      docker pull {{ cloud-registry }}/<registry_ID>/ubuntu:hello
      ```

      Result:

      ```text
      hello: Pulling from cn191rncdrhd********/ubuntu
      02de********: Pull complete
      Digest: sha256:96d...
      Status: Downloaded newer image for {{ cloud-registry }}/cn191rncdrhd********/ubuntu:hello
      {{ cloud-registry }}/cn191rncdrhd********/ubuntu:hello
      ```

  1. Run the Docker image:

      ```bash
      docker run {{ cloud-registry }}/<registry_ID>/ubuntu:hello
      ```

      Result:

      ```text
      Hello World
      ```

{% endlist %}


## How to delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid [paying](#paid-resources) for them:

1. [Delete](../../compute/operations/vm-control/vm-delete.md) the VM.
1. [Delete](../../vpc/operations/address-delete.md) the static public IP address if you reserved one.
1. Delete the [network](../../vpc/operations/network-delete.md) and the [subnets](../../vpc/operations/subnet-delete.md).
1. Delete the [Docker image](../../cloud-registry/concepts/docker-image.md) from the registry.
1. Delete the [registry](../../cloud-registry/concepts/registry.md).


#### See also {#see-also}

* [Working with {{ cloud-registry-name }}](../../cloud-registry/operations/index.md)
* [Creating a VM from a {{ coi }}](../../cos/tutorials/vm-create.md)