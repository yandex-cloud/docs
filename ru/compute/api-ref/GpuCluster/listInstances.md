---
editable: false
sourcePath: en/_api-ref/compute/v1/api-ref/GpuCluster/listInstances.md
---

# Compute Cloud API, REST: GpuCluster.listInstances
List instances created in this GPU cluster.
 

 
## HTTP request {#https-request}
```
GET https://compute.{{ api-host }}/compute/v1/gpuClusters/{gpuClusterId}/instances
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
gpuClusterId | <p>ID of the GPU cluster to list instances in.</p> <p>To get a GPU cluster ID, make a <a href="/docs/compute/api-ref/GpuCluster/list">list</a> request.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/compute/api-ref/GpuCluster/listInstances#query_params">pageSize</a>, the service returns a <a href="/docs/compute/api-ref/GpuCluster/listInstances#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>Default value: 100.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/compute/api-ref/GpuCluster/listInstances#query_params">pageToken</a> to the <a href="/docs/compute/api-ref/GpuCluster/listInstances#responses">nextPageToken</a> returned by a previous list request.</p> 
filter | <p>A filter expression that filters resources listed in the response. Currently you can use filtering only on the <a href="/docs/compute/api-ref/Instance#representation">Instance.name</a> field.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "instances": [
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
      "serialPortSettings": {
        "sshAuthorization": "string"
      },
      "gpuSettings": {
        "gpuClusterId": "string"
      },
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
        ],
        "placementGroupPartition": "string"
      },
      "hostGroupId": "string",
      "hostId": "string",
      "maintenancePolicy": "string",
      "maintenanceGracePeriod": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
instances[] | **object**<br><p>List of instances in the specified GPU cluster.</p> 
instances[].<br>id | **string**<br><p>ID of the instance.</p> 
instances[].<br>folderId | **string**<br><p>ID of the folder that the instance belongs to.</p> 
instances[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
instances[].<br>name | **string**<br><p>Name of the instance. 1-63 characters long.</p> 
instances[].<br>description | **string**<br><p>Description of the instance. 0-256 characters long.</p> 
instances[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
instances[].<br>zoneId | **string**<br><p>ID of the availability zone where the instance resides.</p> 
instances[].<br>platformId | **string**<br><p>ID of the hardware platform configuration for the instance.</p> 
instances[].<br>resources | **object**<br><p>Computing resources of the instance such as the amount of memory and number of cores.</p> 
instances[].<br>resources.<br>memory | **string** (int64)<br><p>The amount of memory available to the instance, specified in bytes.</p> 
instances[].<br>resources.<br>cores | **string** (int64)<br><p>The number of cores available to the instance.</p> 
instances[].<br>resources.<br>coreFraction | **string** (int64)<br><p>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core.</p> 
instances[].<br>resources.<br>gpus | **string** (int64)<br><p>The number of GPUs available to the instance.</p> 
instances[].<br>status | **string**<br><p>Status of the instance.</p> <ul> <li>PROVISIONING: Instance is waiting for resources to be allocated.</li> <li>RUNNING: Instance is running normally.</li> <li>STOPPING: Instance is being stopped.</li> <li>STOPPED: Instance stopped.</li> <li>STARTING: Instance is being started.</li> <li>RESTARTING: Instance is being restarted.</li> <li>UPDATING: Instance is being updated.</li> <li>ERROR: Instance encountered a problem and cannot operate.</li> <li>CRASHED: Instance crashed and will be restarted automatically.</li> <li>DELETING: Instance is being deleted.</li> </ul> 
instances[].<br>metadata | **object**<br><p>The metadata ``key:value`` pairs assigned to this instance. This includes custom metadata and predefined keys.</p> <p>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see <a href="/docs/compute/concepts/vm-metadata">Metadata</a>.</p> 
instances[].<br>metadataOptions | **object**<br><p>Options allow user to configure access to instance's metadata</p> 
instances[].<br>metadataOptions.<br>gceHttpEndpoint | **string**<br><p>Enabled access to GCE flavored metadata</p> <ul> <li>ENABLED: Option is enabled</li> <li>DISABLED: Option is disabled</li> </ul> 
instances[].<br>metadataOptions.<br>awsV1HttpEndpoint | **string**<br><p>Enabled access to AWS flavored metadata (IMDSv1)</p> <ul> <li>ENABLED: Option is enabled</li> <li>DISABLED: Option is disabled</li> </ul> 
instances[].<br>metadataOptions.<br>gceHttpToken | **string**<br><p>Enabled access to IAM credentials with GCE flavored metadata</p> <ul> <li>ENABLED: Option is enabled</li> <li>DISABLED: Option is disabled</li> </ul> 
instances[].<br>metadataOptions.<br>awsV1HttpToken | **string**<br><p>Enabled access to IAM credentials with AWS flavored metadata (IMDSv1)</p> <ul> <li>ENABLED: Option is enabled</li> <li>DISABLED: Option is disabled</li> </ul> 
instances[].<br>bootDisk | **object**<br><p>Boot disk that is attached to the instance.</p> 
instances[].<br>bootDisk.<br>mode | **string**<br><p>Access mode to the Disk resource.</p> <ul> <li>READ_ONLY: Read-only access.</li> <li>READ_WRITE: Read/Write access.</li> </ul> 
instances[].<br>bootDisk.<br>deviceName | **string**<br><p>Serial number that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance.</p> <p>This value can be used to reference the device for mounting, resizing, and so on, from within the instance.</p> 
instances[].<br>bootDisk.<br>autoDelete | **boolean** (boolean)<br><p>Specifies whether the disk will be auto-deleted when the instance is deleted.</p> 
instances[].<br>bootDisk.<br>diskId | **string**<br><p>ID of the disk that is attached to the instance.</p> 
instances[].<br>secondaryDisks[] | **object**<br><p>Array of secondary disks that are attached to the instance.</p> 
instances[].<br>secondaryDisks[].<br>mode | **string**<br><p>Access mode to the Disk resource.</p> <ul> <li>READ_ONLY: Read-only access.</li> <li>READ_WRITE: Read/Write access.</li> </ul> 
instances[].<br>secondaryDisks[].<br>deviceName | **string**<br><p>Serial number that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance.</p> <p>This value can be used to reference the device for mounting, resizing, and so on, from within the instance.</p> 
instances[].<br>secondaryDisks[].<br>autoDelete | **boolean** (boolean)<br><p>Specifies whether the disk will be auto-deleted when the instance is deleted.</p> 
instances[].<br>secondaryDisks[].<br>diskId | **string**<br><p>ID of the disk that is attached to the instance.</p> 
instances[].<br>localDisks[] | **object**<br><p>Array of local disks that are attached to the instance.</p> 
instances[].<br>localDisks[].<br>size | **string** (int64)<br><p>Size of the disk, specified in bytes.</p> 
instances[].<br>localDisks[].<br>deviceName | **string**<br><p>Serial number that is reflected into the /dev/disk/by-id/ tree of a Linux operating system running within the instance.</p> <p>This value can be used to reference the device for mounting, resizing, and so on, from within the instance.</p> 
instances[].<br>filesystems[] | **object**<br><p>Array of filesystems that are attached to the instance.</p> 
instances[].<br>filesystems[].<br>mode | **string**<br><p>Access mode to the filesystem.</p> <ul> <li>READ_ONLY: Read-only access.</li> <li>READ_WRITE: Read/Write access.</li> </ul> 
instances[].<br>filesystems[].<br>deviceName | **string**<br><p>Name of the device representing the filesystem on the instance.</p> <p>The name should be used for referencing the filesystem from within the instance when it's being mounted, resized etc.</p> 
instances[].<br>filesystems[].<br>filesystemId | **string**<br><p>ID of the filesystem that is attached to the instance.</p> 
instances[].<br>networkInterfaces[] | **object**<br><p>Array of network interfaces that are attached to the instance.</p> 
instances[].<br>networkInterfaces[].<br>index | **string**<br><p>The index of the network interface, will be generated by the server, 0,1,2... etc if not specified.</p> 
instances[].<br>networkInterfaces[].<br>macAddress | **string**<br><p>MAC address that is assigned to the network interface.</p> 
instances[].<br>networkInterfaces[].<br>subnetId | **string**<br><p>ID of the subnet.</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address | **object**<br><p>Primary IPv4 address that is assigned to the instance for this network interface.</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>address | **string**<br><p>An IPv4 internal network address that is assigned to the instance for this network interface.</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat | **object**<br><p>One-to-one NAT configuration. If missing, NAT has not been set up.</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat.<br>address | **string**<br><p>An external IP address associated with this instance.</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat.<br>ipVersion | **string**<br><p>IP version for the external IP address.</p> <ul> <li>IPV4: IPv4 address, for example 192.0.2.235.</li> <li>IPV6: IPv6 address. Not available yet.</li> </ul> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat.<br>dnsRecords[] | **object**<br><p>External DNS configuration</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat.<br>dnsRecords[].<br>fqdn | **string**<br><p>Name of the A/AAAA record as specified when creating the instance. Note that if `fqdn' has no trailing '.', it is specified relative to the zone (@see dns_zone_id).</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat.<br>dnsRecords[].<br>dnsZoneId | **string**<br><p>DNS zone id for the record (optional, if not set, some private zone is used).</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat.<br>dnsRecords[].<br>ttl | **string** (int64)<br><p>DNS record ttl (optional, if not set, a reasonable default is used.)</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat.<br>dnsRecords[].<br>ptr | **boolean** (boolean)<br><p>When true, indicates there is a corresponding auto-created PTR DNS record.</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>dnsRecords[] | **object**<br><p>Internal DNS configuration</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>dnsRecords[].<br>fqdn | **string**<br><p>Name of the A/AAAA record as specified when creating the instance. Note that if `fqdn' has no trailing '.', it is specified relative to the zone (@see dns_zone_id).</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>dnsRecords[].<br>dnsZoneId | **string**<br><p>DNS zone id for the record (optional, if not set, some private zone is used).</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>dnsRecords[].<br>ttl | **string** (int64)<br><p>DNS record ttl (optional, if not set, a reasonable default is used.)</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>dnsRecords[].<br>ptr | **boolean** (boolean)<br><p>When true, indicates there is a corresponding auto-created PTR DNS record.</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address | **object**<br><p>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet.</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>address | **string**<br><p>An IPv4 internal network address that is assigned to the instance for this network interface.</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat | **object**<br><p>One-to-one NAT configuration. If missing, NAT has not been set up.</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat.<br>address | **string**<br><p>An external IP address associated with this instance.</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat.<br>ipVersion | **string**<br><p>IP version for the external IP address.</p> <ul> <li>IPV4: IPv4 address, for example 192.0.2.235.</li> <li>IPV6: IPv6 address. Not available yet.</li> </ul> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat.<br>dnsRecords[] | **object**<br><p>External DNS configuration</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat.<br>dnsRecords[].<br>fqdn | **string**<br><p>Name of the A/AAAA record as specified when creating the instance. Note that if `fqdn' has no trailing '.', it is specified relative to the zone (@see dns_zone_id).</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat.<br>dnsRecords[].<br>dnsZoneId | **string**<br><p>DNS zone id for the record (optional, if not set, some private zone is used).</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat.<br>dnsRecords[].<br>ttl | **string** (int64)<br><p>DNS record ttl (optional, if not set, a reasonable default is used.)</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat.<br>dnsRecords[].<br>ptr | **boolean** (boolean)<br><p>When true, indicates there is a corresponding auto-created PTR DNS record.</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>dnsRecords[] | **object**<br><p>Internal DNS configuration</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>dnsRecords[].<br>fqdn | **string**<br><p>Name of the A/AAAA record as specified when creating the instance. Note that if `fqdn' has no trailing '.', it is specified relative to the zone (@see dns_zone_id).</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>dnsRecords[].<br>dnsZoneId | **string**<br><p>DNS zone id for the record (optional, if not set, some private zone is used).</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>dnsRecords[].<br>ttl | **string** (int64)<br><p>DNS record ttl (optional, if not set, a reasonable default is used.)</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>dnsRecords[].<br>ptr | **boolean** (boolean)<br><p>When true, indicates there is a corresponding auto-created PTR DNS record.</p> 
instances[].<br>networkInterfaces[].<br>securityGroupIds[] | **string**<br><p>ID's of security groups attached to the interface</p> 
instances[].<br>serialPortSettings | **object**<br><p>Serial port settings</p> 
instances[].<br>serialPortSettings.<br>sshAuthorization | **string**<br><p>Authentication and authorization in serial console when using SSH protocol</p> <ul> <li>INSTANCE_METADATA: Authentication and authorization using SSH keys in instance metadata</li> <li>OS_LOGIN: Authentication and authorization using Oslogin service</li> </ul> 
instances[].<br>gpuSettings | **object**<br><p>GPU settings</p> 
instances[].<br>gpuSettings.<br>gpuClusterId | **string**<br><p>Attach instance to specified GPU cluster.</p> 
instances[].<br>fqdn | **string**<br><p>A domain name of the instance. FQDN is defined by the server in the format ``<hostname>.<region_id>.internal`` when the instance is created. If the hostname were not specified when the instance was created, FQDN would be ``<id>.auto.internal``.</p> 
instances[].<br>schedulingPolicy | **object**<br><p>Scheduling policy configuration.</p> 
instances[].<br>schedulingPolicy.<br>preemptible | **boolean** (boolean)<br><p>True for short-lived compute instances. For more information, see <a href="/docs/compute/concepts/preemptible-vm">Preemptible VMs</a>.</p> 
instances[].<br>serviceAccountId | **string**<br><p>ID of the service account to use for <a href="/docs/compute/operations/vm-connect/auth-inside-vm">authentication inside the instance</a>. To get the service account ID, use a <a href="/docs/iam/api-ref/ServiceAccount/list">list</a> request.</p> 
instances[].<br>networkSettings | **object**<br><p>Network Settings</p> 
instances[].<br>networkSettings.<br>type | **string**<br><p>Network Type</p> <ul> <li>STANDARD: Standard network.</li> <li>SOFTWARE_ACCELERATED: Software accelerated network.</li> <li>HARDWARE_ACCELERATED: Hardware accelerated network (not available yet, reserved for future use).</li> </ul> 
instances[].<br>placementPolicy | **object**<br><p>Placement policy configuration.</p> 
instances[].<br>placementPolicy.<br>placementGroupId | **string**<br><p>Placement group ID.</p> 
instances[].<br>placementPolicy.<br>hostAffinityRules[] | **object**<br><p>List of affinity rules. Scheduler will attempt to allocate instances according to order of rules.</p> 
instances[].<br>placementPolicy.<br>hostAffinityRules[].<br>key | **string**<br><p>Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId'</p> 
instances[].<br>placementPolicy.<br>hostAffinityRules[].<br>op | **string**<br><p>Include or exclude action</p> 
instances[].<br>placementPolicy.<br>hostAffinityRules[].<br>values[] | **string**<br><p>Affinity value or host ID or host group ID</p> 
instances[].<br>placementPolicy.<br>placementGroupPartition | **string** (int64)<br><p>Placement group partition</p> 
instances[].<br>hostGroupId | **string**<br><p>ID of the dedicated host group that the instance belongs to.</p> 
instances[].<br>hostId | **string**<br><p>ID of the dedicated host that the instance belongs to.</p> 
instances[].<br>maintenancePolicy | **string**<br><p>Behaviour on maintenance events</p> <ul> <li>RESTART: Restart instance to move it to another host during maintenance</li> <li>MIGRATE: Use live migration to move instance to another host during maintenance</li> </ul> 
instances[].<br>maintenanceGracePeriod | **string**<br><p>Time between notification via metadata service and maintenance</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/compute/api-ref/GpuCluster/listInstances#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/compute/api-ref/GpuCluster/listInstances#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 