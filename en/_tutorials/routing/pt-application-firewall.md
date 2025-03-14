# Setting up PT Application Firewall


[PT Application Firewall](https://www.ptsecurity.com/ww-en/products/af/) is a [web application firewall](https://en.wikipedia.org/wiki/Web_application_firewall) that ensures continuous protection for web applications, users, and network infrastructure while helping meet security standards.

In this tutorial, you will deploy a test infrastructure with PT Application Firewall for web applications and a test [damn vulnerable web application (DVWA)](https://github.com/digininja/DVWA#damn-vulnerable-web-application) and then test its features for protection against standard web attacks.

To set up PT Application Firewall and test it:

1. [Get your cloud ready](#prepare-cloud).
1. [Create a web server](#create-web-server). 
1. [Run your DVWA](#run-dvwa). 
1. [Set up the firewall](#configure-firewall). 
1. [Test the firewall](#test-firewall). 

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support costs include:

* Fee for continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for IP addresses and outbound traffic (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

## Create a web server {#create-web-server}

1. Create an [Ubuntu](/marketplace/products/yc/ubuntu-22-04-lts) VM named `dvwa-server`.

    1. On the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) page in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
    1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, in the **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** field, enter `Ubuntu 22.04` and select a public [Ubuntu 22.04](/marketplace/products/yc/ubuntu-22-04-lts) image.
    1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../overview/concepts/geo-scope.md) to create your VM in. If you do not know which availability zone you need, leave the default one.
    1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

        * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select the network and subnet to connect your VM to. If the required [network](../../vpc/concepts/network.md#network) or [subnet](../../vpc/concepts/network.md#subnet) is not listed, [create it](../../vpc/operations/subnet-create.md).
        * Under **{{ ui-key.yacloud.component.compute.network-select.field_external }}**, keep `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` to assign your VM a random external IP address from the {{ yandex-cloud }} pool, or select a static address from the list if you reserved one in advance.

    1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the data for access to the VM:

        * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, specify the username: `ycuser`.
        * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

    1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `dvwa-server`.
    1. Leave all other settings unchanged and click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

    {% note info %}

    A public and a private IP addresses are assigned to the VM when you create it. Write them down, as you will need them to access the VM and set up the firewall.

    {% endnote %}

1. Connect to the `dvwa-server` VM over SSH by running the following command in the terminal:

    ```bash
    ssh ycuser@<public_IP_address_of_dvwa-server>
    ```

## Run your DVWA {#run-dvwa}

1. Install [Docker](https://www.docker.com/) on the `dvwa-server` VM:

   ```bash
   curl --fail --silent --show-error --location https://test.docker.com --output test-docker.sh
   sudo sh test-docker.sh
   ```

1. Run a container with the DVWA:
   ```bash
   sudo docker run --rm -it -p 8080:80 sagikazarmark/dvwa
   ```

1. Set up the DVWA:
   1. In the browser, go to:

   ```html
   http://<public_IP_address_of_dvwa-server>:8080
   ```

   1. On the authorization page, enter `admin` for the username and `password` for the password.
   1. Click **Create / Reset Database** at the bottom of the `Database Setup` page. 
   1. Log in again using the same username and password.
   1. Click **DVWA Security** on the left of the screen and go to the page with security settings.
   1. In the Security Level section, select the required security level for the application. Select **Low** in the drop-down list and click **Submit**.
   

## Set up the firewall {#configure-firewall}

1. Create a VM named `pt-firewall` from a [PT Application Firewall](/marketplace/products/pt/pt-application-firewall) public image:

    {% list tabs group=instructions %}

    - Management console {#console}

        1. On the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) page in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
        1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, in the **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** field, enter `PT Application Firewall` and select the current [PT Application Firewall](/marketplace/products/pt/pt-application-firewall) image.
        1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the [availability zone](../../overview/concepts/geo-scope.md) where the `dvwa-server` VM resides.
        1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

            * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select the network and subnet to connect your VM to. If the required [network](../../vpc/concepts/network.md#network) or [subnet](../../vpc/concepts/network.md#subnet) is not listed, [create it](../../vpc/operations/subnet-create.md).
            * Under **{{ ui-key.yacloud.component.compute.network-select.field_external }}**, keep `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` to assign your VM a random external IP address from the {{ yandex-cloud }} pool, or select a static address from the list if you reserved one in advance.

        1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the data for access to the VM:

            * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, specify the username: `ycuser`.
            * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, select the SSH key saved in your [organization user](../../organization/concepts/membership.md) profile.

                If there are no saved SSH keys in your profile, or you want to add a new key:

                * Click **{{ ui-key.yacloud.compute.instances.create.button_add-ssh-key }}**.
                * Enter a name for the SSH key.
                * Upload or paste the contents of the public key file. You need to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair for the SSH connection to a VM yourself.
                * Click **{{ ui-key.yacloud.common.add }}**.

        1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `pt-firewall`.
        1. Under **{{ ui-key.yacloud.compute.instances.create.section_additional }}**, enable `{{ ui-key.yacloud.compute.instances.create.field_serial-port-enable }}`.
        1. Leave all other settings unchanged and click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

    {% endlist %}

    {% note info %}

    A public and a private IP addresses are assigned to the VM when you create it. We recommend [making your public IP address static](../../vpc/operations/set-static-ip.md).

    {% endnote %}

1. Go to the [serial console](../../compute/operations/serial-console/index.md) of the new VM:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder the VM was created in.
      1. Go to **{{ compute-name }}** and select the `pt-firewall` VM.
      1. Navigate to the **{{ ui-key.yacloud.compute.instance.switch_console }}** tab.
      1. Enter `pt` for the username and `positive` for the password.
      1. You will be prompted to change the password. Enter the current password (`positive`) and create a new one in line with the system requirements.
      1. Possible further actions will be suggested. Enter `0`.
      1. Create a configuration by running the following commands one by one:

      ```bash
      if set eth-ext1 inet_method dhcp
      dns add 77.88.8.8
      config commit
      config sync
      ```

   {% endlist %}

1. Log in to the firewall configuration console:
   1. In the browser, go to:
      ```html
      http://<public_IP_address_of_pt-firewall>:8443
      ```
   1. On the authorization page, enter `admin` for the username and `positive` for the password.
   1. You will be prompted to change the password. Enter the current password (`positive`) and create a new one.
1. Configure the network interfaces:
   1. At the top of the screen, select **Configuration** / **Network** / **Gateways**.
   1. In the table, click the edit icon in the row with the `pt-firewall` interface.
   1. On the **General** tab, enable `Active` to activate the interface.
   1. In the **Aliases** field of the **Network** tab, add the `WAN-wan`, `LAN-lan`, and `MGMT-mgmt` options from the drop-down list. 
   1. Click **Apply**.
1. Configure an **Upstream** with the DVWA set as a backend server:
   1. At the top of the screen, select **Configuration** / **Network** / **Upstreams**.
   1. On the `UPSTREAMS` page, click **Create**.
   1. In the **Name** field, enter `DVWA`.
   1. In the **Backend** line, click **Add** and specify the following:
      * In the **Host** field: `<public_IP_address_of_dvwa-server>`.
      * In the **Port** field: `8080`.
   1. Leave all the other settings unchanged and click **Apply**.
1. Configure the service:
   1. At the top of the screen, select **Configuration** / **Network** / **Services**.
   1. On the `SERVICES` page, click **Create**.
   1. In the **Name** field, enter `DVWA-RP`.
   1. In the **Servers** line, click **Add** and specify the following:
      * In the **Network interface alias** field: `WAN-wan` from the drop-down list.
      * In the **Listen Port** field: `80`.
      * In the **Upstream** field: `DVWA` from the drop-down list.
   1. Leave all the other settings unchanged and click **Apply**.
1. Add a web application:
   1. At the top of the screen, select **Configuration** / **Security** / **Web applications**.
   1. On the `WEB APPLICATIONS` page, click **Create**.
   1. In the **Name** field, enter `DVWA-APP`.
   1. In the **Service** field, select `DVWA-RP` from the drop-down list.
   1. In the **Protection mode** field, select `Detection` from the drop-down list.
   1. In the **Locations** line, click **Add** and specify ` \/ `.
   1. Leave all the other settings unchanged and click **Apply**.

## Test the firewall {#test-firewall}

To test the firewall, use the Wallarm [GoTestWAF](https://github.com/wallarm/gotestwaf#gotestwaf-) tool for web attack simulation:

1. Open a new window in the command line terminal and connect to the `dvwa-server` VM over SSH:
   ```bash
   ssh yclogrus@<public_IP_address_of_dvwa-server>
   ```

1. Run a test with the following command:

   ```bash
   sudo docker run -v ${PWD}/reports:/app/reports wallarm/gotestwaf --url=http://<public_IP_address_of_pt-firewall>/ --skipWAFBlockCheck
   ```

1. Wait for the test to complete and view the results. The `Summary` table clearly shows that no attacks were blocked (the `TRUE-NEGATIVE TESTS BLOCKED` section): 

   ```bash
   Summary:
   +-----------------------------+-----------------------------+-----------------------------+-----------------------------+
   |            TYPE             | TRUE-NEGATIVE TESTS BLOCKED | TRUE-POSITIVE TESTS PASSED  |           AVERAGE           |
   +-----------------------------+-----------------------------+-----------------------------+-----------------------------+
   | API Security                | 0.00%                       | n/a                         | 0.00%                       |
   | Application Security        | 0.17%                       | 100.00%                     | 50.09%                      |
   +-----------------------------+-----------------------------+-----------------------------+-----------------------------+
   |                                                                        SCORE            |           25.05%            |
   +-----------------------------+-----------------------------+-----------------------------+-----------------------------+
   ```

1. In your browser, return to the `WEB APPLICATIONS` section (**Configuration** / **Security** / **Web applications**) of the firewall setup page and click the edit icon in the `DVWA` row.
1. In the **Protection mode** field, select `Active prevention` from the drop-down list and click **Apply**.
1. In the terminal, run the test from step 2 once again.
1. Wait for the test to complete and view the results. This time, the `Summary` table shows that all the attacks were blocked (100% of attacks in the `TRUE-NEGATIVE TESTS BLOCKED` section): 

   ```bash
   Summary:
   +-----------------------------+-----------------------------+-----------------------------+-----------------------------+
   |            TYPE             | TRUE-NEGATIVE TESTS BLOCKED | TRUE-POSITIVE TESTS PASSED  |           AVERAGE           |
   +-----------------------------+-----------------------------+-----------------------------+-----------------------------+
   | API Security                | 100.00%                     | n/a                         | 100.00%                     |
   | Application Security        | 100.00%                     | 0.00%                       | 50.00%                      |
   +-----------------------------+-----------------------------+-----------------------------+-----------------------------+
   |                                                                        SCORE            |           75.00%            |
   +-----------------------------+-----------------------------+-----------------------------+-----------------------------+
   ```

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. [Delete](../../compute/operations/vm-control/vm-delete.md) the `dvwa-server` and `pt-firewall` VMs.
1. [Delete the static public IP addresses](../../vpc/operations/address-delete.md).

