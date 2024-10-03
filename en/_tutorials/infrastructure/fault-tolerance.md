# Configuring a fault-tolerant architecture in {{ yandex-cloud }}


In this tutorial, you will learn how to configure a fault-tolerant architecture in {{ yandex-cloud }} and check how it works using various test cases.

Fault tolerance is the property that enables a system to continue operating after a failure of one or more of its components.

To configure and test the architecture:

1. [Prepare your cloud](#before-begin).
1. [Set up a test bench](#prepare).
1. [Run test scenarios](#run).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost for supporting a fault-tolerant {{ yandex-cloud }} architecture includes:

* Fee for [disks](../../compute/concepts/disk.md) and continuously running [VMs](../../compute/concepts/vm.md) (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for a continuously running [{{ mpg-full-name }} cluster](../../managed-postgresql/concepts/index.md) (see [{{ mpg-name }} pricing](../../managed-postgresql/pricing.md)).
* Fee for using a dynamic or static [public IP](../../vpc/concepts/address.md) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Set up a test bench {#prepare}

Description of the test bench:

* The application is packaged into a [Docker image](../../container-registry/concepts/docker-image.md) and pushed to {{ container-registry-full-name }}.

   Docker images are deployed on four VMs based on a [{{ coi }}](../../cos/). The VMs are grouped and located in two different [availability zones](../../overview/concepts/geo-scope.md).

* A DB cluster is managed by {{ mpg-name }} and consists of two hosts that reside in different availability zones.
* The [{{ load-testing-name }} Tool](/marketplace/products/yc/load-testing) application generates the {{ marketplace-full-name }} workload that is applied to [{{ network-load-balancer-full-name }}](../../network-load-balancer/). The network load balancer distributes traffic across VMs.

### Create TodoList app containers {#create-app}

To prepare the application to run in {{ yandex-cloud }}:

1. Download and unpack the [repository](https://github.com/glebmish/yandex-cloud-fault-tolerance-demo/archive/master.zip) with the demo application source code, the {{ TF }} specifications, and a script to simulate the application failure.
1. Go to the repository:

   ```bash
   cd yandex-cloud-fault-tolerance-demo-master/app
   ```

1. [Get authenticated](../../container-registry/operations/authentication.md) in {{ container-registry-name }}.

   ```bash
   yc container registry configure-docker
   ```

1. [Create a registry](../../container-registry/operations/registry/registry-create.md):

   ```bash
   yc container registry create --name todo-registry
   ```

1. [Create a Docker image](../../container-registry/operations/docker-image/docker-image-create.md) with the `v1` tag:

   ```bash
   docker build . --tag {{ registry }}/<registry_ID>/todo-demo:v1 --platform linux/amd64
   ```

1. Create a Docker image with the `v2` tag (to test the application update case):

   ```bash
   docker build . --build-arg COLOR_SCHEME=dark --tag {{ registry }}/<registry_ID>/todo-demo:v2 --platform linux/amd64
   ```

1. [Push the Docker images](../../container-registry/operations/docker-image/docker-image-push.md) to {{ container-registry-name }}:

   ```bash
   docker push {{ registry }}/<registry_ID>/todo-demo:v1
   docker push {{ registry }}/<registry_ID>/todo-demo:v2
   ```

### Deploy the infrastructure {#create-environment}

To prepare the environment for running the application in {{ yandex-cloud }}:

1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
1. Go to the directory with the environment specification:

   ```bash
   cd ../terraform/app
   ```

1. Initialize {{ TF }} in the spec directory:

   ```bash
   terraform init
   ```

1. Save the folder ID to the `YC_FOLDER` variable and the [IAM token](../../iam/concepts/authorization/iam-token.md) to the `YC_TOKEN` variable:

   ```bash
   export YC_FOLDER=<folder_ID>
   export YC_TOKEN=$(yc iam create-token)
   ```

1. Generate a key to [connect to a VM via SSH](../../compute/operations/vm-connect/ssh.md):

   ```bash
   ssh-keygen -t ed25519
   ```

1. In the file named `app/todo-service.tf`, specify the path to the public SSH key (the default value is `~/.ssh/id_ed25519.pub`).
1. Check the cloud quotas to be able to deploy the resources you need.

   {% cut "Information about resources to be created" %}

   The following resources will be created:

   * {{ vpc-name }} [network](../../vpc/concepts/network.md#network) with three [subnets](../../vpc/concepts/network.md#subnet) in all availability zones.
   * Two [service accounts](../../iam/concepts/users/service-accounts.md):
      * Service account for managing a VM instance group with the `editor` role.
      * Service account for pulling a Docker image to a VM with the `container-registry.images.puller` [role](../../iam/concepts/access-control/roles.md).
   * Instance group of four {{ coi }}-based VM instances in the `{{ region-id }}-b` and `{{ region-id }}-c` availability zones.
   * {{ mpg-name }} cluster with two hosts in the `{{ region-id }}-b` and `{{ region-id }}-c` availability zones.
   * Network load balancer to distribute traffic between the group's VMs.

   {% endcut %}

1. Deploy and run the application:

   ```bash
   terraform apply -var yc_folder=$YC_FOLDER -var yc_token=$YC_TOKEN -var user=$USER
   ```

   Where:

   * `yc_folder`: [Folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where the application will be deployed.
   * `yc_token`: [IAM token](../../iam/concepts/authorization/iam-token.md) of the user to deploy the application.

To access the application, go to the `lb_address` received after executing the `terraform apply` command.

### Create and run the {{ load-testing-name }} Tool app {#create-load-testing-tool}

{% note warning %}

Before creating your {{ load-testing-name }} Tool app, [create TodoList app containers](#create-app) and [deploy the infrastructure](#create-environment).

{% endnote %}

1. Go to the directory with the {{ load-testing-name }} Tool specification:

   ```bash
   cd ../tank
   ```

1. Initialize {{ TF }} in the directory with the {{ load-testing-name }} Tool specification:

   ```bash
   terraform init
   ```

1. In the file named `tank/main.tf`, specify the path to the public and private SSH keys (the default values are `~/.ssh/id_ed25519.pub` and `~/.ssh/id_ed25519`).
1. Deploy and run the VM:

   ```bash
   terraform apply -var yc_folder=$YC_FOLDER -var yc_token=$YC_TOKEN -var user=$USER -var overload_token=<overload_token>
   ```

   Where:

   * `yc_folder`: Folder where the {{ load-testing-name }} Tool will be deployed.
   * `yc_token`: IAM token of the user to deploy the {{ load-testing-name }} Tool.
   * `overload_token`: Token to connect to `<overload.yandex.net>`. To get the token, log in, click your profile at the top right, and select **My api token** from the drop-down menu.

1. Connect to the created VM via SSH. The connection address is specified in the `terraform apply` command output.

   ```bash
   ssh <username>@<VM's_IP>
   ```

1. Run the {{ load-testing-name }} Tool:

   ```bash
   sudo yandex-tank -c load.yaml
   ```

1. Go to `<overload.yandex.net>` and find the running load: **Public tests** → **show my tests only**.

## Running scenarios {#run}

### VM failure {#error-vm}

How the failure shows itself: The VM with the application is unavailable.

Possible causes include:

* A failure of the physical host that the VM was running on.
* The VM with the application was deleted by mistake.

To simulate the failure, delete one of the instances in the group:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with your instance group.
   1. In the list of services, select **{{ compute-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/compute/vm-group-pic.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
   1. Select the `todo-ig` group.
   1. Go to the **{{ ui-key.yacloud.compute.placement-group.switch_instances }}** panel.
   1. In the line with the appropriate VM, click ![image](../../_assets/options.svg), and then click **{{ ui-key.yacloud.common.delete }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.compute.instances.popup-confirm_button_delete }}**.

{% endlist %}

Test bench reaction:

1. The network load balancer and {{ ig-name }} get information about the VM failure and exclude it from load balancing: traffic stops coming to this VM instance and is distributed across the remaining instances in the group.
1. {{ ig-name }} is [automatically restored](../../compute/concepts/instance-groups/autohealing.md).
   1. Deletes the unavailable VM instance (in this test case, it is already deleted and this step is skipped).
   1. Creates a new VM instance.
   1. Waits for the application to start on the VM instance.
   1. Adds the VM instance to load balancing.

The load balancer and {{ ig-name }} require some time to detect the problem and disable traffic to the faulty VM instance. This may cause Connection Timeout errors (HTTP code `0` in the **Quantities** and **HTTP codes** charts in the {{ load-testing-name }} Tool monitoring app).

After disabling load balancing for the unavailable VM instance, the user load is handled correctly.

### Application failure {#error-app}

How the failure shows itself: The application doesn't respond in time or doesn't work correctly from the user's point of view.

Possible causes include:

* A memory leak caused the application to fail.
* The application is unable continue due to DB connectivity loss.
* The application fails to handle requests due to heavy load.

According to [health check](../../compute/concepts/instance-groups/autohealing.md#setting-up-health-checks) settings, {{ ig-name }} polls VM instances in the group over HTTP. When operating normally, accessing the `/healthy` endpoint returns the HTTP code `200`. Otherwise, {{ ig-name }} starts the recovery procedure.

To simulate the failure in the `yandex-cloud-fault-tolerance-demo-master` repository, run the following script:

```bash
fail_random_host.sh <instance_group_ID>
```

A random instance from the group will start returning the HTTP code `503`.

Test bench reaction:

1. {{ ig-name }} receives information about the application failure and excludes the VM instance from load balancing: traffic stops coming to this instance and is distributed across the remaining instances in the group.
1. {{ ig-name }} is [automatically restored](../../compute/concepts/instance-groups/autohealing.md).
   1. Restarts the faulty VM instance.
   1. Waits for the application to start on the VM instance.
   1. Adds the VM instance to load balancing.

{{ ig-name }} polls the instance several times before disabling traffic and starting the recovery procedure. This may cause Service Unavailable errors (HTTP code `503` in the **Quantities** and **HTTP codes** charts in the {{ load-testing-name }} Tool monitoring app).

After disabling load balancing for the faulty VM instance, the user load is handled correctly.

### Availability zone failure {#zone-down}

How the failure shows itself: Multiple VMs are unavailable in the same zone.

Possible causes include:

* Data center downtime.
* Scheduled maintenance in the data center.

To move your resources to another data center:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder with your instance group.
  1. In the list of services, select **{{ compute-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/compute/vm-group-pic.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. Select the `todo-ig` group.
  1. In the top-right corner, click **{{ ui-key.yacloud.common.edit }}**.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_allocation }}**, uncheck the `{{ region-id }}-b` availability zone.
  1. Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.

{% endlist %}

Test bench reaction:

1. {{ ig-name }} disables load balancing for the VMs in the `{{ region-id }}-b` availability zone.
1. These VMs will be deleted while at the same time new VMs will be created in the `{{ region-id }}-c` zone.
1. {{ ig-name }} adds the created VMs to load balancing.

The number of VM instances that can be simultaneously created and deleted depends on the [deployment policy](../../compute/concepts/instance-groups/policies/deploy-policy.md).

While disabling load balancing for VM instances, Connection Timeout errors may occur (HTTP code `0` in the **Quantities** and **HTTP codes** charts in the {{ load-testing-name }} Tool monitoring app).

After disabling load balancing for the VM instances, the user load is handled correctly.

### Updating an application {#update-app}

To update the application:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder with your instance group.
  1. In the list of services, select **{{ compute-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/compute/vm-group-pic.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. Select the `todo-ig` group.
  1. In the top-right corner, click **{{ ui-key.yacloud.common.edit }}**.
  1. Under **{{ ui-key.yacloud.compute.groups.create.section_instance }}**, click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_coi }}** tab.
  1. Select the Docker container you need and click ![image](../../_assets/options.svg) → **{{ ui-key.yacloud.common.edit }}**.
  1. In the window that opens, specify the image with the new application version (the `v2` tag) in the **{{ ui-key.yacloud.compute.instances.create.field_coi-image }}** field.
  1. Click **{{ ui-key.yacloud.common.apply }}**.
  1. Click **{{ ui-key.yacloud.compute.groups.create.button_edit }}**.
  1. Click **{{ ui-key.yacloud.common.save }}** on the **{{ ui-key.yacloud.compute.group.edit.label_title }}** page.

{% endlist %}

Test bench reaction:

1. {{ ig-name }} disables load balancing for two VM instances with the outdated app version (the [status](../../compute/concepts/instance-groups/statuses.md#vm-statuses) of these instances is `RUNNING_OUTDATED`).
1. Deletes them while creating VM instances with the new app version.
1. Adds the created VM instances to load balancing.
1. The actions are repeated for the remaining two instances with the outdated app version.

Refresh the app page. If the network load balancer sends your request to a VM instance that's already updated, you'll see the app version with a dark color scheme.

The number of VM instances that can be simultaneously created and deleted depends on the [deployment policy](../../compute/concepts/instance-groups/policies/deploy-policy.md).

While disabling load balancing for VM instances, Connection Timeout errors may occur (HTTP code `0` in the **Quantities** and **HTTP codes** charts in the {{ load-testing-name }} Tool monitoring app).

After disabling load balancing for the VM instances, the user load is handled correctly.

### Scaling a DB configuration {#scaling-database}

You may need to scale your DB if:

* Cluster host performance is insufficient to handle requests.
* The data requires more storage capacity.

To scale the DB configuration:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder with your DB cluster.
  1. In the list of services, select **{{ mpg-name }}**.
  1. Select the `todo-postgresql` cluster.
  1. Click ![image](../../_assets/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_resource }}**, select `s2.medium`.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

{% endlist %}

{{ mpg-name }} will run the update command for the cluster.

When switching between the master and a replica (at the beginning and end of the update process), an Internal Server Error may occur (HTTP code `500` in the **Quantities** and **HTTP codes** charts in the {{ load-testing-name }} Tool monitoring app).

After switching, the user load is handled correctly.

## Deleting applications and environments {#clear-out}

{% note warning %}

If you created your VM with the {{ load-testing-name }} Tool, be sure to delete the VM first, otherwise deleting the {{ vpc-name }} network will fail.

{% endnote %}

To delete the {{ load-testing-name }} Tool application, go to the `yandex-cloud-fault-tolerance-demo-master/terraform/tank` folder and run the following command:

```bash
terraform destroy -var yc_folder=$YC_FOLDER -var yc_token=$YC_TOKEN -var user=$USER -var overload_token=not-used
```

To delete the TodoList application, go to the `yandex-cloud-fault-tolerance-demo-master/terraform/app` folder and run the following command:

```bash
terraform destroy -var yc_folder=$YC_FOLDER -var yc_token=$YC_TOKEN -var user=$USER
```
