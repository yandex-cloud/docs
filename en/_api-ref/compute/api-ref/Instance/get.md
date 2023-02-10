---
editable: false
---

# Compute Cloud API, REST: Instance.get
Returns the specified Instance resource.
 
To get the list of available Instance resources, make a [list](/docs/compute/api-ref/Instance/list) request.
 
## HTTP request {#https-request}
```
GET https://compute.{{ api-host }}/compute/v1/instances/{instanceId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
instanceId | <p>Required. ID of the Instance resource to return. To get the instance ID, use a <a href="/docs/compute/api-ref/Instance/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
view | <p>Defines which information about the Instance resource should be returned in the server response.</p> <ul> <li>BASIC: Doesn't include the metadata of the instance in the server response.</li> <li>FULL: Returns the metadata of the instance in the server response.</li> </ul> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "zoneId": "string",
  "platformId": "string",
  "resources": {
    "memory": "string",
    "cores": "string",
    "coreFraction": "string",
    "gpus": "string"
  },
  "status": "string",
  "metadata": "object",
  "metadataOptions": {
    "gceHttpEndpoint": "string",
    "awsV1HttpEndpoint": "string",
    "gceHttpToken": "string",
    "awsV1HttpToken": "string"
  },
  "bootDisk": {
    "mode": "string",
    "deviceName": "string",
    "autoDelete": true,
    "diskId": "string"
  },
  "secondaryDisks": [
    {
      "mode": "string",
      "deviceName": "string",
      "autoDelete": true,
      "diskId": "string"
    }
  ],
  "localDisks": [
    {
      "size": "string",
      "deviceName": "string"
    }
  ],
  "filesystems": [
    {
      "mode": "string",
      "deviceName": "string",
      "filesystemId": "string"
    }
  ],
  "networkInterfaces": [
    {
      "index": "string",
      "macAddress": "string",
      "subnetId": "string",
      "primaryV4Address": {
        "address": "string",
        "oneToOneNat": {
          "address": "string",
          "ipVersion": "string",
          "dnsRecords": [
            {
              "fqdn": "string",
              "dnsZoneId": "string",
              "ttl": "string",
              "ptr": true
            }
          ]
        },
        "dnsRecords": [
          {
            "fqdn": "string",
            "dnsZoneId": "string",
            "ttl": "string",
            "ptr": true
          }
        ]
      },
      "primaryV6Address": {
        "address": "string",
        "oneToOneNat": {
          "address": "string",
          "ipVersion": "string",
          "dnsRecords": [
            {
              "fqdn": "string",
              "dnsZoneId": "string",
              "ttl": "string",
              "ptr": true
            }
          ]
        },
        "dnsRecords": [
          {
            "fqdn": "string",
            "dnsZoneId": "string",
            "ttl": "string",
            "ptr": true
          }
        ]
      },
      "securityGroupIds": [
        "string"
      ]
    }
  ],
  "fqdn": "string",
  "schedulingPolicy": {
    "preemptible": true
  },
  "serviceAccountId": "string",
  "networkSettings": {
    "type": "string"
  },
  "placementPolicy": {
    "placementGroupId": "string",
    "hostAffinityRules": [
      {
        "key": "string",
        "op": "string",
        "values": [
          "string"
        ]
      }
    ]
  }
}
```
An Instance resource. For more information, see [Instances](/docs/compute/concepts/vm).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the instance.</p> 
folderId | **string**<br><p>ID of the folder that the instance belongs to.</p> 
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the instance. 1-63 characters long.</p> 
description | **string**<br><p>Description of the instance. 0-256 characters long.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
zoneId | **string**<br><p>ID of the availability zone where the instance resides.</p> 
platformId | **string**<br><p>ID of the hardware platform configuration for the instance.</p> 
resources | **object**<br><p>Computing resources of the instance such as the amount of memory and number of cores.</p> 
resources.<br>memory | **string** (int64)<br><p>The amount of memory available to the instance, specified in bytes.</p> 
resources.<br>cores | **string** (int64)<br><p>The number of cores available to the instance.</p> 
resources.<br>coreFraction | **string** (int64)<br><p>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core.</p> 
resources.<br>gpus | **string** (int64)<br><p>The number of GPUs available to the instance.</p> 
status | **string**<br><p>Status of the instance.</p> <ul> <li>PROVISIONING: Instance is waiting for resources to be allocated.</li> <li>RUNNING: Instance is running normally.</li> <li>STOPPING: Instance is being stopped.</li> <li>STOPPED: Instance stopped.</li> <li>STARTING: Instance is being started.</li> <li>RESTARTING: Instance is being restarted.</li> <li>UPDATING: Instance is being updated.</li> <li>ERROR: Instance encountered a problem and cannot operate.</li> <li>CRASHED: Instance crashed and will be restarted automatically.</li> <li>DELETING: Instance is being deleted.</li> </ul> 
metadata | **object**<br><p>The metadata ``key:value`` pairs assigned to this instance. This includes custom metadata and predefined keys.</p> <p>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see <a href="/docs/compute/concepts/vm-metadata">Metadata</a>.</p> 
metadataOptions | **object**<br><p>Options allow user to configure access to instance's metadata</p> 
metadataOptions.<br>gceHttpEndpoint | **string**<br><p>Enabled access to GCE flavored metadata</p> <ul> <li>ENABLED: Option is enabled</li> <li>DISABLED: Option is disabled</li> </ul> 
metadataOptions.<br>awsV1HttpEndpoint | **string**<br><p>Enabled access to AWS flavored metadata (IMDSv1)</p> <ul> <li>ENABLED: Option is enabled</li> <li>DISABLED: Option is disabled</li> </ul> 
metadataOptions.<br>gceHttpToken | **string**<br><p>Enabled access to IAM credentials with GCE flavored metadata</p> <ul> <li>ENABLED: Option is enabled</li> <li>DISABLED: Option is disabled</li> </ul> 
metadataOptions.<br>awsV1HttpToken | **string**<br><p>Enabled access to IAM credentials with AWS flavored metadata (IMDSv1)</p> <ul> <li>ENABLED: Option is enabled</li> <li>DISABLED: Option is disabled</li> </ul> 
bootDisk | **object**<br><p>Boot disk that is attached to the instance.</p> 
bootDisk.<br>mode | **string**<br><p>Access mode to the Disk resource.</p> <ul> <li>READ_ONLY: Read-only access.</li> <li>READ_WRITE: Read/Write access.</li> </ul> 
bootDisk.<br>deviceName | **string**<br><p>Serial number that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance.</p> <p>This value can be used to reference the device for mounting, resizing, and so on, from within the instance.</p> 
bootDisk.<br>autoDelete | **boolean** (boolean)<br><p>Specifies whether the disk will be auto-deleted when the instance is deleted.</p> 
bootDisk.<br>diskId | **string**<br><p>ID of the disk that is attached to the instance.</p> 
secondaryDisks[] | **object**<br><p>Array of secondary disks that are attached to the instance.</p> 
secondaryDisks[].<br>mode | **string**<br><p>Access mode to the Disk resource.</p> <ul> <li>READ_ONLY: Read-only access.</li> <li>READ_WRITE: Read/Write access.</li> </ul> 
secondaryDisks[].<br>deviceName | **string**<br><p>Serial number that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance.</p> <p>This value can be used to reference the device for mounting, resizing, and so on, from within the instance.</p> 
secondaryDisks[].<br>autoDelete | **boolean** (boolean)<br><p>Specifies whether the disk will be auto-deleted when the instance is deleted.</p> 
secondaryDisks[].<br>diskId | **string**<br><p>ID of the disk that is attached to the instance.</p> 
localDisks[] | **object**<br><p>Array of local disks that are attached to the instance.</p> 
localDisks[].<br>size | **string** (int64)<br><p>Size of the disk, specified in bytes.</p> 
localDisks[].<br>deviceName | **string**<br><p>Serial number that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance.</p> <p>This value can be used to reference the device for mounting, resizing, and so on, from within the instance.</p> 
filesystems[] | **object**<br><p>Array of filesystems that are attached to the instance.</p> 
filesystems[].<br>mode | **string**<br><p>Access mode to the filesystem.</p> <ul> <li>READ_ONLY: Read-only access.</li> <li>READ_WRITE: Read/Write access.</li> </ul> 
filesystems[].<br>deviceName | **string**<br><p>Name of the device representing the filesystem on the instance.</p> <p>The name should be used for referencing the filesystem from within the instance when it's being mounted, resized etc.</p> 
filesystems[].<br>filesystemId | **string**<br><p>ID of the filesystem that is attached to the instance.</p> 
networkInterfaces[] | **object**<br><p>Array of network interfaces that are attached to the instance.</p> 
networkInterfaces[].<br>index | **string**<br><p>The index of the network interface, generated by the server, 0,1,2... etc. Currently only one network interface is supported per instance.</p> 
networkInterfaces[].<br>macAddress | **string**<br><p>MAC address that is assigned to the network interface.</p> 
networkInterfaces[].<br>subnetId | **string**<br><p>ID of the subnet.</p> 
networkInterfaces[].<br>primaryV4Address | **object**<br><p>Primary IPv4 address that is assigned to the instance for this network interface.</p> 
networkInterfaces[].<br>primaryV4Address.<br>address | **string**<br><p>An IPv4 internal network address that is assigned to the instance for this network interface.</p> 
networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat | **object**<br><p>One-to-one NAT configuration. If missing, NAT has not been set up.</p> 
networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat.<br>address | **string**<br><p>An external IP address associated with this instance.</p> 
networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat.<br>ipVersion | **string**<br><p>IP version for the external IP address.</p> <ul> <li>IPV4: IPv4 address, for example 192.0.2.235.</li> <li>IPV6: IPv6 address. Not available yet.</li> </ul> 
networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat.<br>dnsRecords[] | **object**<br><p>External DNS configuration</p> 
networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat.<br>dnsRecords[].<br>fqdn | **string**<br><p>Name of the A/AAAA record as specified when creating the instance. Note that if `fqdn' has no trailing '.', it is specified relative to the zone (@see dns_zone_id).</p> 
networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat.<br>dnsRecords[].<br>dnsZoneId | **string**<br><p>DNS zone id for the record (optional, if not set, some private zone is used).</p> 
networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat.<br>dnsRecords[].<br>ttl | **string** (int64)<br><p>DNS record ttl (optional, if not set, a reasonable default is used.)</p> 
networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat.<br>dnsRecords[].<br>ptr | **boolean** (boolean)<br><p>When true, indicates there is a corresponding auto-created PTR DNS record.</p> 
networkInterfaces[].<br>primaryV4Address.<br>dnsRecords[] | **object**<br><p>Internal DNS configuration</p> 
networkInterfaces[].<br>primaryV4Address.<br>dnsRecords[].<br>fqdn | **string**<br><p>Name of the A/AAAA record as specified when creating the instance. Note that if `fqdn' has no trailing '.', it is specified relative to the zone (@see dns_zone_id).</p> 
networkInterfaces[].<br>primaryV4Address.<br>dnsRecords[].<br>dnsZoneId | **string**<br><p>DNS zone id for the record (optional, if not set, some private zone is used).</p> 
networkInterfaces[].<br>primaryV4Address.<br>dnsRecords[].<br>ttl | **string** (int64)<br><p>DNS record ttl (optional, if not set, a reasonable default is used.)</p> 
networkInterfaces[].<br>primaryV4Address.<br>dnsRecords[].<br>ptr | **boolean** (boolean)<br><p>When true, indicates there is a corresponding auto-created PTR DNS record.</p> 
networkInterfaces[].<br>primaryV6Address | **object**<br><p>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet.</p> 
networkInterfaces[].<br>primaryV6Address.<br>address | **string**<br><p>An IPv4 internal network address that is assigned to the instance for this network interface.</p> 
networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat | **object**<br><p>One-to-one NAT configuration. If missing, NAT has not been set up.</p> 
networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat.<br>address | **string**<br><p>An external IP address associated with this instance.</p> 
networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat.<br>ipVersion | **string**<br><p>IP version for the external IP address.</p> <ul> <li>IPV4: IPv4 address, for example 192.0.2.235.</li> <li>IPV6: IPv6 address. Not available yet.</li> </ul> 
networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat.<br>dnsRecords[] | **object**<br><p>External DNS configuration</p> 
networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat.<br>dnsRecords[].<br>fqdn | **string**<br><p>Name of the A/AAAA record as specified when creating the instance. Note that if `fqdn' has no trailing '.', it is specified relative to the zone (@see dns_zone_id).</p> 
networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat.<br>dnsRecords[].<br>dnsZoneId | **string**<br><p>DNS zone id for the record (optional, if not set, some private zone is used).</p> 
networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat.<br>dnsRecords[].<br>ttl | **string** (int64)<br><p>DNS record ttl (optional, if not set, a reasonable default is used.)</p> 
networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat.<br>dnsRecords[].<br>ptr | **boolean** (boolean)<br><p>When true, indicates there is a corresponding auto-created PTR DNS record.</p> 
networkInterfaces[].<br>primaryV6Address.<br>dnsRecords[] | **object**<br><p>Internal DNS configuration</p> 
networkInterfaces[].<br>primaryV6Address.<br>dnsRecords[].<br>fqdn | **string**<br><p>Name of the A/AAAA record as specified when creating the instance. Note that if `fqdn' has no trailing '.', it is specified relative to the zone (@see dns_zone_id).</p> 
networkInterfaces[].<br>primaryV6Address.<br>dnsRecords[].<br>dnsZoneId | **string**<br><p>DNS zone id for the record (optional, if not set, some private zone is used).</p> 
networkInterfaces[].<br>primaryV6Address.<br>dnsRecords[].<br>ttl | **string** (int64)<br><p>DNS record ttl (optional, if not set, a reasonable default is used.)</p> 
networkInterfaces[].<br>primaryV6Address.<br>dnsRecords[].<br>ptr | **boolean** (boolean)<br><p>When true, indicates there is a corresponding auto-created PTR DNS record.</p> 
networkInterfaces[].<br>securityGroupIds[] | **string**<br><p>ID's of security groups attached to the interface</p> 
fqdn | **string**<br><p>A domain name of the instance. FQDN is defined by the server in the format ``&lt;hostname&gt;.&lt;region_id&gt;.internal`` when the instance is created. If the hostname were not specified when the instance was created, FQDN would be ``&lt;id&gt;.auto.internal``.</p> 
schedulingPolicy | **object**<br><p>Scheduling policy configuration.</p> 
schedulingPolicy.<br>preemptible | **boolean** (boolean)<br><p>True for short-lived compute instances. For more information, see <a href="/docs/compute/concepts/preemptible-vm">Preemptible VMs</a>.</p> 
serviceAccountId | **string**<br><p>ID of the service account to use for <a href="/docs/compute/operations/vm-connect/auth-inside-vm">authentication inside the instance</a>. To get the service account ID, use a <a href="/docs/iam/api-ref/ServiceAccount/list">list</a> request.</p> 
networkSettings | **object**<br><p>Network Settings</p> 
networkSettings.<br>type | **string**<br><p>Network Type</p> <ul> <li>STANDARD: Standard network.</li> <li>SOFTWARE_ACCELERATED: Software accelerated network.</li> <li>HARDWARE_ACCELERATED: Hardware accelerated network (not available yet, reserved for future use).</li> </ul> 
placementPolicy | **object**<br><p>Placement policy configuration.</p> 
placementPolicy.<br>placementGroupId | **string**<br><p>Placement group ID.</p> 
placementPolicy.<br>hostAffinityRules[] | **object**<br><p>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules.</p> 
placementPolicy.<br>hostAffinityRules[].<br>key | **string**<br><p>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId'</p> 
placementPolicy.<br>hostAffinityRules[].<br>op | **string**<br><p>Include or exclude action</p> 
placementPolicy.<br>hostAffinityRules[].<br>values[] | **string**<br><p>Affinity value or host ID or host group ID</p> 