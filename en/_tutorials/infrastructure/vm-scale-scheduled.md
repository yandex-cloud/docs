# Scheduled scaling of instance groups


Create a [{{ compute-full-name }}](../../compute/) [instance group](../../compute/concepts/instance-groups/index.md) and set up scheduled [scaling](../../compute/concepts/instance-groups/scale.md) for it. A [{{ sf-full-name }}](../../functions/) [function](../../functions/concepts/function.md) triggered by a [timer](../../functions/concepts/trigger/timer.md) will manage the instance group size.

To set up scaling for your instance group using standard tools, such as the [management console](../../console/), [CLI](../../cli/), or [API](../../api-design-guide/):
1. [Prepare your cloud](#before-begin).
1. [Create auxiliary resources](#create-aux-resources).
1. [Create an instance group](#create-ig).
1. [Create {{ sf-name }} resources](#create-sf-resources).
1. [Test instance group scaling](#test-scale).

If you no longer need the resources you created, [delete them](#clear-out).

You can also deploy an infrastructure for scaling your instance group via {{ TF }} using a [ready-made configuration file](#terraform).

## Prepare your cloud {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

We will use a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) named `example-folder` as an example.

### Required paid resources {#paid-resources}

The infrastructure cost includes:
* Using a [VM](../../compute/concepts/vm.md) (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Function calls, computing resources allocated to executing the function, and outgoing traffic (see [{{ sf-name }} pricing](../../functions/pricing.md)).

## Create auxiliary resources {#create-aux-resources}

### Create a service account {#create-sa}

The [service account](../../iam/concepts/users/service-accounts.md) will be linked to the {{ compute-name }} instance group and {{ sf-name }} function.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select `example-folder`.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. In the **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** field, specify `vm-scale-scheduled-sa`.
  1. Click ![](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the following [roles](../../iam/concepts/access-control/roles.md):
     * `compute.admin`: To manage the instance group.
     * `iam.serviceAccounts.user`: To link the service account to instances in the group.
     * `{{ roles-functions-invoker }}`: To call the {{ sf-name }} function.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- CLI {#cli}

  1. Create a service account:

     ```bash
     yc iam service-account create --name vm-scale-scheduled-sa \
       --folder-name example-folder
     ```

     Result:

     ```text
     id: ajeab0cnib1p********
     folder_id: b0g12ga82bcv********
     created_at: "2022-03-15T09:44:35.989446Z"
     name: vm-scale-scheduled-sa
     ```

     For more information about the `yc iam service-account create` command, see the [CLI reference](../../cli/cli-ref/managed-services/iam/service-account/create.md).
  1. Assign the following [roles](../../iam/concepts/access-control/roles.md) to the service account:
     * `compute.admin`: To manage the instance group:

       ```bash
       yc resource-manager folder add-access-binding example-folder \
         --service-account-name vm-scale-scheduled-sa \
         --role compute.admin \
         --folder-name example-folder
       ```

     * `iam.serviceAccounts.user`: To link the service account to instances in the group:

       ```bash
       yc resource-manager folder add-access-binding example-folder \
         --service-account-name vm-scale-scheduled-sa \
         --role iam.serviceAccounts.user \
         --folder-name example-folder
       ```

     * `{{ roles-functions-invoker }}`: To call the {{ sf-name }} function:

       ```bash
       yc resource-manager folder add-access-binding example-folder \
         --service-account-name vm-scale-scheduled-sa \
         --role {{ roles-functions-invoker }} \
         --folder-name example-folder
       ```

     For more information about the `yc resource-manager folder add-access-binding` command, see the [CLI reference](../../cli/cli-ref/managed-services/resource-manager/folder/add-access-binding.md).

- {{ TF }} {#tf}

  See [How to create an infrastructure using {{ TF }}](#terraform) for details.

- API {#api}

  1. Create a service account named `vm-scale-scheduled-sa`. To do this, use the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call.
  1. Assign the service account the following [roles](../../iam/concepts/access-control/roles.md) for the current folder:
     * `compute.admin`: To manage the instance group.
     * `iam.serviceAccounts.user`: To link the service account to instances in the group.
     * `{{ roles-functions-invoker }}`: To call the {{ sf-name }} function.

     To do this, use the [setAccessBindings](../../resource-manager/api-ref/Folder/setAccessBindings.md) REST API method for the [Folder](../../resource-manager/api-ref/Folder/index.md) resource or the [FolderService/SetAccessBindings](../../resource-manager/api-ref/grpc/Folder/setAccessBindings.md) gRPC API call.

- {{ TF }} {#tf}

  See [How to create an infrastructure using {{ TF }}](#terraform) for details.

{% endlist %}

### Create a cloud network {#create-network}

The instance group will be hosted in the [{{ vpc-full-name }}](../../vpc/) [cloud network](../../vpc/concepts/network.md#network) and its [subnets](../../vpc/concepts/network.md#subnet).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. At the top right, click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. In the **{{ ui-key.yacloud.vpc.networks.create.field_name }}** field, specify `vm-scale-scheduled-network`.
  1. Select **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.

- CLI {#cli}

  1. Create a network named `vm-scale-scheduled-network`:

     ```bash
     yc vpc network create --name vm-scale-scheduled-network \
       --folder-name example-folder
     ```

     Result:

     ```text
     id: enpabce123hd********
     folder_id: b0g12ga82bcv********
     created_at: "2022-03-15T09:55:50.004472Z"
     name: vm-scale-scheduled-network
     ```

     For more information about the `yc vpc network create` command, see the [CLI reference](../../cli/cli-ref/managed-services/vpc/network/create.md).
  1. Create a subnet named `vm-scale-scheduled-subnet-a` in the `{{ region-id }}-a` [availability zone](../../overview/concepts/geo-scope.md):

     ```bash
     yc vpc subnet create --name vm-scale-scheduled-subnet-a \
       --folder-name example-folder \
       --network-name vm-scale-scheduled-network --range 192.168.1.0/24 \
       --zone {{ region-id }}-a
     ```

     Result:

     ```text
     id: e1lnabc23r1c********
     folder_id: b0g12ga82bcv********
     created_at: "2022-03-15T09:56:51.859345Z"
     name: vm-scale-scheduled-subnet-a
     network_id: enpabce123hd********
     zone_id: {{ region-id }}-a
     v4_cidr_blocks:
     - 192.168.1.0/24
     ```

     For more information about the `yc vpc subnet create` command, see the [CLI reference](../../cli/cli-ref/managed-services/vpc/subnet/create.md).
  1. Create a subnet named `vm-scale-scheduled-network-b` in the `{{ region-id }}-b` availability zone:

     ```bash
     yc vpc subnet create --name vm-scale-scheduled-subnet-b \
       --folder-name example-folder \
       --network-name vm-scale-scheduled-network --range 192.168.2.0/24 \
       --zone {{ region-id }}-b
     ```

     Result:

     ```text
     id: b1csa2b3clid********
     folder_id: b0g12ga82bcv********
     created_at: "2022-03-15T09:57:48.934429Z"
     name: vm-scale-scheduled-subnet-b
     network_id: enpabce123hd********
     zone_id: {{ region-id }}-b
     v4_cidr_blocks:
     - 192.168.2.0/24
     ```

- {{ TF }} {#tf}

  See [How to create an infrastructure using {{ TF }}](#terraform) for details.

- API {#api}

  1. Create a network named `vm-scale-scheduled-network` using the [create](../../vpc/api-ref/Network/create.md) REST API method for the [Network](../../vpc/api-ref/Network/index.md) resource or the [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md) gRPC API call.
  1. Create a subnet named `vm-scale-scheduled-subnet-a` in the `{{ region-id }}-a` availability zone and `vm-scale-scheduled-subnet-b` in the `{{ region-id }}-b` availability zone using the [create](../../vpc/api-ref/Subnet/create.md) REST API method for the [Subnet](../../vpc/api-ref/Subnet/index.md) resource or the[ SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md) gRPC API call.

{% endlist %}

## Create an instance group {#create-ig}

An instance group will be created with manual scaling so that a {{ sf-name }} function can manage the group size.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select `example-folder`.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. At the top right, click **{{ ui-key.yacloud.compute.groups.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_base }}**:
     * In the **{{ ui-key.yacloud.compute.groups.create.field_name }}** field, specify `vm-scale-scheduled-ig`.
     * Select **{{ ui-key.yacloud.compute.groups.create.field_service-account }}** `vm-scale-scheduled-sa`.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_allocation }}**, select `{{ region-id }}-a` and `{{ region-id }}-b` in the **{{ ui-key.yacloud.compute.groups.create.field_zone }}** field.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_instance }}**, click **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}** and do the following in the window that opens:
     * Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select the [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts) image.
     * Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, specify the following configuration:
       * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`.
       * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`.
       * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `20%`.
       * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `2 {{ ui-key.yacloud.common.units.label_gigabyte }}`
     * Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
       * In the **{{ ui-key.yacloud.compute.instances.create.field_instance-group-network }}** field, select `vm-scale-scheduled-network`.
       * In the **{{ ui-key.yacloud.compute.instances.create.field_instance-group-address }}** field, select `{{ ui-key.yacloud.compute.instances.create.value_address-none }}`.
     * Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**:
       * In the **{{ ui-key.yacloud.compute.instances.create.field_service-account }}** field, select `vm-scale-scheduled-sa`.
       * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter the name of the user to be created on the VM. You can come up with any username you like.
       * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the public SSH key. You can create a key pair by following [this guide](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
     * Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_deploy }}**, specify the following configuration:
     * **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-expansion }}**: `2`. 
     * **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-unavailable }}**: `2`.
     * **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-creating }}**: `2`.
     * **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-deleting }}**: `2`.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_scale }}**:
     * In the **{{ ui-key.yacloud.compute.groups.create.field_scale-type }}** field, select `{{ ui-key.yacloud.compute.groups.create.value_scale-fixed }}`.
     * Specify **{{ ui-key.yacloud.compute.groups.create.field_scale-size }}** `2`.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  1. Get the IDs of the resources you created at the previous steps:
     * `vm-scale-scheduled-sa` service account ID:

       ```bash
       yc iam service-account get vm-scale-scheduled-sa \
         --folder-name example-folder | grep "^id"
       ```

       Result:

       ```text
       id: ajeab0cnib1p********
       ```

       For more information about the `yc iam service-account get` command, see the [CLI reference](../../cli/cli-ref/managed-services/iam/service-account/get.md).
     * `vm-scale-scheduled-network` network ID:

       ```bash
       yc vpc network get vm-scale-scheduled-network \
         --folder-name example-folder | grep "^id"
       ```

       Result:

       ```text
       id: enpabce123hd********
       ```

       For more information about the `yc vpc network get` command, see the [CLI reference](../../cli/cli-ref/managed-services/vpc/network/get.md).
     * `vm-scale-scheduled-subnet-a` subnet ID:

       ```bash
       yc vpc subnet get vm-scale-scheduled-subnet-a \
         --folder-name example-folder | grep "^id"
       ```

       Result:

       ```text
       id: e1lnabc23r1c********
       ```

       For more information about the `yc vpc subnet get` command, see the [CLI reference](../../cli/cli-ref/managed-services/vpc/subnet/get.md).
     * `vm-scale-scheduled-subnet-b` subnet ID:

       ```bash
       yc vpc subnet get vm-scale-scheduled-subnet-b \
         --folder-name example-folder | grep "^id"
       ```

       Result:

       ```text
       id: b1csa2b3clid********
       ```

       For more information about the `yc vpc subnet get` command, see the [CLI reference](../../cli/cli-ref/managed-services/vpc/subnet/get.md).
  1. Get the ID of the latest version of the [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts) public image:

     ```bash
     yc compute image get-latest-from-family ubuntu-2004-lts \
       --folder-id standard-images | grep "^id"
     ```

     Result:

     ```text
     id: fd83n3uou8m0********
     ```

     For more information about the `yc compute image get-latest-from-family` command, see the [CLI reference](../../cli/cli-ref/managed-services/compute/image/get-latest-from-family.md).
  1. Insert the obtained IDs in the `specification.yaml` file with the VM group specification:

     {% include [vm-scale-scheduled-yaml-spec-init](../../_includes/instance-groups/vm-scale-scheduled-yaml-spec-init.md) %}

  1. Create an instance group named `vm-scale-scheduled-ig` based on `specification.yaml`:

     ```bash
     yc compute instance-group create --file specification.yaml \
       --folder-name example-folder
     ```

     Result:

     ```text
     done (2m18s)
     id: cl0kabcquk1g********
     folder_id: b0g12ga82bcv********
     ...
     service_account_id: ajeab0cnib1p********
     status: ACTIVE
     ```

- {{ TF }} {#tf}

  See [How to create an infrastructure using {{ TF }}](#terraform) for details.

- API {#api}

  1. Get the IDs of the resources you created at the previous steps:
     * `vm-scale-scheduled-sa` service account ID: Using the [get](../../iam/api-ref/ServiceAccount/get.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Get](../../iam/api-ref/grpc/ServiceAccount/get.md) gRPC API call.
     * `vm-scale-scheduled-network` network ID: Using the [get](../../vpc/api-ref/Network/get.md) REST API method for the [Network](../../vpc/api-ref/Network/index.md) resource or the [NetworkService/Get](../../vpc/api-ref/grpc/Network/get.md) gRPC API call.
     * `vm-scale-scheduled-subnet-a` and `vm-scale-scheduled-subnet-b` subnet IDs: Using the [get](../../vpc/api-ref/Subnet/get.md) REST API method for the [Subnet](../../vpc/api-ref/Subnet/index.md) resource or the [SubnetService/Get](../../vpc/api-ref/grpc/Subnet/get.md) gRPC API call.
  1. Get the ID of the latest version of the public [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts) image in the `standard-images` family using the [getLatestByFamily](../../compute/api-ref/Image/getLatestByFamily.md) REST API method for the [Image](../../compute/api-ref/Image/index.md) resource or the [ImageService/GetLatestByFamily](../../compute/api-ref/grpc/Image/getLatestByFamily.md) gRPC API call.
  1. Insert the obtained IDs in the `specification.yaml` file with the VM group specification:

     {% include [vm-scale-scheduled-yaml-spec-init](../../_includes/instance-groups/vm-scale-scheduled-yaml-spec-init.md) %}

  1. Create an instance group named `vm-scale-scheduled-ig` based on `specification.yaml`. To do this, use the [createFromYaml](../../compute/instancegroup/api-ref/InstanceGroup/createFromYaml.md) REST API method for the [InstanceGroup](../../compute/instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/CreateFromYaml](../../compute/instancegroup/api-ref/grpc/InstanceGroup/createFromYaml.md) gRPC API call.

- {{ TF }} {#tf}

  See [How to create an infrastructure using {{ TF }}](#terraform) for details.

{% endlist %}

## Create {{ sf-name }} resources {#create-sf-resources}

### Create a function {#create-function}

The function will contain the code with the {{ yandex-cloud }} CLI commands that update the instance group.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select `example-folder`.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. At the top right, click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, specify `vm-scale-scheduled-function`.
  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Select the **Bash** runtime environment.
  1. Enable **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
  1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}**, select the `handler.sh` file.
  1. Replace the file contents with the code below:

     {% include [vm-scale-scheduled-function-code.md](../../_includes/instance-groups/vm-scale-scheduled-function-code.md) %}

  1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**:
     * Set the **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** field value to `60`.
     * In the **{{ ui-key.yacloud.forms.label_service-account-select }}** field, select `vm-scale-scheduled-sa`.
     * Under **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**, add the following variables:
       * `IG_NAME` = `vm-scale-scheduled-ig`.
       * `IG_BASE_SIZE` = `2`.
       * `FOLDER_ID` = Folder ID. You can get the ID by following [this guide](../../resource-manager/operations/folder/get-id.md).
  1. In the top-right corner, click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

  1. Create a file named `config.pkr.hcl` with the following code:

     {% include [vm-scale-scheduled-function-code.md](../../_includes/instance-groups/vm-scale-scheduled-function-code.md) %}

  1. Create a function:
 
     ```bash
     yc serverless function create vm-scale-scheduled-function \
       --folder-name example-folder
     ```

     Result:

     ```text
     done (1s)
     id: d4e7d67ikvmq********
     folder_id: b1g9hv2loamq********
     ...
     log_group_id: ckgij6l0845h********
     http_invoke_url: https://{{ sf-url }}/d4e7d67ikvmq********
     status: ACTIVE
     ```

  1. Create a function version:

     ```bash
     yc serverless function version create --folder-name example-folder \
       --function-name vm-scale-scheduled-function --runtime bash \
       --source-path ./handler.sh --entrypoint "handler.sh" \
       --execution-timeout 60s \
       --service-account-id <service_account_ID> \
       --environment \
         IG_NAME=vm-scale-scheduled-ig,IG_BASE_SIZE=2,FOLDER_ID=<folder_ID>
     ```

     Where:
     * `--service-account-id`: `vm-scale-schedule-sa` service account ID. To get the ID, follow the [Create a VM group](#create-ig) step on the **CLI** tab.
     * `FOLDER_ID` in `--environment`: Folder ID. You can get the ID by following [this guide](../../resource-manager/operations/folder/get-id.md).

     Result:

     ```text
     done (1s)
     id: d4efmv9n3qf1********
     function_id: d4e7d67ikvmq********
     ...
       FOLDER_ID: b1g9hv2loamq********
       IG_BASE_SIZE: "2"
       IG_NAME: vm-scale-scheduled-ig
     ```

- {{ TF }} {#tf}

  See [How to create an infrastructure using {{ TF }}](#terraform) for details.

- API {#api}

  1. Create a function named `vm-scale-scheduled-function` using the [create](../../functions/functions/api-ref/Function/create.md) REST API method for the [Function](../../functions/functions/api-ref/Function/index.md) resource or the [FunctionService/Create](../../functions/functions/api-ref/grpc/Function/create.md) gRPC API call. You can find the ID of the created function in the output.
  1. Create a function version using the [createVersion](../../functions/functions/api-ref/Function/createVersion.md) REST API method for the [Function](../../functions/functions/api-ref/Function/index.md) resource or the [FunctionService/CreateVersion](../../functions/functions/api-ref/grpc/Function/createVersion.md) gRPC API call. The function version should have the following code:

     {% include [vm-scale-scheduled-function-code.md](../../_includes/instance-groups/vm-scale-scheduled-function-code.md) %}

- {{ TF }} {#tf}

  See [How to create an infrastructure using {{ TF }}](#terraform) for details.

{% endlist %}

### Create a trigger {#create-trigger}

A [trigger](../../functions/concepts/trigger/index.md) sets conditions for running a function. For scheduled function calls, use a [timer trigger](../../functions/concepts/trigger/timer.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select `example-folder`.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. At the top right, click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:
     * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_name }}** field, specify `vm-scale-scheduled-trigger`.
     * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_timer }}`.
     * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}`.
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_timer }}**, in the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_cron-expression }}** field, specify `*/2 * * * ? *`. The trigger will fire every two minutes, e.g., at 09:58, 10:00, 10:02, 10:04, etc.
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**:
     * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function }}** field, specify `vm-scale-scheduled-function`.
     * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function-tag }}** field, select `$latest`.
     * Select **{{ ui-key.yacloud.serverless-functions.triggers.form.field_function_service-account }}** `vm-scale-scheduled-sa`.
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}**, reset the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_dlq_service-account }}** (`{{ ui-key.yacloud.component.service-account-select.label_no-service-account }}`) field.
  1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

  Run the following command:

  ```bash
  yc serverless trigger create timer --folder-name example-folder \
    --name vm-scale-scheduled-trigger \
    --cron-expression "*/2 * * * ? *" \
    --invoke-function-name vm-scale-scheduled-function \
    --invoke-function-tag '$latest' \
    --invoke-function-service-account-name vm-scale-scheduled-sa
  ```

  Result:

  ```text
  id: a1s22pb0v5i4********
  folder_id: b1g9hv2loamq********
  created_at: "2022-04-06T14:56:54.253709098Z"
  ...
        function_tag: $latest
        service_account_id: aje9s4pud13h********
  status: ACTIVE
  ```

