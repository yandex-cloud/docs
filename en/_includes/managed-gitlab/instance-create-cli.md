{% include [cli-install](../cli-install.md) %}

{% include [default-catalogue](../default-catalogue.md) %}

1. See the description of the [CLI](../../cli) command for creating a {{ mgl-name }} instance:

     ```bash
     yc managed-gitlab instance create --help
     ```

1. Select a [subnet](../../vpc/concepts/network.md#subnet):

    ```bash
    yc vpc subnet list
    ```

    Result:

     ```text
     +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
     |          ID          |           NAME            |      NETWORK ID      | ROUTE TABLE ID |       ZONE        |      RANGE      |
     +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
     | e9bnlm18l70a******** |   default-{{ region-id }}-a   | enpe3m3fa00u******** |                |   {{ region-id }}-a   | [10.128.0.0/24] |
     +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
     ```

1. Create a {{ GL }} instance (this example does not use all available parameters):

    ```bash
    yc managed-gitlab instance create \
      --name first-instance \
      --resource-preset-id <host_class> \
      --disk-size <disk_size_in_GB> \
      --admin-login <admin_login> \
      --admin-email <admin_email_address> \
      --domain-prefix <instance_domain_name> \
      --deletion-protection \
      --approval-rules <approval_rule_configuration> \
      --subnet-id <subnet_ID>
    ```

    Where:
    * `--name`: Instance name, unique within {{ yandex-cloud }}. The naming requirements are as follows:

      {% include [name-format](../name-format.md) %}

    * `--resource-preset-id`: Host class. Represents the configuration of the virtual machine to host the {{ GL }} instance. The possible values are:
      * `s2.micro`: 2 vCPUs, 8 GB RAM
      * `s2.small`: 4 vCPUs, 16 GB RAM
      * `s2.medium`: 8 vCPUs, 32 GB RAM
      * `s2.large`: 16 vCPUs, 64 GB RAM
    * `--disk-size`: Disk size in GB.
    * `--admin-login`: {{ GL }} instance admin login.
    * `--admin-email`: Instance admin email address. This is the address to receive the email with a link to create a password.
    * `--domain-prefix`: [Instance domain name](../../compute/concepts/network.md#hostname). The system will automatically create the relevant DNS records for it in the `.gitlab.yandexcloud.net` domain.

      {% include [domain-name-format](domain-name-format.md) %}

    * `--deletion-protection`: Instance protection against accidental deletion by the user.
    * `--approval-rules`: [Approval rule](../../managed-gitlab/concepts/approval-rules.md) configuration. The possible values are:
      * `BASIC`
      * `STANDARD`
      * `ADVANCED`

      {% include [note-approval-rules-pricing](note-approval-rules-pricing.md) %}

    * `--subnet-id`: ID of the selected subnet.

    Result:

    ```text
    id: c17c60tpadua********
    folder_id: b1g2slt7p9ug********
    created_at: "2025-07-20T18:34:16.078Z"
    updated_at: "2025-07-20T18:34:16.078Z"
    name: test-cli
    resource_preset_id: s2.small
    disk_size: "107374182400"
    status: RUNNING
    admin_login: admin-gl
    admin_email: user@example.com
    domain: test-domain-user.gitlab.yandexcloud.net
    subnet_id: e9b4rrpuu2a********
    backup_retain_period_days: "7"
    deletion_protection: true
    approval_rules_id: BASIC
    gitlab_version: 17.11.6
    ```

    For more information about this command, see the [CLI reference](../../managed-gitlab/cli-ref/instance/create.md).
