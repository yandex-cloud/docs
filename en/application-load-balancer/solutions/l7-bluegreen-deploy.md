# Blue-green deployment for switching between service versions

In this scenario, you'll use {{ alb-name }} to prepare for switching between the old and new versions of the service based on the <q>[blue-green deployment](https://martinfowler.com/bliki/BlueGreenDeployment.html)</q> technique.

To do this:

1. [Before you start](#before-you-begin).
1. [Create instance groups](#create-ig).
1. [Upload the service files to the VMs](#update-app).
1. [Create {{ alb-name }} backend groups](#create-l7backend).
1. [Create an HTTP router and virtual hosts](#create-route-hosts).
1. [Create an L7 load balancer](#create-balancer).
1. [Check the availability of the service](#check-hosts).
1. [Test switching between the versions of the service](#test-switch).
1. [Switch to the new version of the service](#switch).
1. [Delete the created resources](#clear-out).

## Before you start {#before-you-begin}

{% include [before-you-begin](../../solutions/_solutions_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of infrastructure support includes a fee for disks and continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).

## Create instance groups {#create-ig}

Create two instance groups named `app-blue` and `app-green` with a pre-installed web server.

{% list tabs %}

- Management console

  1. In [management console]({{ link-console-main }}), select the folder where you want to create your instance group.
  1. In the list of services, select **{{ compute-name }}**.
  1. Go to the **Instance groups** tab and click **Create group**.
  1. Under **Basic parameters**:
     * Enter the **Name** `app-blue` and **Description** for the instance group.
     * Select a [service account](../../iam/concepts/users/service-accounts.md) from the list or create a new one. To be able to create, update, and delete group instances, [assign the role](../../iam/operations/sa/assign-role-for-sa.md) `editor` for the service account. All operations in {{ ig-name }} are performed on behalf of the service account.
  1. In the **Allocation** section, select the desired **availability zones**. Instances of a group may reside in [different availability zones and regions](../../overview/concepts/geo-scope.md).
  1. Under **Instance template**, click **Define** to set up the configuration for a basic instance:
     * Under **Basic parameters**, enter the template **Description**:
     * Under **Image/boot disk selection**, go to the **Cloud Marketplace** tab and select a public LEMP image.
     * Under **Disks**, select the `HDD` **Disk type** and set the **Disk size** to `13 GB`.
     * Under **Computing resources**, specify the following VM configuration:
       * [Platform](../../compute/concepts/vm-platforms.md): Intel Cascade Lake.
       * **vCPU**: 2.
       * [Guaranteed vCPU performance](../../compute/concepts/performance-levels.md): 20%.
       * **RAM**: 1 GB.
       * Enable the **Preemptible** option.
     * In the **Network settings** section, select the network and subnet to connect the VM to. If you don't have a network or subnet, create them right on the VM creation page.
       * In the **Public address** field, leave the **Auto** value to assign a random external IP address from the Yandex.Cloud pool, or select a static address from the list if you reserved one in advance.
     * Under **Access**, specify the information required to access the instance:
       * Specify a **Service account** to be linked to the instance.
       * Enter the username in the **Login** field.
       * In the **SSH key** field, paste the contents of the [public key file](../../compute/quickstart/quick-create-linux.md#create-ssh).
       * If needed, **Grant access to the serial console**.
     * Click **Save**.
  1. Under **Scalability**, specify:
     * **Fixed** [type of scaling](../../compute/concepts/instance-groups/scale.md).
     * Instance group size: 2.
  1. Under **Integration with Application Load Balancer**:
     * Enable the **Create target group** option to add the instance group to the [target group](../../application-load-balancer/concepts/target-group.md) in {{ alb-name }}.
     * Specify the name of the target group: `app-blue-tg`.
  1. Click **Create**.

  Repeat the above steps to create the second instance group (`app-green`) and the `app-green-tg` target group.

{% endlist %}

## Upload the service files to the VMs {#update-app}

To update the service version, upload the `index.html` file with updated contents to both VMs from the `app-green` group.

{% cut "Example file index.html" %}

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Version 2</title>
  </head>
  <body>
    <p>Version 2 is working</p>
  </body>
</html>
```

{% endcut %}

To upload a file to a VM:

1. You can learn the IP address of the VM under **Network** on the VM page in [management console]({{ link-console-main }}).

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH.

1. Grant your user write access to the directory `/var/www/html`:

   ```bash
   sudo chown -R "$USER":www-data /var/www/html
   ```

1. Upload the `index.html` file to the VM over SCP.

{% list tabs %}

- Linux/macOS

  To upload the file from your local machine, use the `scp` command-line utility:
    ```bash
    scp -r <file path> <VM username>@<VM IP address>:/var/www/html
    ```

- Windows

  Use the [WinSCP](https://winscp.net/eng/download.php) program to copy the `index.html` file from the local machine to the `/var/www/html` directory on the VM.

{% endlist %}

## Create {{ alb-name }} backend groups {#create-l7backend}

Create a backend group named `prod` with `blue` and `green` backends:

{% list tabs %}

- Management console
  1. In the [management console]({{ link-console-main }}), select the folder where the backend group will be created.
  1. In the list of services, select **{{ alb-name }}** and go to the **Backend groups** tab.
  1. Click **Create backend group**.
  1. Enter the backend group name: `prod`.
  1. Under **Backends**, click **Add**. Specify the backend settings:
      1. Enter the backend name: `blue`.
      1. Set the weight of the backend: `100`.
      1. In the **Target group** list, select `app-blue-tg`.
      1. Specify the **Port** that the backend VMs will use to receive incoming traffic from the load balancer: `80`.
      1. Click **Add health check**.
      1. Enter the **Port** that the backend VMs will use to accept health check connections from the load balancer: `80`.
      1. Enter the **Path** to be accessed by the load balancer's health checks: `/`.
  1. Click **Add** and repeat the above steps to set up the `green` backend with a weight of `0` and the `app-green-tg` target group.
  1. Click **Create**.

{% endlist %}

Similarly, create a backend group named `staging`: for the `blue` backend, set the weight to `0`, and for the `green` backend, set the weight to `100`.

## Create an HTTP router and virtual hosts {#create-route-hosts}

Create an HTTP router with two virtual hosts: `mywebsite.com` and `staging.mywebsite.com`:

{% list tabs %}

- Management console
  1. In the [management console]({{ link-console-main }}), select the folder where you want to create an HTTP router.
  1. In the list of services, select **{{ alb-name }}**.
  1. In the menu on the left, select **HTTP routers**.
  1. Click **Create HTTP router**.
  1. Enter the router name: `myrouter`.
  1. Under **Add virtual host**, click **Add host**. Specify the following host settings:
     1. Enter the host name: `prod`.
     1. Specify the **Authority** value: `mywebsite.com`
     1. Click **Add route**.
     1. Enter the **Name**: `prod`.
     1. In the **Path** field, select `Exact match` and specify the path `/`.
     1. In the **HTTP methods** list, select `GET`.
     1. In the **Action** field, leave the value `Routing`.
     1. In the **Backend group** list, select `prod`.
  1. Under **Virtual hosts**, click **Add host**. Specify the backend settings:
     1. Enter the host name: `staging`.
     1. Specify the **Authority** value: `staging.mywebsite.com`
     1. Click **Add route**.
     1. Enter the **Name**: `staging`.
     1. In the **Path** field, select `Exact match` and specify the path `/`.
     1. In the **HTTP methods** list, select `GET`.
     1. In the **Action** field, leave the value `Routing`.
     1. In the **Backend group** list, select `staging`.
  1. Leave the other settings as they are and click **Create**.

{% endlist %}

## Create an L7 load balancer {#create-balancer}

{% list tabs %}

- Management console
  1. In the [management console]({{ link-console-main }}), select the folder where the load balancer will be created.
  1. In the list of services, select **{{ alb-name }}**.
  1. In the menu on the left, select **Load balancers**.
  1. Click **Create L7 load balancer**.
  1. Enter the name of the load balancer: `deploy-balancer`.
  1. Under **Network Settings**, select the network whose subnets will host the load balancer's nodes and the [appropriate security groups](../concepts/application-load-balancer.md#security-groups) (if there is no corresponding field, all incoming and outgoing traffic will be allowed for the load balancer).
  1. Under **Allocation**, select three subnets for the load balancer's nodes and enable traffic to these subnets.
  1. Click **Add listener** under **Listeners**. Set the listener settings:
      1. Enter the listener name: `app-listener`.
      1. Under **Public IP address settings**, enable traffic.
      1. Set the port to `80`.
      1. In the **Assign IP address** field, select **Automatically**.
  1. In the **HTTP router** field, select `myrouter`.
  1. Click **Create**.

{% endlist %}

## Check the availability of the service {#check-hosts}

Check the availability of the service on both hosts: `mywebsite.com` and `staging.mywebsite.com`.

1. Run the command:

   ```
   curl -H "Host: mywebsite.com" http://<L7 load balancer's IP address>
   ```

   This opens the `Welcome to nginx!` page.

1. Check the availability of the second host:

   ```
   curl -H "Host: staging.mywebsite.com" http://<load balancer's IP address>
   ```

   As a result, the new version of the service is displayed: `Version 2 is working`.

## Test switching between the versions of the service {#test-switch}

1. In the [management console]({{ link-console-main }}), go to the working folder.

1. In the list of services, select **{{ alb-name }}** and go to the **Backend groups** tab.

1. In the `prod` backend group, specify the following new parameters:
   * **Weight** of the `blue` backend: 50.
   * **Weight** of the `green` backend: 50.

1. Make sure that the new version of the service is running on the `mywebsite.com` host. Run the command several times:

   ```
   curl -H "Host: mywebsite.com" http://<L7 load balancer's IP address>
   ```

   The results will display the nginx stub or the second version of the service alternately.

1. To switch all traffic to the new service version, set the following backend weights:
   * `blue`: 0.
   * `green`: 100.

   {% note info %}

   You can change the ratio of traffic gradually by setting different values of backend weights: `50/50`, `30/70`, or `0/100`.

   {% endnote %}

1. Make sure that only the new service version now responds on the `mywebsite.com` host.

   ```
   curl -H "Host: mywebsite.com" http://<L7 load balancer's IP address>
   ```

1. Test the rollback of the service to the initial version:
   1. In the `prod` backend group, reset the backend weights to the initial values: `blue` to `100` and `green` to `0`.
   1. Run the curl command to check that the first version of the service, that is the nginx stub, responds on the `mywebsite.com` host.

## Switch to the new version of the service {#switch}

{% list tabs %}

- Management console

  1. In the list of services, select **{{ alb-name }}** and go to the **Backend groups** tab.
  1. In the `prod` backend group, specify:
     * **Weight** of the `blue` backend: 0.
     * **Weight** of the `green` backend: 100.
     * Switch the target group to `staging`.
  1. In the `staging` backend group, swap the weights:
     * **Weight** of the `blue` backend: 100.
     * **Weight** of the `green` backend: 0.

{% endlist %}

## Delete the created resources {#clear-out}

To shut down the infrastructure and stop paying for the created resources:

1. Delete the non-billable resources that block the deletion of billable resources:
   1. [Delete](../operations/application-load-balancer-delete.md) the `deploy-balancer` L7 load balancer.
   1. [Delete](../operations/http-router-delete.md) the `myrouter` HTTP routers.
   1. [Delete](../operations/backend-group-delete.md) the `prod` and `staging` backend groups.
1. [Delete](../../compute/operations/instance-groups/delete.md) the `app-blue` and `app-green` instance groups.

