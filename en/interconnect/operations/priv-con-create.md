---
title: How to create a private connection in an {{ interconnect-name }} trunk
description: Follow this guide to create a private connection in an {{ interconnect-name }} trunk.
---

# Creating a private connection

{% include [cic-cr-access](../../_includes/interconnect/cic-cr-access.md) %}

{% note info %}

You need the [cic.editor](../security/index.md#cic-editor) role to run this operation.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. View the description of the CLI command to create a [private connection](../concepts/priv-con.md):

      ```bash
      yc cic private-connection create --help
      ```

  1. Create a private connection:

      ```bash
      yc cic private-connection create --name prc-m9 \
        --description "Private connection #1 via M9" \ 
        --trunk-id cf3td**********nufvr \
        --vlan-id 125 \
        --ipv4-peering peering-subnet=192.168.10.0/30,peer-ip=192.168.10.1,cloud-ip=192.168.10.2,peer-bgp-asn=65202 \
        --async
      ```

      {% note info %}

      By default, the private connection will be created in the same folder as the trunk. To simplify maintenance, it is best not create trunks and private connections in different folders.

      {% endnote %}

      Expected result:

      ```text
      id: cca59**********dvjir
      name: prc-m9
      folder_id: b1gqf**********jiz2w
      region_id: ru-central1
      trunk_connection_id: cf3td**********nufvr
      vlan_id: "125"
      ipv4_peering:
        peering_subnet: 192.168.10.0/30
        peer_ip: 192.168.10.1
        cloud_ip: 192.168.10.2
        peer_bgp_asn: "20001"
        peer_bgp_md5_key: '*** hidden ***'
      status: ACTIVE
      created_at: "2025-03-20T08:25:33Z"
      ```

      Where:
      * `id`: Private connection ID.
      * `name`: Private connection name.
      * `description`: Private connection description.
      * `folder_id`: ID of the cloud folder the private connection was created in.
      * `region_id`: Cloud region the private connection was created in.
      * `trunk_connection_id`: ID of the trunk the private connection was created in.
      * `vlan_id`: VLAN ID for the private connection in 802.1Q trunk. This value is selected by the customer. It must be different from the VLAN IDs of the previously set up private connections in this trunk.
      * `ipv4_peering`: Group of IP/BGP connectivity parameters for the private connection:
        * `peering_subnet`: [Point-to-point subnet](../concepts/priv-con.md#priv-address) for BGP peering. This value is selected by the customer.
        * `peer_ip`: Customer endpoint IP address on the point-to-point peering subnet. This value is selected by the customer.
        * `cloud_ip`: {{ yandex-cloud }} endpoint IP address on the point-to-point peering subnet. This value is selected by the customer.
        * `peer_bgp_asn`: Customer endpoint [BGP ASN](../concepts/priv-con.md#bgp-asn) in ASPlain format. This value is selected by the customer.
        * `peer_bgp_md5_key`: Optional parameter. Encrypted BGP session key value.
      * `status`: Resource state. Target state: `ACTIVE`.
      * `created_at`: Date and time of resource creation.
      * `async`: Running the operation in asynchronous mode. This is the recommended mode for all operations that involve changes to resources.

{% endlist %}

