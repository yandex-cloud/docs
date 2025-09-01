# Running a containerized app in {{ serverless-containers-full-name }}


Follow this guide to deploy a containerized app in [{{ serverless-containers-name }}](../../serverless-containers/) to administer {{ MG }}.

{{ MG }} is deployed on a [{{ compute-full-name }}](../../compute/) VM. A [{{ container-registry-full-name }}](../../container-registry/) is used to host the container with the app. [{{ lockbox-full-name }}](../../lockbox/) is used to encrypt sensitive data. Secure access to the application is enabled over a [{{ api-gw-full-name }}](../../api-gateway/). The entire infrastructure of the containerized app resides in a single folder.

To deploy your containerized app:

1. [Get your cloud ready](#before-you-begin).
1. [Create a service account](#sa-create).
1. [Create a cloud network with a subnet](#create-network).
1. [Configure the security group](#configure-sg).
1. [Create a {{ compute-name }} VM with {{ MG }}](#create-vm).
1. [Create a {{ lockbox-name }} secret and version](#secret-create).
1. [Create a registry in {{ container-registry-name }}](#create-registry).
1. [Push the Docker image to {{ container-registry-name }}](#push-image).
1. [Create a container in {{ serverless-containers-name }}](#create-container).
1. [Create an {{ api-gw-name }}](#create-api-gw).
1. [Test the application](#check-app).

If you no longer need the resources you created, [delete them](#clear-out).


## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The application support cost includes:

* Fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for storing secrets (see [{{ lockbox-full-name }} pricing](../../lockbox/pricing.md)).
* Fee for storing a Docker image (see [{{ container-registry-full-name }} pricing](../../container-registry/pricing.md)).
* Fee for container invocation count, computing resources allocated to run the application, and outbound traffic (see [{{ serverless-containers-name }} pricing](../../serverless-containers/pricing.md)).
* Fee for API gateway requests (see [{{ api-gw-full-name }} pricing](../../api-gateway/pricing.md)).
* Fee for logging operations and data storage in a [log group](../../logging/concepts/log-group.md) (see [{{ cloud-logging-full-name }} pricing](../../logging/pricing.md)).


## Create a service account {#sa-create}

Create a [service account](../../iam/concepts/users/service-accounts.md) and assign it the required [roles](../../iam/concepts/access-control/roles.md) for the folder that will host the containerized app infrastructure.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{link-console-main}}), go to the folder that will host the containerized app infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Enter `mongo-express` as the service account name.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `{{ roles-cr-puller }}`, `{{ roles-lockbox-payloadviewer }}`, and `{{ roles-serverless-containers-invoker }}` [roles](../../load-testing/security/index.md#roles-list).
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Create a service account named `mongo-express`:

      ```bash
      yc iam service-account create --name mongo-express
      ```

      Result:

      ```text
      id: aje3pdqm1cul********
      folder_id: b1g681qpemb4********
      created_at: "2025-06-14T10:31:06.911280565Z"
      name: mongo-express
      ```

  1.  Assign the service account the `{{ roles-cr-puller }}`, `{{ roles-lockbox-payloadviewer }}`, and `{{ roles-serverless-containers-invoker }}` roles for the folder that will host your container:

      ```bash
      yc resource-manager folder add-access-binding <folder_name_or_ID> \
        --role {{ roles-cr-puller }} \
        --subject serviceAccount:<service_account_ID>

      yc resource-manager folder add-access-binding <folder_name_or_ID> \
        --role {{ roles-lockbox-payloadviewer }} \
        --subject serviceAccount:<service_account_ID>

      yc resource-manager folder add-access-binding <folder_name_or_ID> \
        --role {{ roles-serverless-containers-invoker }} \
        --subject serviceAccount:<service_account_ID>
      ```

      Where:

      * `<folder_name_or_ID>`: Name or ID of the folder to host the container.
      * `--subject serviceAccount`: `mongo-express` service account ID.

      Result:

      ```text
      effective_deltas:
        - action: ADD
          access_binding:
            role_id: container-registry.images.puller
            subject:
              id: aje3pdqm1cul********
              type: serviceAccount

      effective_deltas:
        - action: ADD
          access_binding:
            role_id: lockbox.payloadViewer
            subject:
              id: aje3pdqm1cul********
              type: serviceAccount

      effective_deltas:
        - action: ADD
          access_binding:
            role_id: serverless-containers.containerInvoker
            subject:
              id: aje3pdqm1cul********
              type: serviceAccount
      ```

- API {#api}

  1. To create a service account, use the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call.
  1. To assign the service account roles for a folder, use the [updateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md) REST API method for the [Folder](../../resource-manager/api-ref/Folder/index.md) resource or the [FolderService/UpdateAccessBindings](../../resource-manager/api-ref/grpc/Folder/updateAccessBindings.md) gRPC API call.

{% endlist %}


## Create a cloud network and subnet {#create-network}

Create a [cloud network](../../vpc/concepts/network.md) and [subnet](../../vpc/concepts/network.md#subnet) the VM will reside in.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}** from the list of services.
  1. At the top right, click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. In the **{{ ui-key.yacloud.vpc.networks.create.field_name }}** field, specify `mongo-express-network`.
  1. In the **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** field, select **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. In the left-hand panel, select ![subnets](../../_assets/vpc/subnets.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
  1. At the top right, click **{{ ui-key.yacloud.common.create }}**.
  1. In the **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** field, specify `mongo-express-subnet-{{ region-id }}-b`.
  1. In the **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** field, select `{{ region-id }}-b`.
  1. In the **{{ ui-key.yacloud.vpc.subnetworks.create.field_network }}** field, select `mongo-express-network`.
  1. In the **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** field, specify `192.168.1.0/24`.
  1. Click **{{ ui-key.yacloud.vpc.subnetworks.create.button_create }}**.

- CLI {#cli}

  1. Create a cloud network:

      ```bash
      yc vpc network create \
        --name mongo-express-network
      ```

      Result:

      ```text
      id: enp1b4okmg57********
      folder_id: b1g681qpemb4********
      created_at: "2025-06-13T12:57:02Z"
      name: mongo-express-network
      default_security_group_id: enphs1omp6m4********
      ```

      Save the default security group ID specified in the `default_security_group_id` field.

  1. Create a subnet:

      ```bash
      yc vpc subnet create \
         --name mongo-express-subnet-{{ region-id }}-b \
         --zone {{ region-id }}-b \
         --network-id <network_ID> \
         --range 192.168.1.0/24
      ```

      Where:

      * `--name`: Subnet name.
      * `--zone`: Availability zone.
      * `--network-id`: `mongo-express-network` network ID.
      * `--range`: List of IPv4 addresses the traffic will come to or from.

      Result:

      ```text
      id: e2l9i0eaq32t********
      folder_id: b1g681qpemb4********
      created_at: "2025-06-14T09:27:37Z"
      name: mongo-express-subnet-ru-central1-b
      network_id: enp1b4okmg57********
      zone_id: ru-central1-b
      v4_cidr_blocks:
        - 192.168.1.0/24
      ```

- API {#api}

  1. To create a cloud network, use the [create](../../vpc/api-ref/Network/create.md) REST API method for the [Network](../../vpc/api-ref/Network/index.md) resource or the [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md) gRPC API call, providing the following in your request:

      * ID of the folder to host the network.
      * Name of the new network,`mongo-express-network`, in the `name` parameter.

  1. To create a subnet, use the [create](../../vpc/api-ref/Subnet/create.md) REST API method for the [Subnet](../../vpc/api-ref/Subnet/index.md) resource or the [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md) gRPC API call.

{% endlist %}


## Configure the security group {#configure-sg}

Configure the default [security group](../../vpc/concepts/security-groups.md) in the cloud network you created [earlier](#create-network).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}** from the list of services.
  1. In the left-hand panel, select ![image](../../_assets/vpc/security-group.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}**.
  1. Next to the default security group created for `mongo-express-network`, click ![image](../../_assets/options.svg) and select **{{ ui-key.yacloud.common.edit }}**.
  1. Under **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}**, navigate to the **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** tab.
  1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}** and create a rule based on this table:

      | Traffic<br/>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
      | --- | --- | --- | --- | --- | --- |
      | `Ingress` | `any` | `27017` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |

  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Add the rule to the security group:

  ```bash
  yc vpc security-group update-rules <security_group_ID> \
    --add-rule "direction=ingress,port=27017,protocol=any,v4-cidrs=[0.0.0.0/0,0.0.0.0/0]"
  ```

  Where `<security_group_ID>` is the `default_security_group_id` value obtained in the previous step.

  Result:

  ```text
  id: enpmal7qcb1q********
  folder_id: b1g681qpemb4********
  created_at: "2025-06-14T09:24:47Z"
  name: default-sg-enpeiqghds1j********
  description: Default security group for network
  network_id: enpeiqghds1j********
  status: ACTIVE
  rules:
    ...
    - id: enprm96de4ec********
      direction: INGRESS
      ports:
        from_port: "27017"
        to_port: "27017"
      protocol_name: ANY
      protocol_number: "-1"
      cidr_blocks:
        v4_cidr_blocks:
          - 0.0.0.0/0
          - 0.0.0.0/0
  default_for_network: true
  ```

- API {#api}

  To add a rule to a security group, use the [updateRules](../../vpc/api-ref/SecurityGroup/updateRules.md) REST API method for the [SecurityGroup](../../vpc/api-ref/SecurityGroup/index.md) resource or the [SecurityGroupService/UpdateRules](../../vpc/api-ref/grpc/SecurityGroup/updateRules.md) gRPC API call, providing the following in your request:

    * ID of the security group you want to add rules to, in the `securityGroupId` parameter.

        {% include [get-security-group-id](../../_includes/vpc/get-security-group-id.md) %}

    * New security group rules, in the `additionRuleSpecs[]` array:

        * Traffic direction: `ingress`.
        * Name of the traffic transmission protocol, in the `additionRuleSpecs[].protocolName` parameter: `any`.
        * List of CIDRs and subnet masks, in the `additionRuleSpecs[].cidrBlocks.v4CidrBlocks[]` parameter: `[0.0.0.0/0,0.0.0.0/0]`.
        * First port in the traffic ports range, in the `additionRuleSpecs[].ports.fromPort` parameter: `0`.
        * Last port in the traffic port range, in the `additionRuleSpecs[].ports.toPort` parameter: `65535`.

{% endlist %}


## Create a VM with {{ MG }} {#create-vm}

We recommend using a [VM](../../compute/concepts/vm.md) with basic configuration.

{% list tabs group=instructions %}

- Management console {#console}

  1. On the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) page in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. Select **{{ ui-key.yacloud.compute.instances.create.option_create-form-extended-title }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**:

      1. Navigate to the **{{ ui-key.yacloud.compute.instances.create.image_value_coi }}** tab and click **{{ ui-key.yacloud.compute.instances.create.image_coi_label_empty-button }}**.
      1. In the window that opens, go to the **{{ ui-key.yacloud.compute.instances.create.value_docker-compose-yaml }}** tab and specify the Docker container as follows:

          ```yaml
          version: '3.1'

          services:
            mongo:
              image: mongo
              restart: always
              environment:
                MONGO_INITDB_ROOT_USERNAME: mongo_db_user
                MONGO_INITDB_ROOT_PASSWORD: <password>
              ports:
                - 27017:27017
          ```

          In the `MONGO_INITDB_ROOT_PASSWORD` parameter, specify the password to use for accessing the database. To create a password, you can use [this password generator](https://passwordsgenerator.net/). Save the password, as you will need it in the next steps.

      1. Click **{{ ui-key.yacloud.common.apply }}**.

  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../overview/concepts/geo-scope.md) for your VM. If you are not sure which one to choose, leave the default.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select `mongo-express-subnet-{{ region-id }}-b`.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

      * Under **{{ ui-key.yacloud.compute.instances.create.field_user }}**, enter the username. Do not use `root` or other names reserved for the OS purposes. For operations requiring root privileges, use the `sudo` command.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `mongo-vm`.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  Wait for the VM status to change to `Running` and save its public IP address: you will need it for connecting to the database.

- CLI {#cli}

  1. [Create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair (public and private keys) for SSH access to the VM.
  1. Create `docker-spec.yaml`, a Docker container specification file:

      ```yaml
      version: '3.1'

      services:
        mongo:
          image: mongo
          restart: always
          environment:
            MONGO_INITDB_ROOT_USERNAME: mongo_db_user
            MONGO_INITDB_ROOT_PASSWORD: <password>
          ports:
            - 27017:27017
      ```

      In the `MONGO_INITDB_ROOT_PASSWORD` parameter, specify the password to use for accessing the database. To create a password, you can use [this password generator](https://passwordsgenerator.net/). Save the password, as you will need it in the next steps.

  1. Run this command:

      ```bash
      yc compute instance create-with-container \
        --docker-compose-file docker-spec.yaml \
        --name mongo-vm \
        --zone {{ region-id }}-b \
        --network-interface subnet-name=mongo-express-subnet-{{ region-id }}-b,nat-ip-version=ipv4 \
        --ssh-key <path_to_public_key_file> \
        --create-boot-disk size=30
      ```

      Where:

      * `--docker-compose-file`: Path to the Docker container [specification file](../../cos/concepts/coi-specifications.md#coi-spec).
      * `--name`: VM name.
      * `--zone`: Availability zone.
      * `--network-interface`: VM network settings.
      * `--ssh-key`: Path to the public SSH key file, e.g., `./ssh-key.pub`. The default username for SSH access is `yc-user`.
      * `--create-boot-disk size`: Boot disk size. It must be at least 30 GB.

      Result:

      ```text
      id: epde18u4mahl********
      folder_id: b1g7gvsi89m3********
      created_at: "2023-02-08T10:34:06.601Z"
      name: mongo-vm
      ...
      ```

{% endlist %}


## Create a {{ lockbox-name}} secret {#secret-create}

The [{{ lockbox-name }} secret](../../lockbox/concepts/secret.md) will store encrypted authentication credentials.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}** from the list of services.
  1. Click **{{ ui-key.yacloud.lockbox.button_create-secret }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the secret: `mongodb-creds`.
  1. Under **{{ ui-key.yacloud.lockbox.label_version-dialog-title }}**:

      * In the **{{ ui-key.yacloud.lockbox.forms.label_key }}** field, enter `login`.
      * In the **{{ ui-key.yacloud.lockbox.forms.label_value }}** field, enter `mongo_db_user` as your DB user login.

  1. Click **{{ ui-key.yacloud.lockbox.forms.button_add-pair }}** and specify the second secret:

      * In the **{{ ui-key.yacloud.lockbox.forms.label_key }}** field, enter `password`.
      * In the **{{ ui-key.yacloud.lockbox.forms.label_value }}** field, enter the password to access the database: the `MONGO_INITDB_ROOT_PASSWORD` value from the [Docker container specification](#create-vm).

  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

   Create a secret named `mongodb-creds`:

    ```bash
    yc lockbox secret create \
      --name mongodb-creds \
      --payload "[{'key': 'login', 'text_value': 'mongo_db_user'},{'key': 'password', 'text_value': '<password>'}]"
    ```

    Where:

    * `--name`: Secret name.
    * `--payload`: Contents of the secret provided as a YAML or JSON array.
    * `<password>`: `MONGO_INITDB_ROOT_PASSWORD` value from the [Docker container specification](#create-vm).

    Result:

    ```text
    id: e6q6nbjfu9m2********
    folder_id: b1qt6g8ht345********
    created_at: "2023-02-08T10:34:06.601Z"
    name: mongodb-creds
    status: ACTIVE
    current_version:
      id: e6q0s9airqca********
      secret_id: e6q6nbjfu9m2********
      created_at: "2023-02-08T10:34:06.601Z"
      status: ACTIVE
      payload_entry_keys:
        - login
        - password
    ```

- API {#api}

  To create a secret, use the [create](../../lockbox/api-ref/Secret/create.md) REST API method for the [Secret](../../lockbox/api-ref/Secret/index.md) resource or the [SecretService/Create](../../lockbox/api-ref/grpc/Secret/create.md) gRPC API call.

{% endlist %}


## Create a registry in {{ container-registry-name }} {#create-registry}

The [registry](../../container-registry/concepts/registry.md) in {{ container-registry-name }} will house the Docker image of the `mongo-express` application.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}** from the list of services.
  1. Click **{{ ui-key.yacloud.cr.overview.button_create }}**.
  1. Specify `app-registry` as the registry name.
  1. Click **{{ ui-key.yacloud.cr.overview.popup-create_button_create }}**.

- CLI {#cli}

  Create a registry named `app-registry`:

  ```bash
  yc container registry create --name app-registry
  ```

  Result:

  ```text
  id: crpd50616s9a********
  folder_id: b1g88tflru0e********
  name: app-registry
  status: ACTIVE
  created_at: "2023-02-08T10:34:06.601Z"
  ```

- API {#api}

  To create a registry, use the [create](../../container-registry/api-ref/Registry/create.md) REST API method for the [Registry](../../container-registry/api-ref/Registry/) resource or the [RegistryService/CreateRegistryRequest](../../container-registry/api-ref/grpc/Registry/create.md) gRPC API call.

{% endlist %}


## Push the Docker image to the registry {#push-image}

1. Create a [Docker Hub](https://hub.docker.com/) account.
1. Install Docker:

    * For a Windows workstation, use [this version](https://docs.docker.com/desktop/install/windows-install/).
    * For a Linux workstation, use [this version](https://docs.docker.com/desktop/install/linux-install/).
    * For a Mac OS workstation, use [this version](https://docs.docker.com/desktop/install/mac-install/).

1. [Download](https://hub.docker.com/_/mongo-express) the `mongo-express` image:

    ```bash
    docker pull mongo-express
    ```

    Result:

    ```text
    Using default tag: latest
    latest: Pulling from library/mongo-express
    6a428f9f83b0: Pull complete
    ...
    e60224d64a04: Pull complete
    Digest: sha256:dcfcf89bf91238ff129469a5a94523b3025913dcc41597d72d4d5f4a********
    Status: Downloaded newer image for mongo-express:latest
    docker.io/library/mongo-express:latest
    ```

1. [Authenticate](../../container-registry/operations/authentication.md) in {{ container-registry-name }} using the Docker credential helper:

    {% list tabs group=instructions %}

    - CLI {#cli}

      1. Configure Docker to use `docker-credential-yc`:

          ```bash
          yc container registry configure-docker
          ```

          Result:

          ```text
          Credential helper is configured in '/home/<user>/.docker/config.json'
          ```

          The current user's profile holds the saved settings.

      1. Check that the `${HOME}/.docker/config.json` file includes the following line:

          ```json
          "{{ registry }}": "yc"
          ```

      Docker is ready to use.

    {% endlist %}

1. [Push](../../container-registry/operations/docker-image/docker-image-push.md) the Docker image to the registry:

    {% list tabs group=instructions %}

    - CLI {#cli}

      1. Assign a URL to the pushed `mongo-express` image using the following format: `{{ registry }}/<registry_ID>/<Docker_image_name>:<tag>`:

          ```bash
          docker tag mongo-express \
          {{ registry }}/<registry_ID>/mongo-express:mongo-tag
          ```

      1. Push the `mongo-express` image to the registry:

          ```bash
          docker push {{ registry }}/<registry_ID>/mongo-express:mongo-tag
          ```

          Result:

          ```text
          \The push refers to repository [{{ registry }}/crpbr3qaut47********/mongo-express]
          7c550ce9591d: Pushed
          ...
          aedc3bda2944: Pushed
          mongo-tag: digest: sha256:c641... size: 1993
          ```

    {% endlist %}


## Create a container in {{ serverless-containers-name }} {#create-container}

To run your application in {{ yandex-cloud }}, create a [container](../../serverless-containers/concepts/container.md) and its [revision](../../serverless-containers/concepts/container.md#revision):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}** from the list of services.
  1. Click **{{ ui-key.yacloud.serverless-containers.button_create-container }}**.
  1. Enter the container name: `mongo-express-container`.
  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Navigate to the **{{ ui-key.yacloud.serverless-containers.label_editor }}** tab.

      1. Under **{{ ui-key.yacloud.serverless-containers.section_resources }}**, enter the amount of RAM: `1024 {{ ui-key.yacloud.common.units.label_megabyte }}`.
      1. Under **{{ ui-key.yacloud.serverless-containers.section_image }}**:

          1. In the **{{ ui-key.yacloud.serverless-containers.label_image-url }}** field, specify the URL of the Docker image you pushed [previously](#push-image).
          1. In the **{{ ui-key.yacloud.serverless-containers.label_environment }}** field, add the following variables:

              * `ME_CONFIG_BASICAUTH_USERNAME`: Leave empty.
              * `ME_CONFIG_BASICAUTH_PASSWORD`: Leave empty.
              * `VCAP_APP_PORT`: Set it to `8080`.
              * `ME_CONFIG_MONGODB_SERVER`: Specify the VM public IP address obtained [earlier](#create-vm).

          1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret }}** field, specify these secrets:

              * `ME_CONFIG_MONGODB_AUTH_USERNAME`: Secret with the `login` key.
              * `ME_CONFIG_MONGODB_AUTH_PASSWORD`: Secret with the `password` key.

        1. Under **{{ ui-key.yacloud.serverless-containers.section_parameters }}**:

            1. In the **{{ ui-key.yacloud.serverless-containers.label_service-account }}** field, specify `mongo-express`.
            1. In the **{{ ui-key.yacloud.serverless-containers.label_timeout }}** field, specify `15`.

  1. Click **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.

- CLI {#cli}

  1. Create a container:

      ```bash
      yc serverless container create --name mongo-express-container
      ```

      Result:

      ```text
      id: bba3fva6ka5g********
      folder_id: b1gqvft7kjk3********
      created_at: "2023-02-08T10:34:06.601Z"
      name: mongo-express-container
      url: https://bba3fva6ka5g********.{{ serverless-containers-host }}/
      status: ACTIVE
      ```

  1. Create a container revision:

      ```bash
      yc serverless container revision deploy \
        --container-name mongo-express-container \
        --cores 1 \
        --memory 1GB \
        --image {{ registry }}/<registry_ID>/mongo-express:mongo-tag \
        --environment ME_CONFIG_BASICAUTH=false \
        --environment VCAP_APP_PORT=8080 \
        --environment ME_CONFIG_MONGODB_SERVER=<VM_public_address> \
        --secret environment-variable=ME_CONFIG_MONGODB_AUTH_USERNAME,key=login,id=<secret_ID> \
        --secret environment-variable=ME_CONFIG_MONGODB_AUTH_PASSWORD,key=password,id=<secret_ID> \
        --service-account-id <mongo_express_service_account_ID> \
        --network-id <network_ID> \
        --execution-timeout 15s \
        --concurrency 1
      ```

      Where:

      * `--image`: URL of the `mongo-express` Docker image you pushed [earlier](#push-image).
      * `--environment`: Environment variables:

          * `ME_CONFIG_BASICAUTH`: Set it to `false`.
          * `VCAP_APP_PORT`: Set it to `8080`.
          * `ME_CONFIG_MONGODB_SERVER`: Specify the VM public IP address obtained [earlier](#create-vm).

      * `--secret environment-variable`: `ME_CONFIG_MONGODB_AUTH_USERNAME` and `ME_CONFIG_MONGODB_AUTH_PASSWORD` secrets you created [earlier](#secret-create).
      * `--service-account-id`: [ID of the `mongo-express` service account](../../iam/operations/sa/get-id.md) you created [earlier](#sa-create).
      * `--network-id`: `mongo-express-network` network ID.

      Result:

      ```text
      id: bbas0ktemln9********
      container_id: bbai45hrl5et********
      created_at: "2025-06-14T10:18:06.791Z"
      image:
        image_url: {{ registry }}/crpbr3qaut47********/mongo-express:mongo-tag
        image_digest: sha256:c641....
        environment:
          ME_CONFIG_BASICAUTH: "false"
          ME_CONFIG_MONGODB_SERVER: 89.169.***.***
          VCAP_APP_PORT: "8080"
      resources:
        memory: "1073741824"
        cores: "1"
        core_fraction: "100"
      execution_timeout: 15s
      concurrency: "1"
      service_account_id: ajeldi88vl73********
      status: ACTIVE
      secrets:
        - id: e6qfi832v2j8********
          version_id: e6qj9a9oifme********
          key: login
          environment_variable: ME_CONFIG_MONGODB_AUTH_USERNAME
        - id: e6qfi832v2j8********
          version_id: e6qj9a9oifme********
          key: password
          environment_variable: ME_CONFIG_MONGODB_AUTH_PASSWORD
      log_options:
        folder_id: b1g681qpemb4********
      runtime:
        http: {}
      ```

- API {#api}

  1. To create a container, use the [create](../../serverless-containers/containers/api-ref/Container/create.md) REST API method for the [Container](../../serverless-containers/containers/api-ref/Container/index.md) resource or the [ContainerService/Create](../../serverless-containers/containers/api-ref/grpc/Container/create.md) gRPC API call.
  1. To create a container revision, use the [deployRevision](../../serverless-containers/containers/api-ref/Container/deployRevision.md) REST API method for the [Container](../../serverless-containers/containers/api-ref/Container/index.md) resource or the [ContainerService/DeployRevision](../../serverless-containers/containers/api-ref/grpc/Container/deployRevision.md) gRPC API call.

{% endlist %}


## Create an {{ api-gw-name }} {#create-api-gw}

Create an [API gateway](../../api-gateway/concepts/index.md) with the `x-yc-apigateway-integration:serverless_containers` extension.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}** from the list of services.
  1. Click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, enter the API gateway name: `mongo-express-gw`.
  1. Under **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}**, add the following specification:

      ```yaml
      openapi: 3.0.0
      info:
        title: Sample API
        version: 1.0.0
      paths:
        /{proxy+}:
          x-yc-apigateway-any-method:
            x-yc-apigateway-integration:
              type: serverless_containers
              container_id: <container_ID>
              service_account_id: <service_account_ID>
            parameters:
            - explode: false
              in: path
              name: proxy
              required: false
              schema:
                default: '-'
                type: string
              style: simple
      ```

      Where:

      * `container_id`: `mongo-express-container` ID.
      * `service_account_id`: `mongo-express` service account ID.

  1. Click **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.
  1. Open the created API gateway and copy the link from the **{{ ui-key.yacloud.serverless-functions.gateways.overview.label_domain }}** field.

- CLI {#cli}

  1. Create an [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification) specification file to describe your API.

      {% cut "Specification" %}

      ```yaml
      openapi: 3.0.0
      info:
        title: Sample API
        version: 1.0.0
      paths:
        /{proxy+}:
          x-yc-apigateway-any-method:
            x-yc-apigateway-integration:
              type: serverless_containers
              container_id: <container_ID>
              service_account_id: <service_account_ID>
            parameters:
            - explode: false
              in: path
              name: proxy
              required: false
              schema:
                default: '-'
                type: string
              style: simple
      ```

      Where:

      * `container_id`: `mongo-express-container` ID.
      * `service_account_id`: `mongo-express` service account ID.

      {% endcut %}

  1. Specify the properties and use the following command to create your API gateway:

      ```bash
      {{ yc-serverless }} api-gateway create \
          --name mongo-express-gw \
          --spec=<specification_file_path>
      ```

      Result:

      ```text
      id: d5d63uh1h26g********
      folder_id: b1g681qpemb4********
      created_at: "2025-06-14T10:23:19.682Z"
      name: mongo-express-gw
      status: ACTIVE
      domain: d5d63uh1h26g********.********.apigw.yandexcloud.net
      connectivity: {}
      log_options:
        folder_id: b1g681qpemb4********
      execution_timeout: 300s
      ```

      Save the link specified in the `domain` field.

- API {#api}

  To create an API gateway, use the [create](../../api-gateway/apigateway/api-ref/ApiGateway/create.md) REST API method for the [ApiGateway](../../api-gateway/apigateway/api-ref/ApiGateway/index.md) resource or the [ApiGatewayService/Create](../../api-gateway/apigateway/api-ref/grpc/ApiGateway/create.md) gRPC API call.

{% endlist %}


## Test the application {#check-app}

Follow the link formatted as `d5d63uh1h26g********.********.apigw.yandexcloud.net` obtained in the previous step. The {{ MG }} admin panel opens.


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete](../../api-gateway/operations/api-gw-delete.md) `mongo-express-gw`.
1. [Delete](../../serverless-containers/operations/delete.md) `mongo-express-container`.
1. [Delete](../../container-registry/operations/docker-image/docker-image-delete.md) the image from `app-registry`.
1. [Delete](../../container-registry/operations/registry/registry-delete.md) `app-registry`.
1. [Delete](../../lockbox/operations/secret-delete.md) the `mongodb-creds` secret.
1. [Delete](../../storedoc/operations/cluster-delete.md) `mongo-vm`.
1. [Delete](../../iam/operations/sa/delete.md) the `mongo-express` service account.
