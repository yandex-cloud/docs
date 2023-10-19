# Creating a trigger for budgets that invokes a {{ sf-name }} function to stop VM instances

Create a trigger for [budgets](../../billing/concepts/budget.md) that invokes a {{ sf-name }} [function](../../functions/concepts/function.md). The function will stop {{ compute-name }} [VM instances](../../compute/concepts/vm.md#project) when the threshold values specified in the budget are exceeded.

To deploy a project:
1. [Download a project](#download).
1. [Create a service account](#create-sa).
1. [Prepare a ZIP archive with the function code](#prepare-zip).
1. [Create a {{ sf-name }} function](#create-function).
1. [Create a budget](#create-budget).
1. [Create a trigger for budgets](#create-trigger).
1. [Create {{ compute-name }} VM instances](#create-vm).
1. [Check that the trigger stops the VM instances](#test).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of resources includes:
* Fee for using VM instances (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Fee for the number of function calls, computing resources allocated to a function, and outgoing traffic (see [{{ sf-name }} pricing](../../functions/pricing.md)).

## Download a project {#download}

Clone the repository with the project:

```bash
git clone https://github.com/yandex-cloud-examples/yc-serverless-trigger-budget
```

## Create a service account {#create-sa}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a service account.
   1. At the top of the screen, go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
   1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Enter the service account name: `service-account-for-budget`.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and assign the service account the `compute.admin`, `iam.serviceAccounts.user`, and `{{ roles-functions-invoker }}` roles.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Create a service account named `service-account-for-budget`:
      ```bash
      yc iam service-account create --name service-account-for-budget
      ```

      Result:
      ```
      id: ajersamh4sjq********
      folder_id: b1gc1t4cb638********
      created_at: "2022-12-07T10:36:29.726397755Z"
      name: service-account-for-budget
      ```

   1. Get a list of folders in the cloud:
      ```bash
      yc resource-manager folder list
      ```

      Result:
      ```
      +----------------------+----------------------+--------+--------+
      |          ID          |         NAME         | LABELS | STATUS |
      +----------------------+----------------------+--------+--------+
      | b1gp7arme3nn******** | my-folder            |        | ACTIVE |
      | b1g0itj57rbj******** | test-folder          |        | ACTIVE |
      +----------------------+----------------------+--------+--------+
      ```

      Save the ID of the folder to create the service account in.

   1. Get a list of service accounts in the folder:
      ```bash
      yc iam service-account list
      ```

      Result:
      ```
      +----------------------+------------------------------+
      |          ID          |             NAME             |
      +----------------------+------------------------------+
      | aje07l4q4vmo******** | test-sa                      |
      | ajersamh4sjq******** | service-account-for-budget   |
      +----------------------+------------------------------+
      ```

      Save the ID of the `service-account-for-budget`.

   1. Assign the service account the `compute.admin`, `iam.serviceAccounts.user` and `serverless.functions.invoker` roles for the folder:
      ```bash
      yc resource-manager folder add-access-binding <folder_ID> \
         --role compute.admin \
         --subject serviceAccount:<service_account_ID>

      yc resource-manager folder add-access-binding <folder_ID> \
         --role iam.serviceAccounts.user \
         --subject serviceAccount:<service_account_ID>

      yc resource-manager folder add-access-binding <folder_ID> \
         --role serverless.functions.invoker \
         --subject serviceAccount:<service_account_ID>
      ```

      Result:
      ```
      done (1s)
      ```

- API

   To create a service account, use the [create](../../iam/api-ref/ServiceAccount/create.md) method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource.

   To assign the service account the `compute.admin`, `iam.serviceAccounts.user`, and `serverless.functions.invoker` folder roles, use the [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource.

{% endlist %}

## Prepare a ZIP archive with the function code {#prepare-zip}

Go to the `yc-serverless-trigger-budget/steps/2-create-function/` directory and add files to the `src.zip` archive:
```bash
zip src.zip index.go go.mod
```

## Create a {{ sf-name }} function {#create-function}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you created the service account.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
   1. Create a function:
      1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
      1. Enter the function name: `function-for-budget`.
      1. Click **{{ ui-key.yacloud.serverless-functions.create.button_create }}**.
   1. Create the function version:
      1. Select `golang119` as the runtime environment, enable the **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** option, and click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
      1. Specify the **{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}** upload method and select the archive created in the previous step.
      1. Specify the `index.StopComputeInstances` entry point.
      1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**, specify:
         * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `5`.
         * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `512 {{ ui-key.yacloud.common.units.label_megabyte }}`.
         * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `service-account-for-budget`.
         * **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**:
            * `FOLDER_ID`: ID of the folder to stop the VM instances in.
            * `TAG`: `target-for-stop`.
      1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI

   1. Create a function named `function-for-budget`:
      ```bash
      yc serverless function create --name function-for-budget
      ```

      Result:
      ```
      done (1s)
      id: d4eiqjdbqt7s********
      folder_id: b1gc1t4cb638********
      created_at: "2022-12-07T10:44:13.156Z"
      name: function-for-budget
      log_group_id: ckg6bie2rtgd********
      http_invoke_url: https://{{ sf-url }}/d4eiqjdbqt7s********
      status: ACTIVE
      ```

   1. Create a function version named `function-for-budget`:
      ```bash
      yc serverless function version create \
        --function-name function-for-budget \
        --memory=512m \
        --execution-timeout=5s \
        --runtime=golang119 \
        --entrypoint=index.StopComputeInstances \
        --service-account-id=<service_account_ID> \
        --environment FOLDER_ID=<folder_ID> \
        --environment TAG=target-for-stop \
        --source-path=./src.zip
      ```

      Where:
      * `--function-name`: Name of the function a version of which you are creating.
      * `--memory`: Amount of RAM.
      * `--execution-timeout`: Maximum function execution time before the timeout is reached.
      * `--runtime`: Runtime environment.
      * `--entrypoint`: Entry point.
      * `--service-account-id`: ID of the `service-account-for-budget`.
      * `--environment`: Environment variables. `FOLDER_ID`: ID of the folder to stop the VM instances in.
      * `--source-path`: Path to the `src.zip` archive.

      Result:
      ```
      done (2m7s)
      id: d4ev38dddr41********
      function_id: d4eiqjdbqt7s********
      created_at: "2022-12-07T11:14:07.802Z"
      runtime: golang119
      entrypoint: index.StopComputeInstances
      resources:
        memory: "536870912"
      execution_timeout: 5s
      service_account_id: ajersamh4sjq********
      image_size: "19587072"
      status: ACTIVE
      tags:
        - $latest
      log_group_id: ckg6bie2rtgd********
      environment:
        FOLDER_ID: b1gc1t4cb638********
        TAG: target-for-stop
      log_options:
        folder_id: b1gc1t4cb638********
      ```

- API

   To create a function, use the [create](../../functions/functions/api-ref/Function/create.md) method for the [Function](../../functions/functions/api-ref/Function/index.md) resource.

   To create a function version, use the [createVersion](../../functions/functions/api-ref/Function/createVersion.md) method for the [Function](../../functions/functions/api-ref/Function/index.md) resource.

{% endlist %}

## Create a budget {#create-budget}

The user can create a budget if they have the `editor` role. To get notifications, the `viewer` role is sufficient.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you created the service account and function.
   1. In the top-left corner, click ![image](../../_assets/main-menu.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}**.
   1. Select ![image](../../_assets/billing.svg) [**{{ billing-name }}**]({{ link-console-billing }}).
   1. On the **{{ ui-key.yacloud.billing.account.label_accounts }}** page, select a billing account.
   1. Go to the **{{ ui-key.yacloud.billing.account.switch_budgets }}** tab and click **{{ ui-key.yacloud.billing.account.budgets.button_create }}**.
   1. Under **{{ ui-key.yacloud.common.section-base }}**, specify:
      * Budget name: `vm-budget`.
      * Budget type: `{{ ui-key.yacloud.billing.account.budgets.label_type-expense }}`.
      * Total usage cost.
      * Calculation period: `{{ ui-key.yacloud.billing.account.budgets.reset-period_value_monthly }}`.
      * Budget end date. The end date is when the budget stops calculating usage and sending notifications. The end date is the last day of the month. It must be within five years of the current date.
      * Users to be notified when the threshold values are reached.
   1. Under **{{ ui-key.yacloud.billing.account.budgets.section_scope }}**, select the current folder and the **{{ compute-name }}** service.
   1. Under **{{ ui-key.yacloud.billing.account.budgets.label_limits }}**, set the threshold values as a percentage, upon reaching which:
      * Specified users will get notifications.
      * The trigger for budgets will fire.

      For example, you can set two thresholds: `50%` and `100%`.
   1. Click **{{ ui-key.yacloud.billing.accounts.button_empty-billing-create }}**.

- API

   To create a budget, use the [create](../../billing/api-ref/Budget/create.md) method for the [Budget](../../billing/api-ref/Budget/index.md) resource.

{% endlist %}

## Create a trigger for budgets {#create-trigger}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you created the service account, function, and budget.

   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.

   1. In the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

      * Enter the trigger name: `vm-stop-trigger`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_billing-budget }}`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}`.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_billing-budget }}**, select your billing account and the `vm-budget` you created in the previous step.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**, select the `function-for-budget` function and specify:

      * [Tag of the function version](../../functions/concepts/function.md#tag). The default tag is `$latest`.
      * Service account: `service-account-for-budget`. It will be used to invoke the function.

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI

   To create a trigger for budgets that will invoke the `function-for-budget`, run the command:

   ```bash
   yc serverless trigger create billing-budget \
     --name vm-stop-trigger \
     --billing-account-id <billing_account_ID> \
     --budget-id <budget_ID> \
     --invoke-function-id <function_ID> \
     --invoke-function-service-account-id <service_account_ID>
   ```

   Where:

   * `--name`: Trigger name.
   * `--billing-account-id`: [Billing account](../../billing/concepts/billing-account.md) ID.
   * `--budget-id`: ID of the `vm-budget`.
   * `--invoke-function-id`: ID of the `function-for-budget`.
   * `--invoke-function-service-account-id`: ID of the `service-account-for-budget`.

   Result:

   ```text
   id: a1sfe084v4**********
   folder_id: b1g88tflru**********
   created_at: "2022-12-04T08:45:31.131391Z"
   name: vm-stop-trigger
   rule:
     billing-budget:
       billing-account-id: dn2char50j**********
       budget-id: dn2jnshmdlc1********
       invoke_function:
         function_id: d4eofc7n0m03********
         function_tag: $latest
         service_account_id: aje3932acd0c********
   status: ACTIVE
   ```

- API

   To create a trigger for budgets, use the [create](../../functions/triggers/api-ref/Trigger/create.md) method for the [Trigger](../../functions/triggers/api-ref/Trigger/index.md) resource.

{% endlist %}

## Create {{ compute-name }} VM instances {##create-vm}

{% list tabs %}

- CLI

   1. Select a subnet:
      ```
      yc vpc subnet list
      ```

   1. Create a virtual machine:
      ```bash
      yc compute instance create \
         --name target-instance-1 \
         --labels target-for-stop=true \
         --zone {{ region-id }}-a \
         --network-interface subnet-name=<subnet_name>,nat-ip-version=ipv4 \
         --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2004-lts \
         --ssh-key ~/.ssh/<key_name>.pub
      ```

      Where:

      * `--name`: VM instance name.
      * `--labels`: Label. The trigger for budgets will stop the VM instance when the threshold values are reached if the `target-for-stop` label value is `true`.
      * `--zone`: Availability zone that corresponds to the selected subnet.
      * `--subnet-name`: Name of the selected subnet.
      * `--nat-ip-version`: Public IP.
      * `image-family`: [Family of images](../../compute/concepts/image#family). This option allows you to install the latest version of the operating system from the specified family.
      * `--ssh-key`: Path to the public SSH key. The user `yc-user` will be automatically created on the VM for this key. [How to create an SSH key pair](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

      Result:
      ```
      done (34s)
      id: fhm8lon8b9a9********
      folder_id: b1gc1t4cb638********
      created_at: "2022-12-07T11:29:39Z"
      name: target-instance-1
      labels:
        target-for-stop: "true"
      zone_id: {{ region-id }}-a
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
        aws_v1_http_token: ENABLED
      boot_disk:
        mode: READ_WRITE
        device_name: fhm459pv68ta********
        auto_delete: true
        disk_id: fhm459pv68ta********
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:8a:e2:e8:5a
          subnet_id: e9b3vsm91fl7********
          primary_v4_address:
            address: 10.128.0.4
            one_to_one_nat:
              address: 158.160.47.82
              ip_version: IPV4
      fqdn: fhm8lon8b9a9********.auto.internal
      scheduling_policy: {}
      network_settings:
        type: STANDARD
      placement_policy: {}
      ```

- API

   To create a VM instance, use the [create](../../compute/api-ref/Instance/create.md) method for the [Instance](../../compute/api-ref/Instance/index.md) resource.

{% endlist %}

Similarly, create two more VM instances: `target-instance-2` and `target-instance-3`. For the latter, set the `target-for-stop` label to `false`.

## Check that the trigger stops the VM instances {#test}

Wait until the threshold values that you specified in the budget are reached. Check that the trigger for budgets has invoked the function and `target-instance-1` and `target-instance-2` have stopped.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete](../../functions/operations/trigger/trigger-delete.md) the trigger for budgets.
1. [Delete](../../functions/operations/function/function-delete.md) the function.
1. [Delete](../../compute/operations/vm-control/vm-delete.md) the VM instances.
1. [Delete](../../iam/operations/sa/delete.md) the service account.
