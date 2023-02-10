# Creating a VM and an instance group from a {{ coi }} using {{ TF }}

To use {{ TF }} to create configurations and run a [VM](../../compute/concepts/vm.md) or an [instance group](../../compute/concepts/instance-groups/index.md) from a [{{ coi }}](../concepts/index.md), follow these steps.

## Before you start {#before-begin}

If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform). In this use case, a configuration file named `example.tf` and located in the `~/cloud-terraform` directory is used.

## Creating and running a VM from a {{ coi }} {#creating-vm}

### Create VM configuration files {#create-config-vm}

1. Use a {{ coi }} from the [image family](../../compute/concepts/image.md#family) of {{ yandex-cloud }}. To do this, add the following lines to the `example.tf` configuration file:

   ```
   data "yandex_compute_image" "container-optimized-image" {
     family = "container-optimized-image"
   }
   ```

1. Describe the VM by adding the following lines to the `example.tf` configuration file:

   ```
   resource "yandex_compute_instance" "instance-based-on-coi" {
     boot_disk {
       initialize_params {
         image_id = data.yandex_compute_image.container-optimized-image.id
       }
     }
     network_interface {
       subnet_id = "<subnet ID>"
       nat = true
     }
     resources {
       cores = 2
       memory = 2
     }
     metadata = {
       docker-container-declaration = file("${path.module}/declaration.yaml")
       user-data = file("${path.module}/cloud_config.yaml")
     }
   }
   ```

   Where `subnet_id` is the [subnet](../../vpc/concepts/network.md#subnet) IDs.

1. Create a cloud specification file named `cloud_config.yaml` in the `~/cloud-terraform` directory. Describe the specification:

   ```yaml
   #cloud-config
   ssh_pwauth: no
   users:
     - name: yc-user
       sudo: ALL=(ALL) NOPASSWD:ALL
       shell: /bin/bash
       ssh_authorized_keys:
         - "<public SSH key>"
   ```

   Where `ssh_authorized_keys` is the [public SSH key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

1. Create a specification file {{ coi }} named `declaration.yaml` in the `~/cloud-terraform` directory. Describe the specification:

   ```yaml
   spec:
     containers:
     - image: cr.yandex/yc/demo/coi:v1
       securityContext:
         privileged: false
       stdin: false
       tty: false
   ```

1. Create a file named `output.tf` in the `~/cloud-terraform` directory to output the VM's [public IP address](../../vpc/concepts/address.md#public-addresses):

   ```
   output "external_ip" {
     value = yandex_compute_instance.instance-based-on-coi.network_interface.0.nat_ip_address
   }
   ```

### Create a VM from a {{ coi }} {#create-vm-coi}

Run the VM with a {{ coi }} using the {{ TF }} configuration.

{% list tabs %}

- CLI

  1. Make sure that the configuration files are correct.

     1. In the command line, go to the `~/cloud-terraform` directory with the configuration files:

        ```bash
        cd /Users/<username>/cloud-terraform
        ```

     1. Run the check using the command:

        ```bash
        terraform plan
        ```

        Result:

        ```
        Refreshing Terraform state in-memory prior to plan...
        The refreshed state will be used to calculate this plan, but will not be
        persisted to local or remote state storage.
        ...
        Note: You didn't specify an "-out" parameter to save this plan, so Terraform
        can't guarantee that exactly these actions will be performed if
        "terraform apply" is subsequently run.
        ```

  1. Deploy your resources in {{ yandex-cloud }}.

     1. Run the command:

        ```bash
        terraform apply
        ```

        Result:

        ```bash
        data.yandex_compute_image.container-optimized-image: Refreshing state...

        An execution plan has been generated and is shown below.
        Resource actions are indicated with the following symbols:
        ...
          Terraform will perform the actions described above.
          Only 'yes' will be accepted to approve.

          Enter a value:
        ```

     1. Confirm that you want to create the resources. To do this, type `yes`:

        ```bash
        Enter a value: yes
        ```

        Result:

        ```bash
        yandex_compute_instance.instance-based-on-coi: Creating...
        yandex_compute_instance.instance-based-on-coi: Still creating... [10s elapsed]
        yandex_compute_instance.instance-based-on-coi: Still creating... [20s elapsed]
        ...
        Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

        Outputs:

        external_ip = <public IP address>
        ```

        The necessary resources are created in the folder. When creating a VM, it's assigned a public IP address and [hostname](../../vpc/concepts/address.md#fqdn) (FQDN).

  1. Check the resources and their settings in the [management console]({{ link-console-main }}).

  1. Connect to the VM with the {{ coi }}.

     1. Run the command:

        ```bash
        ssh yc-user@<public IP address>
        ```

        Result:

        ```
        The authenticity of host '<public IP address> (<public IP address>)' can't be established.
        ECDSA key fingerprint is SHA256:JPq...
        Are you sure you want to continue connecting (yes/no/[fingerprint])?
        ```

     1. Confirm connecting to the VM. To do this, type `yes`:

        ```bash
        Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
        ```

        Result:

        ```bash
        Warning: Permanently added '<public IP address>' (ECDSA) to the list of known hosts.
        Welcome to Ubuntu 20.04.1 LTS (GNU/Linux 5.4.0-52-generic x86_64)

         * Documentation:  https://help.ubuntu.com
        ...
        Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
        applicable law.
        ```

  1. Make an HTTP request to the VM:

     ```html
     curl <public IP address>
     ```

     Result:

     ```html
     <!DOCTYPE html>
     <html lang="en">
     <head>
      <meta http-equiv="refresh" content="3">
       <title>Yandex.Scale</title>
     </head>
     <body>
     <h1>Hello v1</h1>
     </body>
     </html>
     ```

{% endlist %}

## Creating and running an instance group with a {{ coi }} {#creating-group}

### Create instance group configuration files {#create-config-group}

1. Save a configuration file named `example.tf` to the `~/cloud-terraform` directory:

   {% if product == "yandex-cloud" %}

   ```hcl
   provider "yandex" {
     token     = "<OAuth token>"
     cloud_id  = "<cloud ID>"
     folder_id = "<folder ID>"
     zone      = "{{ region-id }}-a"
   }
   data "yandex_compute_image" "container-optimized-image" {
     family = "container-optimized-image"
   }
   resource "yandex_compute_instance_group" "ig-with-coi" {
     name = "ig-with-coi"
     folder_id = "<folder ID>"
     service_account_id = "<service account ID>"
     instance_template {
       platform_id = "standard-v3"
       resources {
         memory = 2
         cores  = 2
       }
       boot_disk {
         mode = "READ_WRITE"
         initialize_params {
           image_id = data.yandex_compute_image.container-optimized-image.id
         }
       }
       network_interface {
         network_id = "<network ID>"
         subnet_ids = ["<subnet IDs>"]
         nat = true
       }
       metadata = {
         docker-container-declaration = file("${path.module}/declaration.yaml")
         user-data = file("${path.module}/cloud_config.yaml")
       }
       service_account_id = "<service account ID>"
     }
     scale_policy {
       fixed_scale {
         size = 2
       }
     }
     allocation_policy {
       zones = ["<availability zones>"]
     }
     deploy_policy {
       max_unavailable = 2
       max_creating = 2
       max_expansion = 2
       max_deleting = 2
     }
   }
   ```

   {% endif %}

   {% if product == "cloud-il" %}

   ```
   provider "yandex" {
     endpoint  = "{{ api-host }}:443"
     token     = "<static key of the service account>"
     cloud_id  = "<cloud ID>"
     folder_id = "<folder ID>"
     zone      = "{{ region-id }}-a"
   }
   data "yandex_compute_image" "container-optimized-image" {
     family = "container-optimized-image"
   }
   resource "yandex_compute_instance_group" "ig-with-coi" {
     name = "ig-with-coi"
     folder_id = "<folder ID>"
     service_account_id = "<service account ID>"
     instance_template {
       platform_id = "standard-v3"
       resources {
         memory = 2
         cores  = 2
       }
       boot_disk {
         mode = "READ_WRITE"
         initialize_params {
           image_id = data.yandex_compute_image.container-optimized-image.id
         }
       }
       network_interface {
         network_id = "<network ID>"
         subnet_ids = ["<subnet IDs>"]
         nat = true
       }
       metadata = {
         docker-container-declaration = file("${path.module}/declaration.yaml")
         user-data = file("${path.module}/cloud_config.yaml")
       }
       service_account_id = "<service account ID>"
     }
     scale_policy {
       fixed_scale {
         size = 2
       }
     }
     allocation_policy {
       zones = ["<availability zones>"]
     }
     deploy_policy {
       max_unavailable = 2
       max_creating = 2
       max_expansion = 2
       max_deleting = 2
     }
   }
   ```

   {% endif %}

   Where:

   {% if product == "cloud-il" %}
   * `endpoint`: hostname and port for {{ yandex-cloud }} API requests: `{{ api-host }}:443`.
   {% endif %}
   * `token`: {% if product == "yandex-cloud" %}[OAuth token](../../iam/concepts/authorization/oauth-token.md){% endif %}{% if product == "cloud-il" %}static key (`secret`) of the service account{% endif %} to access {{ yandex-cloud }}.
   * `name`: Name of the instance group.
   * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md).
   * `instance_template.network_interface.network_id`: ID of the [network](../../vpc/concepts/network.md).
   * `instance_template.network_interface.subnet_ids`: List of [subnet](../../vpc/concepts/network.md#subnet) IDs.
   * `instance_template.service_account_id`: ID of the [service account](../../iam/concepts/users/service-accounts.md) authorized for this instance group.
   * `allocation_policy.zones`: List of [availability zones](../../overview/concepts/geo-scope.md).

1. Use the `cloud_config.yaml` and `declaration.yaml` files from the [Create VM configuration files](#create-config-vm) section.

1. Create a file named `output.tf` in the `~/cloud-terraform` directory to output the public IPs of each VM instance in the group:

   ```
   output "external_ip" {
    value = [yandex_compute_instance_group.ig-with-coi.instances[*].network_interface[0].nat_ip_address]
   }
   ```

### Create an instance group from a {{ coi }} {#create-group-coi}

Run the instance group with a {{ coi }} using the {{ TF }} configuration.

{% list tabs %}

- CLI

  1. Make sure that the configuration files are correct.

     1. In the command line, go to the `~/cloud-terraform` directory with the configuration files:

        ```bash
        cd /Users/<username>/cloud-terraform
        ```

     1. Run the check using the command:

        ```bash
        terraform plan
        ```

        Result:

        ```
        Refreshing Terraform state in-memory prior to plan...
        The refreshed state will be used to calculate this plan, but will not be
        persisted to local or remote state storage.
        ...
        Note: You didn't specify an "-out" parameter to save this plan, so Terraform
        can't guarantee that exactly these actions will be performed if
        "terraform apply" is subsequently run.
        ```

  1. Deploy your resources in {{ yandex-cloud }}.

     1. Run the command:

        ```bash
        terraform apply
        ```

        Result:

        ```bash
        data.yandex_compute_image.container-optimized-image: Refreshing state...

        An execution plan has been generated and is shown below.
        Resource actions are indicated with the following symbols:
        ...
          Terraform will perform the actions described above.
          Only 'yes' will be accepted to approve.

          Enter a value:
        ```

     1. Confirm that you want to create the resources. To do this, type `yes`:

        ```bash
        Enter a value: yes
        ```

        Result:

        ```bash
        yandex_compute_instance_group.ig-with-coi: Creating...
        yandex_compute_instance_group.ig-with-coi: Still creating... [10s elapsed]
        yandex_compute_instance_group.ig-with-coi: Still creating... [20s elapsed]
        ...
        external_ip = [
          [
            "<public IP address of VM1>",
            "<public IP address of VM2>",
          ],
        ]
        ```

        The necessary resources are created in the folder. When creating each VM, it's assigned a public IP address and [hostname](../../vpc/concepts/address.md#fqdn) (FQDN).

  1. Check the resources and their settings in the [management console]({{ link-console-main }}).

  1. Connect to one of the VMs with the {{ coi }}.

     1. Run the command:

        ```bash
        ssh yc-user@<public IP address of VM1>
        ```

        Result:

        ```
        The authenticity of host '<public IP address of VM1> (<public IP address of VM1>)' can't be established.
        ECDSA key fingerprint is SHA256:JPq....
        Are you sure you want to continue connecting (yes/no/[fingerprint])?
        ```

     1. Confirm connecting to the VM. To do this, type `yes`:

        ```bash
        Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
        ```

        Result:

        ```bash
        Warning: Permanently added '<public IP address of VM1>' (ECDSA) to the list of known hosts.
        Welcome to Ubuntu 20.04.1 LTS (GNU/Linux 5.4.0-52-generic x86_64)

         * Documentation:  https://help.ubuntu.com
        ...
        Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
        applicable law.
        ```

  1. Make an HTTP request to one of the VM instances in the group:

     ```html
     curl <public IP address of VM1>
     ```

     Result:

     ```html
     <!DOCTYPE html>
     <html lang="en">
     <head>
      <meta http-equiv="refresh" content="3">
       <title>Yandex.Scale</title>
     </head>
     <body>
     <h1>Hello v1</h1>
     </body>
     </html>
     ```

{% endlist %}