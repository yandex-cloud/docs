# Implementing fault-tolerant scenarios for NAT VMs


In {{ yandex-cloud }}, you can deploy a cloud infrastructure using network VMs that provide firewall protection, network security, and traffic routing. With [static routing](../../vpc/concepts/routing.md), you can route traffic from subnets to network VMs. 

To ensure high availability, you can deploy multiple network VMs in different [availability zones](../../overview/concepts/geo-scope.md) and use a [route switcher](https://github.com/yandex-cloud-examples/yc-route-switcher/tree/main) to automatically switch outbound traffic between them.

In our scenario, the route switcher ensures fault tolerance of a [NAT instance](/marketplace/products/yc/nat-instance-ubuntu-18-04-lts), a network VM with preset routing and IP address translation rules providing internet access for {{ yandex-cloud }} resources.

In the flow chart below, `NAT-A` is the main egress internet gateway, while `NAT-B` is a standby one.

![image](../../_assets/tutorials/route-switcher-scheme.svg)

{% cut "Chart description" %}

   | Element name | Description |
   | ----------- | ----------- |
   | NAT-A, NAT-B | NAT instances that enable internet access for cloud resources by translating the resources' private IP addresses to the NAT instances' public IP addresses. |
   | VPC: demo | {{vpc-name }} network |
   | private-a | Subnet in the `{{ region-id }}-a` availability zone, hosting resources that require internet access. |
   | public-a, public-b | Subnets in the `{{ region-id }}-a` and `{{ region-id }}-b` availability zones, hosting NAT instances |
   | public ip a, public ip b | NAT instance public IP addresses |
   | NLB | Internal network load balancer for the route switcher, performing NAT instance health checks by probing TCP port 22 |

{% endcut %}

If `NAT-A` fails, the route switcher will switch outbound traffic to `NAT-B` by changing its `Next hop` value to the `NAT-B` internal IP address in the route table. After that, `NAT-B` will provide internet access.

![image](../../_assets/tutorials/route-switcher-failure-scheme.svg)

As soon as `NAT-A` recovers, the route switcher will change the `Next hop` value to the `NAT-A` internal IP address, thus rerouting outbound traffic through `NAT-A`.

In this tutorial, we will create a test infrastructure showing how a route switcher works. Our example will include the following basic components:

* **nat-a**: Main NAT instance.
* **nat-b**: Standby NAT instance.
* **test-vm**: Internal VM accessing the internet through a NAT instance. 
* **route-switcher-lb-...**: [Network load balancer](../../network-load-balancer/concepts/index.md) for the route switcher, running health checks on the NAT instances.
* **route-switcher-...**: [Cloud function](../../functions/concepts/function.md) switching outbound traffic to the standby NAT instance if the main one is down.

To deploy the infrastructure and test your route switcher:

1. [Get your cloud ready](#prepare-cloud).
1. [Set up your environment](#prepare-environment).
1. [Deploy your resources](#create-resources).
1. [Enable the route switcher](#enable-route-switcher).
1. [Test the solution for performance and fault tolerance](#test-solution).

If you no longer need the resources you created, [delete them](#clear-out).
 
## Get your cloud ready {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support cost includes:

* Fee for continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using {{ network-load-balancer-name }} (see [{{ network-load-balancer-full-name }} pricing](../../network-load-balancer/pricing.md)).
* Fee for public IP addresses and outbound traffic (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for using the function (see [{{ sf-full-name }} pricing](../../functions/pricing.md)).

## Configure your CLI profile {#setup-profile}

1. If you do not have the {{ yandex-cloud }} CLI yet, [install](../../cli/quickstart.md) it and sign in as a user.
1. Create a service account:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you want to create a service account.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
      1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. Enter a name for the service account, e.g., `sa-terraform`.
      1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

   - CLI {#cli}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      To create a service account, run the command below, specifying `sa-terraform` as the service account name:

      ```bash
      yc iam service-account create --name sa-terraform
      ```

      Where `name` is the service account name.

      Result:

      ```text
      id: ajehr0to1g8b********
      folder_id: b1gv87ssvu49********
      created_at: "2023-06-20T09:03:11.665153755Z"
      name: sa-terraform
      ```

   - API {#api}

      To create a service account, use the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call or the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the `ServiceAccount` resource.

   {% endlist %}

1. Assign the admin [role](../../iam/concepts/access-control/roles.md) for the folder to the service account: 

   {% list tabs group=instructions %}

   - Management console {#console}

      1. On the management console [home page]({{ link-console-main }}), select a folder.
      1. Navigate to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
      1. Find the `sa-terraform` account in the list and click ![image](../../_assets/options.svg).
      1. Click **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
      1. In the dialog that opens, click **Add role** and select `admin`.

   - CLI {#cli}

      Run this command:

      ```
      yc resource-manager folder add-access-binding <folder_ID> \
         --role admin \
         --subject serviceAccount:<service_account_ID>
      ```

   - API {#api}

      To assign a role for a folder to a service account, use the [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md) gRPC API call.

   {% endlist %}

1. Set up the CLI profile to run operations under the service account:

   {% list tabs group=instructions %}

   - CLI {#cli}

      1. Create an [authorized key](../../iam/concepts/authorization/key.md) for the service account and save it to the file:

         ```bash
         yc iam key create \
         --service-account-id <service_account_ID> \
         --folder-id <ID_of_folder_with_service_account> \
         --output key.json
         ```

         Where:
         * `service-account-id`: Service account ID.
         * `folder-id`: Service account folder ID.
         * `output`: Authorized key file name.

         Result:

         ```text
         id: aje8nn871qo4********
         service_account_id: ajehr0to1g8b********
         created_at: "2023-06-20T09:16:43.479156798Z"
         key_algorithm: RSA_2048
         ```

      1. Create a CLI profile to run operations under the service account:
         ```bash
         yc config profile create sa-terraform
         ```

         Result:

         ```text
         Profile 'sa-terraform' created and activated
         ```

      1. Configure the profile:

         ```bash
         yc config set service-account-key key.json
         ```

         Where:

         `service-account-key`: Service account authorized key file.

      1. Add your credentials to the environment variables:

         ```bash
         export YC_TOKEN=$(yc iam create-token)
         ```

    {% endlist %}

## Set up an environment for deploying the resources {#setup-environment}

1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
1. Install [Git](https://en.wikipedia.org/wiki/Git) using the following command:

   ```bash
   sudo apt install git
   ```

1. Clone the `yandex-cloud-examples/yc-route-switcher` GitHub repository and navigate to the directory containing resources for our example:

    ```bash
    git clone https://github.com/yandex-cloud-examples/yc-route-switcher.git
    cd yc-route-switcher/examples
    ```

1. Open the `terraform.tfvars` file in a text editor, such as `nano`:

    ```bash
    nano terraform.tfvars
    ```

1. Edit the following:

   1. Folder ID line:

      ```text
      folder_id = "<folder_ID>"
      ```

   1. Line with a list of public IP addresses allowed to access `test-vm`:

      ```text
      trusted_ip_for_mgmt = ["<workstation_external_IP_address>/32"]
      ```

      Where:
      `<workstation_external_IP_address>` is your computer public IP address. 

      To get your computer public IP address, run this command:

      ```bash
      curl 2ip.ru
      ```

      Result:

      ```text
      192.240.24.87
      ```

## Deploy your resources {#create-resources}

1. Initialize {{ TF }}: 

   ```bash
   terraform init
   ```

1. Check whether the {{ TF }} configuration files are correct:

   ```bash
   terraform validate
   ```

1. Check the list of new cloud resources:

   ```bash
   terraform plan
   ```

1. Create the resources:

   ```bash
   terraform apply 
   ```

1. Wait until the command completes and save its output: {#final-output}

   ```bash
   Outputs:
   nat-a_public_ip_address = "***.***.129.139"
   nat-b_public_ip_address = "***.***.105.234"
   path_for_private_ssh_key = "./pt_key.pem"
   test_vm_password = <sensitive>
   vm_username = "admin"
   ```

## Enable the route switcher {#enable-route-switcher}

1. Make sure the NAT instances are running and accessible from the internal network:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select your infrastructure folder.
      1. Select **{{ network-load-balancer-name }}** and navigate to the `route-switcher-lb-...` page.
      1. Expand the target group and check whether its resources are `Healthy`. 

   {% endlist %}

1. Open the `route-switcher.tf` file in a text editor, such as `nano`:

    ```bash
    nano route-switcher.tf
    ```

1. Change the `start_module` value in the `route-switcher` module to `true`. 
1. Start the module with this command:

   ```bash
   terraform apply 
   ```

   Within five minutes, the route switcher will start, providing fault tolerance for outbound NAT traffic.

## Test the solution for performance and fault tolerance {#test-solution}

### Testing the system performance {#accessibility-test}

1. Connect to the `test-vm` serial console:

   {% list tabs group=instructions %}

   - Management console {#console}
  
      1. In the [management console]({{ link-console-main }}), select your infrastructure folder.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. In the VM list, select `test-vm`.
      1. Navigate to the **{{ ui-key.yacloud.compute.instance.switch_console }}** tab.
      1. Wait for the operating system to boot.

   {% endlist %}

1. Enter the `admin` username and password. 
   To get the password, run this command from the {{ TF }} directory on your computer:

    ```bash
    terraform output test_vm_password
    ```

1. Make sure `test-vm` uses the `nat-a` public IP address to access the internet by running this command in the serial console:

   ```bash
   curl ifconfig.co
   ```

   Compare the IP address you get with `nat-a_public_ip_address` [you saved earlier](#final-output).

1. Run a `ping` to a public host to trigger `test VM` outbound traffic:

   ```bash
   ping ya.ru
   ```

   Make sure you get an ICMP response:

   ```bash
   PING ya.ru (77.88.55.242) 56(84) bytes of data.
   64 bytes from ya.ru (77.88.55.242): icmp_seq=1 ttl=56 time=4.67 ms
   64 bytes from ya.ru (77.88.55.242): icmp_seq=2 ttl=56 time=3.83 ms
   64 bytes from ya.ru (77.88.55.242): icmp_seq=3 ttl=56 time=3.80 ms
   64 bytes from ya.ru (77.88.55.242): icmp_seq=4 ttl=56 time=3.78 ms
   ```

1. Check the route table to make sure the `Next hop` value for the `demo` network matches the `nat-a` internal IP address.

### Testing the system fault tolerance {#fault-tolerance-test}

1. Emulate a system failure by stopping the main NAT instance:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select your infrastructure folder.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. Select the `nat-a` VM from the list, click ![image](../../_assets/options.svg), and select **{{ ui-key.yacloud.common.stop }}**.
      1. In the window that opens, click **{{ ui-key.yacloud.compute.instances.popup-confirm_button_stop }}**.

   - CLI {#cli}

      1. See the description of the CLI command for stopping a VM:

         ```bash
         yc compute instance stop --help
         ```

      1. Stop the VM:

         ```bash
         yc compute instance stop nat-a
         ```

   - API {#api}

      Use the [stop](../../compute/api-ref/Instance/stop.md) REST API method for the [Instance](../../compute/api-ref/Instance/) resource or the [InstanceService/Stop](../../compute/api-ref/grpc/Instance/stop.md) gRPC API call.

   {% endlist %}

1. Monitor the loss of `ping` packets. 
   After the main NAT instance gets disabled, you may see a traffic loss for about a minute with the subsequent traffic recovery.
1. Make sure `test-vm` now uses the `nat-b` public IP address to access the internet by stopping `ping` and running this command in the serial console:

   ```bash
   curl ifconfig.co
   ```

   Compare the IP address you get with `nat-b_public_ip_address` [you saved earlier](#final-output).
1. Check the route table to make sure the route switcher changed the `Next hop` value for the `demo` network to the `nat-b` internal IP address.
1. Run a `ping` to trigger `test VM` outbound traffic:
1. Emulate the system recovery by starting the main NAT instance:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select your infrastructure folder.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. Select the `nat-a` VM from the list, click ![image](../../_assets/options.svg), and select **{{ ui-key.yacloud.common.stop }}**.
      1. In the window that opens, click **{{ ui-key.yacloud.compute.instances.popup-confirm_button_start }}**.

   - CLI {#cli}

      1. See the description of the CLI command for starting a VM:

         ```bash
         yc compute instance start --help
         ```

      1. Start the VM:

         ```bash
         yc compute instance start nat-a
         ```

   - API {#api}

      Use the [start](../../compute/api-ref/Instance/start.md) REST API method for the [Instance](../../compute/api-ref/Instance/) resource or the [InstanceService/Start](../../compute/api-ref/grpc/Instance/start.md) gRPC API call.

   {% endlist %}

1. Monitor the `ping` output. As `NAT-A` recovers, you may not see any packet loss. 
1. Make sure `test-vm` now uses the `nat-a` public IP address to access the internet by stopping `ping` and running this command in the serial console:

   ```bash
   curl ifconfig.co
   ```

   Compare the IP address you get with `nat-a_public_ip_address` [you saved earlier](#final-output).
1. Check the route table to make sure the route switcher changed the `Next hop` value for the `demo` network back to the `nat-a` internal IP address.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created, run this command:

  ```bash
  terraform destroy
  ```
  
  {% note warning %}

  {{ TF }} will **permanently** delete all resources, such as networks, subnets, VMs, load balancer, etc.

  {% endnote %}
