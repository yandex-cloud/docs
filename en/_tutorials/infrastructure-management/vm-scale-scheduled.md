# Scheduled scaling of instance groups

Create a {{ compute-full-name }} [instance group](../../compute/concepts/instance-groups/index.md) and set up scheduled scaling for it. A {{ sf-full-name }} [function](../../functions/concepts/function.md) triggered by a [timer](../../functions/concepts/trigger/timer.md) will manage the instance group size.

To set up scaling for your instance group using standard tools such as the management console, [CLI](../../cli/), or [API](../../api-design-guide/):

1. [Before you start](#before-begin).
1. [Create auxiliary resources](#create-aux-resources).
1. [Creating an instance group](#create-ig).
1. [Create {{ sf-name }} resources](#create-sf-resources).
1. [Test instance group scaling](#test-scale).

If you no longer need these resources, [delete them](#clear-out).

You can also deploy an infrastructure for scaling your instance group via {{ TF }} using a [ready-made configuration file](#terraform).

## Prepare your cloud {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

We use a folder named `example-folder` as an example.

### Required paid resources {#paid-resources}

The cost of the infrastructure includes:

* Using virtual machines (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Function calls, computing resources allocated to executing the function, and outgoing traffic (see [{{ sf-name }} pricing](../../functions/pricing.md)).

## Create auxiliary resources {#create-aux-resources}

### Create a service account {#create-sa}

The [service account](../../iam/concepts/users/service-accounts.md) will be linked to the {{ compute-name }} instance group and {{ sf-name }} function.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
   1. Go to the **Service accounts** tab.
   1. Click **Create service account**.
   1. **Name** it `vm-scale-scheduled-sa`.
   1. In the **Roles in folder** field, add the following [roles](../../iam/concepts/access-control/roles.md):

      * `compute.admin` to manage the instance group.
      * `iam.serviceAccounts.user` to link the service account to instances in the group.
      * `serverless.functions.invoker` to invoke the {{ sf-name }} function.

   1. Click **Create**.

- CLI

   1. Create a service account:

      ```bash
      yc iam service-account create --name vm-scale-scheduled-sa \
        --folder-name example-folder
      ```

      Result:

      ```yaml
      id: ajeab0cnib1pdefe21dm
      folder_id: b0g12ga82bcv0cdeferg
      created_at: "2022-03-15T09:44:35.989446Z"
      name: vm-scale-scheduled-sa
      ```

      For more information about the `yc iam service-account create` command, see the [CLI reference](../../cli/cli-ref/managed-services/iam/service-account/create.md).

   1. Assign the service account the following [roles](../../iam/concepts/access-control/roles.md):

      * `compute.admin` to manage the instance group:

         ```bash
         yc resource-manager folder add-access-binding example-folder \
           --service-account-name vm-scale-scheduled-sa \
           --role compute.admin
         ```

      * `iam.serviceAccounts.user` to link the service account to instances in the group:

         ```bash
         yc resource-manager folder add-access-binding example-folder \
           --service-account-name vm-scale-scheduled-sa \
           --role iam.serviceAccounts.user
         ```

      * `serverless.functions.invoker` to invoke the {{ sf-name }} function:

         ```bash
         yc resource-manager folder add-access-binding example-folder \
           --service-account-name vm-scale-scheduled-sa \
           --role serverless.functions.invoker
         ```

      For more information about the `yc resource-manager folder add-access-binding` command, see the [CLI reference](../../cli/cli-ref/managed-services/resource-manager/folder/add-access-binding.md).

- {{ TF }}

   See [How to create an infrastructure using {{ TF }}](#terraform).

- API

   Use the methods:

   1. [create](../../iam/api-ref/ServiceAccount/create.md) for the `ServiceAccount` resource to create a service account named `vm-scale-scheduled-sa`.
   1. [setAccessBindings](../../resource-manager/api-ref/Folder/setAccessBindings.md) for the `Folder` resource to assign the following roles to the service account in the current folder:

      * `compute.admin` to manage the instance group.
      * `iam.serviceAccounts.user` to link the service account to instances in the group.
      * `serverless.functions.invoker` to invoke the {{ sf-name }} function.

{% endlist %}

### Create a cloud network {#create-network}

Your instance group will be hosted in the [cloud network](../../vpc/concepts/network.md) of {{ vpc-full-name }} and its subnets.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
   1. In the list of services, select **{{ vpc-name }}**.
   1. Click **Create network**.
   1. **Name** it `vm-scale-scheduled-network`.
   1. Select the additional option **Create subnets**.
   1. Click **Create network**.

- CLI

   1. Create a network named `vm-scale-scheduled-network`:

      ```bash
      yc vpc network create --name vm-scale-scheduled-network \
        --folder-name example-folder
      ```

      Result:

      ```yaml
      id: enpabce123hde4ft1r3t
      folder_id: b0g12ga82bcv0cdeferg
      created_at: "2022-03-15T09:55:50.004472Z"
      name: vm-scale-scheduled-network
      ```

      For more information about the `yc vpc network create` command, see the [CLI reference](../../cli/cli-ref/managed-services/vpc/network/create.md).

   1. Create a subnet named `vm-scale-scheduled-subnet-a` in the `{{ region-id }}-a` zone:

      ```bash
      yc vpc subnet create --name vm-scale-scheduled-subnet-a \
        --folder-name example-folder \
        --network-name vm-scale-scheduled-network --range 192.168.1.0/24 \
        --zone {{ region-id }}-a
      ```

      Result:

      ```yaml
      id: e1lnabc23r1c9d0efoje
      folder_id: b0g12ga82bcv0cdeferg
      created_at: "2022-03-15T09:56:51.859345Z"
      name: vm-scale-scheduled-subnet-a
      network_id: enpabce123hde4ft1r3t
      zone_id: {{ region-id }}-a
      v4_cidr_blocks:
      - 192.168.1.0/24
      ```

      For more information about the `yc vpc subnet create` command, see the [CLI reference](../../cli/cli-ref/managed-services/vpc/subnet/create.md).

   1. Create a subnet named `vm-scale-scheduled-network-b` in the `{{ region-id }}-b` zone:

      ```bash
      yc vpc subnet create --name vm-scale-scheduled-subnet-b \
        --folder-name example-folder \
        --network-name vm-scale-scheduled-network --range 192.168.2.0/24 \
        --zone {{ region-id }}-b
      ```

      Result:

      ```yaml
      id: b1csa2b3clideftjb121
      folder_id: b0g12ga82bcv0cdeferg
      created_at: "2022-03-15T09:57:48.934429Z"
      name: vm-scale-scheduled-subnet-b
      network_id: enpabce123hde4ft1r3t
      zone_id: {{ region-id }}-b
      v4_cidr_blocks:
      - 192.168.2.0/24
      ```

- {{ TF }}

   See [How to create an infrastructure using {{ TF }}](#terraform).

- API

   1. Create a network named `vm-scale-scheduled-network` using the [create](../../vpc/api-ref/Network/create.md) method for the `Network` resource.

   1. Create a subnet named `vm-scale-scheduled-subnet-a` in the `{{ region-id }}-a` zone and `vm-scale-scheduled-subnet-b` in the `{{ region-id }}-b` zone using the [create](../../vpc/api-ref/Subnet/create.md) method for the `Subnet` resource.

{% endlist %}

## Create an instance group {#create-ig}

An instance group is created with manual [scaling](../../compute/concepts/instance-groups/scale.md) so that a {{ sf-name }} function can manage the group size.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
   1. Select **{{ compute-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/compute/vm-group-pic.svg) **Instance groups**.
   1. Click **Create group**.
   1. Under **Basic parameters**:

      * **Name** the group, such as `vm-scale-scheduled-ig`.
      * In the **Service account** field, select `vm-scale-scheduled-sa`.

   1. Under **Allocation**, select the `{{ region-id }}-a` and `{{ region-id }}-b` **Availability zones**.
   1. Under **Instance template**, click **Define**:

      * Under **Image/boot disk selection**, select **Ubuntu 20.04** in the **Operating systems** tab.
      * Under **Computing resources**, specify the following configuration:

         * **Platform**: Intel Ice Lake.
         * **vCPU**: 2.
         * **Guaranteed vCPU share**: 20%
         * **RAM**: 2 GB.

      * Under **Network settings**:

         * In the **Network** field, select `vm-scale-scheduled-network`.
         * In the **Public address** field, choose `No address`:

      * Under **Access**:

         * In the **Service account** field, select `vm-scale-scheduled-sa`.
         * In the **Login** field, enter the name of the user to be created on the VM. Come up with a name.
         * In the **SSH key** field, paste the contents of the public {% if lang == "ru" and audience != "internal" %}[SSH](../../glossary/ssh-keygen.md){% else %}SSH{% endif %} key file. You can create a key pair by following the [instructions](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

      * Click **Save**.

   1. Under **Allow when creating and updating**, specify the following settings:

      * **Add above target value**: `2`.
      * **Reduce below target value**: `2`.
      * **Create simultaneously**: `2`.
      * **Stop simultaneously**: `2`.

   1. In the **Scalability** section:

      * In the **Type** field, select `Fixed`.
      * Set the **Size** to `2`.

   1. Click **Create**.

- CLI

   1. Get the IDs of the resources you created earlier:

      * The `vm-scale-scheduled-sa` service account ID:

         ```bash
         yc iam service-account get vm-scale-scheduled-sa \
           --folder-name example-folder | grep "^id"
         ```

         Result:

         ```yaml
         id: ajeab0cnib1pdefe21dm
         ```

         For more information about the `yc iam service-account get` command, see the [CLI reference](../../cli/cli-ref/managed-services/iam/service-account/get.md).

      * The `vm-scale-scheduled-network` ID:

         ```bash
         yc vpc network get vm-scale-scheduled-network \
           --folder-name example-folder | grep "^id"
         ```

         Result:

         ```yaml
         id: enpabce123hde4ft1r3t
         ```

         For more information about the `yc vpc network get` command, see the [CLI reference](../../cli/cli-ref/managed-services/vpc/network/get.md).

      * The `vm-scale-scheduled-subnet-a` ID:

         ```bash
         yc vpc subnet get vm-scale-scheduled-subnet-a \
           --folder-name example-folder | grep "^id"
         ```

         Result:

         ```yaml
         id: e1lnabc23r1c9d0efoje
         ```

         For more information about the `yc vpc subnet get` command, see the [CLI reference](../../cli/cli-ref/managed-services/vpc/subnet/get.md).

      * The `vm-scale-scheduled-subnet-b` ID:

         ```bash
         yc vpc subnet get vm-scale-scheduled-subnet-b \
           --folder-name example-folder | grep "^id"
         ```

         Result:

         ```yaml
         id: b1csa2b3clideftjb121
         ```

         For more information about the `yc vpc subnet get` command, see the [CLI reference](../../cli/cli-ref/managed-services/vpc/subnet/get.md).

   1. Get the ID of the latest version of the Ubuntu 20.04 LTS public image:

      ```bash
      yc compute image get-latest-from-family ubuntu-2004-lts \
        --folder-id standard-images | grep "^id"
      ```

      Result:

      ```yaml
      id: fd83n3uou8m03iq9gavu
      ```

      For more information about the `yc compute image get-latest-from-family` command, see the [CLI reference](../../cli/cli-ref/managed-services/compute/image/get-latest-from-family.md).


   1. Insert the obtained IDs in the `specification.yaml` file with the instance group specification:

      {% include [vm-scale-scheduled-yaml-spec-init](../../_includes/instance-groups/vm-scale-scheduled-yaml-spec-init.md) %}

   1. Create an instance group named `vm-scale-scheduled-ig` according to `specification.yaml`:

      ```bash
      yc compute instance-group create --file specification.yaml \
        --folder-name example-folder
      ```

      Result:

      ```bash
      done (2m18s)
      id: cl0kabcquk1gomdefbkk
      folder_id: b0g12ga82bcv0cdeferg
      ...
      service_account_id: ajeab0cnib1pdefe21dm
      status: ACTIVE
      ```

- {{ TF }}

   See [How to create an infrastructure using {{ TF }}](#terraform).

- API

   1. Get the IDs of the resources you created earlier:

      * The `vm-scale-scheduled-sa` service account ID by using the [ServiceAccountService/Get](../../iam/api-ref/grpc/service_account_service.md#Get) gRPC API call or the [get](../../iam/api-ref/ServiceAccount/get.md) REST API method.
      * The `vm-scale-scheduled-network` ID by using the [NetworkService/Get](../../vpc/api-ref/grpc/network_service.md#Get) gRPC API call or the [get](../../vpc/api-ref/Network/get.md) REST API method.
      * The `vm-scale-scheduled-subnet-a` and `vm-scale-scheduled-subnet-b` IDs by using the [SubnetService/Get](../../vpc/api-ref/grpc/subnet_service.md#Get) gRPC API call or the [get](../../vpc/api-ref/Subnet/get.md) REST API method.

   1. Get the ID of the latest version of the `ubuntu-2004-lts` public image in the `standard-images` family by using the [ImageService/GetLatestByFamily](../../compute/api-ref/grpc/image_service.md#GetLatestByFamily) gRPC API call or the [getLatestByFamily](../../compute/api-ref/Image/getLatestByFamily.md) REST API method.

   1. Insert the obtained IDs in the `specification.yaml` file with the instance group specification:

      {% include [vm-scale-scheduled-yaml-spec-init](../../_includes/instance-groups/vm-scale-scheduled-yaml-spec-init.md) %}

   1. Create an instance group named `vm-scale-scheduled-ig` according to the specification from `specification.yaml`. To do this, use the [InstanceGroupService/CreateFromYaml](../../compute/api-ref/grpc/instance_group_service.md#CreateFromYaml) gRPC API call or the [createFromYaml](../../compute/api-ref/InstanceGroup/createFromYaml.md) REST API method.

{% endlist %}

## Create {{ sf-name }} resources {#create-sf-resources}

### Create a function {#create-function}

The function will contain the code with [{{ yandex-cloud }} CLI](../../cli/) commands that update the instance group.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
   1. Select **{{ sf-name }}**.
   1. Click **Create function**.
   1. **Name** it `vm-scale-scheduled-function`.
   1. Click **Create**.
   1. Select the **Bash** runtime environment.
   1. Enable the **Add files with code examples** option.
   1. Click **Next**.
   1. Under **Editor**, select the `handler.sh` file.
   1. Replace the file contents with the code below:

      {% include [vm-scale-scheduled-function-code.md](../../_includes/instance-groups/vm-scale-scheduled-function-code.md) %}

   1. Under **Parameters**:

      * In the **Timeout, sec** field, enter `60`.
      * In the **Service account** field, select `vm-scale-scheduled-sa`.
      * In the **Environment variables** field, add the following variables:

         * `IG_NAME` = `vm-scale-scheduled-ig`.
         * `IG_BASE_SIZE` = `2`.
         * `FOLDER_ID` = folder ID. You can retrieve the ID by following [instructions](../../resource-manager/operations/folder/get-id.md).

   1. In the upper-right corner, click **Create version**.

- CLI

   1. Create a file named `handler.sh` with the following code:

      {% include [vm-scale-scheduled-function-code.md](../../_includes/instance-groups/vm-scale-scheduled-function-code.md) %}

   1. Create a function:

      ```bash
      yc serverless function create vm-scale-scheduled-function \
        --folder-name example-folder
      ```

      Result:

      ```
      done (1s)
      id: d4e7d67ikvmqk5uoim47
      folder_id: b1g9hv2loamqfnbul7d9
      created_at: "2022-04-01T13:48:27.705Z"
      name: vm-scale-scheduled-function
      log_group_id: ckgij6l0845hsdc9khiq
      http_invoke_url: https://functions.yandexcloud.net/d4e7d67ikvmqk5uoim47
      status: ACTIVE
      ```

   1. Create the function version:

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

      * The `--service-account-id` option is the ID of the `vm-scale-schedule-sa` service account. To get the ID, follow the instructions in the [Create an instance group](#create-ig) step on the **CLI** tab.
      * The `FOLDER_ID` variable in the `--environment` option is the ID of the folder. You can retrieve the ID by following [instructions](../../resource-manager/operations/folder/get-id.md).

      Result:

      ```
      done (1s)
      id: d4efmv9n3qf1ptjtlof3
      function_id: d4e7d67ikvmqk5uoim47
      created_at: "2022-04-01T14:04:29.523Z"
      runtime: bash
      entrypoint: handler.sh
      resources:
      memory: "134217728"
      execution_timeout: 60s
      service_account_id: aje9s4pud13hfhk1bfgn
      image_size: "4096"
      status: ACTIVE
      tags:
      - $latest
      log_group_id: ckgij6l0845hsdc9khiq
      environment:
        FOLDER_ID: b1g9hv2loamqfnbul7d9
        IG_BASE_SIZE: "2"
        IG_NAME: vm-scale-scheduled-ig
      ```

- {{ TF }}

   See [How to create an infrastructure using {{ TF }}](#terraform).

- API

   1. Create a function named `vm-scale-scheduled-function` by using the [FunctionService/Create](../../functions/functions/api-ref/grpc/function_service.md#Create) gRPC API call or the [create](../../functions/functions/api-ref/Function/create.md) REST API method. You can find the ID of the created function in the output.
   1. Create a function version by using the [FunctionService/CreateVersion](../../functions/functions/api-ref/grpc/function_service.md#CreateVersion) gRPC API call or the [createVersion](../../functions/functions/api-ref/Function/createVersion.md) REST API method. The function version should have the following code:

      {% include [vm-scale-scheduled-function-code.md](../../_includes/instance-groups/vm-scale-scheduled-function-code.md) %}

{% endlist %}

### Create a trigger {#create-trigger}

A [trigger](../../functions/concepts/trigger/index.md) sets conditions for running a function. For scheduled function calls, use a [timer trigger](../../functions/concepts/trigger/timer.md).

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
   1. Select **{{ sf-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **Triggers**.
   1. Click **Create trigger**.
   1. Under **Basic parameters**:

      * **Name** the trigger, such as `vm-scale-scheduled-trigger`.
      * In the **Type** field, select `Timer`.
      * In the **Launched resource** field, select `Function`.

   1. Under **Timer settings**, specify **Cron expression** `*/2 * * * ? *` so that the trigger fires every two minutes (at 09:58, 10:00, 10:02, 10:04, and so on).
   1. Under **Function settings**:

      * Select `vm-scale-scheduled-function` in the **Function** field.
      * Select `$latest` in the **Function version tag** field.
      * In the **Service account** field, select `vm-scale-scheduled-sa`.

   1. Under **Dead Letter Queue settings**, clear the **Service account** field (`Not selected`).
   1. Click **Create trigger**.

- CLI

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

   ```
   id: a1s22pb0v5i4q432hi0p
   folder_id: b1g9hv2loamqfnbul7d9
   created_at: "2022-04-06T14:56:54.253709098Z"
   name: vm-scale-scheduled-trigger
   rule:
     timer:
       cron_expression: "*/2 * * * ? *"
       invoke_function_with_retry:
         function_id: d4e7d67ikvmqk5uoim47
         function_tag: $latest
         service_account_id: aje9s4pud13hfhk1bfgn
   status: ACTIVE
   ```

- {{ TF }}

   See [How to create an infrastructure using {{ TF }}](#terraform).

- API

   Use the [TriggerService/Create](../../functions/triggers/api-ref/grpc/trigger_service.md#Create) gRPC API call or the [create](../../functions/triggers/api-ref/Trigger/create.md) REST API method to create a trigger of the `timer` type with the cron expression `*/2 * * * ? *` linked to the function `vm-scale-scheduled-function` of the `$latest` version and the `vm-scale-scheduled-sa` service account.

{% endlist %}

## Test instance group scaling {#test-scale}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the `example-folder` folder.
   1. Select **{{ compute-name }}**.
   1. On the left-hand panel, select ![image](../../_assets/compute/vm-group-pic.svg) **Instance groups**.
   1. Select the `vm-scale-scheduled-ig` group.
   1. Under **VM states**, make sure the number of instances changes every two minutes: increases from 2 to 3, then decreases from 3 to 2, and so on. To check if the instance group has been updated, open ![image](../../_assets/mdb/operations.svg) **Operations**.


- CLI

   Run the following command several times:

   ```bash
   yc compute instance-group get vm-scale-scheduled-ig \
     --folder-name example-folder
   ```

   Result:

   ```
   id: cl1l0ljqbmkp8k1f902l
   folder_id: b1g9hv2loamqfnbul7d9
   created_at: "2022-03-28T13:24:20.693Z"
   name: vm-scale-scheduled-ig
   ...
   managed_instances_state:
     target_size: "2"
     running_actual_count: "2"
   ...
   ```

   The value of the `target_size` field for the group should change from `2` to `3` and back.

- API

   Get information about the `vm-scale-scheduled-ig` instance group several times by using the [InstanceGroupService/Get](../../compute/api-ref/grpc/instance_group_service.md#Get) gRPC API call or the [get](../../compute/api-ref/InstanceGroup/get.md) REST API method. The value of the `target_size` field for the group should change from `2` to `3` and back.

{% endlist %}

## How to delete created resources {#clear-out}

To stop paying for the resources created:

1. [Delete the trigger](../../functions/operations/trigger/trigger-delete.md) `vm-scale-scheduled-trigger`.
1. [Delete the function](../../functions/operations/function/function-delete.md) `vm-scale-scheduled-function`.
1. [Delete the instance group](../../compute/operations/instance-groups/delete.md) `vm-scale-scheduled-ig`.

## How to create an infrastructure using {{ TF }} {#terraform}

{% include [terraform-definition](../terraform-definition.md) %}

To set up scaling for your instance group using {{ TF }}:

1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Prepare files with the infrastructure description:

   {% list tabs %}

   - Ready-made archive

      1. Create a directory for files:
      1. Download the [archive](https://{{ s3-storage-host }}/doc-files/vm-scale-scheduled-terraform.zip) (2 KB).
      1. Unpack the archive to the directory. As a result, it should contain the `vm-scale-scheduled.tf` configuration file and the `vm-scale-scheduled-function.zip` archive with the {{ sf-name }} function code.

   - Creating files manually

      1. Create a directory for files:
      1. In the directory, create:

         * A configuration file named `vm-scale-scheduled.tf`:

            {% cut "vm-scale-scheduled.tf" %}

            {% include [vm-scale-scheduled-tf-config](../../_includes/instance-groups/vm-scale-scheduled-tf-config.md) %}

            {% endcut %}

         * A file with the {{ sf-name }} function code named `handler.sh`:

            {% cut "handler.sh" %}

            {% note warning %}

            If you're creating a file in Windows, make sure that newline characters are in Unix `\n` format rather than `\r\n`. You can replace line breaks in a text editor like [Notepad++](https://notepad-plus-plus.org/) or using tools such as [dos2unix](https://waterlan.home.xs4all.nl/dos2unix.html) or [Tofrodos](https://www.thefreecountry.com/tofrodos/).

            {% endnote %}

            {% include [vm-scale-scheduled-function-code](../../_includes/instance-groups/vm-scale-scheduled-function-code.md) %}

            {% endcut %}

      1. In the directory, create an archive named `vm-scale-scheduled-function.zip` with the `handler.sh` file. Next, delete the `handler.sh` file outside the archive.

   {% endlist %}

1. In the `vm-scale-scheduled.tf` file, paste the following values in the `locals` section:

   * `token`: [OAuth token](../../iam/concepts/authorization/oauth-token.md) (if you're using a [Yandex account](../../iam/concepts/index.md#passport)) or [IAM token](../../iam/concepts/authorization/iam-token.md) (if you're using a Yandex account or [federated account](../../iam/concepts/index.md#saml-federation)) to access {{ yandex-cloud }}. The IAM token is valid for up to 12 hours but no more than the federation's cookie lifetime.
   * `cloud_id`: [ID of the cloud](../../resource-manager/operations/cloud/get-id.md) to create resources in.
   * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) to create resources in.
   * `username`: Name of a user to be created on the VM. Come up with a name.
   * `ssh_key_path`: Path to the file with a public SSH key to authenticate the user on the VM. You can create a key pair by following the [instructions](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

1. Create resources:

   {% include [terraform-validate-plan-apply](../terraform-validate-plan-apply.md) %}

1. [Test instance group scaling](#test-scale).

