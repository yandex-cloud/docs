# Setting up and testing PT Application Firewall

[PT Application Firewall](https://www.ptsecurity.com/ww-en/products/af/) is a [web application firewall](https://en.wikipedia.org/wiki/Web_application_firewall) that ensures continuous protection for web applications, users, and network infrastructure while helping meet security standards.

In this tutorial, you will deploy a test infrastructure with PT Application Firewall for web applications and a test [damn vulnerable web application (DVWA)](https://github.com/digininja/DVWA#damn-vulnerable-web-application) and then test its features for protection against standard web attacks.

To set up PT Application Firewall and test it:

1. [Prepare your cloud](#prepare-cloud).
1. [Create a web server](#create-web-server).
1. [Run your DVWA](#run-dvwa).
1. [Set up the firewall](#configure-firewall).
1. [Test the firewall](#test-firewall).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of this infrastructure includes:

* Fee for continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using public IP addresses and outgoing traffic (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Create a web server {#create-web-server}

1. Create a `dvwa-server` VM with Ubuntu:

   1. In the [management console]({{ link-console-main }}), select the folder to create your VM in.
   1. In the list of services, select **{{ compute-name }}**.
   1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
      * Enter the name: `dvwa-server`.
      * Select an [availability zone](../../overview/concepts/geo-scope.md) to place the VM in.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select Ubuntu 20.04.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the information required to access the instance:
      * Enter the `ycuser` username in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.
      * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the [public key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file. You need to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair for the SSH connection yourself.
   1. Leave all the other settings as they are and click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   {% note info %}

   A public and private IP addresses are assigned to the VM at creation. Write them down, as you will need them to access the VM and set up the firewall.

   {% endnote %}

1. Connect to the `dvwa-server` VM over SSH by running the following command in the terminal:
   ```bash
   ssh ycuser@<dvwa-server_VM_public_IP>
   ```

## Run your DVWA {#run-dvwa}

1. Install [Docker](https://www.docker.com/) on the `dvwa-server` VM:

   ```bash
   curl -fsSL https://test.docker.com -o test-docker.sh
   sudo sh test-docker.sh
   ```

1. Run a container with the DVWA:
   ```bash
   sudo docker run --rm -it -p 8080:80 sagikazarmark/dvwa
   ```

1. Set up the DVWA:
   1. In the browser, go to:

   ```html
   http://<dvwa-server_VM_public_IP>:8080
   ```

   1. On the authorization page, enter `admin` as your username and `password` as your password.
   1. On the `Database Setup` page, click **Create / Reset Database** at the bottom.
   1. Log in again using the same username and password.
   1. Click **DVWA Security** on the left of the screen and go to the page with security settings.
   1. In the Security Level section, select the required security level for the application. Select **Low** in the drop-down list and click **Submit**.


## Set up the firewall {#configure-firewall}

1. Create a `pt-firewall` VM from the `PT Application Firewall` public image:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder to create your VM in.
      1. In the list of services, select **{{ compute-name }}**.
      1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
         * Enter the name: `pt-firewall`.
         * Choose the same availability zone that the `dvwa-server` VM is in.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab.
      1. Select the current `PT Application Firewall` image.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the information required to access the instance:
         * Enter the `ycuser` username in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.
         * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the [public key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file. You need to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair for the SSH connection yourself.
      1. Enable the **{{ ui-key.yacloud.compute.instances.create.field_serial-port-enable }}** option.
      1. Leave all the other settings as they are and click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   {% endlist %}

   {% note info %}

   A public and private IP addresses are assigned to the VM at creation. It is recommended to [make the public IP address static](../../vpc/operations/set-static-ip.md).

   {% endnote %}

1. Go to the [serial console](../../compute/operations/serial-console/index.md) of the created VM:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the folder where the VM was created.
      1. Go to **{{ compute-name }}** and select the `pt-firewall` VM.
      1. Click the **{{ ui-key.yacloud.compute.instance.switch_console }}** tab.
      1. Enter `pt` as your username and `positive` as your password.
      1. You will be prompted to change the password. Enter the current password (`positive`) and set a new password meeting the system requirements.
      1. Possible further actions will be suggested. Set `0`.
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
      http://<pt-firewall_VM_public_IP>:8443
      ```
   1. On the authorization page, enter `admin` as your username and `positive` as your password.
   1. You will be prompted to change the password. Enter the current password (`positive`) and set a new password.
1. Configure the network interfaces:
   1. At the top of the screen, select **Configuration** / **Network** / **Gateways**.
   1. Click the edit icon in the table's row with the `pt-firewall` interface.
   1. In the **General** tab, activate the interface by enabling `Active`.
   1. In the **Network** tab, the **Aliases** field, add the `WAN-wan`, `LAN-lan`, and `MGMT-mgmt` options from the drop-down list.
   1. Click **Apply**.
1. Configure an **Upstream** with the DVWA set as a backend server:
   1. At the top of the screen, select **Configuration** / **Network** / **Upstreams**.
   1. On the `UPSTREAMS` page, click **Create**.
   1. In the **Name** field, enter `DVWA`.
   1. In the **Backend** line, click **Add** and specify the following:
      * In the **Host** field: `<dvwa-server_VM_public_IP>`.
      * In the **Port** field: `8080`.
   1. Leave all the other settings as they are and click **Apply**.
1. Configure the service:
   1. At the top of the screen, select **Configuration** / **Network** / **Services**.
   1. On the `SERVICES` page, click **Create**.
   1. In the **Name** field, enter `DVWA-RP`.
   1. In the **Servers** line, click **Add** and specify the following:
      * In the **Network interface alias** field, select `WAN-wan` from the drop-down list.
      * In the **Listen Port** field, set `80`.
      * In the **Upstream** field, select `DVWA` from the drop-down list.
   1. Leave all the other settings as they are and click **Apply**.
1. Add a web application:
   1. At the top of the screen, select **Configuration** / **Security** / **Web applications**.
   1. On the `WEB APPLICATIONS` page, click **Create**.
   1. In the **Name** field, enter `DVWA-APP`.
   1. In the **Service** field, select `DVWA-RP` from the drop-down list.
   1. In the **Protection mode** field, select `Detection` from the drop-down list.
   1. In the **Locations** line, click **Add** and specify ` \/ `.
   1. Leave all the other settings as they are and click **Apply**.

## Test the firewall {#test-firewall}

To test the firewall, use the Wallarm [GoTestWAF](https://github.com/wallarm/gotestwaf#gotestwaf-) tool for web attack simulation:

1. Open a new window in the command-line terminal and connect to the `dvwa-server` VM over SSH:
   ```bash
   ssh yclogrus@<dvwa-server_VM_public_IP>
   ```

1. Run a test with the following command:

   ```bash
   sudo docker run -v ${PWD}/reports:/app/reports wallarm/gotestwaf --url=http://<pt-firewall_VM_public_IP>/ --skipWAFBlockCheck
   ```

1. Wait for the test to complete and view the results. You can easily see in the `Summary` table that no attacks were blocked (the `TRUE-NEGATIVE TESTS BLOCKED` section):

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

1. In your browser, return to the firewall setup page, the `WEB APPLICATIONS` section (**Configuration** / **Security** / **Web applications**), and click the edit icon in the `DVWA` row.
1. In the **Protection mode** field, select `Active prevention` from the drop-down list and click **Apply**.
1. In the terminal, run the test from step 2 once again.
1. Wait for the test to complete and view the results. This time, the `Summary` table shows that all attacks were blocked (100% of attacks in the `TRUE-NEGATIVE TESTS BLOCKED` section):

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

