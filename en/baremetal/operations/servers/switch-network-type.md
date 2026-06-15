---
title: Switching the type of a network connected to a {{ baremetal-full-name }} server's network interface
description: Follow this guide to switch the type of a network connected to a {{ baremetal-full-name }} server's network interface from public to private or vice versa.
---

# Switching the type of a network connected to a network interface

If a server's [network interface](../../concepts/servers.md#network-interfaces) supports connection to both [private](../../concepts/private-network.md) and [public](../../concepts/public-network.md) networks, you can switch between these network types for that interface.

{% include [switch-iface-network-type-ddos-warn](../../../_includes/baremetal/switch-iface-network-type-ddos-warn.md) %}

To switch the type of a network connected to a network interface:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the server update command:

      ```bash
      yc baremetal server update --help
      ```
  1. Get a list of {{ baremetal-name }} servers in the default folder:

      ```bash
      yc baremetal server list
      ```

      Result:

      ```text
      +----------------------+---------------+---------+-------+---------------------+
      |          ID          |      NAME     | STATUS  | DISKS |     CREATED AT      |
      +----------------------+---------------+---------+-------+---------------------+
      | ly5zeaqeklpg******** | sample-server | RUNNING |       | 2026-05-15 11:46:38 |
      +----------------------+---------------+---------+-------+---------------------+
      ```
  1. Identify the server interface that supports both private and public network connections. The procedure depends on the server configuration type ([ready-made](../../concepts/server-configurations.md) or [custom](../../concepts/server-custom-configurations.md)):

      {% list tabs group=bms_server_type %}

      - Ready-made configuration {#standard}

        1. Get detailed information about your server by specifying its name or ID:

            ```bash
            yc baremetal server get sample-server
            ```

            Result:

            ```yaml
            id: ly5zeaqeklpg********
            ...
            network_interfaces:
              - private_subnet:
                  private_subnet_id: ly5lpb2vydo7********
                private_interface:
                  native_subnet_id: ly5lpb2vydo7********
                  mac_limit: "5"
                id: ly5zjjc2vfpi********
                mac_address: b4:2e:99:58:2b:a6
                configuration_network_interface_id: ly5oc5p4u6vg********
              - private_subnet:
                  private_subnet_id: ly5lpb2vydo7********
                private_interface:
                  native_subnet_id: ly5lpb2vydo7********
                  mac_limit: "5"
                id: ly5mzklkjpa5********
                mac_address: b4:2e:99:58:2b:a8
                configuration_network_interface_id: ly5dmh2u3qwe********
            configuration_id: ly5tdlrmwezt********
            created_at: "2026-05-15T11:46:38.842525Z"
            ```

            As the output shows, your server has two network interfaces, both currently connected to a private network (private subnet `ly5lpb2vydo7********`):

            * Interface `ly5zjjc2vfpi********`, associated with network interface [configuration](../../concepts/server-configurations.md#components) `ly5oc5p4u6vg********`.
            * Interface `ly5mzklkjpa5********`, associated with network interface configuration `ly5dmh2u3qwe********`.

            Server configuration ID (`configuration_id`): `ly5tdlrmwezt********`. Save this value, as you will need it in the next step.
        1. Get details on your server's [configuration](../../concepts/server-configurations.md#components) to determine which of the two interfaces supports both `PRIVATE` and `PUBLIC` network types. To do this, run the following command while specifying the server configuration ID you saved earlier:

            ```bash
            yc baremetal configuration get ly5tdlrmwezt********
            ```

            {% include [conf-get-cli-output](../../../_includes/baremetal/instruction-steps/conf-get-cli-output.md) %}

            The output shows that, given the server configuration, the interface with configuration ID `ly5dmh2u3qwe********` supports both `PRIVATE` and `PUBLIC` networks.

            From the earlier `yc baremetal server get` output, this network interface configuration ID (`ly5dmh2u3qwe********`) corresponds to the server's network interface `ly5mzklkjpa5********`. Thus, this is the only interface here that supports network type switching.

      - Custom configuration {#custom}

        1. Get detailed information about your server by specifying its name or ID:

            ```bash
            yc baremetal server get sample-server
            ```

            Result:

            ```yaml
            id: ly5zeaqeklpg********
            ...
            network_interfaces:
              - private_subnet:
                  private_subnet_id: ly5lpb2vydo7********
                private_interface:
                  native_subnet_id: ly5lpb2vydo7********
                  mac_limit: "5"
                id: ly5zjjc2vfpi********
                mac_address: b4:2e:99:58:2b:a6
                configuration_network_interface_id: ly5oc5p4u6vg********
              - private_subnet:
                  private_subnet_id: ly5lpb2vydo7********
                private_interface:
                  native_subnet_id: ly5lpb2vydo7********
                  mac_limit: "5"
                id: ly5mzklkjpa5********
                mac_address: b4:2e:99:58:2b:a8
                configuration_network_interface_id: ly5dmh2u3qwe********
            configuration:
              custom_configuration:
                cpu:
                  cores: "8"
                  frequency_mhz: "2600"
                  name: Xeon E5-2650V2
                  physical_cores: "8"
                  vendor: Intel
                cpu_num: "2"
                disk_drives:
                  - disk_count: "2"
                    disk_size_gib: "3725"
                    type: HDD
                id: ly5x6w3htlgx********
                memory_gib: "128"
                mounting_availability: UNAVAILABLE
                name: custom-ly5x6w3htlgx********
                network_capacity_gbps: "1"
                network_interfaces:
                  - id: ly5oc5p4u6vg********
                    name: iface0
                    configuration_id: ly5x6w3htlgx********
                    link_speed_gbps: '1'
                    available_modes:
                      - PRIVATE
                  - id: ly5dmh2u3qwe********
                    name: iface1
                    configuration_id: ly5x6w3htlgx********
                    link_speed_gbps: '1'
                    available_modes:
                      - PRIVATE
                      - PUBLIC
            created_at: "2026-05-18T07:42:32.835148Z"
            ```

            As you can see in the output:
            * Your server has two network interfaces (see them under `network_interfaces`), both currently connected to a private network (private subnet `ly5lpb2vydo7********`):

                * Interface `ly5zjjc2vfpi********`, associated with network interface [configuration](../../concepts/server-configurations.md#components) `ly5oc5p4u6vg********`.
                * Interface `ly5mzklkjpa5********`, associated with network interface configuration `ly5dmh2u3qwe********`.
            * The network interface [configuration](../../concepts/server-configurations.md#components) (under `configuration.custom_configuration.network_interfaces`) that supports connecting to different network types (`PRIVATE` and `PUBLIC`) has this ID (the `id` field value): `ly5dmh2u3qwe********`.
            * Under `network_interfaces`, network interface configuration `ly5dmh2u3qwe********` is associated (via the `configuration_network_interface_id` field) with the server's network interface `ly5mzklkjpa5********`. Thus, this is the only interface here that supports network type switching.

      {% endlist %}

  1. Get a list of subnets available for connecting to the server's network interface in the default folder:

      {% include [server-priv-netwrk-same-pool-notice](../../../_includes/baremetal/server-priv-netwrk-same-pool-notice.md) %}

      {% list tabs group=bms_network_type %}

      - Connecting a public network {#public}

        To connect a network interface to a public network, get a list of available public subnets by running this command:

        ```bash
        yc baremetal public-subnet list
        ```

        Result:

        ```text
        +----------------------+------+---------------+-------------------+
        |          ID          | NAME |    ZONE-ID    | HARDWARE-POOL-IDS |
        +----------------------+------+---------------+-------------------+
        | ly57sgipg23b******** |      | {{ region-id }}-m | {{ region-id }}-m4    |
        +----------------------+------+---------------+-------------------+
        ```

      - Connecting a private network {#private}

        To connect a network interface to a private network, get a list of available private subnets by running this command:

        ```bash
        yc baremetal private-subnet list
        ```

        Result:

        ```text
        +----------------------+----------------------+--------+--------------------------------+
        |          ID          |         NAME         | STATUS |          VRF-OPTIONS           |
        +----------------------+----------------------+--------+--------------------------------+
        | ly5lpb2vydo7******** | m4-subnet            | READY  | vrf_id: ly5xox6z2fyn********,  |
        |                      |                      |        | cidr: 192.168.20.0/24,         |
        |                      |                      |        | gateway_ip: 192.168.20.1       |
        | ly5v3mfr4bm5******** | m3-subnet            | READY  | vrf_id: ly5xox6z2fyn********,  |
        |                      |                      |        | cidr: 192.168.21.0/24,         |
        |                      |                      |        | gateway_ip: 192.168.21.1,      |
        |                      |                      |        | start_ip: 192.168.21.1,        |
        |                      |                      |        | end_ip: 192.168.21.254         |
        +----------------------+----------------------+--------+--------------------------------+
        ```

      {% endlist %}

  1. Update the type of the network connected to the server's interface by specifying the server ID, the IDs of both network interfaces, and the IDs of the subnets to connect to each interface:

      {% include [switch-network-role-notice](../../../_includes/baremetal/switch-network-role-notice.md) %}

      {% list tabs group=bms_network_type %}

      - Connecting a public network {#public}

        In the example, the network interface that supports switching between network types is connected to a public network, while the settings for the other interface remain unchanged:

        ```bash
        yc baremetal server update \
          --id=ly5zeaqeklpg******** \
          --network-interfaces='id=ly5zjjc2vfpi********,private-subnet-id=ly5lpb2vydo7********' \
          --network-interfaces='id=ly5mzklkjpa5********,public-subnet-id=ly57sgipg23b********' \
          --async
        ```

      - Connecting a private network {#private}

        In the example, the network interface that supports switching between network types is connected to a private network, while the settings for the other interface remain unchanged:

        ```bash
        yc baremetal server update \
          --id=ly5zeaqeklpg******** \
          --network-interfaces='id=ly5zjjc2vfpi********,private-subnet-id=ly5lpb2vydo7********' \
          --network-interfaces='id=ly5mzklkjpa5********,private-subnet-id=ly5lpb2vydo7********' \
          --async
        ```

      {% endlist %}

      Result:

      ```bash
      id: ly5mroq72gok********
      description: Server update
      created_at: "2026-05-18T05:44:28.751844Z"
      created_by: ajeol2afu1js********
      modified_at: "2026-05-18T05:44:28.751844Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.baremetal.v1alpha.UpdateServerMetadata
        server_id: ly5zeaqeklpg********
      ```
  1. Wait for the operation to complete (usually about five minutes), then refetch server details to confirm the interface network update:

      ```bash
      yc baremetal server get sample-server
      ```

      Result:

      ```yaml
      id: ly5zeaqeklpg********
      ...
      network_interfaces:
        - private_subnet:
            private_subnet_id: ly5lpb2vydo7********
          private_interface:
            native_subnet_id: ly5lpb2vydo7********
            mac_limit: "5"
          id: ly5zjjc2vfpi********
          mac_address: b4:2e:99:58:2b:a6
          configuration_network_interface_id: ly5oc5p4u6vg********
        - public_subnet:
            public_subnet_id: ly57sgipg23b********
          public_interface:
            ip_address: 185.184.***.***
            native_subnet_id: ly57sgipg23b********
            mac_limit: "5"
          id: ly5mzklkjpa5********
          mac_address: b4:2e:99:58:2b:a8
          ip_address: 185.184.***.***
          configuration_network_interface_id: ly5dmh2u3qwe********
      ...
      ```

- API {#api}

  To use these examples, install [cURL](https://curl.haxx.se) and [get](../../../iam/operations/index.md#authentication) an IAM token for authenticating with the {{ yandex-cloud }} [API](../../../api-design-guide/index.yaml).

  {% note tip %}

  For convenience, consider storing the [IAM token](../../../iam/concepts/authorization/iam-token.md) in an environment variable before sending requests.

  {% endnote %}

  The procedure for switching the network type depends on the server configuration type ([ready-made](../../concepts/server-configurations.md) or [custom](../../concepts/server-custom-configurations.md)):

  {% list tabs group=bms_server_type %}

  - Ready-made configuration {#standard}

    1. Get information about your server by including its [ID](*server_id) in the request:

        ```bash
        curl \
          --request GET \
          --header "Authorization: Bearer <IAM_token>" \
          "https://baremetal.{{ api-host }}/baremetal/v1alpha/servers/<server_ID>"
        ```

        Result:

        ```json
        {
          ...
          "networkInterfaces": [
            {
              "privateSubnet": {
                "privateSubnetId": "ly5lpb2vydo7********"
              },
              "privateInterface": {
                "nativeSubnetId": "ly5lpb2vydo7********",
                "macLimit": "5"
              },
              "id": "ly5zjjc2vfpi********",
              "macAddress": "b4:2e:99:58:2b:a6",
              "configurationNetworkInterfaceId": "ly5oc5p4u6vg********"
            },
            {
              "privateSubnet": {
                "privateSubnetId": "ly5lpb2vydo7********"
              },
              "privateInterface": {
                "nativeSubnetId": "ly5lpb2vydo7********",
                "macLimit": "5"
              },
              "id": "ly5mzklkjpa5********",
              "macAddress": "b4:2e:99:58:2b:a8",
              "configurationNetworkInterfaceId": "ly5dmh2u3qwe********"
            }
          ],
            "id": "ly5zeaqeklpg********",
            "cloudId": "b1gia87mbaom********",
            "folderId": "b1gt6g8ht345********",
            "name": "sample-server",
            "zoneId": "{{ region-id }}-m",
            "hardwarePoolId": "{{ region-id }}-m4",
            "status": "RUNNING",
            "configurationId": "ly5tdlrmwezt********",
            "createdAt": "2026-05-15T11:46:38.842525Z"
        }
        ```

        As the example shows, your server has two network interfaces, both currently connected to a private network (private subnet `ly5lpb2vydo7********`):

        * Interface `ly5zjjc2vfpi********`, associated with network interface [configuration](../../concepts/server-configurations.md#components) `ly5oc5p4u6vg********`.
        * Interface `ly5mzklkjpa5********`, associated with network interface configuration `ly5dmh2u3qwe********`.

        Server configuration ID (`configurationId`): `ly5tdlrmwezt********`. Save this value, as you will need it in the next request.
    1. Get details on your server's [configuration](../../concepts/server-configurations.md#components) to determine which of the two interfaces supports both `PRIVATE` and `PUBLIC` network types. To do this, execute the following request while specifying the server configuration ID you saved earlier:

        ```bash
        curl \
          --request GET \
          --header "Authorization: Bearer <IAM_token>" \
          "https://baremetal.{{ api-host }}/baremetal/v1alpha/configurations/ly5tdlrmwezt********"
        ```

        Result:

        ```json
        {
          "cpu": {
            "name": "Xeon D-1521",
            "vendor": "Intel",
            "cores": "8",
            "physicalCores": "4",
            "frequencyMhz": "2400"
          },
          "diskDrives": [
            {
              "type": "SSD",
              "diskCount": "2",
              "diskSizeGib": "838"
            }
          ],
          "id": "ly5tdlrmwezt********",
          "name": "LA-i107-S-1/10G",
          "memoryGib": "16",
          "networkCapacityGbps": "10",
          "cpuNum": "1",
          "networkInterfaces": [
            {
              "id": "ly5oc5p4u6vg********",
              "name": "iface0",
              "configurationId": "ly5tdlrmwezt********",
              "linkSpeedGbps": "1",
              "availableModes": [
                "PRIVATE"
              ]
            },
            {
              "id": "ly5dmh2u3qwe********",
              "name": "iface1",
              "configurationId": "ly5tdlrmwezt********",
              "linkSpeedGbps": "1",
              "availableModes": [
                "PRIVATE",
                "PUBLIC"
              ]
            }
          ],
          "mountingAvailability": "UNAVAILABLE"
        }
        ```

        The output shows that, given the server configuration, the interface with configuration ID `ly5dmh2u3qwe********` supports both `PRIVATE` and `PUBLIC` networks.

        From the output of your earlier server information request, this network interface configuration ID (`ly5dmh2u3qwe********`) corresponds to the server's network interface `ly5mzklkjpa5********`. Thus, this is the only interface here that supports network type switching.

  - Custom configuration {#custom}

    1. Get information about your server by including its [ID](*server_id) in the request:

        ```bash
        curl \
          --request GET \
          --header "Authorization: Bearer <IAM_token>" \
          "https://baremetal.{{ api-host }}/baremetal/v1alpha/servers/<server_ID>"
        ```

        Result:

        ```json
        {
          ...
          "networkInterfaces": [
            {
              "privateSubnet": {
                "privateSubnetId": "ly5lpb2vydo7********"
              },
              "privateInterface": {
                "nativeSubnetId": "ly5lpb2vydo7********",
                "macLimit": "5"
              },
              "id": "ly5zjjc2vfpi********",
              "macAddress": "b4:2e:99:58:2b:a6",
              "configurationNetworkInterfaceId": "ly5oc5p4u6vg********"
            },
            {
              "privateSubnet": {
                "privateSubnetId": "ly5lpb2vydo7********"
              },
              "privateInterface": {
                "nativeSubnetId": "ly5lpb2vydo7********",
                "macLimit": "5"
              },
              "id": "ly5mzklkjpa5********",
              "macAddress": "b4:2e:99:58:2b:a8",
              "configurationNetworkInterfaceId": "ly5dmh2u3qwe********"
            }
          ],
          "customConfiguration": {
            "id": "ly5vpv5ktwut********",
            "name": "custom-ly5vpv5ktwut********",
            "memoryGib": "128",
            "cpu": {
              "name": "Xeon E5-2650V2",
              "vendor": "Intel",
              "cores": "8",
              "physicalCores": "8",
              "frequencyMhz": "2600"
            },
            "diskDrives": [
              {
                "type": "HDD",
                "diskCount": "2",
                "diskSizeGib": "3725"
              }
            ],
            "cpuNum": "2",
            "networkInterfaces": [
              {
                "id": "ly5oc5p4u6vg********",
                "name": "iface0",
                "configurationId": "ly5vpv5ktwut********",
                "linkSpeedGbps": "1",
                "availableModes": [
                  "PRIVATE"
                ]
              },
              {
                "id": "ly5dmh2u3qwe********",
                "name": "iface1",
                "configurationId": "ly5vpv5ktwut********",
                "linkSpeedGbps": "1",
                "availableModes": [
                  "PRIVATE",
                  "PUBLIC"
                ]
              }
            ],
            "mountingAvailability": "UNAVAILABLE"
          },
          "id": "ly5zeaqeklpg********",
          "cloudId": "b1gia87mbaom********",
          "folderId": "b1gt6g8ht345********",
          "name": "sample-server",
          "zoneId": "{{ region-id }}-m",
          "hardwarePoolId": "{{ region-id }}-m4",
          "status": "RUNNING",
          "createdAt": "2026-05-15T11:46:38.842525Z"
        }
        ```

        As you can see in the output:
        * Your server has two network interfaces (see them under `networkInterfaces`), both currently connected to a private network (private subnet `ly5lpb2vydo7********`):

            * Interface `ly5zjjc2vfpi********`, associated with network interface [configuration](../../concepts/server-configurations.md#components) `ly5oc5p4u6vg********`.
            * Interface `ly5mzklkjpa5********`, associated with network interface configuration `ly5dmh2u3qwe********`.
        * The network interface [configuration](../../concepts/server-configurations.md#components) (under `customConfiguration.networkInterfaces`) that supports connecting to different network types (`PRIVATE` and `PUBLIC`) has this ID (the `id` field value): `ly5dmh2u3qwe********`.
        * Under `networkInterfaces`, network interface configuration `ly5dmh2u3qwe********` is associated (via the `configurationNetworkInterfaceId` field) with the server's network interface `ly5mzklkjpa5********`. Thus, this is the only interface here that supports network type switching.
 
  {% endlist %}

  1. Update the type of the network connected to the server's interface by specifying the server ID, the IDs of both network interfaces, and the IDs of the subnets to connect to each interface:

      {% include [switch-network-role-notice](../../../_includes/baremetal/switch-network-role-notice.md) %}

      {% list tabs group=bms_network_type %}

      - Connecting a public network {#public}

        In the example, the network interface that supports switching between network types is connected to a public network, while the settings for the other interface remain unchanged.

        Execute the following request specifying the server ID, the IDs of its network interfaces, and those of the desired [subnets](*subnets):

        {% include [server-priv-netwrk-same-pool-notice](../../../_includes/baremetal/server-priv-netwrk-same-pool-notice.md) %}

        ```bash
        curl \
          --request PATCH \
          --header "Authorization: Bearer <IAM_token>" \
          "https://baremetal.{{ api-host }}/baremetal/v1alpha/servers/<server_ID>" \
          --data \
                  '''
                  {
                    "updateMask": {
                      "paths": [
                        "network_interfaces"
                      ]
                    },
                    "networkInterfaces": [
                      {
                        "id": "ly5zjjc2vfpi********",
                        "privateInterface": {
                          "nativeSubnetId": "ly5lpb2vydo7********"
                        }
                      },
                      {
                        "id": "ly5mzklkjpa5********",
                        "publicInterface": {
                          "nativeSubnet": {
                            "subnetId": "ly57sgipg23b********"
                          }
                        }
                      }
                    ]
                  }
                  '''
        ```

      - Connecting a private network {#private}

        In the example, the network interface that supports switching between network types is connected to a private network, while the settings for the other interface remain unchanged.

        Execute the following request specifying the server ID, the IDs of its network interfaces, and those of the desired [subnets](*subnets):

        {% include [server-priv-netwrk-same-pool-notice](../../../_includes/baremetal/server-priv-netwrk-same-pool-notice.md) %}

        ```bash
        curl \
          --request PATCH \
          --header "Authorization: Bearer <IAM_token>" \
          "https://baremetal.{{ api-host }}/baremetal/v1alpha/servers/<server_ID>" \
          --data \
                  '''
                  {
                    "updateMask": {
                      "paths": [
                        "network_interfaces"
                      ]
                    },
                    "networkInterfaces": [
                      {
                        "id": "ly5zjjc2vfpi********",
                        "privateInterface": {
                          "nativeSubnetId": "ly5lpb2vydo7********"
                        }
                      },
                      {
                        "id": "ly5mzklkjpa55xikrktd",
                        "privateInterface": {
                          "nativeSubnetId": "ly5lpb2vydo7********"
                        }
                      }
                    ]
                  }
                  '''
        ```

      {% endlist %}

      Result:

      ```json
      {
        "done": false,
        "metadata": {
          "@type": "type.googleapis.com/yandex.cloud.baremetal.v1alpha.UpdateServerMetadata",
          "serverId": "ly5zeaqeklpg********"
        },
        "id": "ly56w27i7ehd********",
        "description": "Server update",
        "createdAt": "2026-05-18T18:28:52.058175Z",
        "createdBy": "ajeol2afu1js********",
        "modifiedAt": "2026-05-18T18:28:52.058175Z"
      }
      ```
  1. Wait for the operation to complete (usually about five minutes), then refetch server details to confirm the interface network update.

{% endlist %}

[*server_id]: You can get the server ID using the [management console]({{ link-console-main }}) or this [{{ yandex-cloud }} CLI](../../../cli/cli-ref/baremetal/cli-ref/server/list.md) command: `yc baremetal server list`.

[*subnets]: * Private subnet IDs are available in the [management console]({{ link-console-main }}) or via this [{{ yandex-cloud }} CLI](../../../cli/cli-ref/baremetal/cli-ref/private-subnet/list.md) command: `yc baremetal private-subnet list`.
* Public subnet IDs are available in the [management console]({{ link-console-main }}) or via this [{{ yandex-cloud }} CLI](../../../cli/cli-ref/baremetal/cli-ref/public-subnet/list.md) command: `yc baremetal public-subnet list`.