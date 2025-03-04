# Implementing fault-tolerant use cases for network VMs


In {{ yandex-cloud }}, you can deploy a cloud infrastructure using network VMs that provide firewall protection, network security, and traffic routing. With [static routing](../../vpc/concepts/routing.md), traffic is routed from subnets to network VMs. 

To ensure high availability, we will deploy two NAT VMs in different [availability zones](../../overview/concepts/geo-scope.md), using [route-switcher module](https://github.com/yandex-cloud-examples/yc-route-switcher/tree/main) to automatically switch outbound traffic between them.

This tutorial describes a use case when the route-switcher module provides fault tolerance of a [NAT instance](/marketplace/products/yc/nat-instance-ubuntu-18-04-lts), a network VM with preset routing and IP address translation rules. NAT instances help provide internet access for VMs and other cloud resources hosted in {{ yandex-cloud }}.

In the flow chart below, `NAT-A` is the main internet gateway, while `NAT-B` is a standby one.

![image](../../_assets/tutorials/route-switcher-scheme.svg)

{% cut "Description of the scheme elements" %}

   | Element name | Description |
   | ----------- | ----------- |
   | NAT-A, NAT-B | NAT instances that provide internet access to cloud resources by translating the resources' internal IP addresses to the NAT instances' public IPs. |
   | VPC: demo | {{vpc-name }} network |
   | private-a | Subnet in the `{{ region-id }}-a` availability zone for hosting resources that require internet access. |
   | public-a, public-b | Subnets in the `{{ region-id }}-a` and `{{ region-id }}-b` availability zones hosting the NAT instances. |
   | public ip a, public ip b | NAT instances’ public IP addresses. |
   | NLB | Internal network load balancer required for the route-switcher module to run; it checks whether the NAT instances are available by performing health checks on port TCP 22. |

{% endcut %}

If `NAT-A` fails, route-switcher will switch outbound traffic to `NAT-B` by changing its route table’s `Next hop` value to the `NAT-B` internal IP address. After that, `NAT-B` will provide internet access.

![image](../../_assets/tutorials/route-switcher-failure-scheme.svg)

Once `NAT-A` recovers, route-switcher will change the `Next hop` value to the `NAT-A` internal IP address, thus rerouting outbound traffic to `NAT-A`.

In this tutorial, we will create a test infrastructure showing how route-switcher works. Our example will include the following components:

* **nat-a**: Main NAT instance.
* **nat-b**: Standby NAT instance.
* **test-vm**: VM within the infrastructure's internal perimeter that is going to have internet access through the respective NAT instance. 
* **route-switcher-lb-...**: [Network load balancer](../../network-load-balancer/concepts/index.md) required for the route-switcher module to run and used to check if the NAT instances are available.
* **route-switcher-...**: [Cloud function](../../functions/concepts/function.md) that switches outgoing traffic over to the standby NAT instance if the main one is down.

To deploy the infrastructure and test route-switcher:

1. [Get your cloud ready](#prepare-cloud).
1. [Prepare the environment](#prepare-environment).
1. [Deploy your resources](#create-resources).
1. [Enable the route-switcher module](#enable-route-switcher).
1. [Test the solution for performance and fault tolerance](#test-solution).

If you no longer need the resources you created, [delete them](#clear-out).
 
## Get your cloud ready {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support cost includes:

* Fee for continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using {{ network-load-balancer-name }} (see [{{ network-load-balancer-full-name }} pricing](../../network-load-balancer/pricing.md)).
* Fee for IP addresses and outbound traffic (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for using the function (see [{{ sf-full-name }} pricing](../../functions/pricing.md)).

## Configure the CLI profile {#setup-profile}

1. If you do not have the {{ yandex-cloud }} command line interface yet, [install](../../cli/quickstart.md) it and sign in as a user.
1. Create a service account:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder where you want to create a service account.
      1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
      1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. Specify the service account name, e.g., `sa-terraform`.
      1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

   - CLI {#cli}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      To create a service account, run the command below and specify the `sa-terraform` name:

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

1. Assign the service account the administrator [role](../../iam/concepts/access-control/roles.md) for the folder: 

   {% list tabs group=instructions %}

   - Management console {#console}

      1. On the management console [home page]({{ link-console-main }}), select a folder.
      1. Navigate to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
      1. Find the `sa-terraform` account in the list and click ![image](../../_assets/options.svg).
      1. Click **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
      1. In the dialog that opens, click **Add role** and select the `admin` role.

   - CLI {#cli}

      Run this command:

      ```
      yc resource-manager folder add-access-binding <folder_ID> \
         --role admin \
         --subject serviceAccount:<service_account_ID>
      ```

   - API {#api}

      To assign a service account a role for a folder, use the [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md) gRPC API call.

   {% endlist %}

1. Set up a CLI profile to run operations on behalf of the service account:

   {% list tabs group=instructions %}

   - CLI {#cli}

      1. Create a service account [authorized key](../../iam/concepts/authorization/key.md) and save it to the file:

         ```bash
         yc iam key create \
         --service-account-id <service_account_ID> \
         --folder-id <service_account_folder_ID> \
         --output key.json
         ```

         Where:
         * `service-account-id`: Service account ID.
         * `folder-id`: ID of the service account folder.
         * `output`: Name of the authorized key file.

         Result:

         ```text
         id: aje8nn871qo4********
         service_account_id: ajehr0to1g8b********
         created_at: "2023-06-20T09:16:43.479156798Z"
         key_algorithm: RSA_2048
         ```

      1. Create a CLI profile to perform operations under the service account:
         ```bash
         yc config profile create sa-terraform
         ```

         Result:

         ```text
         Profile 'sa-terraform' created and activated
         ```

      1. Set the profile configuration:

         ```bash
         yc config set service-account-key key.json
         ```

         Where:

         `service-account-key`: Authorized key file name.

      1. Add your credentials to the environment variables:

         ```bash
         export YC_TOKEN=$(yc iam create-token)
         ```

    {% endlist %}

## Set up the environment for deploying the resources {#setup-environment}

1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
1. Install [Git](https://en.wikipedia.org/wiki/Git) with this command:

   ```bash
   sudo apt install git
   ```

1. Clone the `yandex-cloud-examples/yc-route-switcher` GitHub repository and navigate to the directory containing resources for our example:

    ```bash
    git clone https://github.com/yandex-cloud-examples/yc-route-switcher.git
    cd yc-route-switcher/examples
    ```

1. Open the `terraform.tfvars` file, e.g., using the `nano` editor:

    ```bash
    nano terraform.tfvars
    ```

1. Edit the following:

   1. Line with the folder ID:   

      ```text
      folder_id = "<folder_ID>"
      ```

   1. String with a list of allowed public IP addresses for `test-vm` access:

      ```text
      trusted_ip_for_mgmt = ["<workstation_external_IP_address>/32"]
      ```

      Where:
      `<workstation_external_IP_address>` is your computer public IP address. 

      To find out the external IP address of your workstation, run:

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

1. Preview your new cloud resources:

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

## Enable the route-switcher module {#enable-route-switcher}

1. Make sure the NAT gateways are running and available from the internal network:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select your infrastructure folder.
      1. Select **{{ network-load-balancer-name }}** and navigate to the `route-switcher-lb-...` page.
      1. Open the target group and make sure its resources are `Healthy`. 

   {% endlist %}

1. Open the `route-switcher.tf` file, e.g., using the `nano` editor:

    ```bash
    nano route-switcher.tf
    ```

1. Change the `start_module` value in the `route-switcher` module to `true`. 
1. Start the module with this command:

   ```bash
   terraform apply 
   ```

   Within five minutes, route-switcher will start its work, providing fault tolerance for outbound NAT traffic.

## Test the solution for performance and fault tolerance {#test-solution}

### Testing the system performance {#accessibility-test}

1. Connect to the `test-vm` serial console:

   {% list tabs group=instructions %}

   - Management console {#console}
  
      1. In the [management console]({{ link-console-main }}), select your infrastructure folder.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. In the VM list, select `test-vm`.
      1. Navigate to the **{{ ui-key.yacloud.compute.instance.switch_console }}** tab.
      1. Wait for the operating system to start up completely.

   {% endlist %}

1. Enter the `admin` username and password. 
   To get the password, run this command in your computer terraform scenario directory:

    ```bash
    terraform output test_vm_password
    ```

1. Make sure `test-vm` is connected to the internet via the public IP address of `nat-a`. Run the following command in the serial console:

   ```bash
   curl ifconfig.co
   ```

   Compare the IP address you get with `nat-a_public_ip_address` [you saved earlier](#final-output).

1. Emulate `test VM` outbound traffic by running `ping`:

   ```bash
   ping ya.ru
   ```

   Make sure you get ICMP response:

   ```bash
   PING ya.ru (77.88.55.242) 56(84) bytes of data.
   64 bytes from ya.ru (77.88.55.242): icmp_seq=1 ttl=56 time=4.67 ms
   64 bytes from ya.ru (77.88.55.242): icmp_seq=2 ttl=56 time=3.83 ms
   64 bytes from ya.ru (77.88.55.242): icmp_seq=3 ttl=56 time=3.80 ms
   64 bytes from ya.ru (77.88.55.242): icmp_seq=4 ttl=56 time=3.78 ms
   ```

1. Make sure the `Next hop` value in the route table for the `demo` network matches the internal IP address of `nat-a`.

### Testing the system fault tolerance {#fault-tolerance-test}

1. Emulate a system failure by stopping the main NAT gateway:

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

1. Monitor the loss of packets sent by `ping`. 
   After the main NAT instance is disabled, there may be a traffic loss for around one minute, and then the traffic should recover.
1. Make sure internet access is now provided via the public IP address of `nat-b`. To do this, in the serial console, stop the `ping` command and run the following one:

   ```bash
   curl ifconfig.co
   ```

   Compare the IP address with the `nat-b_public_ip_address` value from the [resulting output](#final-output).
1. Check that the route-switcher has changed the `Next hop` value in the route table for the `demo` network and it now matches the internal IP address of `nat-b`.
1. Enable outgoing traffic from the test VM using the `ping` command.
1. Run the main NAT instance by emulating system recovery:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select your infrastructure folder.
      1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. Select the `nat-a` VM from the list, click ![image](../../_assets/options.svg), and select **{{ ui-key.yacloud.common.stop }}**.
      1. In the window that opens, click **{{ ui-key.yacloud.compute.instances.popup-confirm_button_start }}**.

   - CLI {#cli}

      1. See the description of the `instance stop` CLI command:

         ```bash
         yc compute instance start --help
         ```

      1. Stop the VM:

         ```bash
         yc compute instance start nat-a
         ```

   - API {#api}

      Use the [start](../../compute/api-ref/Instance/start.md) REST API method for the [Instance](../../compute/api-ref/Instance/) resource or the [InstanceService/Start](../../compute/api-ref/grpc/Instance/start.md) gRPC API call.

   {% endlist %}

1. Monitor the `ping` utility output. While the NAT-A instance is being recovered, there may be no loss of sent packets. 
1. Make sure internet access is provided via the public IP address of `nat-a` again. To do this, in the serial console, stop the `ping` command and run the following one:

   ```bash
   curl ifconfig.co
   ```

   Compare the IP address with the `nat-a_public_ip_address` value from the [resulting output](#final-output).
1. Check that the route-switcher has changed the `Next hop` value in the route table for the `demo` network and it matches the internal IP address of `nat-a` again.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created, run this command:

  ```bash
  terraform destroy
  ```
  
  {% note warning %}

  {{ TF }} will **permanently** delete all the resources you created, e.g., networks, subnets, VMs, load balancer, etc.

  {% endnote %}
