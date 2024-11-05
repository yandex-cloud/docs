# Setting up PT Application Firewall


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

The infrastructure support costs include:

* Fee for continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using public IP addresses and outgoing traffic (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Create a web server {#create-web-server}

1. Create a `dvwa-server` VM with [Ubuntu](/marketplace/products/yc/ubuntu-22-04-lts):

   1. In the [management console]({{ link-console-main }}), select the folder to create your VM in.
   1. In the list of services, select **{{ compute-name }}**.
   1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
      * Enter the name: `dvwa-server`.
      * Select an [availability zone](../../overview/concepts/geo-scope.md) to place your VM in.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select [Ubuntu 22.04](/marketplace/products/yc/ubuntu-22-04-lts).
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the data for access to the VM:
      * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter the `ycuser` username.
      * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the [public key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file. You need to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair for the SSH connection on your own.
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

   1. On the authorization page, enter `admin` for username and `password` for password.
   1. Click **Create / Reset Database** at the bottom of the `Database Setup` page. 
   1. Log in again using the same username and password.
   1. Click **DVWA Security** on the left of the screen and go to the page with security settings.
   1. In the Security Level section, select the required security level for the application. Select **Low** in the drop-down list and click **Submit**.
   

## Set up the firewall {#configure-firewall}

1. Create a VM named `pt-firewall` from a [PT Application Firewall](/marketplace/products/pt/pt-application-firewall) public image:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder to create your VM in.
      1. In the list of services, select **{{ compute-name }}**.
      1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**:
         * Enter the name: `pt-firewall`.
         * Select the same availability zone as the one the `dvwa-server` VM is in.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab.
      1. Select the current [PT Application Firewall](/marketplace/products/pt/pt-application-firewall) image.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the data for access to the VM:
         * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter the `ycuser` username.
         * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the [public key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file. You need to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair for the SSH connection yourself.
      1. Enable the **{{ ui-key.yacloud.compute.instances.create.field_serial-port-enable }}** option.
      1. Leave all other settings unchanged and click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   {% endlist %}

   {% note info %}

   A public and a private IP addresses are assigned to the VM when you create it. It is recommended to [make the public IP address static](../../vpc/operations/set-static-ip.md).

   {% endnote %}

1. Go to the [serial console](../../compute/operations/serial-console/index.md) of the new VM:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder the VM was created in.
      1. Go to **{{ compute-name }}** and select the `pt-firewall` VM.
      1. Go to the **{{ ui-key.yacloud.compute.instance.switch_console }}** tab.
      1. Enter `pt` for username and `positive` for password.
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
   1. On the authorization page, enter `admin` for username and `positive` for password.
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
   1. Leave all the other settings as they are and click **Apply**.
1. Configure the service:
   1. At the top of the screen, select **Configuration** / **Network** / **Services**.
   1. On the `SERVICES` page, click **Create**.
   1. In the **Name** field, enter `DVWA-RP`.
   1. In the **Servers** line, click **Add** and specify the following:
      * In the **Network interface alias** field: `WAN-wan` from the drop-down list.
      * In the **Listen Port** field: `80`.
      * In the **Upstream** field: `DVWA` from the drop-down list.
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

1. Open a new window in the command line terminal and connect to the `dvwa-server` VM over SSH:
   ```bash
   ssh yclogrus@<public_IP_address_of_dvwa-server>
   ```

1. Run a test with the following command:

   ```bash
   sudo docker run -v ${PWD}/reports:/app/reports wallarm/gotestwaf --url=http://<public_IP_address_of_pt-firewall>/ --skipWAFBlockCheck
   ```

1. Wait for the test to complete and view the results. It is easy to see from the `Summary` table that no attacks were blocked (the `TRUE-NEGATIVE TESTS BLOCKED` section):

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

