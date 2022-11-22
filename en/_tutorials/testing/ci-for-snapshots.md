# Creating test VMs using GitLab CI

You can use {{ yandex-cloud }} to automate routine actions, such as running a specific script after each commit to the `master` branch in a git repository. In the example below, a VM is created and tested after each commit.

To configure CI for VM disk snapshots:

1. [Create a VM for the test application](#create-vm): create a new virtual machine that will be used to make a disk snapshot for creating new virtual machines via CI.
1. [Prepare the VM with the test application](#configure-vm): install the web server and the set of components for the test application on the VM. Write a test application that will reverse the words in a text sent to the server.
1. [Check how the application works](#test-app): send a test request to check the server settings and the results.
1. [Create a snapshot of the VM disk](#create-snapshot): create a snapshot of the VM disk that CI will use to create new virtual machines.
1. [Create a VM with GitLab](#create-gitlab-vm): create a virtual machine with GitLab, where the repository will store the CI settings and the functional testing script.
1. [Configure GitLab](#configure-gitlab): create a repository for files and get the necessary configuration parameters.
1. [Configure Runner](#configure-runner): set up the Runner utility for performing tasks.
1. [Configure CI](#configure-ci): set the CI configuration by specifying the necessary parameters for commands and testing.
1. [Check how the application works on the VM created using CI](#test-new-vm): make sure that VMs created with CI and the snapshot are created and the test application is running.

## Before you start {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

Before creating a VM:

1. Go to the {{ yandex-cloud }} [management console]({{ link-console-main }}) and select the folder where you want to perform the operations.
1. Make sure the selected folder has a network with a subnet that the VM can be connected to. To do this, select **{{ vpc-short-name }}** on the folder page. If the list contains a network, click on its name to see the list of subnets. If there aren't any networks or subnets, [create them](../../vpc/quickstart.md).

## 1. Create a VM for the test application {#create-vm}

Create a VM where the test application will be installed, the set of components required for it to work, and a web server:

1. On the folder page of the [management console]({{ link-console-main }}), click **Create resource** and select **Virtual machine**.

1. In the **Name** field, enter the VM name: `ci-tutorial-test-app`.

1. Select the [availability zone](../../overview/concepts/geo-scope.md) to locate the VM in.

1. Under **Image/boot disk selection**, click the **{{ marketplace-name }}** tab, and select the public image of [Ubuntu 18.04](/marketplace/products/yc/ubuntu-18-04-lts).

1. In the **Computing resources** section, select the following configuration:
   * **Platform**: Intel Ice Lake.
   * **Guaranteed vCPU share**: 20%.
   * **vCPU**: 2.
   * **RAM**: 1 GB.

1. In the **Network settings** section, select the subnet to connect the VM to when creating it.

1. Specify data required for accessing the VM.
    - Enter the username in the **Login** field.
    - In the **SSH key** field, copy the contents of the public key file.
You need to create a key pair for SSH connection yourself. To generate keys, use third-party tools, such as `ssh-keygen` utilities on Linux and macOS or [PuTTYgen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) on Windows.

1. Click **Create VM**.

Creating the VM may take several minutes. When the VM's status changes to `RUNNING`, you can begin configuring it.

When a VM is created, it is assigned an IP address and hostname (FQDN). This data can be used for SSH access.

## 2. Prepare a VM with the test application {#configure-vm}

On the created VM, install the set of components required for the test application and a web server for processing requests. The application will be written in Python 2.

1. In the **Network** section on the VM page of the [management console]({{ link-console-main }}), find the VM's public IP address.

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH. You can use the `ssh` tool on Linux and macOS and [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) for Windows.

   ```
   ssh <Login>@<Public_IP_of_the_VM>
   ```

1. Run the `apt update` command to update lists of available packages.
1. Install the necessary packages (jq JSON processor, git client, PIP package manager, virtualenv virtual environment management system, the set of header files for Python C API, and the nginx web server):

   ```
   sudo apt-get --yes install jq git python-pip virtualenv python-dev nginx-full
   ```

1. Create the folder where the application will be located and make the user you used for connecting to the VM the owner of the folder:

   ```
   sudo mkdir /srv/test-app
   sudo chown -R $USER /srv/test-app
   ```

1. Go to the folder and create a virtualenv virtual environment in it:

   ```
   cd /srv/test-app
   virtualenv test-venv
   ```

1. Activate the virtual environment:

   ```
   . test-venv/bin/activate
   ```

1. Install the Flask framework and the uWSGI web server in the virtual environment:

   ```
   pip install flask uwsgi
   ```

1. Deactivate the virtual environment:

   ```
   deactivate
   ```

1. Create the `api.py` file in the `/srv/test-app` folder:

   ```
   touch api.py
   ```

1. Open the `api.py` file using any text editor, and insert the Python code that:
   * Accepts a text string as input in the `text` parameter.
   * Writes each word from the passed string in the opposite order.
   * Returns a response:
        * In JSON format, if the client application can accept JSON.
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

1. Create the `wsgi.py` file in the `/srv/test-app` folder:

   ```
   touch wsgi.py
   ```

1. Open the `wsgi.py` file using any text editor and insert the code that runs the test application:

   ```python
   # wsgi.py
   from api import app

   if __name__ == "__main__":
       app.run()
   ```

1. Create the `test-app.ini` file in the `/srv/test-app` folder:

   ```
   touch test-app.ini
   ```

1. Open the `test-app.ini` file using any text editor and insert the configuration of the uWSGI server:

   ```
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

1. Assign the `www-data` user as the owner of the `/srv/test-app` folder and the files it contains:

   ```
   sudo chown -R www-data:www-data /srv/test-app
   ```

1. Prepare the service to start your uWSGI server. To do this, make the `/etc/systemd/system/test-app.service` file look like this:

   ```
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

1. Specify the settings of the new virtual server in the nginx configuration by making the `/etc/nginx/sites-available/test-app.conf` file look like this:

   ```
   #/etc/nginx/sites-available/test-app.conf
   server {
       #server_name test-app.yandex  www.test-app.yandex;

       listen 80;

       location /test/ {
           include uwsgi_params;
           uwsgi_param SCRIPT_NAME /test;
           uwsgi_modifier1 30;
           uwsgi_pass unix:/srv/test-app/test-app.sock;
       }
   }
   ```

1. Create a symbolic link that points to the nginx configuration file `test-app.conf`:

   ```
   sudo ln -s /etc/nginx/sites-available/test-app.conf /etc/nginx/sites-enabled/
   ```

1. Delete the symbolic link that points to the default nginx configuration:

   ```
   sudo unlink /etc/nginx/sites-enabled/default
   ```

1. Add the service to the system autorun list:

   ```
   sudo systemctl enable test-app.service
   ```

## 3. Check that the test application is working {#test-app}

To make sure the test application is running and the web server is configured correctly, send a simple request.

1. In the browser bar, enter the URL for testing the web server and application:

   ```
   http://<Public_IP_of_the_VM>/test/?text=hello_world
   ```

1. If everything is working, the screen will display text with reversed words from the `text` parameter.

## 4. Take a snapshot of the VM disk {#create-snapshot}

To easily transfer the created application and web server configuration to VMs created with CI, you need to take a snapshot of the test VM disk.

1. In the {{ yandex-cloud }} management console, select the folder where the VM was created.
1. Select **{{ compute-short-name }}**.
1. Find the `ci-tutorial-test-app` VM and select it.
1. Click **Stop**.
1. In the window that opens, click **Stop**.
1. After stopping the VM, select the **Disks** tab.
1. In the disk row, click ![vertical-ellipsis](../../_assets/vertical-ellipsis.svg) and select **Create snapshot**.
1. In the window that opens, enter a name for the snapshot: `test-app-snap`.
1. Click **Create snapshot**.

## 5. Create a virtual machine with GitLab {#create-gitlib-vm}

One of the ways to set up CI in {{ yandex-cloud }} is to take advantage of a public image with GitLab pre-installed. GitLab includes a set of tools for managing git repositories and configuring CI.

1. On the folder page of the [management console]({{ link-console-main }}), click **Create resource** and select **Virtual machine**.

1. In the **Name** field, enter the VM name: `ci-tutorial-gitlab`.

1. Select the [availability zone](../../overview/concepts/geo-scope.md) to locate the VM in.

1. Under **Image/boot disk selection**, click the **{{ marketplace-name }}** tab, and select the [GitLab](/marketplace/products/yc/gitlab) image.

1. In the **Computing resources** section, select the following configuration:
   * **Guaranteed vCPU share**: 100%.
   * **vCPU**: 2.
   * **RAM**: 2 GB.

1. In the **Network settings** section, select the subnet to connect the VM to when creating it.

1. Specify data required for accessing the VM.
    - Enter the username in the **Login** field.
    - In the **SSH key** field, copy the contents of the public key file.
You need to create a key pair for SSH connection yourself. To generate keys, use third-party tools, such as `ssh-keygen` utilities on Linux and macOS or [PuTTYgen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) on Windows.

1. Click **Create VM**.

Creating the VM may take several minutes. When the VM's status changes to `RUNNING`, you can begin configuring it.

When a VM is created, it is assigned an IP address and hostname (FQDN). This data can be used for SSH access.

## 6. Configure GitLab {#configure-gitlab}

To configure GitLab and prepare CI, you must create a new repository and enter the necessary parameters for authorization in CI.

1. In a browser, open the GitLab admin panel for the created VM. To do this, open a link that looks like `http://<VM-public-IP-address>`.

1. Set the administrator password.

1. Log in as `root` with the administrator password.

1. Click **Create a project**.

1. Set the project name: `gitlab-test`.

1. Click **Create project**.

1. Get an OAuth token from Yandex OAuth. To do this, follow the [link](https://oauth.yandex.com/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb) and click **Allow**.

1. In the browser, open a link that looks like `http://<VM-public-IP-address>/root`.

1. Select the `gitlab-test` project.

1. On the screen that opens, choose the **Settings** tab on the left. In the menu that opens, select **CI/CD**.

1. Under **Variables**, click **Expand**.

1. Create a new variable:
    * For the variable name, specify `YC_OAUTH`.
    * Specify the OAuth token you received as the value of the variable.
    * Click **Save variables**.

1. Under **Runners**, click **Expand**.

1. Under **Set up a specific Runner automatically**, you will see the **server address** to connect to and the **token** for registering the server in the project. Use these values when registering Runner.

## 7. Configure Runner {#configure-runner}

Runner is a tool for performing tasks that a user creates. You need to install Runner on the VM and register it in GitLab. In order for Runner to perform tasks, prepare additional components: install the {{ yandex-cloud }} CLI and create a test to check the created VM.

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM with GitLab over SSH.

   ```
   ssh <Login>@<Public_IP_of_the_GitLab_VM>
   ```

1. Add the new repository to the package manager:

   ```
   curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
   ```

1. Install the Runner that will run your CI scripts:

   ```
   sudo apt-get -y install gitlab-runner
   ```

1. Register the Runner:

   * In the step `Please enter the gitlab-ci coordinator URL`, specify the address of the GitLab server.
   * In the step `Please enter the gitlab-ci token for this runner`, specify the Runner token.
   * In the step `Please enter the gitlab-ci description for this runner`, enter the description `gitlab test runner`.
   * In the step `Please enter the gitlab-ci tags for this runner`, don't type anything. Press **Enter**.
   * In the step `Please enter the executor`, specify `shell`.

   ```
   sudo gitlab-runner register
   Runtime platform                                    arch=amd64 os=linux pid=8197 revision=3afdaba6 version=11.5.0
   Running in system-mode.

   Please enter the gitlab-ci coordinator URL (e.g. https://gitlab.com/):
   http://<ci-gitlab-IP-address>/
   Please enter the gitlab-ci token for this runner:
   <Runner-token>
   Please enter the gitlab-ci description for this runner:
   [ci-tutorial-gitlab]: gitlab test runner
   Please enter the gitlab-ci tags for this runner (comma separated):

   Registering runner... succeeded                     runner=wZqzyy9s
   Please enter the executor: virtualbox, docker+machine, docker-ssh+machine, kubernetes, docker, docker-ssh, shell, ssh, parallels:
   shell
   Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded!
   ```

1. Install the {{ yandex-cloud }} CLI so that the CI script can create VMs:

   ```
   curl https://{{ s3-storage-host }}{{ yc-install-path }} --output install.sh
   sudo bash install.sh -n -i /opt/{{ product }}
   ```

1. To perform functional testing, install the `pytest` package:

   ```
   sudo apt-get install python-pytest
   ```

1. Create the `test.py` file with the functional testing script:
   1. Open the home page of the `gitlab-test` repository.
   1. Click **+** and choose **New file**.
   1. In the window that opens, give the file the name `test.py`.
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

## 8. Configure CI {#configure-ci}

You need to define the configuration for CI.

1. Open the home page of the `gitlab-test` repository:

   ```
   http://<Public_IP_of_the_GitLab_VM>/root/gitlab-test
   ```

1. Click **Set up CI/CD**. You will see the screen for adding a new file.
1. GitLab automatically gives the file the name `.gitlab-ci.yml`: don't change it. Copy the following configuration to the file:

   ```
   #.gitlab-ci.yml
   stages:
     - build
     - test

   build:
     stage: build
     variables:
       snapshot_name: test-app-snap
       folder_id: <folder-id>
       subnet_name: <subnet-name>
     script:
       - export instance_name="ci-tutorial-test-app-$(date +%s)"
       - export PATH="/opt/{{ product }}/bin:${PATH}"
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

1. In the `snapshot_name` field, enter a name for the snapshot of the first VM.
In the `folder_id` field, specify the ID of the folder where the VMs are created.
In the `subnet_name` field, specify the name of the subnet that the VMs will connect to. To find the name in the management console, open the appropriate folder and go to the {{ vpc-name }} page.
1. Click **Commit changes**.

## 9. Check how the application works on the VM created using CI {#test-new-vm}

After the commit, you need to make sure that CI worked correctly. A new VM should appear in the folder where the test application and web server are deployed.

To check the created VM:

1. Open the {{ yandex-cloud }} management console.
1. In the folder where the VMs were created, select the **{{ compute-short-name }}** service.
1. If everything was configured correctly, the list of VMs should include a new VM with a name like `ci-tutorial-test-app-1543910277`.
1. Select the VM you created and copy the public address of the created VM.
1. In the browser, open a link in this format:

   ```
   http://<public_IP_address_of_the_created_VM>/test/?text=hello_world
   ```

1. The application created in the previous steps should also work on the created VM by returning reversed words from the `text` parameter.

