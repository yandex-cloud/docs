* `--opensearch-node-group`: `{{ OS }}` host group configuration, where:

   * `--resource-preset-id`: Host class that defines the configuration of virtual machines the {{ OS }} nodes will be deployed on. All available options are listed under [Host classes](../../managed-opensearch/concepts/instance-types.md).
   * `disk-size`: Disk size in bytes. Minimum and maximum values depend on the selected host class.
   * `disk-type-id`: [Disk type](../../managed-opensearch/concepts/storage.md).
   * `roles`: [Host roles](../../managed-opensearch/concepts/host-roles.md). The possible values include:

      * `data`: Assigns the `DATA` role only.
      * `manager`: Assigns the `MANAGER` role only.
      * `data+manager` or `manager+data`: Assigns both roles.

      {% note tip %}

      We do not recommend enabling public access to hosts with the `MANAGER` role, as this is not secure.

      {% endnote %}

* `--dashboards-node-group`: `Dashboards` host group configuration. It is configured in the same way as the `{{ OS }}` host group, except for the host roles. You do not need to configure any roles for the `Dashboards` group.
