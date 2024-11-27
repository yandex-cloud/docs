# Running a containerized app in {{ serverless-containers-full-name }}


Follow this guide to deploy a containerized app in [{{ serverless-containers-name }}](../../serverless-containers/) to administer a {{ MG }} DBMS.

The DBMS is deployed on a [{{ compute-full-name }}](../../compute/) VM. A [{{ container-registry-full-name }}](../../container-registry/) registry is used to host the container with the app. [{{ lockbox-full-name }}](../../lockbox/) is used to encrypt sensitive data. Secure access to the application is enabled over the [{{ api-gw-full-name }}](../../api-gateway/) API gateway. The entire infrastructure of the containerized app resides in a single folder.

To deploy your containerized app:

1. [Prepare your cloud](#before-you-begin).
1. [Create a service account](#sa-create).
1. [Create a network and configure the security group](#create-network).
1. [Create a {{ compute-name }} VM with {{ MG }}](#create-vm).
1. [Create a {{ lockbox-name }} secret and version](#secret-create).
1. [Create a registry in {{ container-registry-name }}](#create-registry).
1. [Push the Docker image to {{ container-registry-name }}](#push-image).
1. [Create a {{ serverless-containers-name }} container](#create-container).
1. [Create an {{ api-gw-name }} API gateway](#create-api-gw).
1. [Test the application](#check-app).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The application support cost includes:

* Fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Secret storage fees (see [{{ lockbox-full-name }} pricing](../../lockbox/pricing.md)).
* Fee for storing a Docker image (see [{{ container-registry-full-name }} pricing](../../container-registry/pricing.md)).
* Fee for the number of container calls, computing resources allocated to execute the application, and outgoing traffic (see [{{ serverless-containers-name }} pricing](../../serverless-containers/pricing.md)).
* Fee for requests to the API gateway (see [{{ api-gw-full-name }} pricing](../../api-gateway/pricing.md)).

## Create a service account {#sa-create}

Create a [service account](../../iam/concepts/users/service-accounts.md) and assign it the [roles](../../iam/concepts/access-control/roles.md) for the folder to host the containerized app infrastructure.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{link-console-main}}), go to the folder that will host the containerized app infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Enter the service account name: `mongo-express`.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `{{ roles-cr-puller }}`, `{{ roles-lockbox-payloadviewer }}`, and `serverless-containers.containerInvoker` [roles](../../load-testing/security/index.md#roles-list).
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Create a service account named `mongo-express`:

      ```bash
      yc iam service-account create --name mongo-express
      ```

  1. Assign the service account the `{{ roles-cr-puller }}`, `{{ roles-lockbox-payloadviewer }}`, and `serverless-containers.containerInvoker` roles for the folder that will host your container:

      ```bash
      yc resource-manager folder add-access-binding <folder_name_or_ID> \
        --role {{ roles-cr-puller }}, {{ roles-lockbox-payloadviewer }}, serverless-containers.containerInvoker \
        --subject serviceAccount:<service_account_ID>
      ```

      Where:

      * `<folder_name_or_ID>`: Name or ID of the folder to host the container.
      * `--subject serviceAccount`: `mongo-express` service account ID.

- API {#api}

  To create a service account, use the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call.

  To assign the service account a role for the folder, use the [updateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md) REST API method for the [Folder](../../resource-manager/api-ref/Folder/index.md) resource or the [FolderService/UpdateAccessBindings](../../resource-manager/api-ref/grpc/Folder/updateAccessBindings.md) gRPC API call.


{% endlist %}

## Create a network and configure the security group {#create-network}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder to host the network.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. At the top right, click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. In the **{{ ui-key.yacloud.vpc.networks.create.field_name }}** field, specify `mongo-express-network`.
  1. In the **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** field, select **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. In the left-hand panel, select ![image](../../_assets/vpc/security-group.svg) **{{ ui-key.yacloud.vpc.switch_security-groups }}**.
  1. Click the ![image](../../_assets/options.svg) icon next to the default security group created for `mongo-express-network`.
  1. In the menu that opens, click **{{ ui-key.yacloud.common.edit }}**.
  1. Configure the security group:

     1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
     1. Under **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}**, add a rule using the instructions below the table:

        | Traffic<br/>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
        | --- | --- | --- | --- | --- | --- |
        | `Incoming` | `any` | `27017` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |

        1. Select the **{{ ui-key.yacloud.vpc.network.security-groups.label_egress }}** or **{{ ui-key.yacloud.vpc.network.security-groups.label_ingress }}** tab.
        1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_add-rule }}**.
        1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** field of the window that opens, specify a single port or a range of ports that traffic will come to or from. To open all ports, click **{{ ui-key.yacloud.vpc.network.security-groups.forms.button_select-all-port-range }}**.
        1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** field, specify the appropriate protocol or leave **{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}** to allow traffic transmission over any protocol.
        1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** or **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** field, select the `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`, and the rule will apply to a range of IP addresses. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** field, specify `0.0.0.0/0`.
        1. Click **{{ ui-key.yacloud.common.save }}**.
   
     1. Click **{{ ui-key.yacloud.common.save }}**.
     1. Click **{{ ui-key.yacloud.common.save }}** once again.

- CLI {#cli}

  1. Create a cloud network:

      ```
      yc vpc network create \
        --name mongo-express-network
      ```

  1. Get the name or ID of the group to edit:

     ```
     yc vpc security-groups list
     ```

     Result:

     ```
     +----------------------+---------------------------------+------------------------------------+----------------------+
     |          ID          |              NAME               |          DESCRIPTION               |      NETWORK-ID      |
     +----------------------+---------------------------------+------------------------------------+----------------------+
     | enp9bmjge93b******** | default-sg-enp509crtquf******** | Default security group for network | enp509crtquf******** |
     +----------------------+---------------------------------+------------------------------------+----------------------+
     ```

  1. Add a rule using the `update-rules` command and the `--add-rule` parameter:

     ```
     yc vpc security-group update-rules <group_name_or_ID> \
       --add-rule "direction=ingress,port=27017,protocol=any,v4-cidrs=[0.0.0.0/0,0.0.0.0/0]"
     ```

     Where `<group_name_or_ID>` is the value obtained at the previous step.

- API {#api}

  1. To create a [cloud network](../../vpc/concepts/network.md), use the [create](../../vpc/api-ref/Network/create.md) REST API method for the [Network](../../vpc/api-ref/Network/index.md) resource or the [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md) gRPC API call, and provide the following in the request:

      * ID of the folder to host the network.
      * Name of the new network,`mongo-express-network`, in the `name` parameter.

  1. To add a rule to a security group, use the [updateRules](../../vpc/api-ref/SecurityGroup/updateRules.md) REST API method for the [SecurityGroup](../../vpc/api-ref/SecurityGroup/index.md) resource or the [SecurityGroupService/UpdateRules](../../vpc/api-ref/grpc/SecurityGroup/updateRules.md) gRPC API call, and provide the following in your request:

      * ID of the security group you want to add rules to, in the `securityGroupId` parameter.

        {% include [get-security-group-id](../../_includes/vpc/get-security-group-id.md) %}

      * New security group rules, in the `additionRuleSpecs[]` array:

        * Traffic direction: `ingress`.
        * Name of the traffic transmission protocol, in the `additionRuleSpecs[].protocolName` parameter: `any`.
        * List of CIDRs and subnet masks, in the `additionRuleSpecs[].cidrBlocks.v4CidrBlocks[]` parameter: `[0.0.0.0/0,0.0.0.0/0]`.
        * First port in the traffic ports range, in the `additionRuleSpecs[].ports.fromPort` parameter: `0`.
        * Last port in the traffic ports range, in the `additionRuleSpecs[].ports.toPort` parameter: `65535`.

{% endlist %}

## Create a VM with {{ MG }} {#create-vm}

We recommend using a [VM](../../compute/concepts/vm.md) with basic configuration.

{% list tabs group=instructions %}

- Management console {#console}

  1. On the [folder page](../../resource-manager/concepts/resources-hierarchy.md#folder) in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.  
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**:

      1. Go to the **{{ ui-key.yacloud.compute.instances.create.image_value_coi }}** tab and click **{{ ui-key.yacloud.compute.instances.create.image_coi_label_empty-button }}**.
      1. In the window that opens, go to the **{{ ui-key.yacloud.compute.instances.create.value_docker-compose-yaml }}** tab and enter the VM specification:

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

         In the `MONGO_INITDB_ROOT_PASSWORD` parameter, specify the password to use for accessing the database. To create a password, you can use the [password generator](https://passwordsgenerator.net/). Save the password as you will need it in the next steps.

      1. Click **{{ ui-key.yacloud.common.apply }}**.

  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../overview/concepts/geo-scope.md) to create your VM in. If you do not know which availability zone you need, leave the default one.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select a subnet in the `mongo-express-network` network you created earlier.
      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access data:

      * Under **{{ ui-key.yacloud.compute.instances.create.field_user }}**, enter the username. Do not use `root` or other names reserved by the OS. To perform operations requiring superuser permissions, use the `sudo` command.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `mongo-vm`.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  Wait for the VM status to change to `Running` and save its public IP address: you will need it for connecting to the database.

- CLI {#cli}

  1. [Prepare](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair (public and private keys) for SSH access to the VM.

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

     In the `MONGO_INITDB_ROOT_PASSWORD` parameter, specify the password to use for accessing the database. To create a password, you can use the [password generator](https://passwordsgenerator.net/). Save the password as you will need it in the next steps.



  1. Run this command:

     ```bash
     yc compute instance create-with-container \
       --coi-spec-file docker-spec.yaml \
       --name mongo-vm \
       --zone {{ region-id }}-b \
       --ssh-key ssh-key.pub \
       --create-boot-disk size=30 
     ```

     Where:
     * `--coi-spec-file`: Path to the Docker container [specification file](../../cos/concepts/coi-specifications.md#coi-spec).
     * `--name`: VM name.
     * `--zone`: Availability zone.
     * `--ssh-key`: Contents of the [public key](../../compute/quickstart/quick-create-linux.md#create-ssh) file. You need to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair for the SSH connection yourself.
      * `--create-boot-disk size`: Boot disk size. It must be at least 30 GB.

     Result:

     ```text
     done (1m40s)
      id: epde18u4mahl********
      folder_id: b1g7gvsi89m3********
      created_at: "2023-02-08T10:34:06.601Z"
      name: mongo-vm
      ...
     ```

{% endlist %}

## Create a {{ lockbox-name}} secret {#secret-create}

A [{{ lockbox-name }} secret](../../lockbox/concepts/secret.md) will store the encrypted authentication credentials.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [secret](../../lockbox/concepts/secret.md).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Click **{{ ui-key.yacloud.lockbox.button_create-secret }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the secret: `mongodb-creds`.
  1. Under **{{ ui-key.yacloud.lockbox.label_version-dialog-title }}**:
      * In the **{{ ui-key.yacloud.lockbox.forms.label_key }}** field, enter `login`.
      * In the **{{ ui-key.yacloud.lockbox.forms.label_value }}** field, enter `mongo_db_user` as your DB user login.
  1. Click **{{ ui-key.yacloud.lockbox.forms.button_add-pair }}** and specify the second secret:
      * In the **{{ ui-key.yacloud.lockbox.forms.label_key }}** field, enter `password`.
      * In the **{{ ui-key.yacloud.lockbox.forms.label_value }}** field, enter the password to access the database: the `MONGO_INITDB_ROOT_PASSWORD` value from the [VM specification](#create-vm).
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  1. Use the following command to create the `mongodb-creds` secret:
  
     ```bash
     yc lockbox secret create \
       --name mongodb-creds \
       --payload "[{'key': 'login', 'text_value': 'mongo_db_user'},{'key': 'password', 'text_value': '<password>'}]" 
     ```

     Where:

     * `--name`: Secret name.
     * `--payload`: Contents of the secret as a YAML or JSON array.
     * `<password>`: `MONGO_INITDB_ROOT_PASSWORD` value from the [VM specification](#create-vm).

     Result:
     
     ```
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

  1. In the [management console]({{ link-console-main }}), select the folder to create a registry in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Click **{{ ui-key.yacloud.cr.overview.button_create }}**.
  1. Specify a name for the registry: `app-registry`.
  1. Click **{{ ui-key.yacloud.cr.overview.popup-create_button_create }}**.

- CLI {#cli}

  Create the `app-registry` registry:

  ```bash
  yc container registry create --name app-registry
  ```

  Result:

  ```text
  done
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

   * [Install on Windows](https://docs.docker.com/desktop/install/windows-install/).
   * [Install on Linux](https://docs.docker.com/desktop/install/linux-install/).
   * [Install on Mac OS](https://docs.docker.com/desktop/install/mac-install/).

1. [Download](https://hub.docker.com/_/mongo-express) the `mongo-express` image:

   ```
   docker pull mongo-express
   ```

   The result will be as follows:

   ```
   Using default tag: latest
   latest: Pulling from library/mongo-express
   6a428f9f83b0: Pull complete
   f2b1fb32259e: Pull complete
   40888f2a0a1f: Pull complete
   4e3cc9ce09be: Pull complete
   eaa1898f3899: Pull complete
   ab4078090382: Pull complete
   ae780a42c79e: Pull complete
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

         Settings are saved in the current user's profile.

      1. Check that the `${HOME}/.docker/config.json` configuration file includes the following line:

         ```json
         "{{ registry }}": "yc"
         ```

      Docker is ready to use.

    {% endlist %}

1. [Push](../../container-registry/operations/docker-image/docker-image-push.md) the Docker image to the registry:

    {% list tabs group=instructions %}

    - CLI {#cli}

      1. Assign a URL to the pushed `mongo-express` image using the following format: `{{ registry }}/<registry_ID>/<Docker_image_name>:<tag>`:

         ```
         docker tag mongo-express \
         {{ registry }}/<registry_ID>/mongo-express:mongo-tag
         ```

      1. Push the `mongo-express` image to the registry:

         ```
         docker push {{ registry }}/<registry_ID>/mongo-express:mongo-tag
         ```

    {% endlist %}

## Create a {{ serverless-containers-name }} container {#create-container}

To run your application in {{ yandex-cloud }}, create a [container](../../serverless-containers/concepts/container.md) and its [revision](../../serverless-containers/concepts/container.md#revision):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a container.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
  1. Click **{{ ui-key.yacloud.serverless-containers.button_create-container }}**.
  1. Enter the container name: `mongo-express-container`.
  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Go to the **{{ ui-key.yacloud.serverless-containers.label_editor }}** tab.
     1. Under **{{ ui-key.yacloud.serverless-containers.section_resources }}**, enter the amount of RAM: `1024 {{ ui-key.yacloud.common.units.label_megabyte }}`.
     1. Under **{{ ui-key.yacloud.serverless-containers.section_image }}**:
        1. In the **{{ ui-key.yacloud.serverless-containers.label_image-url }}** field, specify the Docker image you pushed [previously](#push-image).
        1. In the **{{ ui-key.yacloud.serverless-containers.label_environment }}** field, add the following variables:
           * `ME_CONFIG_BASICAUTH_USERNAME`: Leave empty.
           * `ME_CONFIG_BASICAUTH_PASSWORD`: Leave empty.
           * `VCAP_APP_PORT`: Set the port to `8080`.
           * `ME_CONFIG_MONGODB_SERVER`: Specify the VM public IP address obtained [previously](#create-vm).
        1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret }}** field, specify these secrets:
           * `ME_CONFIG_MONGODB_AUTH_USERNAME`: Secret with the `login` key.
           * `ME_CONFIG_MONGODB_AUTH_PASSWORD`: Secret with the `password` key.
     1. Under **{{ ui-key.yacloud.serverless-containers.section_parameters }}**:
        1. In the **{{ ui-key.yacloud.serverless-containers.label_service-account }}** field, specify `mongo-express`.
        1. In the **{{ ui-key.yacloud.serverless-containers.label_timeout }}** field, specify `15`.
  1. Click **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.

- CLI {#cli}

  1. Create a container:

      ```
      yc serverless container create --name mongo-express-container
      ```

      Result:

      ```
      id: bba3fva6ka5g********
      folder_id: b1gqvft7kjk3********
      created_at: "2023-02-08T10:34:06.601Z"
      name: mongo-express-container
      url: https://bba3fva6ka5g********.{{ serverless-containers-host }}/
      status: ACTIVE
      ```

  1. Create a container revision:

      ```
      yc serverless container revision deploy \
        --container-name mongo-express-container \
        --image <Docker_image_URL> \
        --cores 1 \
        --memory 1GB \
        --concurrency 1 \
        --execution-timeout 15s \
        --service-account-id <mongo_express_service_account_ID> \
        --environment ME_CONFIG_BASICAUTH_USERNAME="", ME_CONFIG_BASICAUTH_PASSWORD="", VCAP_APP_PORT=8080, ME_CONFIG_MONGODB_SERVER=<VM_public_address> \
        --secret environment-variable=ME_CONFIG_MONGODB_AUTH_USERNAME,key=login \
        --secret environment-variable=ME_CONFIG_MONGODB_AUTH_PASSWORD,key=password
      ```

      Where:

      * `--image`: URL of the `mongo-express` Docker image you pushed [earlier](#push-image).
      * `--service-account-id`: [ID of the `mongo-express` service account](../../iam/operations/sa/get-id.md) you created [earlier](#sa-create).
      * `--environment`: Environment variables:

        * `ME_CONFIG_BASICAUTH_USERNAME`: Leave empty.
        * `ME_CONFIG_BASICAUTH_PASSWORD`: Leave empty.
        * `VCAP_APP_PORT`: Set the port to `8080`.
        * `ME_CONFIG_MONGODB_SERVER`: Specify the VM public IP address obtained [previously](#create-vm).

      * `--secret environment-variable`: `ME_CONFIG_MONGODB_AUTH_USERNAME` and `ME_CONFIG_MONGODB_AUTH_PASSWORD` secrets you created [earlier](#secret-create).

      Result:

      ```
      id: bbajn5q2d74c********
      container_id: bba3fva6ka5g********
      created_at: "2023-02-08T10:34:06.601Z"
      image:
        image_url: {{ registry }}/crpd3cicopk7********/mongo-express-container:latest
        image_digest: sha256:de8e1dce7ceceeafaae122f7670084a1119c961cd9ea1795eae92bd********
      resources:
        memory: "1073741824"
        cores: "1"
      execution_timeout: 15s
      service_account_id: ajeqnasj95o7********
      status: ACTIVE
      ```

- API {#api}

  To create a container, use the [create](../../serverless-containers/containers/api-ref/Container/create.md) REST API method for the [Container](../../serverless-containers/containers/api-ref/Container/index.md) resource or the [ContainerService/Create](../../serverless-containers/containers/api-ref/grpc/Container/create.md) gRPC API call.

  To create a container revision, use the [deployRevision](../../serverless-containers/containers/api-ref/Container/deployRevision.md) REST API method for the [Container](../../serverless-containers/containers/api-ref/Container/index.md) resource or the [ContainerService/DeployRevision](../../serverless-containers/containers/api-ref/grpc/Container/deployRevision.md) gRPC API call.

{% endlist %}

## Create an {{ api-gw-name }} {#create-api-gw}

Create an [API gateway](../../api-gateway/concepts/index.md) with the `x-yc-apigateway-integration:serverless_containers` extension.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create an API gateway.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the API gateway: `mongo-express-gw`.
  1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** section, add the specification:

      ```yaml
      openapi: 3.0.0
      info:
        title: Sample API
        version: 1.0.0
      servers:
        - url: https://mongo-express-container.apigw.yandexcloud.net
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

      * `container_id`: Container ID for `mongo-express-container`.
      * `service_account_id`: `mongo-express` service account ID.

  1. Click **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.

- CLI {#cli}

  1. Prepare an [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification) API specification file.

      {% cut "Specification" %}

      ```yaml
      openapi: 3.0.0
      info:
        title: Sample API
        version: 1.0.0
      servers:
        - url: https://mongo-express-container.apigw.yandexcloud.net
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

      * `container_id`: Container ID for `mongo-express-container`.
      * `service_account_id`: `mongo-express` service account ID.

      {% endcut %}

  1. Specify the parameters and create an API gateway using this command:

      ```bash
      {{ yc-serverless }} api-gateway create \
          --name mongo-express-gw \
          --spec=<specification_file_path>
      ```

- API {#api}

  To create an API gateway, use the [create](../../api-gateway/apigateway/api-ref/ApiGateway/create.md) REST API method for the [ApiGateway](../../api-gateway/apigateway/api-ref/ApiGateway/index.md) resource or the [ApiGatewayService/Create](../../api-gateway/apigateway/api-ref/grpc/ApiGateway/create.md) gRPC API call.

{% endlist %}

## Test the application {#check-app}

Click `https://mongo-express-container.apigw.yandexcloud.net` to use the MongoDB admin panel.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete](../../api-gateway/operations/api-gw-delete.md) the `mongo-express-gw` API gateway.
1. [Delete](../../serverless-containers/operations/delete.md) the `mongo-express-container` container.
1. [Delete](../../container-registry/operations/docker-image/docker-image-delete.md) the image from `app-registry`.
1. [Delete](../../container-registry/operations/registry/registry-delete.md) the `app-registry` registry.
1. [Delete `mongodb-creds`](../../lockbox/operations/secret-delete.md).
1. [Delete](../../managed-mongodb/operations/cluster-delete.md) `mongo-vm`.
1. [Delete](../../iam/operations/sa/delete.md) the `mongo-express` service account.
