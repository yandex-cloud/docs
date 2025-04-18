# Automating image builds using Jenkins and Packer

Based on the specified configuration, [Packer](https://www.packer.io/) creates [VM disk images](../../compute/concepts/image.md) in [{{ compute-full-name }}](../../compute/). [Jenkins](https://www.jenkins.io/) enables continuous integration (CI).

You can use images to create a cloud infrastructure using such IaC tools as [{{ TF }}](https://www.terraform.io/language#about-the-terraform-language).

To install and configure Jenkins, Packer, GitHub, and {{ TF }} to work together:
1. [Get your cloud ready](#before-you-begin).
1. [Configure the environment](#prepare).
1. [Create a service account](#create-service-account).
1. [Create a Jenkins VM](#create-jenkins-vm).
1. [Install Packer to your VM](#install-packer).
1. [Configure Jenkins](#configure-jenkins).
1. [Set up a Jenkins task](#jenkins-job).
1. [Configure the GitHub repository](#configure-github-repo).
1. [Create an image using Jenkins](#create-image).
1. [Deploy the images using {{ TF }}](#deploy-image).

If you no longer need the VM or the cluster you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support costs include:
* Fee for continuously running VMs (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Fee for storing created images (see [{{ compute-name }} pricing](../../compute/pricing#prices-storage)).
* Fee for using a dynamic [public IP address](../../vpc/concepts/address.md#public-addresses) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Configure the environment {#prepare}

Set up the software:
* [Install](../../cli/operations/install-cli.md) the {{ yandex-cloud }} command line interface.
* [Install](https://www.terraform.io/downloads) {{ TF }}. See also: [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md).
* [Download](https://stedolan.github.io/jq/download/) the `jq` utility.
* [Configure](https://gitforwindows.org) Git. If you are running Windows, use Git Bash.
* [Create](https://github.com/yandex-cloud-examples/yc-marketplace-vm-image-packer) a repository branch with examples in your GitHub account.
* [Prepare](../../compute/operations/vm-connect/ssh.md) an SSH key for VM access.

## Create a service account {#create-service-account}

Jenkins uses [service accounts](../../iam/concepts/users/service-accounts.md) to perform actions in your [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). To [create a service account](../../iam/operations/sa/create.md):
1. Get the folder and cloud IDs by running `yc config list`.
1. Create a service account and provide its ID to the environment variable using these commands:

   ```bash
   yc iam service-account create --name <username>
   yc iam key create --service-account-name <username> -o <username.json>
   SERVICE_ACCOUNT_ID=$(yc iam service-account get --name <username> --format json | jq -r .id)
   ```

   This will create a JSON file containing login credentials in the current folder.
1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the service account the `admin` [role](../../iam/concepts/access-control/roles.md) for the folder where the operations will be performed:

   ```bash
   yc resource-manager folder add-access-binding <folder_name> --role admin --subject serviceAccount:$SERVICE_ACCOUNT_ID
   ```

## Create a Jenkins VM {#create-jenkins-vm}

Jenkins will get VM image configuration changes from GitHub and then use Packer to create images in the cloud.

To create a VM:

1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your VM.
1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab, click **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**, and select the [Jenkins](/marketplace/products/yc/jenkins) image.

    {% note info %}

    To configure the Jenkins VM manually, follow [this guide](https://www.jenkins.io/doc/book/installing/linux/).

    {% endnote %}

1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../overview/concepts/geo-scope.md) where your VM will reside.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, enter `15 {{ ui-key.yacloud.common.units.label_gigabyte }}` as your boot [disk](../../compute/concepts/disk.md) size.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}** tab and specify the parameters as follows:

    * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`
    * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
    * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `20%`
    * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `2 {{ ui-key.yacloud.common.units.label_gigabyte }}`

1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

    * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, enter the ID of a subnet in the new VM’s availability zone. Alternatively, select a [cloud network](../../vpc/concepts/network.md#network) from the list.

        * Each network must have at least one [subnet](../../vpc/concepts/network.md#subnet). If there is no subnet, create one by selecting **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.
        * If you do not have a network, click **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** to create one:

            * In the window that opens, specify the network name and select the folder to host the network.
            * Optionally, enable the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** setting to automatically create subnets in all availability zones.
            * Click **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

    * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` to assign a random external IP address from the {{ yandex-cloud }} pool to the VM. Alternatively, select a static address from the list if you reserved one.

1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

    * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter a name for the user you want to create on the VM, e.g., `yc-user`.

        {% note alert %}

        Do not use `root` or other reserved usernames. To perform operations requiring root privileges, use the `sudo` command.

        {% endnote %}

    * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `jenkins-tutorial`.
1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

## Install Packer {#install-packer}

Packer enables you to create VM disk images with parameters specified in a configuration file.

{% note info %}

{{ yandex-cloud }} requires Packer 1.5 or higher.

{% endnote %}

1. Download a [Packer](https://packer.io/downloads) distribution kit for Linux. You can also download a Packer distribution kit for your platform from [here](https://hashicorp-releases.yandexcloud.net/packer/).
1. Upload Packer to the VM you created:

   ```bash
   scp packer_<Packer_version>_linux_amd64.zip <login>@<VM_public_IP_address>:~/
   ```

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH. To do this, use `ssh` in Linux or macOS, or `PuTTY` in Windows.
1. Create a new folder, move the Packer executables there, and unpack the archive:

   ```bash
   sudo mkdir /opt/yandex-packer/
   sudo mv packer_<Packer_version>_linux_amd64.zip /opt/yandex-packer/
   unzip packer_<Packer_version>_linux_amd64.zip
   ```

1. Configure the [Yandex Compute Builder plugin](https://developer.hashicorp.com/packer/plugins/builders/yandex):

    1. Create a file named `config.pkr.hcl` in the `/opt/yandex-packer/` directory with the following contents:
        
        ```hcl
        packer {
          required_plugins {
            yandex = {
              version = ">= 1.1.2"
              source  = "{{ packer-source-link }}"
            }
          }
        }
        ```

    1. Install the plugin:

        ```bash
        packer init <path_to_config.pkr.hcl>
        ```

        Result:

        ```text
        Installed plugin github.com/hashicorp/yandex v1.1.2 in ...
        ```

1. Jenkins will run all its actions on behalf of the`jenkins` user. This is why you need to grant this user the permissions to launch Packer:

   ```bash
   sudo chmod u+x /opt/yandex-packer/packer*
   sudo chown jenkins:jenkins /opt/yandex-packer/packer*
   ```

## Configure Jenkins {#configure-jenkins}

To build images based on configurations from GitHub, configure Jenkins:
1. Connect to the VM over SSH using `ssh` in Linux or macOS or `PuTTY` in Windows.
1. Open the password file required to launch the configuration and copy the password:

   ```bash
   sudo cat /var/lib/jenkins/secrets/initialAdminPassword
   ```

1. In your browser, go to `http://<public_IP_address_of_VM_with_Jenkins>`. Open the Jenkins management console.
1. Enter the password you copied in the **Administrator password** field and click **Continue**.
1. Choose **Select plugins to install**.

   You will need the following plugins:
   * `Pipeline`: Plugin that retrieves source code from the version control system to build, test, and deploy the code.
   * `Git`: Plugin for working with Git repositories.
   * `Credentials Binding`: Plugin for creating environment variables with authentication data.
1. Click **Install**. This will start the installation of the components you selected.
1. After the installation is complete, you will be prompted to create an administrator account. Fill in the form and click **Save and Continue**.
1. You will be prompted to create a URL for Jenkins. Leave this URL format: `http://<VM_public_IP_address>/`. Click **Save and finish**.
1. Click **Start using Jenkins** to complete the installation and go to the Jenkins administration panel.

## Set up a Jenkins task {#jenkins-job}

Enter your {{ yandex-cloud }} credentials and create a task to download changes from the GitHub repository so that Jenkins can build images. These credentials will be used in the variables stored in the Packer configuration files.
1. Open the Jenkins administration panel.
1. In the top-right corner, click the username.
1. Select **Credentials**.
1. Under **Stores scoped to Jenkins**, click the `Global` link.
1. Get the ID of the subnet where the images will be built by running the `yc vpc subnet list` command.
1. Click **Add credentials**. Specify the following parameters:
   1. From the **Kind** list, select `Secret text`.
   1. In the **Scope** list, leave `Global`.
   1. In the **Secret** field, enter the ID of your folder.
   1. In the **Id** field, specify `YC_FOLDER_ID`. Click **OK**.
1. Create another secret with these parameters:
   1. **Kind**: `Secret text`.
   1. **Scope**: `Global`.
   1. **Secret**: ID of the subnet where the Jenkins VM is hosted.
   1. **ID**: `YC_SUBNET_ID`.
1. Create another secret with these parameters:
   1. **Kind**: `Secret file`.
   1. **Scope**: `Global`.
   1. **File**: File named `<username>.json` from [Step 1](#create-service-account).
   1. **ID**: `YC_ACCOUNT_KEY_FILE`.
1. Go back to the main page of the administration panel and select **New item**.
1. Enter a name for the task: `jenkins-tutorial`; select **Pipeline** as the task type. Click **OK**.
1. In the window that opens, check the **GitHub hook trigger for GITScm polling** box. This option allows you to run the build every time you `push`something to the `master` branch of your Git repository.
1. Under **Pipeline**, select `Pipeline script from SCM` from the **Definition** list.
1. From the **SCM** list, select `Git`.
1. In the **Report URL** field, enter the URL of your GitHub fork.
1. In the **Script path** field, enter `Jenkinsfile`.
1. Leave other fields unchanged and click **Save**.

## Configure the GitHub repository {#configure-github-repo}

In the GitHub repository settings, enable a webhook to initiate a Jenkins build and add the public SSH key for authorization.

### Enable a webhook {#configure-webhook}

1. In your browser, open the fork of your GitHub repository.
1. Click the **Settings** tab.
1. Select **Webhooks** and click **Add webhook**.
1. In the **Payload URL** field, enter `http://<VM_public_IP_address>/github-webhook/`.
1. Click **Add webhook**.

### Add an SSH key to GitHub {#add-ssh-key}

1. Click your GitHub avatar. In the menu that opens, select **Settings**.
1. Click **SSH and GPG keys**.
1. Click **New SSH key**.
1. In the **Title** field, enter a name for your key.
1. Paste your SSH key into the **Key** box.
1. Click **Add SSH key**.

## Create an image using Jenkins {#create-image}

Jenkins launches an image build automatically after you run `push` in the `master` branch of your GitHub repository.
1. Clone the [examples](https://github.com/yandex-cloud-examples/yc-marketplace-vm-image-packer) repository fork you created when [getting started](#before-you-begin) to your computer:

   ```bash
   git clone https://github.com/<GitHub_login>/yc-marketplace-vm-image-packer.git
   ```

1. Modify the Packer templates in the `packer` directory. You can find articles and guides regarding Packer templates on the [Packer website](http://packer.io/docs/templates/index.html). In the `image_family` and `source_image_family` parameters, specify the [image families](../../compute/concepts/image#family) for Jenkins to build.
1. Modify the Pipeline for `Jenkinsfile` located in the repository root directory. For the Pipeline user handbook, see the [Packer website](https://jenkins.io/doc/book/pipeline/syntax/).
1. Upload the changes to GitHub:

   ```bash
   git add -A
   git commit -m "Build update"
   git push
   ```

1. Open the Jenkins administration panel and check the task status.
1. If the configuration is correct, the system will start building images. You can see the result in the build logs.

{% note info %}

When configuring a Jenkins task under **GitHub Hook log**, you may encounter a `Polling has not run yet` error. In this case, run the first build manually.

{% endnote %}

As a result, three new images will appear in **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** under **{{ ui-key.yacloud.compute.switch_images }}**:
* `Debian`: Basic image with the latest updates.
* `Nginx`: `Debian`-based image with an nginx web server.
* `Django`: `Debian`-based image with the Django framework.

## Deploy the images {#deploy-image}

Once the images have been created, you can use them to create your VMs. Create a test infrastructure using {{ TF }}:
1. In the fork directory, go to the {{ TF }} files directory:

   ```bash
   cd examples/jenkins-packer/terraform
   ```

1. Rename the `terraform.tfvars_example` file:

   ```bash
   mv terraform.tfvars_example terraform.tfvars
   ```

1. Provide the required values in the file fields. See also the [{{ TF }}](https://www.terraform.io/language#about-the-terraform-language) and [{{ yandex-cloud }}]({{ tf-provider-link }}) overview articles.
1. Initialize the {{ TF }} provider by running `terraform init`.
1. Run the `terraform plan -var-file="terraform.tfvars"` command. Check the configuration you created.
1. Run `terraform apply` and confirm that you want to create the infrastructure by typing `yes` into the terminal prompt.

This will create:
1. [Cloud network](../../vpc/concepts/network.md#network).
1. Subnets in all availability zones.
1. VMs from the images created by Packer. VMs with nginx will get public IP addresses. All VMs will be connected to subnets.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:
* [Delete the VMs you created](../../compute/operations/vm-control/vm-delete.md).
* [Delete the images you created](../../compute/operations/image-control/delete.md).
* [Delete the service account](../../iam/operations/sa/delete.md) and the `<username.json>` file.
* [Delete the network and the subnets](../../vpc/operations/network-delete.md).

To delete the resources created with {{ TF }}, run `terraform destroy`.