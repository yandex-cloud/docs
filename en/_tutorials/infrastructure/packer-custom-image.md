# Building a VM image with infrastructure tools using Packer


In {{ compute-full-name }}, you can create a [VM disk image](../../compute/concepts/image.md) with additional infrastructure tools using [Packer](https://www.packer.io/).

Use Packer to build a VM image based on [Ubuntu Linux 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts), with its parameters specified in a configuration file. Add these tools commonly used with {{ yandex-cloud }}, to the image:
* [{{ yandex-cloud }} CLI](../../cli/quickstart.md) 0.91.0 or higher
* [{{ TF }}](https://www.terraform.io/) 1.1.9
* [kubectl]({{ k8s-docs }}/reference/kubectl/) 1.23
* [Docker](https://docs.docker.com/get-started/overview/) 20.10.16 or higher
* [Git](https://git-scm.com/about) 2.25.1 or higher
* [Helm](https://helm.sh/docs/) 3.9.0
* [jq](https://stedolan.github.io/jq/manual/) 1.6 or higher
* [tree](https://manpages.ubuntu.com/manpages/focal/en/man1/tree.1.html) 1.8.0 or higher
* [gRPCurl](https://github.com/fullstorydev/grpcurl) 1.8.6
* [Pulumi](https://www.pulumi.com/docs/) 3.33.2
* [tmux](https://manpages.ubuntu.com/manpages/focal/man1/tmux.1.html) 3.0a or higher

Using Packer, you will create an auxiliary VM that will have the required software installed on it. Next, you will build an image based on its boot disk. After that, you will delete the auxiliary VM and boot disk.

Follow the same steps to create your own image with all required software.

To build an image and create a VM from it:
1. [Get your cloud ready](#before-begin).
1. [Set up your working environment](#environment-prepare).
1. [Prepare the image configuration](#prepare-image-config).
1. [Build the image](#create-image).
1. [Create a VM from the image](#create-vm).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of building a VM image and creating a VM from it includes:
* Fee for storing built images (see [{{ compute-full-name }} pricing](../../compute/pricing.md#prices-storage)).
* Fee for VM computing resources (see [{{ compute-full-name }} pricing](../../compute/pricing.md#prices-instance-resources)).

## Set up your working environment {#environment-prepare}

1. Install Packer:
    1. Download Packer and install it by following [this guide on the Packer website](https://www.packer.io/intro/getting-started/install.html#precompiled-binaries).

        You can also download Packerfor your platform from [this {{ yandex-cloud }}](https://hashicorp-releases.yandexcloud.net/packer/) mirror.

    1. After the download is complete, add the path to the directory with the executable to the `PATH` variable. To do this, run this command: 

        ```bash
        export PATH=$PATH:<Packer_executable_directory_path>
        ```

        {% note info %}

        {{ yandex-cloud }} requires Packer 1.5 or higher.

        {% endnote %}

1. Configure the [Yandex Compute Builder plugin](https://developer.hashicorp.com/packer/plugins/builders/yandex):

    1. Create a file named `config.pkr.hcl` with these contents:
        
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

1. [Install](../../cli/quickstart.md#install) the {{ yandex-cloud }} CLI and [create](../../cli/quickstart.md#initialize) a profile.
1. Get the info on the available subnets and availability zones. If you do not have any subnets, [create](../../vpc/operations/subnet-create.md) one.

    {% list tabs group=instructions %}

    - CLI {#cli}
  
      * Run this command:

        ```bash
        yc vpc subnet list
        ```

        Result:

        ```text
        +----------------------+----------------------+----------------------+----------------+---------------+-----------------+
        |          ID          |         NAME         |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |      RANGE      |
        +----------------------+----------------------+----------------------+----------------+---------------+-----------------+
        | b0c29k6anelk******** | intro2-{{ region-id }}-d | enp45glgitd6******** |                | {{ region-id }}-d | [10.130.0.0/24] |
        | e2ltcj4urgpb******** | intro2-{{ region-id }}-b | enp45glgitd6******** |                | {{ region-id }}-b | [10.129.0.0/24] |
        | e9bn57jvjnbu******** | intro2-{{ region-id }}-a | enp45glgitd6******** |                | {{ region-id }}-a | [10.128.0.0/24] |
        +----------------------+----------------------+----------------------+----------------+---------------+-----------------+
        ```

      * From the `ID` column, save the ID of the [subnet](../../vpc/concepts/network.md#subnet) that will host the auxiliary VM for creating the image; from the `ZONE` column, save the appropriate [availability zone](../../overview/concepts/geo-scope.md). You will need these parameters later on.

    - API {#api}
    
      Use the [list](../../vpc/api-ref/Subnet/list.md) REST API method for the [Subnet](../../vpc/api-ref/Subnet/index.md) resource or the [SubnetService/List](../../vpc/api-ref/grpc/Subnet/list.md) gRPC API call.

    {% endlist %}

1. Specify the values of the variables required for building the image in the command line.

    ```bash
    export YC_FOLDER_ID=$(yc config get folder-id)
    export YC_ZONE="<availability_zone>"
    export YC_SUBNET_ID="<subnet_ID>"
    export YC_TOKEN=$(yc iam create-token)
    ```

    Where:

    * `YC_FOLDER_ID`: ID of the folder with the auxiliary VM used for creating the image. Its value gets populated automatically.
    * `YC_ZONE`: Availability zone that will host the auxiliary VM used for creating the image and that you got earlier.
    * `YC_SUBNET_ID`: ID of the subnet that will host the auxiliary VM used for creating the image and that you got earlier.
    * `YC_TOKEN`: [IAM token](../../iam/concepts/authorization/iam-token.md) required for creating VM images; it also gets populated automatically.
1. [Generate](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) an SSH key pair. You will need these keys to create a VM and connect to it.

## Prepare the image configuration {#prepare-image-config}

1. Create an [HCL](https://github.com/hashicorp/hcl#readme) configuration file, such as `toolbox.pkr.hcl`.
1. In the configuration file, describe the image parameters:

    
    ```hcl
    # {{ yandex-cloud }} Toolbox VM Image based on Ubuntu 20.04 LTS
    #
    # Provisioner docs:
    # https://www.packer.io/docs/builders/yandex
    #

    variable "YC_FOLDER_ID" {
      type = string
      default = env("YC_FOLDER_ID")
    }

    variable "YC_ZONE" {
      type = string
      default = env("YC_ZONE")
    }

    variable "YC_SUBNET_ID" {
      type = string
      default = env("YC_SUBNET_ID")
    }

    variable "TF_VER" {
      type = string
      default = "1.1.9"
    }

    variable "KCTL_VER" {
      type = string
      default = "1.23.0"
    }

    variable "HELM_VER" {
      type = string
      default = "3.9.0"
    }

    variable "GRPCURL_VER" {
      type = string
      default = "1.8.6"
    }

    variable "GOLANG_VER" {
      type = string
      default = "1.17.2"
    }

    variable "PULUMI_VER" {
      type = string
      default = "3.33.2"
    }

    source "yandex" "yc-toolbox" {
      folder_id           = "${var.YC_FOLDER_ID}"
      source_image_family = "ubuntu-2004-lts"
      ssh_username        = "ubuntu"
      use_ipv4_nat        = "true"
      image_description   = "{{ yandex-cloud }} Ubuntu Toolbox image"
      image_family        = "my-images"
      image_name          = "yc-toolbox"
      subnet_id           = "${var.YC_SUBNET_ID}"
      disk_type           = "network-hdd"
      zone                = "${var.YC_ZONE}"
    }

    build {
      sources = ["source.yandex.yc-toolbox"]
 
      provisioner "shell" {
        inline = [
          # Global Ubuntu things
          "sudo apt-get update",
          "echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections",
          "sudo apt-get install -y unzip python3-pip python3.8-venv",

          # {{ yandex-cloud }} CLI tool
          "curl --silent --remote-name https://{{ s3-storage-host-cli }}{{ yc-install-path }}",
          "chmod u+x install.sh",
          "sudo ./install.sh -a -i /usr/local/ 2>/dev/null",
          "rm -rf install.sh",
          "sudo sed -i '$ a source /usr/local/completion.bash.inc' /etc/profile",
      
          # Docker
          "curl --fail --silent --show-error --location https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-keyring.gpg",
          "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
          "sudo apt-get update",
          "sudo apt-get install -y docker-ce containerd.io",
          "sudo usermod -aG docker $USER",
          "sudo chmod 666 /var/run/docker.sock",
          "sudo useradd -m -s /bin/bash -G docker yc-user",

          # Docker Artifacts
          "docker pull hello-world",
          "docker pull -q amazon/aws-cli",
          "docker pull -q golang:${var.GOLANG_VER}",

          # Terraform (classic way)
          #"curl --fail --silent --show-error --location https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-keyring.gpg",
          #"echo \"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main\" | sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null",
          #"sudo apt-get update",
          #"sudo apt-get install -y terraform",
          #
          # Alternative Option
          "curl --silent --location {{ terraform-mirror }}${var.TF_VER}/terraform_${var.TF_VER}_linux_amd64.zip --output terraform.zip",
          "unzip terraform.zip",
          "sudo install -o root -g root -m 0755 terraform /usr/local/bin/terraform",
          "rm -rf terraform terraform.zip",
          # Terraform configuration file ?
          #"cat <<EOF > ~/.terraformrc \n provider_installation { network_mirror { url = \"https://terraform-mirror.yandexcloud.net/\" include = [\"registry.terraform.io/*/*\"] } direct { exclude = [\"registry.terraform.io/*/*\"] } } \n EOF",

          # kubectl
          "curl --silent --location --remote-name https://dl.k8s.io/release/v${var.KCTL_VER}/bin/linux/amd64/kubectl",
          "sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl",
          "rm -rf kubectl",

          # Helm
          "curl --silent --show-error --location --remote-name https://get.helm.sh/helm-v${var.HELM_VER}-linux-amd64.tar.gz",
          "tar zxf helm-v${var.HELM_VER}-linux-amd64.tar.gz",
          "sudo install -o root -g root -m 0755 linux-amd64/helm /usr/local/bin/helm",
          "rm -rf helm-v${var.HELM_VER}-linux-amd64.tar.gz",
          "rm -rf linux-amd64",
          # User can add own repo after login like this:
          # helm repo add stable https://charts.helm.sh/stable

          ## grpccurl
          "curl --silent --show-error --location --remote-name https://github.com/fullstorydev/grpcurl/releases/download/v${var.GRPCURL_VER}/grpcurl_${var.GRPCURL_VER}_linux_x86_64.tar.gz",
          "tar zxf grpcurl_${var.GRPCURL_VER}_linux_x86_64.tar.gz",
          "sudo install -o root -g root -m 0755 grpcurl /usr/local/bin/grpcurl",
          "rm -rf grpcurl_${var.GRPCURL_VER}_linux_x86_64.tar.gz",
          "rm -rf grpcurl",

          # Pulumi
          "curl --silent --show-error --location --remote-name https://get.pulumi.com/releases/sdk/pulumi-v${var.PULUMI_VER}-linux-x64.tar.gz",
          "tar zxf pulumi-v${var.PULUMI_VER}-linux-x64.tar.gz",
          "sudo cp pulumi/* /usr/local/bin/",
          "rm -rf pulumi-v${var.PULUMI_VER}-linux-x64.tar.gz",
          "rm -rf pulumi",

          # Other packages
          "sudo apt-get install -y git jq tree tmux",

          # Clean
          "rm -rf .sudo_as_admin_successful",

          # Test - Check versions for installed components
          "echo '=== Tests Start ==='",
          "yc version",
          "terraform version",
          "docker version",
          "kubectl version --client=true",
          "helm version",
          "grpcurl --version",
          "git --version",
          "jq --version",
          "tree --version",
          "pulumi version",
          "echo '=== Tests End ==='"
        ]
      }
    }
    ```




{% include [warning-provisioner-metadata](../../_includes/tutorials/infrastructure-management/warning-provisioner-metadata.md) %}

## Build the image {#create-image}

1. In the command line, navigate to the configuration file directory.

    ```bash
    cd <path_to_configuration_file_directory>
    ```

1. Make sure the image configuration file is correct using this command:

    ```bash
    packer validate yc-toolbox.pkr.hcl
    ```

    Where `yc-toolbox.pkr.hcl` is the configuration file name.

    If the configuration is correct, you will get this message:
     
    ```bash
    The configuration is valid.
    ```

1. Build the image with the command:

    ```bash
    packer build yc-toolbox.pkr.hcl
    ```

    Where `yc-toolbox.pkr.hcl` is the configuration file name.
1. After the image is built, you will get a notification message:

    ```bash
    ...
    ==> Builds finished. The artifacts of successful builds are:
    --> yandex.yc-toolbox: A disk image was created: yc-toolbox (id: fd83j475posv********) with family name infra-images
    ```

    Save the ID of the image you built (`id`). Use this ID to create a VM later.

1. Make sure you can see the image you built {{ yandex-cloud }}.

    {% list tabs group=instructions %}

    - CLI {#cli}
  
      Run this command:

      ```bash
      yc compute image list
      ```

      Result:

      ```text
      +----------------------+------------+-----------+----------------------+--------+
      |          ID          |    NAME    |  FAMILY   |     PRODUCT IDS      | STATUS |
      +----------------------+------------+-----------+----------------------+--------+
      | fd83j475posv******** | yc-toolbox | my-images | f2ek1vhoppg2******** | READY  |
      +----------------------+------------+-----------+----------------------+--------+
      ```

    - API {#api}

      Use the [list](../../compute/api-ref/Image/list.md) REST API method for the [Image](../../compute/api-ref/Image/) resource or the [ImageService/List](../../compute/api-ref/grpc/Image/list.md) gRPC API call.

    {% endlist %}

## Create a VM from the image {#create-vm}
  
1. Specify the values of the variables required for creating your VM. To do this, run this command:

    ```bash
    export VM_NAME="<VM_name>"
    export YC_IMAGE_ID="<image_ID>"
    export YC_SUBNET_ID="<subnet_ID>"
    export YC_ZONE="<availability_zone>"
    ```

    Where:

    * `VM_NAME`: Name of the new VM.
    * `YC_IMAGE_ID`: ID of the image to create the VM from. You got this ID earlier.
    * `YC_SUBNET_ID`: ID of the subnet to host the VM. You got this ID earlier.
    * `YC_ZONE`: Availability zone for the VM that you got earlier.

1. Create your VM from the image you built.

    {% list tabs group=instructions %}

    - CLI {#cli}

      Run this command:

      ```bash
      yc compute instance create \
        --name $VM_NAME \
        --hostname $VM_NAME \
        --zone=$YC_ZONE \
        --create-boot-disk size=20GB,image-id=$YC_IMAGE_ID \
        --cores=2 \
        --memory=8G \
        --core-fraction=100 \
        --network-interface subnet-id=$YC_SUBNET_ID,ipv4-address=auto,nat-ip-version=ipv4 \
        --ssh-key <path_to_public_part_of_SSH_key>
      ```

      Where:

      * `--name`: Name of the new VM.
      * `--hostname`: VM host name.
      * `--zone`: Availability zone.
      * `--create-boot-disk`: Boot disk properties: `size` stands for size, and `image-id`, for the ID of the image being used.
      * `--cores`: Number of vCPUs.
      * `--memory`: Amount of RAM.
      * `--core-fraction`: Basic vCPU performance in percentage.
      * `--network-interface`: Network interface proterties, where `subnet-id` is the subnet ID, `ipv4-address`, the internal IPv4 address, and `nat-ip-version`, the IP specification for the egress NAT.
      * `--ssh-key`: Public part of the SSH key.

      The command outputs info on the VM you created. Save the VM's public IP address:

      ```bash
      ...
      one_to_one_nat:
        address: 62.84.122.151
      ...
      ```

      Learn more about [creating a VM from a custom image](../../compute/operations/vm-create/create-from-user-image.md).

    - API {#api}

      Use the [create](../../compute/api-ref/Instance/create.md) REST API method for the [Instance](../../compute/api-ref/Instance/) resource or the [InstanceService/Create](../../compute/api-ref/grpc/Instance/create.md) gRPC API call.

    {% endlist %}

1. Connect to the VM over SSH:

    ```bash
    ssh -i <path_to_private_part_of_SSH_key> yc-user@<VM_public_IP_address>
    ```

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
* [Delete the VM](../../compute/operations/vm-control/vm-delete.md).
* [Delete the image](../../compute/operations/image-control/delete.md).