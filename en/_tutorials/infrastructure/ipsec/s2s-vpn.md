# Deploying S2S VPN using strongSwan in {{ yandex-cloud }}


Follow this tutorial to deploy a secure site-to-site (S2S) VPN connection between a cloud infrastructure in {{ yandex-cloud }} and a remote site using a [strongSwan](https://www.strongswan.org/)-based IPsec gateway. We will do this using the [strongSwan S2S VPN](/marketplace/products/yc/ipsec-sgw) application from the [{{ cloud-apps-full-name }}](/services/cloud-apps/) folder. This application automates the deployment and basic configuration of your IPsec tunnel, allowing you to:

* Quickly create a secure channel over the public internet.
* Encrypt traffic between subnets.
* Integrate cloud resources into the corporate network while maintaining control over routing.

{% note info %}

This off-the-shelf application automates infrastructure deployment in {{ yandex-cloud }}.

When using strongSwan S2S VPN at a remote location (your on-premises data center, branch office, or another cloud), manual configuration is required.

{% endnote %}

To deploy a secure connection:

1. [Get your cloud ready](#before-you-begin).
1. [Create a service account](#create-service-account).
1. [Create a cloud network](#create-vpc).
1. [Reserve a public static IP address](#reserve-public-static-ip).
1. [Create an SSH key pair](#create-ssh-keys).
2. [Deploy the application](#app-deploy).

If you no longer need the resources you created, [delete](#clear-out) them.


## Required paid resources {#paid-resources}

The cost of infrastructure deployment for this solution includes:

* Fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../../compute/pricing.md)).
* Fee for a static external IP address (see [{{ vpc-full-name }} pricing](../../../vpc/pricing.md)).
* Fee for outbound traffic (see [{{ vpc-full-name }} pricing](../../../vpc/pricing.md)).


## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}


## Create a service account {#create-service-account}

Create an `s2s-vpn-sa` [service account](../../../iam/concepts/users/service-accounts.md) to automatically create resources when you install the application. Assign the `resource-manager.admin`, `iam.admin`, `compute.admin`, and `vpc.admin` roles to it.

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Enter a name for the service account: `s2s-vpn-sa`.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select these roles:
      * `resource-manager.admin`
      * `iam.admin`
      * `compute.admin`
      * `vpc.admin`

  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Create a `s2s-vpn-sa` service account:

      ```bash
      yc iam service-account create --name s2s-vpn-sa
      ```

      Result:

      ```text
      id: nfersamh4sjq********
      folder_id: b1gc1t4cb638********
      created_at: "2023-03-21T10:36:29.726397755Z"
      name: s2s-vpn-sa
      ```

      Save the ID of the `s2s-vpn-sa` service account (`id`) and the ID of the folder where you created it (`folder_id`).

  1. Assign the `resource-manager.admin`, `iam.admin`, `compute.admin`, and `vpc.admin` roles for the folder to the service account:

      ```bash
      yc resource-manager folder add-access-binding <folder_ID> \
        --role resource-manager.admin \
        --subject serviceAccount:<service_account_ID>

      yc resource-manager folder add-access-binding <folder_ID> \
        --role iam.admin \
        --subject serviceAccount:<service_account_ID>

      yc resource-manager folder add-access-binding <folder_ID> \
        --role compute.admin \
        --subject serviceAccount:<service_account_ID>

      yc resource-manager folder add-access-binding <folder_ID> \
        --role vpc.admin \
        --subject serviceAccount:<service_account_ID>
      ```

      Result:

      ```text
      done (1s)
      ```

- API {#api}

  To create a service account, use the [create](../../../iam/api-ref/ServiceAccount/create.md) method for the [ServiceAccount](../../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call.

  To assign the roles for a folder to a service account, use the [setAccessBindings](../../../iam/api-ref/ServiceAccount/setAccessBindings.md) method for the [ServiceAccount](../../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/SetAccessBindings](../../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md) gRPC API call.

{% endlist %}

## Create a cloud network {#create-vpc}

Create a [cloud network](../../../vpc/concepts/network.md) to host the VM.

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. At the top right, click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. In the **{{ ui-key.yacloud.vpc.networks.create.field_name }}** field, specify `s2s-vpn-network`.
  1. In the **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** field, disable **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.

- {{ yandex-cloud }} CLI {#cli}

  Run this command:

  ```bash
  yc vpc network create s2s-vpn-network
  ```

  Result:

  ```text
  id: enp1gg8kr3pv********
  folder_id: b1gt6g8ht345********
  created_at: "2023-12-20T20:08:11Z"
  name: s2s-vpn-network
  default_security_group_id: enppne4l2eg5********
  ```

- API {#api}

  To create a cloud network, use the [create](../../../vpc/api-ref/Network/create.md) REST API method for the [Network](../../../vpc/api-ref/Network/index.md) resource or the [NetworkService/Create](../../../vpc/api-ref/grpc/Network/create.md) gRPC API call.

{% endlist %}


## Reserve a public static IP address {#reserve-public-static-ip}

Reserve a static [public IP address](../../../vpc/concepts/address.md#public-addresses) for the VM the application will be installed on.

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/map-pin.svg) **{{ ui-key.yacloud.vpc.switch_addresses }}** and click **{{ ui-key.yacloud.vpc.addresses.button_create }}**.
  1. In the window that opens, select `{{ region-id }}-b` in the **{{ ui-key.yacloud.vpc.addresses.popup-create_field_zone }}** field and click **{{ ui-key.yacloud.vpc.addresses.popup-create_button_create }}**.

{% endlist %}


## Create an SSH key pair {#create-ssh-keys}

To connect to a [VM](../../../compute/concepts/vm.md) over SSH, you will need a key pair: the public key resides on the VM, and the private one is kept by the user. This method is more secure than with a username and password.

{% include [vm-connect-ssh-linux-note](../../../_includes/vm-connect-ssh-linux-note.md) %}

To create a key pair:

{% list tabs group=operating_system %}

- Linux/macOS {#linux-macos}

  {% include [vm-ssh-prepare-key-linux-macos](../../../_includes/vm-ssh-prepare-key-linux-macos.md) %}

- Windows 10/11 {#windows}

  {% include [vm-ssh-prepare-key-win-10-11](../../../_includes/vm-ssh-prepare-key-win-10-11.md) %}

- Windows 7/8 {#windows7-8}

  {% include [vm-ssh-prepare-key-win-7-8](../../../_includes/vm-ssh-prepare-key-win-7-8.md) %}

{% endlist %}


## Deploy the application {#app-deploy}

### Install the application {#install-app}

As a result of the installation, the following {{ yandex-cloud }} resources will be automatically created:

* [Service account](../../../iam/concepts/users/service-accounts.md)
* [Subnet](../../../vpc/concepts/network.md#subnet)
* [IP_address](../../../vpc/concepts/address.md#public-addresses)
* [Route table](../../../vpc/concepts/routing.md#rt-vm)
* [Security group](../../../vpc/concepts/security-groups.md)
* [VM](../../../compute/concepts/vm.md)

{% note warning %}

[Make sure](../../../quota-manager/operations/read-quotas.md) the target cloud has not reached its quota:

* **{{ ui-key.yacloud_billing.iam.cloud.quotas.label_quota-name-iam.serviceAccounts.count }}**
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-vpc.subnets.count }}**
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-vpc.externalStaticAddresses.count }}**
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-vpc.routeTables.count }}**
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-vpc.staticRoutes.count }}**
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-vpc.securityGroups.count }}**
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.instances.count }}**
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.disks.count }}**
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.ssdDisks.size }}**
* **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-compute.instanceMemory.size }}**

