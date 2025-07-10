[Contact]({{ link-console-support }}/tickets/create) support to create a routing instance in your folder.

Fill out your request as follows:

```text
Subject: [CIC for BareMetal] Creating a routing instance.

Request text:
Please create a routing instance in the specified cloud folder with the following parameters:

folder_id: <folder_ID>

vpc:
  vpc_net_id: <network_ID>
    vpc_subnets:
      {{ region-id }}-a: [CIDR_a1, CIDR_a2, ..., CIDR_an]
      {{ region-id }}-b: [CIDR_b1, CIDR_b2, ..., CIDR_bn]
      {{ region-id }}-d: [CIDR_d1, CIDR_d2, ..., CIDR_dn]
```

Where:
* `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
* `vpc_net_id`: Cloud network [ID](../../vpc/operations/network-get-info.md).
* `vpc_subnets`: List of [announced](../../interconnect/concepts/priv-con.md#prc-announce) address prefixes for each [availability zone](../../overview/concepts/geo-scope.md). For example, for the {{ vpc-short-name }} subnet you created earlier, you will specify `{{ region-id }}-b: [192.168.11.0/24]`.

    You may announce [aggregated](../../interconnect/concepts/priv-con.md#agg-subnets) address prefixes.

{% note info %}

It may take up to 24 hours for the support to create a routing instance. With that done, you will be able to get the ID of the new routing instance by running the `yc cloudrouter routing-instance list` [{{ yandex-cloud }} CLI](../../cli/index.yaml) command.

{% endnote %}