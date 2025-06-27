# Configuring a fault-tolerant architecture in {{ yandex-cloud }}


In this tutorial, you will configure a [fault-tolerant architecture](../../architecture/fault-tolerance.md) in {{ yandex-cloud }} and test it in different scenarios.

By fault tolerance, we mean the ability of a system to operate despite failures in one or more of its components.

To configure and test the architecture:

1. [Get your cloud ready](#before-begin).
1. [Set up a test environment](#prepare).
1. [Run test scenarios](#run).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of supporting a fault-tolerant {{ yandex-cloud }} architecture includes:

* Fee for [disks](../../compute/concepts/disk.md) and continuously running [VMs](../../compute/concepts/vm.md) (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for a continuously running [{{ mpg-full-name }} cluster](../../managed-postgresql/concepts/index.md) (see [{{ mpg-name }} pricing](../../managed-postgresql/pricing.md)).
* Fee for a dynamic or static [public IP address](../../vpc/concepts/address.md) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

## Set up a test environment {#prepare}

How a test environment works:

* The application is packaged into a [Docker image](../../container-registry/concepts/docker-image.md) and pushed to {{ container-registry-full-name }}.

  Docker images are deployed on four [{{ coi }}](../../cos/)-based VMs. The VMs form an instance group and reside in two [availability zones](../../overview/concepts/geo-scope.md).

* A DB cluster managed by {{ mpg-name }} consists of two hosts residing in different availability zones.
* [{{ load-testing-name }} Tool](/marketplace/products/yc/load-testing) (you can find it on {{ marketplace-full-name }}) generates the workload applied to [{{ network-load-balancer-full-name }}](../../network-load-balancer/) that distributes traffic across VMs.

### Create TodoList application containers {#create-app}

To get the application ready to run in {{ yandex-cloud }}:

1. Download and unpack the [repository](https://github.com/glebmish/yandex-cloud-fault-tolerance-demo/archive/master.zip) containing the demo application source code, {{ TF }} specifications, and a failure simulation script.
1. Navigate to the repository:

   ```bash
   cd yandex-cloud-fault-tolerance-demo-master/app
   ```

1. [Get authenticated](../../container-registry/operations/authentication.md) in {{ container-registry-name }}:

   ```bash
   yc container registry configure-docker
   ```

1. [Create a registry](../../container-registry/operations/registry/registry-create.md):

   ```bash
   yc container registry create --name todo-registry
   ```

1. [Create a Docker image](../../container-registry/operations/docker-image/docker-image-create.md) tagged as `v1`:

   ```bash
   docker build . --tag {{ registry }}/<registry_ID>/todo-demo:v1 --platform linux/amd64
   ```

1. Create a Docker image tagged as `v2` to test the application update:

   ```bash
   docker build . --build-arg COLOR_SCHEME=dark --tag {{ registry }}/<registry_ID>/todo-demo:v2 --platform linux/amd64
   ```

1. [Push the Docker images](../../container-registry/operations/docker-image/docker-image-push.md) to {{ container-registry-name }}:

   ```bash
   docker push {{ registry }}/<registry_ID>/todo-demo:v1
   docker push {{ registry }}/<registry_ID>/todo-demo:v2
   ```

### Deploy the infrastructure {#create-environment}

To prepare your {{ yandex-cloud }} application environment:

1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
1. Navigate to the environment specification directory:

   ```bash
   cd ../terraform/app
   ```

1. Initialize {{ TF }}:

   ```bash
   terraform init
   ```

1. Save the folder ID to the `YC_FOLDER` variable and the [IAM token](../../iam/concepts/authorization/iam-token.md) to the `YC_TOKEN` variable:

   ```bash
   export YC_FOLDER=<catalog_ID>
   export YC_TOKEN=$(yc iam create-token)
   ```

1. Generate a key to [connect to a VM over SSH](../../compute/operations/vm-connect/ssh.md):

   ```bash
   ssh-keygen -t ed25519
   ```

1. In the `app/todo-service.tf` file, specify the path to the public SSH key; the default value is `~/.ssh/id_ed25519.pub`.
1. Check the cloud quotas before deploying the required resources.

   {% cut "Information about the number of new resources" %}

   You will create the following resources:

   * A {{ vpc-name }} [network](../../vpc/concepts/network.md#network) with three [subnets](../../vpc/concepts/network.md#subnet) in all availability zones.
   * Two [service accounts](../../iam/concepts/users/service-accounts.md):
     * One with the `editor` role for managing an instance group.
     * Another with the `container-registry.images.puller` [role](../../iam/concepts/access-control/roles.md) for downloading a Docker image to a VM instance.
   * An instance group of four {{ coi }} VMs in the `{{ region-id }}-b` and `{{ region-id }}-d` availability zones.
   * A {{ mpg-name }} cluster with two hosts in the `{{ region-id }}-b` and `{{ region-id }}-d` availability zones.
   * A network load balancer distributing traffic across VM instances in the group.

   {% endcut %}

1. Deploy and run the application:

   ```bash
   terraform apply -var yc_folder=$YC_FOLDER -var yc_token=$YC_TOKEN -var user=$USER
   ```

   Where:

   * `yc_folder`: [Folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you will deploy the application.
   * `yc_token`: [IAM token](../../iam/concepts/authorization/iam-token.md) of the user to deploy the application.

To access the application, navigate to `lb_address` received in the `terraform apply` command output.

### Configure and run {{ load-testing-name }} Tool {#create-load-testing-tool}

{% note warning %}

Before creating your {{ load-testing-name }} Tool, [create TodoList application containers](#create-app) and [deploy the infrastructure](#create-environment).

{% endnote %}

1. Navigate to the {{ load-testing-name }} Tool specification directory:

   ```bash
   cd ../tank
   ```

1. Initialize {{ TF }}:

   ```bash
   terraform init
   ```

1. In the `tank/main.tf` file, specify the paths to the public and private SSH keys; the default values are `~/.ssh/id_ed25519.pub` and `~/.ssh/id_ed25519`, respectively.
1. Deploy and run the VM:

   ```bash
   terraform apply -var yc_folder=$YC_FOLDER -var yc_token=$YC_TOKEN -var user=$USER -var overload_token=<overload_token>
   ```

   Where:

   * `yc_folder`: Folder where you will deploy {{ load-testing-name }} Tool.
   * `yc_token`: IAM token of the {{ load-testing-name }} Tool user.
   * `overload_token`: Token to connect to `<overload.yandex.net>`. To get this token, log in, click your profile at the top right, and select **My api token** from the drop-down menu.

1. Connect to the new VM over SSH. You can find the connection address in the `terraform apply` command output:

   ```bash
   ssh <username>@<VM_IP_address>
   ```

1. Run {{ load-testing-name }} Tool:

   ```bash
   sudo yandex-tank -c load.yaml
   ```

1. Navigate to `<overload.yandex.net>` and find your running task there: **Public tests** → **show my tests only**.

## Running scenarios {#run}

### VM failure {#error-vm}

VM failure is a scenario when the VM with your application is unavailable.

Possible causes:

* The VM physical host failed.
* You deleted the VM by mistake.

To simulate this failure, delete one of the VM instances from the group:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select your instance group folder.
  1. From the list of services, select **{{ compute-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/compute/vm-group-pic.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
  1. Select `todo-ig`.
  1. Navigate to the **{{ ui-key.yacloud.compute.placement-group.switch_instances }}** panel.
  1. Next to the VM you want to delete, click ![image](../../_assets/options.svg) → **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.compute.instances.popup-confirm_button_delete }}**.

{% endlist %}

Test environment response:

1. The network load balancer and {{ ig-name }} identify the VM failure and remove this VM from the load balancing pool, redirecting its traffic to the remaining instances in the group.
1. The {{ ig-name }} service gets [automatically restored](../../compute/concepts/instance-groups/autohealing.md) and:
   1. Deletes the failed VM instance; in our scenario, the system skips this step because the instance is already deleted.
   1. Creates a new VM.
   1. Waits for the application to start on the new VM.
   1. Adds the new VM to the load balancing pool.

The load balancer and {{ ig-name }} need some time to detect the issue and disable traffic to the failed VM. This may cause `Connection Timeout` errors: HTTP code `0` in the **Quantities** and **HTTP codes** charts of the {{ load-testing-name }} Tool monitoring application.

Once the failed VM is removed from the load balancing pool, the system continues to handle user traffic properly.

### Application failure {#error-app}

Application failure is a scenario when your application does not respond in time or works incorrectly.

Possible causes:

* Memory leak
* DB connectivity loss
* Too many requests

According to [health check](../../compute/concepts/instance-groups/autohealing.md#setting-up-health-checks) settings, the {{ ig-name }} service polls the grouped VM instances over HTTP. A healthy VM returns a `200` status code in response to the `/healthy` request. Otherwise, the {{ ig-name }} service starts the recovery process.

To simulate the `yandex-cloud-fault-tolerance-demo-master` repository failure, run this script:

```bash
fail_random_host.sh <instance_group_ID>
```

A random VM instance in the group will start returning a `503` error.

Test environment response:

1. The {{ ig-name }} service identifies the application failure and removes the relevant VM instance from the load balancing pool, redirecting its traffic to the remaining instances in the group.
1. The {{ ig-name }} service gets [automatically restored](../../compute/concepts/instance-groups/autohealing.md) and:
   1. Restarts the failed VM.
   1. Waits for the application to start on the new VM.
   1. Adds the new VM to the load balancing pool.

The {{ ig-name }} service polls the VM several times before disabling traffic and starting the recovery process. This may cause the `Service Unavailable` errors: HTTP code `503` in the **Quantities** and **HTTP codes** charts of the {{ load-testing-name }} Tool monitoring application.

Once the failed VM is removed from the load balancing pool, the system continues to handle user traffic properly.

### Availability zone failure {#zone-down}

Availability zone failure is a scenario when multiple VMs in the same zone become unavailable.

Possible causes:

* Data center outage
* Data center maintenance

To move your resources to another data center:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select your instance group folder.
  1. From the list of services, select **{{ compute-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/compute/vm-group-pic.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
  1. Select `todo-ig`.
  1. In the top-right corner, click **{{ ui-key.yacloud.common.edit }}**.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_allocation }}**, uncheck the `{{ region-id }}-b` availability zone.
  1. Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.

{% endlist %}

Test environment response:

1. The {{ ig-name }} service removes the `{{ region-id }}-b` availability zone VMs from the load balancing pool.
1. The system deletes these VMs, creating new VMs in their stead in the `{{ region-id }}-d` zone.
1. The {{ ig-name }} service adds the new VMs to the load balancing pool.

The number of VMs that can be created and deleted at one time depends on the [deployment policy](../../compute/concepts/instance-groups/policies/deploy-policy.md).

Removing VMs from the load balancing pool can cause the `Connection Timeout` errors: HTTP code `0` in the **Quantities** and **HTTP codes** charts of the {{ load-testing-name }} Tool monitoring application.

Once the failed VMs are removed from the load balancing pool, the system continues to handle user traffic properly.

### Application update {#update-app}

To update your application:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select your instance group folder.
  1. From the list of services, select **{{ compute-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/compute/vm-group-pic.svg) **{{ ui-key.yacloud.compute.instance-groups_hx3kX }}**.
  1. Select `todo-ig`.
  1. In the top-right corner, click **{{ ui-key.yacloud.common.edit }}**.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_instance }}**, click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, navigate to the **{{ ui-key.yacloud.compute.instances.create.image_value_coi }}** tab.
  1. Select the relevant Docker container and click ![image](../../_assets/options.svg) → **{{ ui-key.yacloud.common.edit }}**.
  1. In the window that opens, specify the application image tagged as `v2` in the **{{ ui-key.yacloud.compute.instances.create.field_coi-image }}** field.
  1. Click **{{ ui-key.yacloud.common.apply }}**.
  1. Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
  1. Click **{{ ui-key.yacloud.common.save }}** on the **{{ ui-key.yacloud.compute.group.edit.label_title }}** page.

{% endlist %}

Test environment response:

1. The {{ ig-name }} service removes two VMs running outdated application versions from the load balancing pool, assigning them the `RUNNING_OUTDATED` [status](../../compute/concepts/instance-groups/statuses.md#vm-statuses).
1. The system deletes these VMs, creating new VMs with the new application version in their stead.
1. The {{ ig-name }} service adds new VMs to the load balancing pool.
1. The system repeats the operations above for two remaining VMs with the outdated application version.

Refresh the application page. If the network load balancer sends your request to an updated VM, you will see the dark theme application version.

The number of VMs that can be created and deleted at one time depends on the [deployment policy](../../compute/concepts/instance-groups/policies/deploy-policy.md).

Removing VMs from the load balancing pool can cause the `Connection Timeout` errors: HTTP code `0` in the **Quantities** and **HTTP codes** charts of the {{ load-testing-name }} Tool monitoring application.

Once the failed VMs are removed from the load balancing pool, the system continues to handle user traffic properly.

### Scaling your DB {#scaling-database}

You may need to scale your DB in the following cases:

* Cluster performance is insufficient to handle requests.
* The data requires more storage capacity.

To scale your DB:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select your DB cluster folder.
  1. In the list of services, select **{{ mpg-name }}**.
  1. Select `todo-postgresql`.
  1. Click ![image](../../_assets/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_resource }}**, select `s2.medium`.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

{% endlist %}

{{ mpg-name }} will start updating the cluster.

Switching between master and replica servers at the beginning and end of the update process can cause the `Internal Server Error`: HTTP code `500` in the **Quantities** and **HTTP codes** charts of the {{ load-testing-name }} Tool monitoring application.

After switching is complete, the cluster will process the requests correctly.

## Deleting applications and cleaning up your environment {#clear-out}

{% note warning %}

If you created your VM with {{ load-testing-name }} Tool, make sure to delete it first; otherwise, deleting the {{ vpc-name }} network will fail.

{% endnote %}

To delete the {{ load-testing-name }} Tool app, navigate to the `yandex-cloud-fault-tolerance-demo-master/terraform/tank` folder and run this command:

```bash
terraform destroy -var yc_folder=$YC_FOLDER -var yc_token=$YC_TOKEN -var user=$USER -var overload_token=not-used
```

To delete the TodoList application, navigate to the `yandex-cloud-fault-tolerance-demo-master/terraform/app` folder and run this command:

```bash
terraform destroy -var yc_folder=$YC_FOLDER -var yc_token=$YC_TOKEN -var user=$USER
```
