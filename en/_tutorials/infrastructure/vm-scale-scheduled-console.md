1. [Get your cloud ready](#before-begin).
1. [Create an instance group](#create-ig).
1. [Create the {{ sf-name }}](#create-sf-resources) resources.
1. [Test instance group scaling](#test-scale).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

We will use a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) named `example-folder` as an example.

### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/vm-scale-scheduled/paid-resources.md) %}

## Create the auxiliary resources {#create-aux-resources}

### Create a service account {#create-sa}

The [service account](../../iam/concepts/users/service-accounts.md) will be linked to the {{ compute-name }} instance group and the {{ sf-name }} function.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
  1. At the top of the screen, navigate to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
  1. At the top right, click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. In the **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** field, specify `vm-scale-scheduled-sa`.
  1. Click ![](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select these [roles](../../iam/concepts/access-control/roles.md):
     * `compute.editor`: To manage the instance group.
     * `iam.serviceAccounts.user`: To link the service account to the group’s VM instances.
     * `{{ roles-functions-invoker }}`: To call the {{ sf-name }} function.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- CLI {#cli}

  1. Create a service account:

     ```bash
     yc iam service-account create --name vm-scale-scheduled-sa \
       --folder-name example-folder
     ```

     Result:

     ```yaml
     id: ajeab0cnib1p********
     folder_id: b0g12ga82bcv********
     created_at: "2022-03-15T09:44:35.989446Z"
     name: vm-scale-scheduled-sa
     ```

     For more information about the `yc iam service-account create` command, see the [CLI reference](../../cli/cli-ref/iam/cli-ref/service-account/create.md).
  1. Assign these [roles](../../iam/concepts/access-control/roles.md) to the service account:
     * `compute.editor`: To manage the instance group:

       ```bash
       yc resource-manager folder add-access-binding example-folder \
         --service-account-name vm-scale-scheduled-sa \
         --role compute.editor \
         --folder-name example-folder
       ```

     * `iam.serviceAccounts.user`: To link the service account to the group’s instances:

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

     For more information about the `yc resource-manager folder add-access-binding` command, see the [CLI reference](../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).

- API {#api}

  1. Create a service account named `vm-scale-scheduled-sa`. To do this, use the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call.
  1. Assign the service account these [roles](../../iam/concepts/access-control/roles.md) for the current folder:
     * `compute.admin`: To manage the instance group.
     * `iam.serviceAccounts.user`: To link the service account to the group’s VM instances.
     * `{{ roles-functions-invoker }}`: To call the {{ sf-name }} function.

     To do this, use the [setAccessBindings](../../resource-manager/api-ref/Folder/setAccessBindings.md) REST API method for the [Folder](../../resource-manager/api-ref/Folder/index.md) resource or the [FolderService/SetAccessBindings](../../resource-manager/api-ref/grpc/Folder/setAccessBindings.md) gRPC API call.

{% endlist %}

### Create a cloud network {#create-network}

The instance group will reside in the [{{ vpc-full-name }}](../../vpc/) [network](../../vpc/concepts/network.md#network) and its [subnets](../../vpc/concepts/network.md#subnet).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
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

     ```yaml
     id: enpabce123hd********
     folder_id: b0g12ga82bcv********
     created_at: "2022-03-15T09:55:50.004472Z"
     name: vm-scale-scheduled-network
     ```

     For more information about the `yc vpc network create` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/network/create.md).
  1. Create a subnet named `vm-scale-scheduled-subnet-a` in the `{{ region-id }}-a` [availability zone](../../overview/concepts/geo-scope.md):

     ```bash
     yc vpc subnet create --name vm-scale-scheduled-subnet-a \
       --folder-name example-folder \
       --network-name vm-scale-scheduled-network --range 192.168.1.0/24 \
       --zone {{ region-id }}-a
     ```

     Result:

     ```yaml
     id: e1lnabc23r1c********
     folder_id: b0g12ga82bcv********
     created_at: "2022-03-15T09:56:51.859345Z"
     name: vm-scale-scheduled-subnet-a
     network_id: enpabce123hd********
     zone_id: {{ region-id }}-a
     v4_cidr_blocks:
     - 192.168.1.0/24
     ```

     For more information about the `yc vpc subnet create` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/subnet/create.md).
  1. Create a subnet named `vm-scale-scheduled-network-b` in the `{{ region-id }}-b` availability zone:

     ```bash
     yc vpc subnet create --name vm-scale-scheduled-subnet-b \
       --folder-name example-folder \
       --network-name vm-scale-scheduled-network --range 192.168.2.0/24 \
       --zone {{ region-id }}-b
     ```

     Result:

     ```yaml
     id: b1csa2b3clid********
     folder_id: b0g12ga82bcv********
     created_at: "2022-03-15T09:57:48.934429Z"
     name: vm-scale-scheduled-subnet-b
     network_id: enpabce123hd********
     zone_id: {{ region-id }}-b
     v4_cidr_blocks:
     - 192.168.2.0/24
     ```

- API {#api}

  1. Create a network named `vm-scale-scheduled-network` using the [create](../../vpc/api-ref/Network/create.md) REST API method for the [Network](../../vpc/api-ref/Network/index.md) resource or the [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md) gRPC API call.
  1. Create subnets named `vm-scale-scheduled-subnet-a` in the `{{ region-id }}-a` availability zone and `vm-scale-scheduled-subnet-b` in the `{{ region-id }}-b` availability zone using the [create](../../vpc/api-ref/Subnet/create.md) REST API method for the [Subnet](../../vpc/api-ref/Subnet/index.md) resource or the [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md) gRPC API call.

{% endlist %}

## Create an instance group {#create-ig}

We will create an instance group with manual scaling so that the {{ sf-name }} function can manage the group size.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select `example-folder`.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. At the top right, click **{{ ui-key.yacloud.compute.groups.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_base }}**:
     * In the **{{ ui-key.yacloud.compute.groups.create.field_name }}** field, specify `vm-scale-scheduled-ig`.
     * Select **{{ ui-key.yacloud.compute.groups.create.field_service-account }}** `vm-scale-scheduled-sa`.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_allocation }}**, select `{{ region-id }}-a` and `{{ region-id }}-b` in the **{{ ui-key.yacloud.compute.groups.create.field_zone }}** field.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_instance }}**, click **{{ ui-key.yacloud.compute.groups.create.button_instance_empty-create }}** and do the following in the window that opens:
     * Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, navigate to the **{{ ui-key.yacloud.compute.instances.create.section_image }}** tab and select [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts).
     * Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, specify this configuration:
       * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`
       * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
       * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `20%`
       * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `2 {{ ui-key.yacloud.common.units.label_gigabyte }}`
     * Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:
       * In the **{{ ui-key.yacloud.compute.instances.create.field_instance-group-network }}** field, select `vm-scale-scheduled-network`.
       * In the **{{ ui-key.yacloud.compute.instances.create.field_instance-group-address }}** field, select `{{ ui-key.yacloud.compute.instances.create.value_address-none }}`.
     * Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**:
       * In the **{{ ui-key.yacloud.compute.instances.create.field_service-account }}** field, select `vm-scale-scheduled-sa`.
       * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter the name of the user to create on the VM. You can enter any username of your choice.
       * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the public SSH key contents. You can create a key pair by following [this guide](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
     * Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_deploy }}**, specify this configuration:
     * **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-expansion }}**: `2` 
     * **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-unavailable }}**: `2`
     * **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-creating }}**: `2`
     * **{{ ui-key.yacloud.compute.groups.create.field_deploy-max-deleting }}**: `2`
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

       ```yaml
       id: ajeab0cnib1p********
       ```

       For more information about the `yc iam service-account get` command, see the [CLI reference](../../cli/cli-ref/iam/cli-ref/service-account/get.md).
     * `vm-scale-scheduled-network` ID:

       ```bash
       yc vpc network get vm-scale-scheduled-network \
         --folder-name example-folder | grep "^id"
       ```

       Result:

       ```yaml
       id: enpabce123hd********
       ```

       For more information about the `yc vpc network get` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/network/get.md).
     * `vm-scale-scheduled-subnet-a` ID:

       ```bash
       yc vpc subnet get vm-scale-scheduled-subnet-a \
         --folder-name example-folder | grep "^id"
       ```

       Result:

       ```yaml
       id: e1lnabc23r1c********
       ```

       For more information about the `yc vpc subnet get` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/subnet/get.md).
     * `vm-scale-scheduled-subnet-b` ID:

       ```bash
       yc vpc subnet get vm-scale-scheduled-subnet-b \
         --folder-name example-folder | grep "^id"
       ```

       Result:

       ```yaml
       id: b1csa2b3clid********
       ```

       For more information about the `yc vpc subnet get` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/subnet/get.md).
  1. Get the ID of the latest version of the [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts) public image:

     ```bash
     yc compute image get-latest-from-family ubuntu-2004-lts \
       --folder-id standard-images | grep "^id"
     ```

     Result:

     ```yaml
     id: fd83n3uou8m0********
     ```

     For more information about the `yc compute image get-latest-from-family` command, see the [CLI reference](../../cli/cli-ref/compute/cli-ref/image/get-latest-from-family.md).
  1. Insert these IDs in the `specification.yaml` file with the VM group spec:

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

- API {#api}

  1. Get the IDs of the resources you created at the previous steps:
     * `vm-scale-scheduled-sa` service account ID: Using the [get](../../iam/api-ref/ServiceAccount/get.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Get](../../iam/api-ref/grpc/ServiceAccount/get.md) gRPC API call.
     * `vm-scale-scheduled-network` ID: Using the [get](../../vpc/api-ref/Network/get.md) REST API method for the [Network](../../vpc/api-ref/Network/index.md) resource or the [NetworkService/Get](../../vpc/api-ref/grpc/Network/get.md) gRPC API call.
     * `vm-scale-scheduled-subnet-a` and `vm-scale-scheduled-subnet-b` IDs: Using the [get](../../vpc/api-ref/Subnet/get.md) REST API method for the [Subnet](../../vpc/api-ref/Subnet/index.md) resource or the [SubnetService/Get](../../vpc/api-ref/grpc/Subnet/get.md) gRPC API call.
  1. Get the ID of the latest version of the public [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts) image in the `standard-images` family using the [getLatestByFamily](../../compute/api-ref/Image/getLatestByFamily.md) REST API method for the [Image](../../compute/api-ref/Image/index.md) resource or the [ImageService/GetLatestByFamily](../../compute/api-ref/grpc/Image/getLatestByFamily.md) gRPC API call.
  1. Insert these IDs in the `specification.yaml` file with the VM group spec:

     {% include [vm-scale-scheduled-yaml-spec-init](../../_includes/instance-groups/vm-scale-scheduled-yaml-spec-init.md) %}

  1. Create an instance group named `vm-scale-scheduled-ig` based on `specification.yaml`. To do this, use the [createFromYaml](../../compute/instancegroup/api-ref/InstanceGroup/createFromYaml.md) REST API method for the [InstanceGroup](../../compute/instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/CreateFromYaml](../../compute/instancegroup/api-ref/grpc/InstanceGroup/createFromYaml.md) gRPC API call.

{% endlist %}

## Create the {{ sf-name }} resources {#create-sf-resources}

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
  1. Replace its contents with the code below:

     {% include [vm-scale-scheduled-function-code.md](../../_includes/instance-groups/vm-scale-scheduled-function-code.md) %}

  1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**:
     * Set the **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** field value to `60`.
     * In the **{{ ui-key.yacloud.forms.label_service-account-select }}** field, select `vm-scale-scheduled-sa`.
     * Under **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**, add these variables:
       * `IG_NAME` = `vm-scale-scheduled-ig`.
       * `IG_BASE_SIZE` = `2`.
       * `FOLDER_ID` = `<your_folder_ID>`. You can get the ID by following [this guide](../../resource-manager/operations/folder/get-id.md).
  1. In the top-right corner, click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

  1. Create a file named `config.pkr.hcl` with this code:

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
     * `--service-account-id`: `vm-scale-schedule-sa` ID. To get the ID, follow the [Create a VM group](#create-ig) step on the **CLI** tab.
     * `FOLDER_ID` in `--environment`. You can get the ID by following [this guide](../../resource-manager/operations/folder/get-id.md).

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

- API {#api}

  1. Create a function named `vm-scale-scheduled-function` using the [create](../../functions/functions/api-ref/Function/create.md) REST API method for the [Function](../../functions/functions/api-ref/Function/index.md) resource or the [FunctionService/Create](../../functions/functions/api-ref/grpc/Function/create.md) gRPC API call. From the output, get the ID of the function you created.
  1. Create a function version using the [createVersion](../../functions/functions/api-ref/Function/createVersion.md) REST API method for the [Function](../../functions/functions/api-ref/Function/index.md) resource or the [FunctionService/CreateVersion](../../functions/functions/api-ref/grpc/Function/createVersion.md) gRPC API call. The function version should have this code:

     {% include [vm-scale-scheduled-function-code.md](../../_includes/instance-groups/vm-scale-scheduled-function-code.md) %}

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

  Run this command:

  ```bash
  yc serverless trigger create timer --folder-name example-folder \
    --name vm-scale-scheduled-trigger \
    --cron-expression "*/2 * * * ? *" \
    --invoke-function-name vm-scale-scheduled-function \
    --invoke-function-tag '$latest' \
    --invoke-function-service-account-name vm-scale-scheduled-sa
  ```

  Result:

  ```yaml
  id: a1s22pb0v5i4********
  folder_id: b1g9hv2loamq********
  created_at: "2022-04-06T14:56:54.253709098Z"
  ...
        function_tag: $latest
        service_account_id: aje9s4pud13h********
  status: ACTIVE
  ```

- API {#api}

  Сreate a `timer` trigger with the `*/2 * * * ? *` cron expression by using the [create](../../functions/triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../../functions/triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../functions/triggers/api-ref/grpc/Trigger/create.md) gRPC API call. This trigger will be linked to `vm-scale-scheduled-function` of the `$latest` version and the `vm-scale-scheduled-sa` service account.

{% endlist %}

## Test instance group scaling {#test-scale}

{% include [test-scale](../_tutorials_includes/vm-scale-scheduled/test-scale.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. [Delete the trigger](../../functions/operations/trigger/trigger-delete.md).
1. [Delete](../../functions/operations/function/function-delete.md) the function.
1. [Delete](../../compute/operations/instance-groups/delete.md) the instance group.