---
title: How to create a VM with metadata from environment variables
description: Follow this guide to use environment variables when creating a VM with a custom `cloud-init` script to install additional software and customize your VM while creating it.
---

# Creating a VM with metadata from environment variables

With the [{{ yandex-cloud }} CLI](../../../cli/index.yaml), you can create a [VM](../../concepts/vm.md) whose [metadata](../../concepts/vm-metadata.md) will contain values set in [environment variables](https://en.wikipedia.org/wiki/Environment_variable). The [cloud-init](https://cloudinit.readthedocs.io/en/latest/) agent running on the VM will process the metadata configuration you set in the `user-data` key.

This use case demonstrates creating a VM on [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts) with a preinstalled [Nginx](https://nginx.org/) web server. When executing the CLI command, the local user name and SSH key values will be provided to the VM metadata through substitution from the `USER_NAME` and `SSH_KEY` variables of the environment the command is executed in.

Also, these two variables from the `data` configuration section will be provided to the VM metadata: `var1` set to `value1` and `var2` set to `value2`. These variables and their values will be available in the `user-data` [folder](../../concepts/metadata/directories.md#dir-user) of the metadata service from inside the VM after you create it.

To create a VM with metadata from environment variables:

1. Specify the environment variables containing the VM local user's name and SSH key; these will be substituted into the VM metadata when the {{ yandex-cloud }} CLI command is executed later on:

    ```bash
    export USER_NAME="<username>"
    export SSH_KEY="<SSH_key>"
    ```
1. Create a file named `metadata.yaml` and paste into it the following metadata configuration for the new VM:

    **metadata.yaml**

    ```yaml
    #cloud-config
    datasource:
      Ec2:
        strict_id: false
      data:
        var1: value1
        var2: value2
    ssh_pwauth: no
    users:
    - name: $USER_NAME
      sudo: 'ALL=(ALL) NOPASSWD:ALL'
      shell: /bin/bash
      ssh_authorized_keys:
      - $SSH_KEY
    write_files:
      - path: "/usr/local/etc/startup.sh"
        permissions: "755"
        content: |
          #!/bin/bash
    
          apt-get update
          apt-get install -y nginx
          service nginx start
          sed -i -- "s/ nginx/ Yandex Cloud - $$HOSTNAME/" /var/www/html/index.nginx-debian.html
        defer: true
    runcmd:
      - ["/usr/local/etc/startup.sh"]
    packages:
      - yq
    ```
1. Create a virtual machine:

    {% list tabs group=instructions %}

    - CLI {#cli}

      {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      ```bash
      yc compute instance create \
        --name my-vm \
        --hostname <host_name> \
        --zone <availability_zone> \
        --network-interface subnet-name=<subnet_name>,nat-ip-version=ipv4,security-group-ids=<security_group_ID> \
        --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2204-lts \
        --metadata-from-file user-data="<path_to_configuration_file>"
      ```

      Where:
      * `--name`: Name of the new VM, e.g., `my-vm`.
      * `--hostname`: Host name for the new VM. This is an optional parameter. If omitted, the VM ID will be used as the host name.
      * `--zone`: [Availability zone](../../../overview/concepts/geo-scope.md) the new VM will reside in.
      * `--network-interface`: [Network interface](../../concepts/network.md) settings for the new VM:

          * `subnet-name`: Name of the [subnet](../../../vpc/concepts/network.md#subnet) in the availability zone specified in the `--zone` parameter.
          * `security-group-ids`: [Security group](../../../vpc/concepts/security-groups.md) ID.
      * `--metadata-from-file`: The `user-data` key with the path to the `cloud-config` YAML configuration file for value. e.g., `--metadata-from-file user-data="/home/user/metadata.yaml"`.

          {% note info %}

          Note that the CLI command for the `HOSTNAME` variable will not substitute its value into the metadata. Instead, the `$HOSTNAME` variable name will be provided to the `cloud-init` configuration when executing the CLI command; the hostname value of the new VM will be substituted in place of that variable later what creating the VM.

          This is why the `HOSTNAME` variable is specified using the two-dollar syntax in the `user-data` key: `$$HOSTNAME`. For more information, see [{#T}](../../concepts/metadata/sending-metadata.md#environment-variables).

          {% endnote %}

      {% cut "Result" %}

      ```text
      done (36s)
      id: epd8m0fqvkuu********
      folder_id: b1gt6g8ht345********
      created_at: "2025-01-01T14:24:37Z"
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
        device_name: epd60hoo48qj********
        auto_delete: true
        disk_id: epd60hoo48qj********
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:8b:01:fa:fd
          subnet_id: e2lqsms4cdl3********
          primary_v4_address:
            address: 192.168.15.14
            one_to_one_nat:
              address: 51.250.**.**
              ip_version: IPV4
          security_group_ids:
            - enpbtvidu0g0********
      serial_port_settings:
        ssh_authorization: OS_LOGIN
      gpu_settings: {}
      fqdn: my-web-server.{{ region-id }}.internal
      scheduling_policy: {}
      network_settings:
        type: STANDARD
      placement_policy: {}
      hardware_generation:
        legacy_features:
          pci_topology: PCI_TOPOLOGY_V1
      ```

      {% endcut %}

      For more information about the `yc compute instance create` command, see the [CLI reference](../../../cli/cli-ref/compute/cli-ref/instance/create.md).

    {% endlist %}

1. Save the [public IP address](../../concepts/network.md#public-ip) of the VM you created into the `EXT_IP` variable.

    ```bash
    EXT_IP=$(yc compute instance get my-vm --jq '.network_interfaces[0].primary_v4_address.one_to_one_nat.address')
    ```
1. Connect to the VM over SSH:

    ```bash
    ssh $USER_NAME@$EXT_IP
    ```
1. Get the values of the variables you previously provided to the metadata from inside the VM. To do this, run the following requests in the VM terminal:

    ```bash
    export var1=$(curl -sf -H Metadata-Flavor:Google 169.254.169.254/latest/user-data | yq .datasource.data.var1)
    export var2=$(curl -sf -H Metadata-Flavor:Google 169.254.169.254/latest/user-data | yq .datasource.data.var2)
    echo $var1 $var2
    ```

    Result:

    ```text
    value1 value2
    ```

For other configuration examples for `user-data`, see [Examples](./create-with-cloud-init-scripts.md#examples).

#### See also {#see-also}

* [{#T}](../../concepts/vm-metadata.md)
* [{#T}](./create-with-lockbox-secret.md)
* [{#T}](./create-with-cloud-init-scripts.md)