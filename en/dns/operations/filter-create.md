---
title: How to create a DNS filter in {{ dns-full-name }}
description: Follow this guide to create a DNS filter.
---

# Creating a DNS filter

To create a [DNS filter](../concepts/dns-filter.md):

{% list tabs group=instructions %}

- CLI {#cli}

  To create a new DNS filter and apply it at the cloud level:

  1. See the description of the CLI command for creating a DNS zone:

     ```bash
     yc dns firewall create --help
     ```

  1. Create a DNS filter in the folder with a cloud-level action:

     ```bash
     yc dns firewall create --name filter-1 \
       --description 'DNS Filter #1' \
       --folder-id b1g23..........4kpv3 \
       --enabled \
       --cloud-ids 'b1g38..........qg4nl' \
       --whitelist-fqdns 'dom1.net.,*.dom5.net.,*.ru.' \ 
       --blacklist-fqdns 'www.dom1.net.,info.dom5.net.' 
     ```

     Where:

     * `--name`: Filter name. It must be unique within a folder.
     * `--description`: Filter description.
     * `--folder-id`: ID of the folder where you want to create your filter.
     * `--enabled`: Filter status, enabled or disabled. If not specified, the new filter will be disabled.
     * `--whitelist-fqdns`, `--blacklist-fqdns`: List of FQDNs. [How to use DNS filters](../concepts/dns-filter.md#rules).
     * `--cloud-ids`: List of cloud IDs whose resources are subject to this filter.
     * `--folder-ids`: List of folder IDs whose resources are subject to this filter.
     * `--network-ids`: List of network (VPC) IDs whose resources are subject to this filter.
     * `--lock-resources`: [Centralized filter management mode](../concepts/dns-filter.md#lock).

     Result:

     ```text
      id: dnscmtk2r6neivr20q2l
      folder_id: b1g23..........4kpv3
      created_at: "2026-04-29T04:53:06.591Z"
      name: filter-1
      description: 'DNS Filter #1'
      enabled: true
      resource_config:
      type: CLOUD
      resource_ids:
          - b1g38..........qg4nl
      whitelist_fqdns:
      - dom1.net.
      - '*.dom5.net.'
      - '*.ru.'
      blacklist_fqdns:
      - www.dom1.net.
      - info.dom5.net.
     ```

     Once the filter has been created, you can check the availability of the whitelisted and blacklisted FQDNs using the `dig` and `ping` commands from relevant cloud resources (VMs).

    Result:

     ```text
     dig www.dom1.net 
     
     ; <<>> DiG 9.18.39-0ubuntu0.24.04.3-Ubuntu <<>> www.dom1.net
     ;; global options: +cmd
     ;; Got answer:
     ;; ->>HEADER<<- opcode: QUERY, status: REFUSED, id: 50976
     ;; flags: qr rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 0, ADDITIONAL: 1
     
     ;; OPT PSEUDOSECTION:
     ; EDNS: version: 0, flags:; udp: 65494
     ;; QUESTION SECTION:
     ;www.dom1.net.INA				
     
     ;; Query time: 1 msec
     ;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
     ;; WHEN: Tue Apr 28 13:44:20 UTC 2026
     ;; MSG SIZE  rcvd: 40
     ```

     ```text
     ping www.dom1.net
     ping: www.dom1.net: Temporary failure in name resolution
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. In the configuration file, describe the resources you want to create:

     ```hcl
     resource "yandex_dns_firewall" "filter1" {
       name        = "filter-1"
       description = "DNS Filter #1"
       folder_id   = "b1g27..........pe3fg"

       labels = {
         label1 = "label-1-value"
       }

       enabled         = true
       whitelist_fqdns = ["dom1.net.","*.dom5.net.","*.ru."]
       blacklist_fqdns = ["www.dom1.net.","info.dom5.net."]

       resource_config = {
         type           = "CLOUD"
         resource_ids   = ["b1g38..........qg4nl"]
         lock_resources = false
       }

        deletion_protection = false
     }
     ```

     Where:

     * `name`: Filter name. It must be unique within a folder.
     * `description`: Filter description.
     * `folder_id`: ID of the folder you want to create the filter in.
     * `enabled`: Filter status, enabled or disabled. If not specified, the new filter will be disabled.
     * `deletion_protection`: Enables deletion protection for the new resource.
     * `whitelist_fqdns`, `blacklist_fqdns`: List of FQDNs. [How to use DNS filters](../concepts/dns-filter.md#rules).
     * `resource_config`: Block of attributes of the resource subject to the filter:
          * `type`: Resource type. Valid values: `CLOUD`, `FOLDER`, `NETWORK`.
          * `resource_ids`: List of resource IDs of a given type.
          * `lock_resources`: [Centralized filter management mode](../concepts/dns-filter.md#lock).

  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all the required resources. You can check the new resources in the [management console]({{ link-console-main }}) or using this [CLI](../../cli/quickstart.md) command:

     ```bash
     yc dns firewall get <filter-name>
     ```

{% endlist %}
