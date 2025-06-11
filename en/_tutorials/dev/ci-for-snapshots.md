# Creating test VMs with {{ GL }} CI


You can use {{ yandex-cloud }} to automate routine tasks, such as running a specific script after each Git `master` branch commit. In the following example, we create and test a [VM](../../compute/concepts/vm.md) after each commit.

To configure continuous integration (CI) for VM [disk snapshots](../../compute/concepts/snapshot.md):
1. [Create the test application VM](#create-vm): Create a virtual machine allowing you to make new CI VMs using its disk snapshot.
1. [Configure the test application VM](#configure-vm): Install a web server and test application components on the VM. Write a test application reversing words in a text sent to the server.
1. [Check how the application works](#test-app): Send a test request to check whether the server settings are correct.
1. [Create a VM disk snapshot](#create-snapshot): Create a disk snapshot that CI will use to create new VMs.
1. [Create a VM with {{ GL }}](#create-gitlab-vm): Create a [{{ GL }}](https://about.gitlab.com/) VM with a repository to store CI settings and a test script.
1. [Configure {{ GL }}](#configure-gitlab): Create a file repository and get configuration parameters.
1. [Configure Runner](#configure-runner): Tool for performing tasks.
1. [Configure CI](#configure-ci): Specify the required command and testing parameters.
1. [Make sure the application runs on the CI VM](#test-new-vm): Check whether the system created CI snapshot VMs and they run your test application.

If you no longer need the VMs you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

Before creating a VM:
1. Navigate to the {{ yandex-cloud }} [management console]({{ link-console-main }}) and select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to work with.
1. Make sure the selected folder has a [network](../../vpc/concepts/network.md#network) with a [subnet](../../vpc/concepts/network.md#subnet) where you can connect your VM. To do this, select **{{ vpc-name }}** on the folder page. If the list contains a network, click its name to see the list of subnets. If there are no networks in the list or the selected network has no subnets, [create them](../../vpc/quickstart.md) as required.

### Required paid resources {#paid-resources}

The infrastructure support costs include:
* Fee for continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for storing created images (see [{{ compute-name }} pricing](../../compute/pricing.md#prices-storage)).
* Fee for dynamic public IP addresses (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

## Create the test application VM {#create-vm}

Create a VM where you will install a web server, your test application, and its components:

1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your VM.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select the [Ubuntu 18.04](/marketplace/products/yc/ubuntu-18-04-lts) public image.
1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../overview/concepts/geo-scope.md) where your VM will reside.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}** tab and specify these settings:

    * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`
    * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
    * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `20%`
    * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `1 {{ ui-key.yacloud.common.units.label_gigabyte }}`

1. In **{{ ui-key.yacloud.compute.instances.create.section_network }}**, select the subnet where you will connect your VM.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

    * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter a name for the user you want to create on the VM, e.g., `yc-user`.

      {% note alert %}

      Do not use `root` or other reserved usernames. To perform operations requiring root privileges, use the `sudo` command.

      {% endnote %}

    * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `ci-tutorial-test-app`.
1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

It may take a few minutes to create your VM. When its status changes to `RUNNING`, you can start configuring it.

Once your VM is created, the system will assign it an [IP address and a host name (FQDN)](../../vpc/concepts/address.md). You can use them for SSH access.

## Configure the test application VM {#configure-vm}

On the new VM, install a web server and test application components. You will use Python 2 to create your test application.
1. In the [management console]({{ link-console-main }}), under **{{ ui-key.yacloud.compute.instance.overview.section_network }}** on the VM page, find the VM public IP address.
1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM over SSH. You can do it using `ssh` in Linux or macOS or [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) in Windows.

   ```bash
   ssh <login>@<VM_public_IP_address>
   ```

1. Run the `apt update` command to update the lists of packages available for installation.
1. Install the required packages: jq JSON processor, Git client, PIP package manager, `virtualenv` virtual environment management system, Python C API header files, and Nginx web server:

   ```bash
   sudo apt-get --yes install jq git python-pip virtualenv python-dev nginx-full
   ```

1. Create your application directory and make yourself its owner:

   ```bash
   sudo mkdir /srv/test-app
   sudo chown -R $USER /srv/test-app
   ```

1. Navigate to this directory and create the `virtualenv` virtual environment in it:

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

1. Create the `api.py` file in the `/srv/test-app` directory:

   ```bash
   touch api.py
   ```

1. Open the `api.py` file in any text editor and paste the Python code below into it; the code does the following:
   * Accepts a text string from the `text` input argument.
   * Reverses each word in the string while retaining spaces.
   * Returns a response:
     * In JSON format if the client accepts it.
     * In plain text if the client does not accept JSON.

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

1. Create the `wsgi.py` file in the `/srv/test-app` directory:

   ```bash
   touch wsgi.py
   ```

1. Open the `wsgi.py` file in any text editor and paste the application starting code in it:

   ```python
   # wsgi.py
   from api import app

   if __name__ == "__main__":
       app.run()
   ```

1. Create the `test-app.ini` file in the `/srv/test-app` directory:

   ```bash
   touch test-app.ini
   ```

1. Open the `test-app.ini` file in any text editor and paste the uWSGI server configuration in it:

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

1. Make the `www-data` user owner of the `/srv/test-app` directory and its contents:

   ```bash
   sudo chown -R www-data:www-data /srv/test-app
   ```

1. Prepare the service that will start your uWSGI server. To do this, edit the `/etc/systemd/system/test-app.service` file as follows:

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

1. Specify the new virtual server settings in the Nginx configuration by changing the `/etc/nginx/sites-available/test-app.conf` file as follows:

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

1. Create a symbolic link pointing to the `test-app.conf` Nginx configuration file:

   ```bash
   sudo ln -s /etc/nginx/sites-available/test-app.conf /etc/nginx/sites-enabled/
   ```

1. Delete the symbolic link pointing to the default Nginx configuration:

   ```bash
   sudo unlink /etc/nginx/sites-enabled/default
   ```

1. Configure the service to run at boot:

   ```bash
   sudo systemctl enable test-app.service
   ```

## Check whether the test application is working {#test-app}

To make sure the web server is properly configured and the test application is working as expected, make a simple request.
1. In the browser address bar, enter the following URL:

   ```http
   http://<VM_public_IP_address>/test/?text=hello_world
   ```

1. If everything works correctly, you will see reversed words from the `text` argument string.

## Create a VM disk snapshot {#create-snapshot}

Create a VM disk snapshot to transfer your web server configuration and test application to CI VMs.
1. In the {{ yandex-cloud }} [management console]({{ link-console-main }}), select the folder where you created your VM.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. Find the `ci-tutorial-test-app` VM and select it.
1. Click **{{ ui-key.yacloud.common.stop }}**.
1. In the window that opens, click **{{ ui-key.yacloud.compute.instances.popup-confirm_button_stop }}**.
1. Once the VM gets stopped, select the **{{ ui-key.yacloud.compute.disks_ddfdb }}** tab.
1. Select the disk you need, click ![vertical-ellipsis](../../_assets/console-icons/ellipsis-vertical.svg), and select **{{ ui-key.yacloud.compute.disks.button_action-snapshot }}**.
1. In the window that opens, specify the snapshot name: `test-app-snap`.
1. Click **{{ ui-key.yacloud.common.create }}**.

## Create a {{ GL }} VM {#create-gitlab-vm}

You can set up CI in {{ yandex-cloud }} by using a public image with {{ GL }} pre-installed. {{ GL }} includes tools for managing Git repositories and configuring CI.

1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your VM.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, navigate to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab, click **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**, and select the [{{ GL }}](/marketplace/products/yc/gitlab) image.
1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../overview/concepts/geo-scope.md) where your VM will reside.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}** tab and specify these settings:

    * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`
    * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
    * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`
    * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `2 {{ ui-key.yacloud.common.units.label_gigabyte }}`

1. In **{{ ui-key.yacloud.compute.instances.create.section_network }}**, select the subnet where you will connect your VM.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

    * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter a name for the user you want to create on the VM, e.g., `yc-user`.

      {% note alert %}

      Do not use `root` or other reserved usernames. To perform operations requiring root privileges, use the `sudo` command.

      {% endnote %}

    * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `ci-tutorial-gitlab`.
1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

It may take a few minutes to create your VM. When its status changes to `RUNNING`, you can start configuring it.

Once your VM is created, the system will assign it an [IP address and a host name (FQDN)](../../vpc/concepts/address.md). You can use them for SSH access.

## Configure {{ GL }} {#configure-gitlab}

To set {{ GL }} up and configure the CI process, create a new project and enter your CI login credentials:
1. On the {{ compute-name }} page, select the created VM and copy its public IP address.
1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM over SSH.
1. Get the {{ GL }} administrator password with the following VM command:

   ```bash
   sudo cat /etc/gitlab/initial_root_password
   ```

1. Copy the password without spaces from the `Password` line to the clipboard or a separate file.
1. In your browser, open `http://<VM_public_IP_address>`. This will take you to the {{ GL }} web interface.
1. Log in as the administrator:
   * **Username or email**: `root`.
   * **Password**: Password you copied in the previous step.

   If you are unable to log in, [reset the administrator password](https://docs.gitlab.com/ee/security/reset_user_password.html#reset-your-root-password).
1. [Change the administrator password](https://docs.gitlab.com/ee/user/profile/#change-your-password).
1. Log in as the administrator with the new password.
1. Select **Create a project**.
1. Specify the project name: `gitlab-test`.
1. Click **Create project**.
1. Get a Yandex OAuth token. To do this, follow this [link]({{ link-cloud-oauth }}) and click **Allow**.
1. In your browser, open this link: `http://<VM_public_IP_address>/root`.
1. Select the `gitlab-test` project.
1. On the screen that opens, click **Settings** on the left and, in the popup menu, select **CI/CD**.
1. Under **Variables**, click **Expand**.
1. Create a new variable:
   * Specify the variable name: `YC_OAUTH`.
   * As the value of the variable, specify the OAuth token you received previously.
   * Click **Save variables**.
1. Under **Runners**, click **Expand**.
1. Under **Set up a specific Runner automatically**, you will see the {{ GL }} **server address** and the Runner **token**. You will need them when registering your runner.

## Configure your runner {#configure-runner}

Runner is a tool for running user tasks. You need to create a runner on your VM and register it in {{ GL }}. To make your runner work, install the {{ yandex-cloud }} CLI and create a test to check the new VM.
1. [Connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the {{ GL }} VM over SSH:

   ```bash
   ssh <login>@<public_IP_address_of_VM_with_{{ GL }}>
   ```

1. Add a new repository to the package manager:

   ```bash
   curl --location https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
   ```

1. Install GitLab Runner to run your CI scripts:

   ```bash
   sudo apt-get -y install gitlab-runner
   ```

1. Register your runner:
   * In response to `Please enter the gitlab-ci coordinator URL`, specify your {{ GL }} IP address.
   * In response to `Please enter the gitlab-ci token for this runner`, speciffy your GitLab Runner token.
   * In response to `Please enter the gitlab-ci description for this runner`, specify the `gitlab test runner` description.
   * In response to `Please enter the gitlab-ci tags for this runner`, press **Enter**.
   * In response to `Please enter the executor`, specify `shell`.

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

1. Install the {{ yandex-cloud }} CLI to create VMs with the CI script:

   ```bash
   curl https://{{ s3-storage-host-cli }}{{ yc-install-path }} --output install.sh
   sudo bash install.sh -n -i /opt/yc
   ```

1. Install the `pytest` package for functional testing:

   ```bash
   sudo apt-get install python-pytest
   ```

1. Create the `test.py` file with the functional testing script:
   1. Open the `gitlab-test` repository home page.
   1. Click **+** and select **New file**.
   1. In the window that opens, specify the file name: `test.py`.
   1. Add the following code to the file:

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

   1. Specify your commit message and click **Commit changes**.

## Configure CI {#configure-ci}

Now you need to configure CI.
1. Open the `gitlab-test` repository home page:

   ```http
   http://<public_IP_address_of_{{ GL }}_VM>/root/gitlab-test
   ```

1. Click **Set up CI/CD**. This will open a window for adding a new file.
1. {{ GL }} will automatically name the file as `.gitlab-ci.yml`. Do not rename it. Add the following configuration to the file:

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
         --zone {{ region-id }}-d
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

1. In the `snapshot_name` field, specify the first VM snapshot name.
   In the `folder_id` field, specify the VM folder ID.
   In the `subnet_name` field, specify your VM subnet name; you can find this name on the {{ vpc-name }} page in the relevant folder of the management console.
1. Click **Commit changes**.

## Test the application on the CI VM {#test-new-vm}

After making a commit, make sure that CI performed its function correctly. You should see a new VM with a web server and your test application in the relevant folder..

To test the new VM:
1. Open the {{ yandex-cloud }} management console.
1. In the folder with the VMs, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. If you did everything correctly, you will see a new VM in the list, e.g., `ci-tutorial-test-app-1543910277`.
1. Select the new VM and copy its public IP address.
1. In your browser, open this link:

   ```http
   http://<public_IP_address_of_created_VM>/test/?text=hello_world
   ```

1. Your test application should also work on the new VM, returning reversed words from the `text` argument.

### Delete the resources you created {#clear-out}

If you no longer need the VMs and images you created:
* [Delete the VMs](../../compute/operations/vm-control/vm-delete.md).
* [Delete the images](../../compute/operations/image-control/delete.md).
