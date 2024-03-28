You can use a standard SSH client to connect to VMs with OS Login access enabled. To do this, [export](../../compute/operations/vm-connect/os-login-export-certificate.md) an OS Login certificate to your local computer and specify this certificate when connecting to a VM:

1. [Enable](../../organization/operations/os-login-access.md) access via OS Login at the organization level.

   To connect to a VM via OS Login using an SSH certificate over a standard SSH client, enable **{{ ui-key.yacloud_org.form.oslogin-settings.title_ssh-certificate-settings }}**.

1. Get a list of all VMs in the default folder:

      ```bash
      yc compute instance list
      ```

      Result:

      ```text
      +----------------------+-----------------+---------------+---------+---------------+--------------+
      |          ID          |       NAME      |    ZONE ID    | STATUS  |  EXTERNAL IP  | INTERNAL IP  |
      +----------------------+-----------------+---------------+---------+---------------+--------------+
      | fhm0b28lgf********** | first-instance  | {{ region-id }}-a | RUNNING | 158.160.**.** | 192.168.0.8  |
      | fhm9gk85nj********** | second-instance | {{ region-id }}-a | RUNNING | 51.250.**.*** | 192.168.0.12 |
      +----------------------+-----------------+---------------+---------+---------------+--------------+
      ```

   1. Get a [public address](../../vpc/concepts/address.md#public-addresses) of the VM by specifying its ID:

      ```bash
      yc compute instance get \
          --id <VM_ID>
      ```

      {% cut "Result:" %}

      ```yaml
      id: fhm0b28lgf**********
      folder_id: b1gt6g8ht345********
      created_at: "2023-12-09T06:23:04Z"
      name: first-instance
      zone_id: {{ region-id }}-a
      platform_id: standard-v3
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
        device_name: epd9m2csd95p********
        auto_delete: true
        disk_id: epd9m2csd95p********
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:87:75:**:**
          subnet_id: e2li9tcgi7ii********
          primary_v4_address:
            address: 192.168.0.8
            one_to_one_nat:
              address: 158.160.**.**
              ip_version: IPV4
      gpu_settings: {}
      fqdn: first-instance.{{ region-id }}.internal
      scheduling_policy: {}
      network_settings:
        type: STANDARD
      placement_policy: {}
      ```

      The VM's public address is stated in the `network_interfaces.primary_v4_address.one_to_one_nat.address` field.

      {% endcut %}

1. Connect to the VM:

      ```bash
      ssh -i <certificate_file_path> <username>@<VM_public_IP_address>
      ```

      Where:

      * `<certificate_file_path>`: Path to the previously saved `Identity` certificate file, e.g., `/home/user1/.ssh/yc-cloud-id-b1gia87mbaom********-orgusername`.
      * `<username>`: Organization user name. You can see the username at the end of the exported OS Login certificate. In the example above, it is `orgusername`.
      * `<VM_public_IP_address>`: VM's public IP address you got earlier.

      If this is your first time connecting to the VM, you will see an unknown host warning:

      ```text
      The authenticity of host '158.160.**.** (158.160.**.**)' can't be established.
      ECDSA key fingerprint is SHA256:PoaSwqxRc8g6iOXtiH7ayGHpSN0MXwUfWHk********.
      Are you sure you want to continue connecting (yes/no)?
      ```

      Type `yes` in the terminal and press **Enter**.