- {{ TF }} {#tf}

  See [How to create an infrastructure using {{ TF }}](#terraform) for details.

- API {#api}

  Use the [create](../../functions/triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../../functions/triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../functions/triggers/api-ref/grpc/Trigger/create.md) gRPC API call to create a trigger of the `timer` type with the `*/2 * * * ? *` cron expression. This trigger will be linked with the `vm-scale-scheduled-function` function of the `$latest` version and the `vm-scale-scheduled-sa` service account.

{% endlist %}

## Test instance group scaling {#test-scale}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select `example-folder`.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. Select the `vm-scale-scheduled-ig` group.
  1. Under **{{ ui-key.yacloud.compute.group.overview.section_instances-state }}**, make sure the number of instances changes every two minutes: increases from 2 to 3, then decreases from 3 to 2, etc. You can also check if the instance group has been updated by opening the ![image](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** tab.

- CLI {#cli}

  Run the following command several times:

  ```bash
  yc compute instance-group get vm-scale-scheduled-ig \
    --folder-name example-folder
  ```

  Result:

  ```text
  id: cl1l0ljqbmkp********
  folder_id: b1g9hv2loamq********
  created_at: "2022-03-28T13:24:20.693Z"
  ...
  managed_instances_state:
    target_size: "2"
    running_actual_count: "2"
  ...
  ```

  The value of the `target_size` field for the group should change from `2` to `3` and back.

- API {#api}

  Get information about the `vm-scale-scheduled-ig` instance group multiple times using the [get](../../compute/instancegroup/api-ref/InstanceGroup/get.md) REST API method for the [InstanceGroup](../../compute/instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Get](../../compute/instancegroup/api-ref/grpc/InstanceGroup/get.md) gRPC API call. The value of the `target_size` field for the group should change from `2` to `3` and back.

{% endlist %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. [Delete](../../functions/operations/trigger/trigger-delete.md) the `vm-scale-scheduled-trigger` trigger.
1. [Delete](../../functions/operations/function/function-delete.md) the `vm-scale-scheduled-function` function.
1. [Delete](../../compute/operations/instance-groups/delete.md) the `vm-scale-scheduled-ig` instance group.

## How to create an infrastructure using {{ TF }} {#terraform}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

To set up scaling for your instance group using {{ TF }}:
1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Prepare files with the infrastructure description:

   {% list tabs group=infrastructure_description %}

   - Ready-made archive {#ready}

     1. Create a folder for files.
     1. Download the [archive](https://{{ s3-storage-host }}/doc-files/vm-scale-scheduled-terraform.zip) (2 KB).
     1. Unpack the archive to the directory. As a result, it should contain the `vm-scale-scheduled.tf` configuration file and the `vm-scale-scheduled-function.zip` archive with the {{ sf-name }} function code.

   - Manually {#manual}

     1. Create a folder for files.
     1. In the folder, create:
        * `vm-scale-scheduled.tf` configuration file

          {% cut "vm-scale-scheduled.tf" %}

          {% include [vm-scale-scheduled-tf-config](../../_includes/instance-groups/vm-scale-scheduled-tf-config.md) %}

          {% endcut %}

        * `handler.sh` file with the {{ sf-name }} function code:

          {% cut "handler.sh" %}

          {% include [warning-unix-lines](../_tutorials_includes/warning-unix-lines.md) %}

          {% include [vm-scale-scheduled-function-code](../../_includes/instance-groups/vm-scale-scheduled-function-code.md) %}

          {% endcut %}

     1. In the folder, create the `vm-scale-scheduled-function.zip` archive that contains the `handler.sh` file. Next, delete the `handler.sh` file outside the archive.

   {% endlist %}

1. Under `vm-scale-scheduled.tf`, insert the following values in the `locals` section:
   * `token`: [OAuth token](../../iam/concepts/authorization/oauth-token.md) (if you are using a [Yandex account](../../iam/concepts/users/accounts.md#passport)) or [{{ iam-full-name }} token](../../iam/concepts/authorization/iam-token.md) (if you are using a Yandex account or [federated account](../../iam/concepts/users/accounts.md#saml-federation)) to access {{ yandex-cloud }}. The {{ iam-name }} token is valid for up to 12 hours but cannot exceed the federation cookie lifetime.
   * `cloud_id`: [ID of the cloud](../../resource-manager/operations/cloud/get-id.md) to create the resources in.
   * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) to create the resources in.
   * `username`: Name of the user to create in the VM. You can come up with any username you like.
   * `ssh_key_path`: Path to the file with a public SSH key to authenticate the user on the VM. You can create a key pair by following [this guide](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
1. Create resources:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

1. [Test instance group scaling](#test-scale).