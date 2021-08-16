# Automating image builds using Jenkins and Packer

This scenario describes how to set up automated VM image builds using Jenkins and Packer.
Jenkins lets you to set up the continuous delivery of image configuration changes to Packer to build VM image used in Yandex.Cloud.

The images built can be used to create a cloud infrastructure. In this scenario, Terraform is used to deploy virtual machines from the created images.

To install and configure Jenkins, Packer, GitHub, and Terraform to interact with one another:

1. [Create a service account](#create-service-account)
1. [Create a VM with Jenkins](#create-jenkins-vm)
1. [Install Packer](#install-packer)
1. [Configure Jenkins](#configure-jenkins)
1. [Set up a Jenkins job](#jenkins-job)
1. [Configure a GitHub repository](#configure-github-repo)
1. [Create an image using Jenkins](#create-image)
1. [Deploy the images using Terraform](#deploy-image)

If you no longer need the created VM and images, [delete them](#clear-out).

## Before you start {#before-you-begin}

Before deploying your applications, sign up for Yandex.Cloud and create a billing account:

{% include [prepare-register-billing](../_solutions_includes/prepare-register-billing.md) %}

If you have an active billing account, you can create or select a folder to run your VM in from the [Yandex.Cloud page](https://console.cloud.yandex.com/cloud).

[Learn more about clouds and folders](../../resource-manager/concepts/resources-hierarchy.md).

* Install the Yandex.Cloud command line interface.
* Install [Terraform](terraform-quickstart.md) and configure it to work with Yandex.Cloud.
* Configure the Git client. If you are running Windows, use [Git Bash](https://gitforwindows.org).
* Create a [repository](https://github.com/yandex-cloud/examples) branch with examples in your GitHub account.
* Prepare an SSH key to access the virtual machines.
* [Create](../../vpc/operations/network-create.md) a cloud network and subnet in the selected availability zone.

### Required paid resources {#paid-resources}

The cost of this infrastructure includes:

* A fee for continuously running VMs (see [pricing{{ compute-full-name }}](../../compute/pricing.md)).
* A fee for storing created images (see [{{ compute-full-name }} pricing](../../compute/pricing#prices-storage)).
* A fee for using dynamic public IP addresses (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

## Create a service account {#create-service-account}

Jenkins uses service accounts to perform actions in your cloud and folder. To create a service account:

1. Get the IDs of the folder and cloud by running `yc config list`.

1. Create a service account and pass its ID to the environment variable using the following commands:

   ```
   $ yc iam service-account create --name <username>
   $ yc iam key create --service-account-name <username> -o <username.json>
   $ SERVICE_ACCOUNT_ID=$(yc iam service-account get --name <username> --format json | jq -r .id)
   ```

1. Assign the service account the `admin` role for the folder where operations will be performed:

   ```
   $ yc resource-manager folder add-access-binding <folder_name> --role admin --subject serviceAccount:$SERVICE_ACCOUNT_ID
   ```

## Create a VM with Jenkins {#create-jenkins-vm}

Jenkins will get VM image configuration changes from GitHub and then use Packer to create images in the cloud.

To create a virtual machine with Jenkins:

1. On the folder page in the [management console](https://console.cloud.yandex.com), click **Create resource** and select **Virtual machine**.

1. In the **Name** field, enter a name for the VM: `jenkins-tutorial`.

1. Select the [availability zone](../../overview/concepts/geo-scope.md) to host the VM in.

1. Under **Images from {{ marketplace-name }}**, click **Select**. In the window that opens, select the **Jenkins** image.

1. Under **Disks**, enter 15 GB for the size of the boot disk:

1. Under **Computing resources**:
    - Choose a [platform](../../compute/concepts/vm-platforms.md): Intel Cascade Lake.
    - Specify the number of vCPUs and amount of RAM:
       * **vCPU**: 2.
       * **Guaranteed vCPU share**: 5%.
       * **RAM**: 2 GB.

1. Under **Network settings**, click **Add network** and choose the subnet to connect the virtual machine to. Under **Public IP**, assign a public address to the VM automatically or select a reserved address.

1. Under **Access**, specify the data required to access the VM:
    - Enter the username in the **Login** field.
    - In the **SSH key** field, paste the contents of the public key file.
You need to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair for SSH connections on your own.

1. Click **Create VM**.

## Install Packer {#install-packer}

Packer lets you create [virtual machine images](../../compute/concepts/image.md) with parameters specified in the configuration file.

{% note info %}

Yandex.Cloud requires Packer 1.4.1 and higher.

{% endnote %}

1. Download the [Packer](https://packer.io/downloads) distribution for Linux.

1. Upload Packer to the VM you created:

   ```
   $ scp packer_<Packer version>_linux_amd64.zip <Login>@<Public IP address of your VM>:~/
   ```

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH. You can use the `ssh` utility in Linux or macOS, or `PuTTY` in Windows.

1. Create a new folder, move the Packer executables there, and unpack the archive:

   ```
   $ sudo mkdir /opt/yandex-packer/
   $ sudo mv packer_<Packer version>_linux_amd64.zip /opt/yandex-packer/
   $ unzip packer_<Packer version>_linux_amd64.zip
   ```

1. All Jenkins system activity is performed on behalf of the `jenkins` user. Grant this user rights to launch Packer:

   ```
   $ sudo chmod u+x /opt/yandex-packer/packer*
   $ sudo chown jenkins:jenkins /opt/yandex-packer/packer*
   ```

## Configure Jenkins {#configure-jenkins}

To build images based on configurations from GitHub, configure Jenkins:

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH. You can use the `ssh` utility in Linux or macOS, or `PuTTY` in Windows.

1. Open the password file needed to launch the configuration and copy the password:

   ```
   $ sudo cat /var/lib/jenkins/secrets/initialAdminPassword
   ```

1. Open `http://<public IP address of VM with Jenkins>` in the browser. Open the Jenkins management console.

1. Enter the copied password in the **Administrator password** field and click **Continue**.

1. Choose **Select plugins to install**.

1. You will need the following plugins to run this scenario:
   * `Pipeline` — The plugin for getting the source code from the VCS and assembling, testing, and deploying it.
   * `Git` — The plugin for working with git repositories.
   * `Credentials Binding` — The plugin for creating environment variables with authentication data.

1. Click **Install**. The selected components start to install.

1. When the installation is complete, you are prompted to create an administrator account. Fill in the form fields and click **Save and Continue**.

1. You are prompted to create a URL for Jenkins. Leave the URL as `http://<VM public IP address>/`. Click **Save and finish**.

1. Click **Start using Jenkins** to complete the installation and go to the Jenkins administration panel.

## Set up a Jenkins task {#jenkins-job}

Enter your Yandex.Cloud authorization data and create a task to download changes from the github repository so that Jenkins can build images. The authorization data is used in the variables stored in the Packer configuration files.

1. Open the Jenkins administration panel.
1. Select **Credentials**.
1. Under **Stores scoped to Jenkins**, click the `Global` link.
1. Get the ID of the subnet where images will be built by running the `yc vpc subnet list` command.
1. Click **Add credentials**. Specify the following parameters:
   1. In the **Kind** list, click `Secret text`.
   1. In the **Scope** list, leave `Global`.
   1. In the **Secret** field, enter the ID of your folder.
   1. In the **Id** field, enter `YC_FOLDER_ID`. Click **OK**.
1. Create another secret with the following parameters:
   1. **Kind**: `Secret text`.
   1. **Scope**: `Global`.
   1. **Secret**: ID of the subnet where the Jenkins VM is hosted.
   1. **ID**: `YC_SUBNET_ID`.
1. Create another secret with the following parameters:
   1. **Kind**: `Secret file`.
   1. **Scope**: `Global`.
   1. **File**: The `<username>.json` file from [step 1](#create-service-account).
   1. **ID**: `YC_ACCOUNT_KEY_FILE`.
1. Go back to the main page of the administration panel and select **New item**.
1. Enter a name for the task, like `jenkins-tutorial`, and select **Pipeline** as the task type. Click **OK**.
1. In the window that opens, select the **GitHub hook trigger for GITScm polling** checkbox. This option lets you run the build every time you `push` to the `master` branch of your git repository.
1. Under **Pipeline**, select `Pipeline script from SCM` from the **Definition** list.
1. In the **SCM** list, select `Git`.
1. In the **Report URL** field, enter the URL of your GitHub fork.
1. In the **Script path** field, enter `jenkins-packer/Jenkinsfile`.
1. Leave the other fields unchanged and click **Save**.

## Configure the GitHub repository {#configure-github-repo}

In the GitHub repository settings, set up a webhook to run builds in Jenkins and add the public SSH key for authorization.

### Set up a webhook {#configure-webhook}

1. Open the fork of your GitHub repository in the browser.
1. Click the **Settings** tab.
1. Select **Webhooks** and click **Add webhook**.
1. In the **Payload URL** field, enter `http://<VM public IP address>/github-webhook/`.
1. Click **Add webhook**.

### Add an SSH key to GitHub {#add-ssh-key}

1. Click your GitHub avatar. In the menu that opens, select **Settings**.
1. Click **SSH and GPG keys**.
1. Click **New SSH key**.
1. In the **Title** field, enter a name for your key.
1. Paste your SSH key into the **Key** box.
1. Click **Add SSH key**.

## Create an image using Jenkins {#create-image}

The image is built in Jenkins automatically after you `push` to the `master` branch of your GitHub repository.

1. Clone the [examples](https://github.com/yandex-cloud/examples) repository fork you created while [getting started](#prepare) to your computer:

   ```
   $ git clone git@github.com:<GitHub login>/examples.git
   ```

1. Make changes to the Packer templates hosted in the `jenkins-packer/packer/` folder. You can find the Packer template documentation on the developer's [website](http://packer.io/docs/templates/index.html). In the `image_family` and `source_image_family` parameters, specify the families of images to be built by Jenkins. For more information about families, see [Image families](../../compute/concepts/images#family).

1. Make changes to the `Jenkinsfile` Pipeline description file for Jenkins located in the root of the repository. For the Pipeline documentation, see the developer's [website](https://jenkins.io/doc/book/pipeline/syntax/).

1. Upload the changes to Github:

   ```
   $ git add -A
   $ git commit -m "Build update"
   $ git push
   ```

1. Open the Jenkins administration panel and check the task status.

1. If all the settings are correct, the image assembly is launched. You can see the result in the build logs.

Then there are three new images in **Compute Cloud** under **Images**:

* `Debian`: The basic image with the latest updates.
* `nginx`: An image with the nginx web server, based on the `Debian` image.
* `Django`: An image with the Django framework, based on the `Debian` image.

## Deploy the images {#deploy-image}

Once the images are created, you can use them to create your virtual machines. Create a test infrastructure using Terraform:

1. In the folder with the fork, go to the directory with the Terraform files:

   ```
   $ cd examples/jenkins-packer/terraform
   ```

1. Rename the `terraform.tfvars_example` file:

   ```
   mv terraform.tfvars_example terraform.tfvars
   ```

1. Fill in the file fields with the applicable values. Read the Terraform documentation on the [developer's website](https://www.terraform.io/docs/configuration/index.html).

1. Initialize the Terraform provider by running `terraform init`.

1. Execute `terraform plan -var-file="terraform.tfvars"`. Check the configuration created.

1. Execute `terraform apply` and confirm that you want to create the infrastructure by entering `yes` in the terminal.

This will create:

1. A cloud network.
1. Subnets in all availability zones.
1. Virtual machines from images created by Packer. Virtual machines with nginx get public IP addresses. All virtual machines are connected to subnets.

### Delete the created resources {#clear-out}

If you no longer need the VMs and images:

* [Delete the created VMs](../../compute/operations/vm-control/vm-delete.md).
* [Delete the created images](../../compute/operations/image-control/delete.md).

To delete the resources created with Terraform, run `terraform destroy`.