If any quota has been used up, create a quota increase request and wait for it to be granted.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-apps }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.cloud-apps.label_marketplace }}**.
  1. In the **Search products** field, type `strongswan`, select **strongSwan S2S VPN**, and click **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
  1. In the window that opens, specify the following:

      * **Name**: `s2s-vpn`.
      * **Service account**: `s2s-vpn-sa`.
      * **VPC network**: `s2s-vpn-network`.
      * **New subnet CIDR**: `10.130.0.0/24`.
      * **New subnet zone**: `{{ region-id }}-b`.
      * **Remote gateway IP address**: IP address of the remote VPN gateway that will be added to the strongSwan configuration.
      * **Remote subnet CIDRs**: Comma-separated list of subnets as CIDRs that will be automatically added to the route table.
      * **SSH key**: Contents of the public SSH key created [earlier](#create-ssh-keys).
      * **IPsec IKE Proposal**: `aes128gcm16-prfsha256-ecp256`.
      * **IPsec ESP Proposal**: `aes128gcm16`.
      * **IPsec PSK**: IPsec Pre-Shared Key (PSK) that will be specified in the strongSwan configuration.

  1. Click **Install** and wait for the installation to complete.

{% endlist %}


### Bind the route table {#bind-table}

To route traffic between a cloud and remote networks through the VPN tunnel, bind the route table and subnet.

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
  1. In the line of the automatically created `ipsec-sgw-...` subnet, click ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.vpc.subnetworks.button_action-add-route-table }}** and select the automatically created `ipsec-sgw-...` table.
  1. Click **{{ ui-key.yacloud.vpc.subnet.add-route-table.button_add }}**.

