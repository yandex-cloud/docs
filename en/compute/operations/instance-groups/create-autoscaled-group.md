# Creating an automatically scaled instance group

{% if product == "cloud-il" %}

{% include [one-az-disclaimer](../../../_includes/overview/one-az-disclaimer.md) %}

{% endif %}

You can create an automatically scaled group of identical instances. The size of this group will be managed automatically. For more information, see [{#T}](../../concepts/instance-groups/scale.md#auto-scale).

{% include [warning.md](../../../_includes/instance-groups/warning.md) %}

{% include [sa.md](../../../_includes/instance-groups/sa.md) %}

To create an automatically scaled instance group

{% list tabs %}

- Management console

   {% include [create-autoscaled-group-via-concole.md](../../../_includes/instance-groups/create-autoscaled-group-via-concole.md) %}

- CLI

   {% include [cli-install.md](../../../_includes/cli-install.md) %}

   {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

   1. View a description of the create instance group command in the CLI:

      ```
      {{ yc-compute-ig }} create --help
      ```

   1. Check whether there are networks in the folder:

      ```
      yc vpc network list
      ```

      If there aren't any, [create one](../../../vpc/operations/network-create.md).

   1. Select one of the [public images](../images-with-pre-installed-software/get-list.md) from {{ marketplace-name }} (for example, [CentOS 7](/marketplace/products/yc/centos-7)).

      {% include [standard-images.md](../../../_includes/standard-images.md) %}

     {% if product == "cloud-il" %}

     {% include [windows-trial](../../../_includes/compute/windows-trial.md) %}

     {% endif %}

   1. Create a YAML file with any name (for example, `specification.yaml`).

   1. In the created file, indicate the following:

      * General information about the group:

         ```
         name: first-autoscaled-group
         service_account_id: <ID>
         description: "This instance group was created from YAML config."
         ```

         Where:

         | Key | Value |
         ----- | -----
         | `name` | A name for the instance group. The name must be unique within the folder. The name may contain lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character can't be a hyphen. The maximum length of the name is 63 characters. |
         | `service_account_id` | ID of the service account. |
         | `description` | A description of the instance group. |

      * An [instance template](../../concepts/instance-groups/instance-template.md), such as:

         ```
         instance_template:
             platform_id: standard-v3
             resources_spec:
                 memory: 2g
                 cores: 2
             boot_disk_spec:
                 mode: READ_WRITE
                 disk_spec:
                     image_id: fdvk34al8k5nltb58shr
                     type_id: network-hdd
                     size: 32g
             network_interface_specs:
                 - network_id: c64mknqgnd8avp6edhbt
                   primary_v4_address_spec: {}
             scheduling_policy:
                 preemptible: false
         ```

         {% include [default-unit-size](../../../_includes/instance-groups/default-unit-size.md) %}

         Where (the table contains the keys that directly define the instance parameters):

         | Key | Value |
         ----- | -----
         | `platform_id` | Platform ID. |
         | `memory` | Amount of memory (RAM). |
         | `cores` | Number of processor cores (vCPUs). |
         | `mode` | Disk access mode.</br>– `READ_ONLY`: Read access.</br>– `READ_WRITE`: Read and write access. |
         | `image_id` | ID of the public image. |
         | `type_id` | Disk type. |
         | `size` | Disk size. |
         | `network_id` | The `default-net` ID. |
         | `primary_v4_address_spec` | IPv4 specification. You can allow public access to group instances by specifying the IP version for the public IP address. For more information, see [{#T}](../../concepts/instance-groups/instance-template.md#instance-template). |
         | `scheduling_policy` | Scheduling policy configuration. |
         | `preemptible` | A flag that enables the creation of [preemptible instances](../../concepts/preemptible-vm.md). If the value is `true`, a preemptible instance is created, if `false` (default), a regular instance is created.<br>When creating a preemptible instance group, keep in mind that the instances will terminate after 24 hours of continuous operation or earlier. It's possible that {{ ig-name }} won't be able to restart them immediately due to insufficient resources. This may occur in the event of a drastic increase in {{ yandex-cloud }} computing resource utilization. |
      * [Policies](../../concepts/instance-groups/policies/index.md):

         ```
         deploy_policy:
             max_unavailable: 1
             max_expansion: 0
         scale_policy:
             auto_scale:
                 initial_size: 5
                 max_size: 15
                 min_zone_size: 3
                 measurement_duration: 30s
                 warmup_duration: 60s
                 stabilization_duration: 120s
                 cpu_utilization_rule: 0.75
         allocation_policy:
             zones:
                 - zone_id: {{ region-id }}-a
         ```

         Where:

         | Key | Value |
         ----- | -----
         | `deploy_policy` | [Deployment policy](../../concepts/instance-groups/policies/deploy-policy.md) for instances in the group. |
         | `scale_policy` | [Scaling policy](../../concepts/instance-groups/policies/scale-policy.md) for instances in the group. |
         | `allocation_policy` | [Policy for allocating](../../concepts/instance-groups/policies/allocation-policy.md) instances across zones and regions. |

         Full code for the `specification.yaml` file:

         ```
         name: first-autoscaled-group
         service_account_id: ajed6ilf11qg839dcl1e
         description: "This instance group was created from YAML config."
         instance_template:
             platform_id: standard-v3
             resources_spec:
                 memory: 2g
                 cores: 2
             boot_disk_spec:
                 mode: READ_WRITE
                 disk_spec:
                     image_id: fdvk34al8k5nltb58shr
                     type_id: network-hdd
                     size: 32g
             network_interface_specs:
                 - network_id: c64mknqgnd8avp6edhbt
                   primary_v4_address_spec: {}
         deploy_policy:
             max_unavailable: 1
             max_expansion: 0
         scale_policy:
             auto_scale:
                 initial_size: 5
                 max_size: 15
                 min_zone_size: 3
                 measurement_duration: 30s
                 warmup_duration: 60s
                 stabilization_duration: 120s
                 cpu_utilization_rule:
                     utilization_target: 75
         allocation_policy:
             zones:
                 - zone_id: {{ region-id }}-a
         ```

   1. Create an instance group in the default folder:

      ```
      {{ yc-compute-ig }} create --file specification.yaml
      ```

      This command creates an automatically scaled instance group with the following characteristics:

      * Named `first-autoscaled-group`.
      * Running CentOS 7.
      * In the `default-net` network.
      * In the `{{ region-id }}-a` availability zone.
      * With 2 vCPUs and 2 GB of RAM.
      * With a 32 GB network HDD.

- API

   Use the API [Create](../../api-ref/InstanceGroup/create.md) method.

- {{ TF }}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file, describe the parameters of resources that you want to create:

      ```
      resource "yandex_iam_service_account" "ig-sa" {
        name        = "ig-sa"
        description = "service account to manage IG"
      }
      
      resource "yandex_resourcemanager_folder_iam_binding" "editor" {
        folder_id = "<folder ID>"
        role      = "editor"
        members   = [
          "serviceAccount:${yandex_iam_service_account.ig-sa.id}",
        ]
      }
      
      resource "yandex_compute_instance_group" "ig-1" {
        name               = "autoscaled-ig"
        folder_id          = "<folder ID>"
        service_account_id = "${yandex_iam_service_account.ig-sa.id}"
        instance_template {
          platform_id = "standard-v3"
          resources {
            memory = <RAM amount in GB>
            cores  = <number of vCPU cores>
          }
      
          boot_disk {
            mode = "READ_WRITE"
            initialize_params {
              image_id = "<image ID>"
            }
          }
      
          network_interface {
            network_id = "${yandex_vpc_network.network-1.id}"
            subnet_ids = ["${yandex_vpc_subnet.subnet-1.id}"]
          }
      
          metadata = {
            ssh-keys = "<username>:<SSH key content>"
          }
        }
      
        scale_policy {
          auto_scale {
            initial_size           = 3
            measurement_duration   = 60
            cpu_utilization_target = 75
            min_zone_size          = 3
            max_size               = 15
            warmup_duration        = 60
            stabilization_duration = 120
          }
        }
      
        allocation_policy {
          zones = ["{{ region-id }}-a"]
        }
      
        deploy_policy {
          max_unavailable = 1
          max_expansion   = 0
        }
      }
      
      resource "yandex_vpc_network" "network-1" {
        name = "network1"
      }
      
      resource "yandex_vpc_subnet" "subnet-1" {
        name           = "subnet1"
        zone           = "{{ region-id }}-a"
        network_id     = "${yandex_vpc_network.network-1.id}"
        v4_cidr_blocks = ["192.168.10.0/24"]
      }
      ```

      Where:

      * `yandex_iam_service_account`: Description of a [service account](../../../iam/concepts/users/service-accounts.md). All operations in {{ ig-name }} are performed on behalf of the service account.
      * `yandex_resourcemanager_folder_iam_binding`: Description of access rights to the folder that the service account belongs to. To be able to create, update, and delete group instances, assign the `editor` [role](../../../iam/concepts/access-control/roles.md) to the service account.
      * `yandex_compute_instance_group`: Description of an [instance group](../../concepts/index.md):

         * General information about the group:

            | Field | Description |
            ----- | -----
            | `name` | Name of the instance group. |
            | `folder_id` | Folder ID. |
            | `service_account_id` | ID of the service account. |

         * [The instance template](../../concepts/instance-groups/instance-template.md):

            | Field | Description |
            ----- | -----
            | `platform_id` | [Platform](../../concepts/vm-platforms.md). |
            | `resources` | The number of vCPU cores and the amount of RAM available to the instance. The values must match the selected [platform](../../concepts/vm-platforms.md). |
            | `boot_disk` | Boot disk settings. Enter: </br> - The selected image ID. You can get the image ID from the [list of public images](../images-with-pre-installed-software/get-list.md). </br> Disk access mode: `READ_ONLY` (read) or `READ_WRITE` (read and write). |
            | `network_interface` | Network configuration. Specify the network ID and subnet ID. |
            | `metadata` | In the metadata, pass the public key for accessing the instance via SSH. For more information, see [{#T}](../../concepts/vm-metadata.md). |

           {% if product == "cloud-il" %}

           {% include [windows-trial](../../../_includes/compute/windows-trial.md) %}

           {% endif %}

         * [Policies](../../concepts/instance-groups/policies/index.md):

            | Field | Description |
            ----- | -----
            | `deploy_policy` | [Deployment policy](../../concepts/instance-groups/policies/deploy-policy.md) for instances in the group. |
            | `scale_policy` | [Scaling policy](../../concepts/instance-groups/policies/scale-policy.md) for instances in the group. |
            | `allocation_policy` | [Policy for allocating](../../concepts/instance-groups/policies/allocation-policy.md) instances across zones and regions. |

      * `yandex_vpc_network`: Description of the [cloud network](../../../vpc/concepts/network.md#network).
      * `yandex_vpc_subnet`: Description of the [subnet](../../../vpc/concepts/network.md#subnet) the instance group will connect to.

      {% note info %}

      If you already have suitable resources, such as a service account, cloud network, and subnet, you don't need to describe them again. Use their names and IDs in the appropriate parameters.

      {% endnote %}

      For more information about resources that you can create with {{ TF }}, please see the [provider documentation]({{ tf-provider-link }}/).

   1. Make sure that the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, {{ TF }} points them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

         ```
         terraform apply
         ```

      1. Confirm that you want to create the resources.

      Afterwards, all the necessary resources are created in the specified folder. You can check that the resources are there with the correct settings using the [management console]({{ link-console-main }}).

{% endlist %}