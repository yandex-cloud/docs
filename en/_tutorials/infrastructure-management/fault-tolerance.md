# Configuring a fault-tolerant architecture in {{ yandex-cloud }}

In this guide, you'll learn how to configure a fault-tolerant architecture in {{ yandex-cloud }} and check how it works using various test cases.

Fault tolerance is the property that enables a system to continue operating after a failure of one or more of its components.

To configure and test the architecture:
1. [Before you start](#before-begin).
1. [Set up a test bench](#prepare):
   * [Create TodoList app containers](#create-app).
   * [Deploy the infrastructure](#create-environment).
   * [Create and run the {{ load-testing-name }} Tool](#create-load-testing-tool).
1. [Run the following test scenarios](#run):
   * [VM failure](#error-vm).
   * [Application failure](#error-app).
   * [Availability zone failure](#zone-down).
   * [Updating an application](#update-app).
   * [Scaling a DB configuration](#scaling-database).

If you no longer need these resources, [delete them](#clear-out).

## Prepare your cloud {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost for supporting a fault-tolerant {{ yandex-cloud }} architecture includes:
* A fee for the [disks](../../compute/concepts/disk.md) and the continuously running [VMs](../../compute/concepts/vm.md) (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A fee for the continuously running [cluster {{ mpg-full-name }}](../../managed-postgresql/concepts/index.md) (see [{{ mpg-name }} pricing](../../managed-postgresql/pricing.md)).
* A fee for using a dynamic or a static [public IP](../../vpc/concepts/address.md) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Set up a test bench {#prepare}

### Description of the test bench {#stand}

Description of the test bench:
* The application is packaged into a [Docker image](../../container-registry/concepts/docker-image.md) and pushed to {{ container-registry-full-name }}.

   Docker images are deployed on four VMs based on a [{{ coi }}](../../cos/). The VMs are grouped and located in two different [availability zones](../../overview/concepts/geo-scope.md).
* A DB cluster is managed by {{ mpg-name }} and consists of two hosts that reside in different availability zones.
* The [{{ load-testing-name }} Tool](/marketplace/products/yc/load-testing) application generates the {{ marketplace-full-name }} workload that is applied to [{{ network-load-balancer-full-name }}](../../network-load-balancer/). The network load balancer distributes traffic across VMs.

### Create TodoList app containers {#create-app}

To prepare the application to run in {{ yandex-cloud }}:

1. [Authenticate](../../container-registry/operations/authentication.md) in {{ container-registry-name }}.

   ```bash
   yc container registry configure-docker
   ```

1. [Create a registry](../../container-registry/operations/registry/registry-create.md):

   ```bash
   yc container registry create --name todo-registry
   ```

1. [Create a Docker image](../../container-registry/operations/docker-image/docker-image-create.md) with the `v1` tag:

    ```bash
    docker build . --tag {{ registry }}/<registry_id>/todo-demo:v1
    ```

1. Create a Docker image with the `v2` tag (to test the application update case):

    ```bash
    docker build . --build-arg COLOR_SCHEME=dark --tag {{ registry }}/<registry_id>/todo-demo:v2
    ```

1. [Push the Docker images](../../container-registry/operations/docker-image/docker-image-push.md) to {{ container-registry-name }}:

    ```bash
    docker push {{ registry }}/<registry_id>/todo-demo:v1
    docker push {{ registry }}/<registry_id>/todo-demo:v2
    ```

### Deploy the infrastructure {#create-environment}

To prepare the environment for running the application in {{ yandex-cloud }}:
1. Install [{{ TF }}](https://www.terraform.io).
1. Download the [repository](https://github.com/glebmish/yandex-cloud-fault-tolerance-demo/archive/master.zip) including the demo application source code, the {{ TF }} specs, and a script to simulate the application failure.
1. Go to the directory with the environment specification:

   ```bash
   cd app
   ```

1. Initialize {{ TF }} in the spec directory:

   ```bash
   terraform init
   ```

1. In the file named `app/todo-service.tf`, specify the path to the public SSH key (the default value is `~/.ssh/id_ed25519.pub`).
1. Deploy and run the application:

   ```bash
   terraform apply -var yc_folder=<folder_id> -var yc_token=<yc_token> -var user=$USER
   ```

   Where:
   * `folder_id`: The [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where the application will be deployed.
   * `yc_token`: The [OAuth-token](../../iam/concepts/authorization/oauth-token.md) of the user that you want to deploy the application under.

The following resources are created:
* A {{ vpc-name }} [network](../../vpc/concepts/network.md#network) with three [subnets](../../vpc/concepts/network.md#subnet) in all availability zones.
* Two [service accounts](../../iam/concepts/users/service-accounts.md):
   * A service account for managing a VM instance group with the `editor` role.
   * A service account for pulling a Docker image to a VM with the `container-registry.images.puller` [role](../../iam/concepts/access-control/roles.md).
* An instance group of four {{ coi }}-based VM instances in the `{{ region-id }}-a` and `{{ region-id }}-b` availability zones.
* A {{ mpg-name }} cluster with two hosts in the `{{ region-id }}-a` and `{{ region-id }}-b` availability zones.
* The network load balancer for distributing traffic across VM instances in the instance group.

To access the application, go to the `lb_address` received after executing the `terraform apply` command.

### Create and run the {{ load-testing-name }} Tool app {#create-load-testing-tool}

{% note warning %}

Before creating your {{ load-testing-name }} Tool app, [create TodoList app containers](#create-app) and [deploy the infrastructure](#create-environment).

{% endnote %}

1. Go to the directory with the {{ load-testing-name }} Tool specification:

   ```bash
   cd load-testing-tool
   ```

1. Initialize {{ TF }} in the directory with the {{ load-testing-name }} Tool specification:

   ```bash
   terraform init
   ```

1. In the file named `load-testing-tool/main.tf`, specify the path to the public and private SSH keys (the default values are `~/.ssh/id_ed25519.pub` and `~/.ssh/id_ed25519`).
1. Deploy and run the VM:

   ```bash
   terraform apply -var yc_folder=<folder_id> -var yc_token=<yc_token> -var user=$USER -var overload_token=<overload_token>
   ```

   Where:
   * `folder_id`: The folder where the {{ load-testing-name }} Tool will be deployed.
   * `yc_token`: The OAuth token of the user that you want to deploy the {{ load-testing-name }} Tool under.
   * `overload_token`: The token that is used to connect to `<overload.yandex.net>`. To get the token, log in, click on your profile at the top right, and select **My api token** from the drop-down menu.

1. Connect to the created VM via SSH. The connection address is specified in the `terraform apply` command result.
1. Run the {{ load-testing-name }} Tool:

   ```bash
   sudo yandex-tank -c load.yaml
   ```

1. Go to `<overload.yandex.net>` and find the running shot: **Public tests** -> **show my tests only**.

## Running {#run} scenarios

### VM failure {#error-vm}

How the failure shows itself: The VM with the application is unavailable.

Possible cause:
* A failure of the physical host that the VM was running on.
* The VM with the application was deleted by mistake.

To simulate the failure, delete one of the instances in the group.

Test bench reaction:
1. The network load balancer and {{ ig-name }} get information about the VM failure and exclude it from load balancing: traffic stops coming to this VM instance and is distributed across the remaining instances in the group.
1. {{ ig-name }} is [automatically restored](../../compute/concepts/instance-groups/autohealing.md).
   1. Deletes the unavailable VM instance (in this test case, it is already deleted and this step is skipped).
   1. Creates a new VM instance.
   1. Waits for the application to start on the VM instance.
   1. Adds the VM instance to load balancing.

The load balancer and {{ ig-name }} require some time to detect the problem and disable traffic to the faulty VM instance. This may cause Connection Timeout errors (HTTP code `0` in the **Quantities** and **HTTP codes** charts in the {{ load-testing-name }} Tool monitoring app).

After disabling load balancing for the unavailable VM instance, the user load is handled correctly.

### {#error-app} Application failure.

How the failure shows itself: The application doesn't respond in time or doesn't work correctly from the user's point of view.

Possible cause:
* A memory leak caused the application to fail.
* The application is unable continue due to DB connectivity loss.
* The application fails to handle requests due to heavy load.

According to [health check](../../compute/concepts/instance-groups/autohealing.md#setting-up-health-checks) settings, {{ ig-name }} polls VM instances in the group over HTTP. When operating normally, accessing the `/healthy` endpoint returns the HTTP code `200`. Otherwise, {{ ig-name }} starts the recovery procedure.

To simulate the failure, run the script:

```bash
fail_random_host.sh <group_id>
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

### {#zone-down} Availability zone failure.

How the failure shows itself: Multiple VMs are unavailable in the same zone.

Possible cause:
* Data center downtime.
* Scheduled maintenance in the data center.

To move your resources to another data center:
1. In the [management console]({{ link-console-main }}), select the folder with your instance group.
1. From the list of services, select {{ compute-name }}.
1. Click **Instance groups**.
1. Select the `todo-ig` group.
1. Click **Edit**.
1. In the **Distribution** section, uncheck the `{{ region-id }}-b` availability zone.
1. Click **Save changes**.

Test bench reaction:
1. {{ ig-name }} disables load balancing for the VMs in the `{{ region-id }}-b` availability zone.
1. These VMs are deleted and, at the same time, VMs are created in the `{{ region-id }}-a` zone.
1. {{ ig-name }} adds the created VMs to load balancing.

The number of VM instances that can be simultaneously created and deleted depends on the [deployment policy](../../compute/concepts/instance-groups/policies/deploy-policy.md).

While disabling load balancing for VM instances, Connection Timeout errors may occur (HTTP code `0` in the **Quantities** and **HTTP codes** charts in the {{ load-testing-name }} Tool monitoring app).

After disabling load balancing for the VM instances, the user load is handled correctly.

### Updating an application {#update-app}

To update the application:
1. In the [management console]({{ link-console-main }}), select the folder with your instance group.
1. From the list of services, select {{ compute-name }}.
1. Click **Instance groups**.
1. Select the `todo-ig` group.
1. Click **Edit**.
1. Under **Instance template**, click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) and select **Edit**.
1. On the **Container Solution** tab, select the required Docker container.
1. In the **Docker image** field of the window that opens, enter the name of the Docker image with the new app version.
1. Click **Apply**.
1. Click **Save**.
1. Click **Save changes**.

Test bench reaction:

1. {{ ig-name }} disables load balancing for two VM instances with the outdated app version (the [status](../../compute/concepts/instance-groups/statuses.md#vm-statuses) of these instances is `RUNNING_OUTDATED`).
1. Deletes them while creating VM instances with the new app version.
1. Adds the created VM instances to load balancing.
1. The actions are repeated for the remaining two instances with the outdated app version.

Refresh the app page. If the network load balancer sends your request to a VM instance that's already updated, you'll see the app version with a dark color scheme.

The number of VM instances that can be simultaneously created and deleted depends on the [deployment policy](../../compute/concepts/instance-groups/policies/deploy-policy.md).

While disabling load balancing for VM instances, Connection Timeout errors may occur (HTTP code `0` in the **Quantities** and **HTTP codes** charts in the {{ load-testing-name }} Tool monitoring app).

After disabling load balancing for the VM instances, the user load is handled correctly.

### Scaling a {#scaling-database} DB configuration.

You may need to scale your DB if:
* Cluster host performance is insufficient to handle requests.
* The data requires more storage capacity.

To scale the DB configuration:

1. In the ({{ link-console-main }}) [management console], select the folder with your DB cluster.
1. From the list of services, select {{ mpg-name }}.
1. Select the `todo-postgresql` cluster.
1. Click **Edit cluster**.
1. Under **Host class**, select **s2.medium**.
1. Click **Save changes**.

{{ mpg-name }} will run the update command for the cluster.

When switching between the master and a replica (at the beginning and end of the update process), an Internal Server Error may occur (HTTP code `500` in the **Quantities** and **HTTP codes** charts in the {{ load-testing-name }} Tool monitoring app).

After switching, the user load is handled correctly.

## Deleting {#clear-out} applications and environments

{% note warning %}

If you created your VM with the {{ load-testing-name }} Tool, be sure to delete the VM first, otherwise deleting the {{ vpc-name }} will fail.

{% endnote %}

To delete the {{ load-testing-name }} Tool app, go to the `load-testing-tool` folder and run the command:

```bash
terraform destroy -var yc_folder=<folder_id> -var yc_token=<yc_token> -var user=$USER -var overload_token=not-used
```

To delete the TodoList app, go to the `app` directory and run the following command:

```bash
terraform destroy -var yc_folder=<folder_id> -var yc_token=<yc_token> -var user=$USER
```
