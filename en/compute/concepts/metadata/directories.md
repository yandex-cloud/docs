---
title: Metadata folders in {{ compute-name }} VM instances
description: In this article, you will learn about the folders available in the {{ compute-full-name }} VM instance metadata service and the keys they contain.
---

# Metadata folders

The VM instance [metadata service](../vm-metadata.md) provides access to the following metadata folders:

| **Folder** | **Path** |
| --- | --- |
| `computeMetadata` | [/computeMetadata/v1/](#dir-compute) |
| `user-data` | [/latest/user-data/](#dir-user) |

## computeMetadata {#dir-compute}

The `computeMetadata` folder contains the following main keys:

#|
|| **Key name (path)** | **Description** | **Value example** ||
|| instance/attributes/enable-oslogin | Key responsible for access to the VM instance via [{{ oslogin }}](../../../organization/concepts/os-login.md). The possible values are:</br>- `true`: Access enabled.</br>- `false`: Access disabled. | `true` ||
|| instance/attributes/install-unified-agent | Key responsible for installing the [{{ unified-agent-short-name }}](../../../monitoring/concepts/data-collection/unified-agent/index.md) on the VM instance. The possible values are:</br>- `1`: Agent installed.</br>- `0`: Agent not installed. | `0` ||
|| instance/attributes/serial-port-enable | Key responsible for access to the VM instance via the [serial console](../../operations/serial-console/index.md). The possible values are:</br>- `1`: Access enabled.</br>- `0`: Access disabled. | `0` ||
|| instance/description | VM description. | `VM description` ||
|| instance/hostname | Full internal VM name ([FQDN](../network.md#hostname)). | `my-vm.{{ region-id }}.internal` ||
|| instance/id | VM ID. | `epdhfouo8bgq********` ||
|| instance/maintenance-event | Key indicating whether the [VM instance maintenance](../vm-policies.md) event has occurred. | `NONE` ||
|| instance/name | VM name. | `my-vm-name` ||
|| instance/zone | [Availability zone](../../../overview/concepts/geo-scope.md) ID in `projects/<cloud-id>/zones/<zone-id>` format. | `projects/b1g3o1qx3ra2********/zones/{{ region-id }}-d` ||
|| instance/disks/ | List of VM [disk](../disk.md) indexes. | `0/` ||
|| instance/disks/<disk_index>/device-name | Disk ID. | `epds95ahfikq********` ||
|| instance/disks/<disk_index>/mode | Disk operating mode. | `READ_WRITE` ||
|| instance/disks/<disk_index>/type | Disk [type](../disk.md#disks-types). | `PERSISTENT` ||
|| instance/disks/<disk_index>/index | Index in the list of VM disk indexes. | `0` ||
|| instance/network-interfaces/ | List of indexes of the VM instance [network interfaces](../network.md). | `0/` ||
|| instance/network-interfaces/<interface_index>/ip | [Internal IPv4 address](../network.md#internal-ip) of the VM instance network interface. | `10.128.0.27` ||
|| instance/network-interfaces/<interface_index>/mac | [MAC address](../network.md#mac-address) of the VM instance network interface. | `d0:0d:12:2f:84:2e` ||
|| instance/network-interfaces/<interface_index>/network | ID of the [subnet](../../../vpc/concepts/network.md#subnet) the network interface is connected to. | `e2lqsms4cdl3********` ||
|| instance/network-interfaces/<interface_index>/access-configs/<interface_index>/external-ip | [Public IP address](../network.md#public-ip) of the VM instance network interface. | `178.1**.2**.123` ||
|| instance/network-interfaces/<interface_index>/access-configs/<interface_index>/type | Type of external connectivity of the VM instance network interface. | `ONE_TO_ONE_NAT` ||
|| instance/service-accounts/ | Key indicating whether a [service account](../../../iam/concepts/users/service-accounts.md) is linked to the VM instance. If a service account is not linked, the key does not return anything. | `default/` ||
|| instance/service-accounts/default/token | Service account's [IAM token](../../../iam/concepts/authorization/iam-token.md) in [JSON](https://en.wikipedia.org/wiki/JSON) format. | 
```
\{"access_token":"t1.9euelZ*********dXkMXAQ",
"expires_in":42617,"token_type":"Bearer"\}
```
||
|| instance/vendor/cloud-id | ID of the [cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud) the VM instance is created in. | `b1gia87mbaom********` ||
|| instance/vendor/folder-id | ID of the [folder](../../../resource-manager/concepts/resources-hierarchy.md#cloud) the VM instance is created in. | `b1gt6g8ht345********` ||
|| instance/vendor/identity/document | [Identity document](./identity-document.md) in JSON format containing information about the VM instance ID (`instanceId`), ID of the image (`imageId`) the VM instance was created from, and additional info about the VM instance image. | 
```
\{"instanceId":"epdhfouo8bgq********",
"productCodes":null,"imageId":"fd8a1rd5b389********",
"productIds":["f2ev7krjsaqc********","f2eokm18lqng********"],
"createdAt":"2024-05-09T20:47:02Z","version":"2023-03-01"\}
```
||
|| instance/vendor/identity/base64 | [Cryptographic signature](./identity-document.md#signed-identity-documents) of the identity document in [Base64](https://www.base64encode.org/) format. | `U9UfLdKb91Zd********0bBs8ta0g==` ||
|| instance/vendor/identity/dsa | Cryptographic signature of the identity document in [DSA](https://en.wikipedia.org/wiki/Digital_Signature_Algorithm) format. | 
```
-----BEGIN PKCS7-----MIIB+QYJKoZIhvc
******/RaHgWi0=-----END PKCS7-----
```
||
|| instance/vendor/labels | List of [label](../../../resource-manager/concepts/labels.md) keys linked to the VM instance. | `env` ||
|| instance/vendor/labels/<label_key> | Value of selected label key from the list. | `prod` ||
|| instance/vendor/environment | Cloud [region](../../../overview/concepts/region.md). | `{{ region-id }}` ||
|| yandex/folder-id | ID of the folder the VM instance was created in. | `b1gt6g8ht345********` ||
|#


## user-data {#dir-user}

The `user-data` folder contains no separate keys, so the data is provided all at once when accessing the root key of the `/latest/user-data/` folder.

This folder stores the metadata specified by the user when [creating](../../operations/index.md#vm-create) or [modifying](../../operations/vm-control/vm-update.md#change-metadata) the VM instance. This information is received by the [cloud-init](https://cloudinit.readthedocs.io/en/latest/index.html) process initiated when the VM instance starts.

To get information from this folder, you need to [run a request](../../operations/vm-info/get-info.md#example4).

{% note alert %}

All data in the `user-data` metadata folder will be publicly available to any user with terminal access to the VM instance.

{% endnote %}

## Use cases {#examples}

* [{#T}](../../tutorials/secure-password-script.md)
* [{#T}](../../tutorials/rds-gw.md)
* [{#T}](../../../tutorials/security/gitlab-lockbox-integration.md)
* [{#T}](../../../tutorials/archive/vm-with-backup-policy/index.md)
* [{#T}](../../../tutorials/routing/multi-folder-vpc.md)

#### See also {#see-also}

* [{#T}](../vm-metadata.md)
* [{#T}](./public-image-keys.md)
* [{#T}](./sending-metadata.md)
* [{#T}](./accessing-metadata.md)
* [{#T}](./identity-document.md)