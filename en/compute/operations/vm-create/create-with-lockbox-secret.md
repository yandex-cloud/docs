---
title: How to create a VM with access to a {{ lockbox-name }} secret
description: Follow this guide to get the value of a {{ lockbox-full-name }} secret provided via metadata when creating a VM from inside the VM.
---

# Creating a VM instance with access to a {{ lockbox-full-name }} secret

You can use the [metadata](../../concepts/vm-metadata.md) service to provide the ID of a [{{ lockbox-full-name }} secret](../../../lockbox/concepts/secret.md) to a [VM](../../concepts/vm.md) and then get the value of that secret from inside the VM using the [IAM token](../../../iam/concepts/authorization/iam-token.md) of the [service account](../../../iam/concepts/users/service-accounts.md) linked to the VM.

Just like other user data, {{ lockbox-name }} secrets are provided in the `user-data` key. You can provide metadata to the `user-data` [folder](../../concepts/metadata/directories.md#dir-user) both when [creating](../index.md#vm-create) and [updating](../vm-control/vm-update.md) a VM.

To provide a {{ lockbox-name }} secret to a VM via metadata:

1. [Create](../../../lockbox/operations/secret-create.md) a {{ lockbox-name }} secret.
1. [Create](../../../iam/operations/sa/create.md) a service account and [assign](../../../iam/operations/sa/assign-role-for-sa.md#binding-role-resource) the `lockbox.payloadViewer` role to it.
1. Create a file named `metadata.yaml` and paste into it the following metadata configuration for the new VM:

    **metadata.yaml**

    ```yaml
    #cloud-config

    datasource:
      Ec2:
        strict_id: false
      secrets:
        my_secret: <secret_ID>
    ssh_pwauth: no
    users:
      - name: <username>
        sudo: ALL=(ALL) NOPASSWD:ALL
        shell: /bin/bash
        ssh-authorized-keys:
          - "<user_public_SSH_key>"
    packages:
      - jq
      - yq
    ```

    Where:
    * `my_secret`: [ID](../../../lockbox/operations/secret-get-info.md) of the secret you created.

        {% note warning %}

        Provide only the IDs of your secrets to the `user-data` folder, not their [values](../../../lockbox/concepts/secret.md#secret).

        {% endnote %}

    * `name`: Name of the local user to create on the VM, e.g., `admin`.
    * `ssh-authorized-keys`: Public SSH key of the new VM user.

1. Create a virtual machine:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) containing your secret and service account.
      1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. In the left-hand panel, select ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
      1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select the [Ubuntu 24.04 LTS](/marketplace/products/yc/ubuntu-2404-lts-oslogin) image.
      1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../../overview/concepts/geo-scope.md) the VM will reside in.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, in the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, enter the ID of a subnet in the new VM's availability zone or select a [cloud network](../../../vpc/concepts/network.md#network) from the list.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

          * Enter the VM user name in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field,
          * {% include [access-ssh-key](../../../_includes/compute/create/access-ssh-key.md) %}
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, enter a name for your VM:

          {% include [name-format](../../../_includes/name-format.md) %}

      1. Under **{{ ui-key.yacloud.compute.instances.create.section_additional }}**, select the service account you created earlier.
      1. Under **{{ ui-key.yacloud.common.metadata }}**:

          * In the **{{ ui-key.yacloud.common.label_key }}** field, specify `user-data`.
          * In the **{{ ui-key.yacloud.common.value }}** field, paste the contents of the `metadata.yaml` configuration file you created earlier.
      1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

    - CLI {#cli}

      {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      Run this command:

      ```bash
      yc compute instance create \
        --name my-vm \
        --hostname <host_name> \
        --zone <availability_zone> \
        --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2404-lts-oslogin \
        --network-interface subnet-name=<subnet_name>,ipv4-address=auto,nat-ip-version=ipv4 \
        --metadata-from-file user-data="<path_to_configuration_file>" \
        --service-account-id <service_account_ID>
      ```

      Where:
      * `--name`: Name of the new VM, e.g., `my-vm`.
      * `--hostname`: Host name for the new VM. This is an optional parameter. If omitted, the VM ID will be used as the host name.
      * `--zone`: [Availability zone](../../../overview/concepts/geo-scope.md) the new VM will reside in.
      * `--network-interface`: [Network interface](../../concepts/network.md) settings for the new VM:

          * `subnet-name`: Name of the [subnet](../../../vpc/concepts/network.md#subnet) in the availability zone specified in the `--zone` parameter.
      * `--metadata-from-file`: The `user-data` key with the path to the `cloud-config` YAML configuration file for value, e.g., `--metadata-from-file user-data="/home/user/metadata.yaml"`.
      * `service-account-id`: [ID](../../..//iam/operations/sa/get-id.md) of the service account with the `lockbox.payloadViewer` [role](../../../lockbox/security/index.md#lockbox-payloadViewer).

      {% cut "Result" %}

      ```text
      done (31s)
      id: epde2t9aovjm********
      folder_id: b1gt6g8ht345********
      created_at: "2025-02-04T18:18:58Z"
      name: my-vm
      zone_id: {{ region-id }}-b
      platform_id: standard-v2
      resources:
        memory: "2147483648"
        cores: "2"
        core_fraction: "100"
      status: RUNNING
      metadata_options:
        gce_http_endpoint: ENABLED
        aws_v1_http_endpoint: ENABLED
        gce_http_token: ENABLED
        aws_v1_http_token: DISABLED
      boot_disk:
        mode: READ_WRITE
        device_name: epd27gmf2vu2********
        auto_delete: true
        disk_id: epd27gmf2vu2********
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:e1:75:2a:c7
          subnet_id: e2lqsms4cdl3********
          primary_v4_address:
            address: 192.168.15.25
            one_to_one_nat:
              address: 51.***.***.93
              ip_version: IPV4
      serial_port_settings:
        ssh_authorization: OS_LOGIN
      gpu_settings: {}
      fqdn: my-vm.ru-central1.internal
      scheduling_policy: {}
      service_account_id: ajegtlf2q28a********
      network_settings:
        type: STANDARD
      placement_policy: {}
      hardware_generation:
        legacy_features:
          pci_topology: PCI_TOPOLOGY_V1
      ```

      {% endcut %}

    - {{ TF }} {#tf}

      {% include [terraform-install](../../../_includes/terraform-install.md) %}

      1. In the configuration file, define the parameters of the resources you want to create:

          ```hcl
          # Creating a boot disk for the VM

          resource "yandex_compute_disk" "boot-disk" {
            type     = "network-ssd"
            zone     = "<availability_zone>"
            size     = "20"
            image_id = "fd8bpal18cm4kprpjc2m"
          }

          # Creating a VM instance

          resource "yandex_compute_instance" "my-vm" {
            name               = "<VM_name>"
            platform_id        = "standard-v2"
            zone               = "<availability_zone>"
            service_account_id = "<service_account_ID>"

            resources {
              cores  = "2"
              memory = "4"
            }

            boot_disk {
              disk_id = yandex_compute_disk.boot-disk.id
            }

            network_interface {
              subnet_id          = "<subnet_ID>"
              nat                = true
              security_group_ids = ["<security_group_ID>"]
            }

            metadata = {
              user-data = "${file("<path_to_configuration_file>")}"
            }
          }
          ```

          Where:
          * `zone`: [Availability zone](../../../overview/concepts/geo-scope.md) the VM and disk will reside in.
          * `service_account_id`: [ID](../../..//iam/operations/sa/get-id.md) of the previously created service account with the `lockbox.payloadViewer` [role](../../../lockbox/security/index.md#lockbox-payloadViewer).
          * `name`: Name of the new VM, e.g., `my-vm`.
          * `subnet_id`: ID of the [subnet](../../../vpc/concepts/network.md#subnet) in the availability zone specified in the `zone` parameter.
          * `security_group_ids`: [Security group](../../../vpc/concepts/security-groups.md) ID.
          * `user-data`: Path to the `metadata.yaml` configuration file you created earlier.

          For more information about the resources being created, see the [relevant TF provider articles]({{ tf-provider-link }}).

      1. Create the resources:

          {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

          This will create all the resources you need in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}).

    - API {#api}

      Use the [create](../../api-ref/Instance/create.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/Create](../../api-ref/grpc/Instance/create.md) gRPC API call.

    {% endlist %}

1. [Connect to the new VM over SSH](../vm-connect/ssh.md). In the VM terminal:

    1. Get the IAM token of the service account linked to the VM and save that token to the `YC_TOKEN` variable. To do this, send the following request to the `computeMetadata` [folder](../../concepts/metadata/directories.md#dir-compute) in the metadata service:

        ```bash
        export YC_TOKEN=$(curl -sf -H Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token | jq -r .access_token)
        ```
    1. Get the secret ID you provided to the `user-data` [folder](../../concepts/metadata/directories.md#dir-user) in the metadata service when creating the VM.

        ```bash
        export my_secret_id=$(curl -sf -H Metadata-Flavor:Google 169.254.169.254/latest/user-data | yq .datasource.secrets.my_secret | tr -d \")
        ```
    1. Get the secret value and save it to the `my_secret_value` variable. To do this, send the following request to the {{ lockbox-full-name }} API:

        ```bash
        export my_secret_value=$(curl -sf -H "Authorization: Bearer $YC_TOKEN" "https://{{ api-host-lockbox-payload }}/lockbox/v1/secrets/${my_secret_id}/payload" | jq -r .entries[0].textValue)
        echo $my_secret_value
        ```

        Result:

        ```bash
        admin@my-vm:~$ echo $my_secret_value
        my value
        ```

For more `user-data` key configuration examples, see [Examples](./create-with-cloud-init-scripts.md#examples).

#### See also {#see-also}

* [{#T}](../../concepts/vm-metadata.md)
* [{#T}](./create-with-env-variables.md)
* [{#T}](./create-with-cloud-init-scripts.md)