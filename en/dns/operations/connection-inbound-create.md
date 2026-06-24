---
title: How to create an inbound DNS connection in {{ dns-full-name }}
description: Follow this guide to create an inbound DNS connection.
---

# Creating an inbound DNS connection

To create an [inbound DNS connection](../concepts/dns-connection.md):

{% list tabs group=instructions %}

- CLI {#cli}

  To create a new inbound DNS connection:

  1. Reserve an IP address for the inbound DNS connection in the required subnet:

     ```bash
     yc vpc address create --name dns-ep \
       --description 'DNS Inbound IP' \
       --internal-ipv4 address=10.0.1.101,subnet=f5hqt..........3gj28
     ```

     Where:

     * `--name`: Name of the private IP address to reserve. It must be unique within a folder.
     * `--description`: Description of the IP address to reserve.
     * `--internal-ipv4`: Attribute block for reserving a private IP address:
       * `address`: IPv4 address to reserve. You cannot specify IP addresses that are already in use in the VPC.
       * `subnet`: ID of the subnet the IP address will be reserved in.

    Result:

     ```text
      id: e3gck..........qd6j2
      folder_id: b1g42..........5ghp2
      name: dns-ep
      description: DNS Inbound IP
      internal_ipv4_address:
        address: 10.0.1.101
        subnet_id: f5hqt..........3gj28
      reserved: true
      type: INTERNAL
      ip_version: IPV4
     ```

  1. See the CLI command description for creating an inbound DNS connection:

     ```bash
     yc dns inbound-endpoint create --help
     ```   

  1. Create an inbound DNS connection:

     ```bash
     yc dns inbound-endpoint create --name dns-ep \
       --description 'DNS Inbound' \
       --network-id enpd3..........39qap \
       --address-id e3gck..........qd6j2
     ```

     Where:

     * `--name`: Connection name. It must be unique within a folder.
     * `--description`: Connection description.
     * `--network-id`: ID of the VPC network in which the inbound DNS connection will be created.
     * `--address-id`: ID of the reserved IP address that will be used for the inbound DNS connection.

     Result:

     ```text
     id: dnses..........9nh78
     folder_id: b1g42..........5ghp2
     name: dns-ep
     description: DNS Inbound
     address: 10.0.1.101
     address_id: e3gck..........qd6j2
     status: AVAILABLE
     ```

     Once created, you can test FQDN name resolution through the created DNS connection using the `dig` command.

     Result:

     ```text
     dig @10.0.1.101 test-vm.ru-central1.internal

     ; <<>> DiG 9.18.39-0ubuntu0.24.04.3-Ubuntu <<>> test-vm.ru-central1.internal
     ;; global options: +cmd
     ;; Got answer:
     ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 50976
     ;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

     ;; OPT PSEUDOSECTION:
     ; EDNS: version: 0, flags:; udp: 65494
     ;; QUESTION SECTION:
     ;test-vm.ru-central1.internal.INA				

     ;; ANSWER SECTION:
     test-vm.ru-central1.internal. 600 IN A 10.0.1.15

     ;; Query time: 9 msec
     ;; SERVER: 10.0.1.101#53(10.0.1.101) (UDP)
     ;; WHEN: Tue Apr 28 13:44:20 UTC 2026
     ;; MSG SIZE  rcvd: 133
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. In the configuration file, describe the resources you want to create:

    ```hcl
    resource "yandex_vpc_network" "my_net" {}

    resource "yandex_vpc_subnet" "subnet1" {
      network_id     = yandex_vpc_network.my_net.id
      v4_cidr_blocks = ["10.0.1.0/24"]
    }

    resource "yandex_vpc_address" "dns_address" {
      name        = "dns-ep"
      description = "internal address for DNS inbound endpoint"

      internal_ipv4_address {
        subnet_id = yandex_vpc_subnet.subnet1.id
        address   = "10.0.1.101"
      }
      deletion_protection = false
    }

    resource "yandex_dns_inbound_endpoint" "dns_connection" {
      name        = "dns-ep"
      description = "DNS Inbound"

      network_id  = yandex_vpc_network.my_net.id
      address_id  = yandex_vpc_address.dns_address.id

      deletion_protection = false
    }
    ```

    Where:

     * `name`: Connection name. It must be unique within a folder.
     * `description`: Connection description.
     * `network_id`: ID of the VPC network in which the inbound DNS connection will be created.
     * `address_id`: ID of the reserved IP address that will be used for the inbound DNS connection.

  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all the required resources. You can check the new resources in the [management console]({{ link-console-main }}) or using this [CLI](../../cli/quickstart.md) command:

     ```bash
     yc dns inbound-endpoint get <connection_name>
     ```

{% endlist %}
