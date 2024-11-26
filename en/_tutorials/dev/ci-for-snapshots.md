# Creating test VMs via {{ GL }} CI


You can use {{ yandex-cloud }} to automate routine tasks, such as running a specific script after each commit to the `master` branch in a Git repository. The example below creates and tests a [VM](../../compute/concepts/vm.md) following each commit.

To configure Continuous Integration (CI) for VM [disk snapshots](../../compute/concepts/snapshot.md):
1. [Create a VM for the test application](#create-vm): Create a new VM whose disk snapshot will be used to create new VMs via CI.
1. [Set the VM up with a test application](#configure-vm): Deploy a web server and components to support the test application to the VM. Write a test application that will reverse the words in a text sent to the server.
1. [Check how the application works](#test-app): Send a test request to check the server settings and the results.
1. [Create a VM disk snapshot](#create-snapshot): Create a VM disk snapshot for CI to use to create new VMs.
1. [Create a VM with {{ GL }}](#create-gitlab-vm): Create a VM with [{{ GL }}](https://about.gitlab.com/) to store CI settings and a functionality test script in a repository.
1. [Configure {{ GL }}](#configure-gitlab): Create a file repository and get the parameters required for configuration.
1. [Configure Runner](#configure-runner): Tool for performing tasks.
1. [Configure CI](#configure-ci): Set the CI configuration by specifying the necessary parameters for commands and testing.
1. [Check that the application runs on the VM created using CI](#test-new-vm): Make sure that the VMs you are trying to create with CI and the VM snapshot have been created and the test application is functional.

If you no longer need the VMs you created, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

Before creating a VM:
1. Go to the {{ yandex-cloud }} [management console]({{ link-console-main }}) and select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you will perform the operations.
1. Make sure the selected folder has a [network](../../vpc/concepts/network.md#network) with a [subnet](../../vpc/concepts/network.md#subnet) you can connect the VM to. To do this, select **{{ vpc-name }}** on the folder page. If the list contains a network, click its name to see the list of subnets. If there is neither network nor subnet, [create them](../../vpc/quickstart.md).


### Required paid resources {#paid-resources}

The infrastructure support costs include:
* Fee for continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for storing created images (see [{{ compute-name }} pricing](../../compute/pricing.md#prices-storage)).
* Fee for using a dynamic public IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Create a VM for the test application {#create-vm}

Create a VM to deploy the test application to, a set of components required for it to run, and a web server:

1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create your VM in.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select the [Ubuntu 18.04](/marketplace/products/yc/ubuntu-18-04-lts) public image.
1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../overview/concepts/geo-scope.md) to place your VM in.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}** tab and specify the parameters as follows:

    * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`.
    * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`.
    * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `20%`
    * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `1 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

1. In **{{ ui-key.yacloud.compute.instances.create.section_network }}**, select the subnet to connect the VM to once it is created.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the information required to access the VM:

    * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter a name for the user you want to create on the VM, e.g., `yc-user`.

      {% note alert %}

      Do not use `root` or other usernames reserved by the operating system. To perform operations requiring superuser permissions, use the `sudo` command.

      {% endnote %}

    * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `ci-tutorial-test-app`.
1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

It may take a few minutes to create the VM. When its status changes to `RUNNING`, you can start to configure your VM.

Once created, the VM is assigned an [IP address and a host name (FQDN)](../../vpc/concepts/address.md). This data can be used for SSH access.

## Prepare a VM with the test application {#configure-vm}

On the created VM, deploy a collection of components required for the test application to run and a web server to handle requests. The application will be written in Python 2.
1. Under **{{ ui-key.yacloud.compute.instance.overview.section_network }}** on the VM page in the [management console]({{ link-console-main }}), find the VM's public IP address.
1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM via SSH. To do this, use `ssh` in Linux or macOS, or [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) in Windows.

   ```bash
   ssh <login>@<VM_public_IP_address>
   ```

1. Run the `apt update` command to update the lists of packages available for installation.
1. Install the required packages: jq JSON processor, Git client, PIP package manager, virtualenv virtual environment management system, header files for the Python C API, and Nginx web server:

   ```bash
   sudo apt-get --yes install jq git python-pip virtualenv python-dev nginx-full
   ```

1. Create a directory to host the application. In addition, change the ownership of the directory to the user under which you will be connecting to the VM:

   ```bash
   sudo mkdir /srv/test-app
   sudo chown -R $USER /srv/test-app
   ```

1. Go to the directory and create the `virtualenv` virtual environment in it:

   ```bash
   cd /srv/test-app
   virtualenv test-venv
   ```

1. Activate the virtual environment:

   ```bash
   . test-venv/bin/activate
   ```

1. Install the Flask framework and the uWSGI web server in the virtual environment:

   ```bash
   pip install flask uwsgi
   ```

1. Deactivate the virtual environment:

   ```bash
   deactivate
   ```

1. In the `/srv/test-app` directory, create a file named `api.py`:

   ```bash
   touch api.py
   ```

1. Open the `api.py` file in any text editor and paste there the Python code which:
   * Accepts a text string as input in the `text` parameter.
   * Writes each word from the string in the reverse order.
   * Returns a response:
     * In JSON format if the client application can accept JSON.
     * In plain text if the client application does not accept JSON.

   ```python
   # api.py
   import json
   from flask import Flask, request, make_response as response

   app = Flask(__name__)

   @app.route("/")
   def index():
       text = request.args.get('text')
       json_type = 'application/json'
       json_accepted = json_type in request.headers.get('Accept', '')
       if text:
           words = text.split()
           reversed_words = [word[::-1] for word in words]
           if json_accepted:
               res = response(json.dumps({'text': reversed_words}), 200)
           else:
               res = response(' '.join(reversed_words), 200)
       else:
           res = response('text not found', 501)
       res.headers['Content-Type'] = json_type if json_accepted else 'text/plain'
       return res
   ```

1. In the `/srv/test-app` directory, create a file named `wsgi.py`:

   ```bash
   touch wsgi.py
   ```

1. Open the `wsgi.py` file in any text editor and paste the code that runs the test application:

   ```python
   # wsgi.py
   from api import app

   if __name__ == "__main__":
       app.run()
   ```

1. In the `/srv/test-app` directory, create a file named `test-app.ini`:

   ```bash
   touch test-app.ini
   ```

1. Open the `test-app.ini` file in any text editor and paste the configuration of the uWSGI server:

   ```ini
   #test-app.ini
   [uwsgi]
   module = wsgi:app

   master = true
   processes = 1

   socket = test-app.sock
   chmod-socket = 660
   vacuum = true

   die-on-term = true
   ```

1. Assign the `www-data` user as the owner of the `/srv/test-app` directory and the files in it:

   ```bash
   sudo chown -R www-data:www-data /srv/test-app
   ```

1. Prepare the service to start your uWSGI server. To do this, edit the `/etc/systemd/system/test-app.service` file as follows:

   ```ini
   #/etc/systemd/system/test-app.service
   [Unit]
   Description=uWSGI instance to serve test API
   After=network.target

   [Service]
   User=www-data
   Group=www-data
   WorkingDirectory=/srv/test-app
   Environment="PATH=/srv/test-app/test-venv/bin"
   ExecStart=/srv/test-app/test-venv/bin/uwsgi --ini test-app.ini

   [Install]
   WantedBy=multi-user.target
   ```

1. Provide the settings of the new virtual server in the Nginx configuration by changing the `/etc/nginx/sites-available/test-app.conf` file as follows:

   ```nginx
   #/etc/nginx/sites-available/test-app.conf
   server {
       #server_name test-app.yandex www.test-app.yandex;

       listen 80;

       location /test/ {
           include uwsgi_params;
           uwsgi_param SCRIPT_NAME /test;
           uwsgi_modifier1 30;
           uwsgi_pass unix:/srv/test-app/test-app.sock;
       }
   }
   ```

1. Create a symbolic link that points to the `test-app.conf` Nginx configuration file:

   ```bash
   sudo ln -s /etc/nginx/sites-available/test-app.conf /etc/nginx/sites-enabled/
   ```

1. Delete the symbolic link that points to the default Nginx configuration:

   ```bash
   sudo unlink /etc/nginx/sites-enabled/default
   ```

1. Add the service to the system autorun list:

   ```bash
   sudo systemctl enable test-app.service
   ```

## Check that the test application is working {#test-app}

To make sure the test application is functional and the web server is properly configured, send a simple request.
1. In the browser bar, enter the URL for testing the web server and application:

   ```http
   http://<VM_public_IP_address>/test/?text=hello_world
   ```

1. If everything works correctly, the screen will display text with reversed words from the `text` parameter.

## Take a snapshot of the VM disk {#create-snapshot}

To easily transfer the app and the web server configuration you created to VMs spawned with CI, you will need to take a snapshot of the test VM disk.
1. In the {{ yandex-cloud }} [management console]({{ link-console-main }}), select the folder you created your VM in.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. Find the `ci-tutorial-test-app` VM and select it.
1. Click **{{ ui-key.yacloud.common.stop }}**.
1. In the window that opens, click **{{ ui-key.yacloud.compute.instances.popup-confirm_button_stop }}**.
1. After stopping the VM, select the **{{ ui-key.yacloud.compute.switch_disks }}** tab.
1. In the required disk row, click ![vertical-ellipsis](../../_assets/console-icons/ellipsis-vertical.svg) and select **{{ ui-key.yacloud.compute.disks.button_action-snapshot }}**.
1. In the window that opens, enter a name for the snapshot: `test-app-snap`.
1. Click **{{ ui-key.yacloud.common.create }}**.

## Create a VM with {{ GL }} {#create-gitlab-vm}

You can set up CI in {{ yandex-cloud }} by using a public image with {{ GL }} pre-installed. {{ GL }} includes a set of tools for managing Git repositories and configuring CI.

1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create your VM in.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab, click **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**, and select the [{{ GL }}](/marketplace/products/yc/gitlab) image.
1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../overview/concepts/geo-scope.md) to place your VM in.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}** tab and specify the parameters as follows:

    * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`.
    * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`.
    * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`.
    * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `2 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

1. In **{{ ui-key.yacloud.compute.instances.create.section_network }}**, select the subnet to connect the VM to once it is created.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, specify the information required to access the VM:

    * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter a name for the user you want to create on the VM, e.g., `yc-user`.

      {% note alert %}

      Do not use `root` or other usernames reserved by the operating system. To perform operations requiring superuser permissions, use the `sudo` command.

      {% endnote %}

    * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `ci-tutorial-gitlab`.
1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

It may take a few minutes to create the VM. When its status changes to `RUNNING`, you can start to configure your VM.

Once created, the VM is assigned an [IP address and a host name (FQDN)](../../vpc/concepts/address.md). This data can be used for SSH access.

## Configure {{ GL }} {#configure-gitlab}

To set {{ GL }} up and configure the CI process, create a new project and enter the CI login credentials:
1. On the {{ compute-name }} page, select the created VM and copy its public IP.
1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM via SSH.
1. Get the {{ GL }} administrator password using the following VM command:

   ```bash
   sudo cat /etc/gitlab/initial_root_password
   ```

1. Copy the password (without spaces) from the `Password` row to the clipboard or a separate file.
1. Open `http://<VM_public_IP_address>` in your browser. This will take you to the {{ GL }} web interface.
1. Log in using the administrator account:
   * **Username or email**: `root`.
   * **Password**: Password you copied earlier.

   If you are unable to log in, [reset the administrator account password](https://docs.gitlab.com/ee/security/reset_user_password.html#reset-your-root-password).
1. [Change the administrator account password](https://docs.gitlab.com/ee/user/profile/#change-your-password).
1. Log in to the system again using the administrator account and the new password.
1. Select **Create a project**.
1. Set the project name: `gitlab-test`.
1. Click **Create project**.
1. Obtain an OAuth token from the Yandex OAuth service. To do this, follow the [link]({{ link-cloud-oauth }}) and click **Allow**.
1. In the browser, open the link formatted as `http://<VM_public_IP_address>/root`.
1. Select the `gitlab-test` project.
1. On the screen that opens, choose the **Settings** tab on the left. In the menu that opens, select **CI/CD**.
1. Under **Variables**, click **Expand**.
1. Create a new variable:
   * Specify `YC_OAUTH` as the variable name.
   * Specify the OAuth token you received as the value of the variable.
   * Click **Save variables**.
1. Under **Runners**, click **Expand**.
1. Under **Set up a specific Runner automatically**, you will see the **server address** to connect to and the **token** for registering the server in the project. Use these values when registering the Runner.

## Configure a Runner {#configure-runner}

A Runner is a tool for performing tasks that a user creates. You need to install a Runner on the VM and register it in {{ GL }}. For the Runner to be able to perform tasks, set up additional components: install the {{ yandex-cloud }} CLI and create a test to check the created VM.
1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM with {{ GL }} over SSH:

   ```bash
   ssh <login>@<public_IP_address_of_VM_with_{{ GL }}>
   ```

1. Add the new repository to the package manager:

   ```bash
   curl --location https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
   ```

1. Install GitLab Runner that will run your CI scripts:

   ```bash
   sudo apt-get -y install gitlab-runner
   ```

1. Register GitLab Runner:
   * For `Please enter the gitlab-ci coordinator URL`, enter the IP address of your {{ GL }} server.
   * For `Please enter the gitlab-ci token for this runner`, enter your GitLab Runner token.
   * For `Please enter the gitlab-ci description for this runner`, enter the `gitlab test runner` description.
   * For `Please enter the gitlab-ci tags for this runner`, do not type anything. Press **Enter**.
   * For `Please enter the executor`, enter `shell`.

   ```bash
   sudo gitlab-runner register
   Runtime platform                                    arch=amd64 os=linux pid=8197 revision=3afdaba6 version=11.5.0
   Running in system-mode.

   Please enter the gitlab-ci coordinator URL (e.g. https://gitlab.com/):
   http://<{{ GL }}>_CI_IP_address/
   Please enter the gitlab-ci token for this runner:
   <Runner_token>
   Please enter the gitlab-ci description for this runner:
   [ci-tutorial-gitlab]: gitlab test runner
   Please enter the gitlab-ci tags for this runner (comma separated):

   Registering runner... succeeded                     runner=wZqzyy9s
   Please enter the executor: virtualbox, docker+machine, docker-ssh+machine, kubernetes, docker, docker-ssh, shell, ssh, parallels:
   shell
   Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded!
   ```

1. For the CI script to be able to create VMs, please install the {{ yandex-cloud }} CLI:

   ```bash
   curl https://{{ s3-storage-host-cli }}{{ yc-install-path }} --output install.sh
   sudo bash install.sh -n -i /opt/yc
   ```

1. To perform functional testing, install the `pytest` package:

   ```bash
   sudo apt-get install python-pytest
   ```

1. Create a file named `test.py` with the functional testing script:
   1. Open the home page of the `gitlab-test` repository.
   1. Click **+** and select **New file**.
   1. In the window that opens, name the file as `test.py`.
   1. Copy the following code to the file body:

      ```python
      # test.py
      import pytest
      import json
      import socket as s

      @pytest.fixture
      def hostname(request):
          with open("instance-creation.out", "r") as fd:
              fqdn = json.loads(fd.read()).get("fqdn")

          return fqdn

      @pytest.fixture
      def socket(request):
          _socket = s.socket(s.AF_INET, s.SOCK_STREAM)
          def socket_teardown():
              _socket.close()
          request.addfinalizer(socket_teardown)
          return _socket

      def test_server_connect(socket, hostname):
          socket.connect((hostname, 80))
          assert socket
      ```

   1. Write any commit message and click **Commit changes**.

## Configure CI {#configure-ci}

You need to define the configuration for CI.
1. Open the home page of the `gitlab-test` repository:

   ```http
   http://<public_IP_address_of_{{ GL }}_VM>/root/gitlab-test
   ```

1. Click **Set up CI/CD**. A window will open for adding a new file.
1. {{ GL }} will name the file as `.gitlab-ci.yml` automatically. Do not rename it. Copy the following configuration to the file:

   ```yaml
   #.gitlab-ci.yml
   stages:
     - build
     - test

   build:
     stage: build
     variables:
       snapshot_name: test-app-snap
       folder_id: <folder_ID>
       subnet_name: <subnet_name>
     script:
       - export instance_name="ci-tutorial-test-app-$(date +%s)"
       - export PATH="/opt/yc/bin:${PATH}"
       - yc config set token $YC_OAUTH
       - yc compute instance create
         --format json
         --name $instance_name
         --folder-id $folder_id
         --zone {{ region-id }}-a
         --network-interface subnet-name=$subnet_name,nat-ip-version=ipv4
         --create-boot-disk name=$instance_name-boot,type=network-ssd,size=15,snapshot-name=$snapshot_name,auto-delete=true
         --memory 1
         --cores 1
         --hostname $instance_name > instance-creation.out
       - sleep 30
     artifacts:
       when: on_success
       paths:
       - instance-creation.out
       expire_in: 10 mins

   test_external:
     stage: test
     script:
       - py.test test.py > pytest-external.out
     artifacts:
       paths:
       - pytest-external.out
       expire_in: 1 hour
   ```

1. In the `snapshot_name` field, enter the snapshot name for the first VM.
   In the `folder_id` field, specify the ID of the folder where VMs are created.
   In the `subnet_name` field, specify the name of the subnet the VMs will connect to. You can get the name in the management console: open the appropriate folder and go to the {{ vpc-name }} service page.
1. Click **Commit changes**.

## Test the application on the VM created using CI {#test-new-vm}

After making a commit, you need to make sure that CI worked correctly. The appropriate folder should contain a new VM where the test application and the web server are deployed.

To test the created VM:
1. Open the {{ yandex-cloud }} management console.
1. In the folder where the VMs were created, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. If everything is properly configured, the VM list should display a new VM, such as `ci-tutorial-test-app-1543910277`.
1. Select the created VM and copy its public IP address.
1. In the browser, open the following link:

   ```http
   http://<public_IP_address_of_created_VM>/test/?text=hello_world
   ```

1. The application you created in the previous steps should also function on the created VM and return the reversed words from the `text` parameter.

### Delete the resources you created {#clear-out}

If you no longer need the VMs and images:
* [Delete the created VMs](../../compute/operations/vm-control/vm-delete.md).
* [Delete the created images](../../compute/operations/image-control/delete.md).