- {{ yandex-cloud }} CLI {#cli}

  Run this command:

  ```bash
  yc vpc subnet update <name_of_automatically_created_subnet> \
    --route-table-name=<name_of_automatically_created_table>
  ```

  Result:

  ```text
  id: e9b6n3jj3gh6********
  folder_id: b1g681qpemb4********
  created_at: "2024-05-19T13:24:58Z"
  name: ipsec-sgw-{{ region-id }}-b
  network_id: enppoggov6ub********
  zone_id: {{ region-id }}-b
  v4_cidr_blocks:
    - 10.1.0.0/16
  route_table_id: enp4v8foko6s********
  dhcp_options: {}
  ```

- API {#api}

  To associate a route table with a subnet, use the [update](../../../vpc/api-ref/Subnet/update.md) REST API method for the [Subnet](../../../vpc/api-ref/Subnet/index.md) resource or the [SubnetService/Update](../../../vpc/api-ref/grpc/Subnet/update.md) gRPC API call.

  {% include [Note API updateMask](../../../_includes/note-api-updatemask.md) %}

{% endlist %}


### Configure the VM {#configure-vm}

After you install the application, perform the final configuration of the IPsec gateway on the VM.

1. [Connect](../../../compute/operations/images-with-pre-installed-software/operate.md#vm-connect) to the VM over SSH. To this using the `admin` username and the private SSH key you [created earlier](#create-ssh-keys).
1. Get administrator permissions:

    ```bash
    sudo su
    ```

1. Go to the administrator's home folder and run the script:

    ```bash
    cd /root
    ./update.sh
    ```

    The system will create the `ipsec-*.txt` files in the `/root` folder. You can use these files as an example when configuring a connection on a remote endpoint.

    {% note tip %}

    If the IP ranges of {{ yandex-cloud }} and the remote network match, you may need to use Source NAT. To do this, run this command:

    ```bash
    iptables \
      -t nat \
      -A POSTROUTING \
      -s <local_subnet> \
      -d <remote_subnet> \
      -j SNAT \
      --to-source <new_address>
    ```

    {% endnote %}


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

* Uninstall strongSwan S2S VPN:

    1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-apps }}**.
    1. In the line with the application, click ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.common.delete }}** and confirm the deletion.

        Deleting the application will delete all resources associated with it.

* [Delete](../../../vpc/operations/delete-route-table.md) the route table.
* [Delete](../../../iam/operations/sa/delete.md) the service account.
* [Delete](../../../vpc/operations/address-delete.md) the static public IP address.
* [Delete](../../../vpc/operations/network-delete.md) the cloud network.