* `--opensearch-node-group`: `{{ OS }}` host group configuration, where:

   * `resource-preset-id`: Host class that defines the configuration of virtual machines the {{ OS }} nodes will be deployed on. All available options are listed under [Host classes](../../managed-opensearch/concepts/instance-types.md).
   * `disk-size`: Disk size in bytes. The minimum and maximum values depend on the selected host class.
   * `disk-type-id`: [Disk type](../../managed-opensearch/concepts/storage.md).
   * `zone-ids`: [Availability zones](../../overview/concepts/geo-scope.md) Separate zones with commas and enclose them in square brackets. Here is an example:

      ```bash
      zone-ids=[ru-central1-a,ru-central1-b,ru-central1-d]
      ```

   * `subnet-names`: Name of the subnets in the specified availability zones. Separate subnets with commas and enclose them in square brackets. Here is an example:

      ```bash
      subnet-names=[default-ru-central1-a,default-ru-central1-b,default-ru-central1-d]
      ```

      You can specify the `subnet-ids` parameter with network IDs instead of `subnet-names`. Separate IDs with commas and enclosed them in square brackets. Here is an example:

      ```bash
      subnet-ids=[e9bp8qmchqh2********,e2l963gkhobo********,fl8klaabecc3********]
      ```

   * `roles`: [Host roles](../../managed-opensearch/concepts/host-roles.md). The possible values are as follows:

      * `data`: Assigns the `DATA` role only.
      * `manager`: Assigns the `MANAGER` role only.
      * `data+manager` or `manager+data`: Assigns both roles.

      {% note tip %}

      For security reasons, we do not recommend enabling public access to hosts with the `MANAGER` role.

      {% endnote %}

* `--dashboards-node-group`: `Dashboards` host group configuration. It is configured in the same way as the `{{ OS }}` host group, except for the host roles. You do not need to configure any roles for the `Dashboards` group.
