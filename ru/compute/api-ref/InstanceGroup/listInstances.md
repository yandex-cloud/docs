---
editable: false
sourcePath: en/_api-ref/compute/api-ref/InstanceGroup/listInstances.md
---

# Method listInstances
Lists instances for the specified instance group.
 

 
## HTTP request {#https-request}
```
GET https://compute.{{ api-host }}/compute/v1/instanceGroups/{instanceGroupId}/instances
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
instanceGroupId | <p>Required. ID of the InstanceGroup resource to list instances for. To get the instance group ID, use a <a href="/docs/compute/api-ref/InstanceGroup/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/compute/api-ref/InstanceGroup/listInstances#query_params">pageSize</a>, the service returns a <a href="/docs/compute/api-ref/InstanceGroup/listInstances#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/compute/api-ref/InstanceGroup/listInstances#query_params">pageToken</a> to the <a href="/docs/compute/api-ref/InstanceGroup/listInstances#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters resources listed in the response. Currently you can use filtering only on the ``name`` field.</p> <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "instances": [
    {
      "id": "string",
      "status": "string",
      "instanceId": "string",
      "fqdn": "string",
      "name": "string",
      "statusMessage": "string",
      "zoneId": "string",
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
          }
        }
      ],
      "statusChangedAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
instances[] | **object**<br><p>Lists instances for the specified instance group.</p> 
instances[].<br>id | **string**<br><p>ID of the managed instance.</p> 
instances[].<br>status | **string**<br><p>Status of the managed instance.</p> <ul> <li>CREATING_INSTANCE: Instance is being created.</li> <li>UPDATING_INSTANCE: Instance is being updated.</li> <li>DELETING_INSTANCE: Instance is being deleted.</li> <li>STARTING_INSTANCE: Instance is being started.</li> <li>STOPPING_INSTANCE: Instance is being stopped.</li> <li>AWAITING_STARTUP_DURATION: Instance has been created successfully, but startup duration has not elapsed yet.</li> <li>CHECKING_HEALTH: Instance has been created successfully and startup duration has elapsed, but health checks have not passed yet and the managed instance is not ready to receive traffic.</li> <li>OPENING_TRAFFIC: Instance Groups is initiating health checks and routing traffic to the instances.</li> <li>AWAITING_WARMUP_DURATION: Instance is now receiving traffic, but warmup duration has not elapsed yet.</li> <li>CLOSING_TRAFFIC: Instance Groups has initiated the process of stopping routing traffic to the instances.</li> <li>RUNNING_ACTUAL: Instance is running normally and its attributes match the current InstanceTemplate.</li> <li>RUNNING_OUTDATED: Instance is running normally, but its attributes do not match the current InstanceTemplate. It will be updated, recreated or deleted shortly.</li> <li>STOPPED: Instance was stopped.</li> <li>DELETED: Instance was deleted.</li> <li>PREPARING_RESOURCES: Instance Groups is preparing dependent resources.</li> </ul> 
instances[].<br>instanceId | **string**<br><p>ID of the instance.</p> 
instances[].<br>fqdn | **string**<br><p>Fully Qualified Domain Name.</p> 
instances[].<br>name | **string**<br><p>The name of the managed instance.</p> 
instances[].<br>statusMessage | **string**<br><p>Status message for the managed instance.</p> 
instances[].<br>zoneId | **string**<br><p>ID of the availability zone where the instance resides.</p> 
instances[].<br>networkInterfaces[] | **object**<br><p>Array of network interfaces that are attached to the managed instance.</p> 
instances[].<br>networkInterfaces[].<br>index | **string**<br><p>The index of the network interface, generated by the server, 0,1,2... etc. Currently only one network interface is supported per instance.</p> 
instances[].<br>networkInterfaces[].<br>macAddress | **string**<br><p>MAC address that is assigned to the network interface.</p> 
instances[].<br>networkInterfaces[].<br>subnetId | **string**<br><p>ID of the subnet.</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address | **object**<br><p>Primary IPv4 address that is assigned to the instance for this network interface.</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>address | **string**<br><p>An IPv4 internal network address that is assigned to the managed instance for this network interface. If not specified by the user, an unused internal IP is assigned by the system.</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat | **object**<br><p>One-to-one NAT configuration. If missing, NAT has not been set up.</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat.<br>address | **string**<br><p>An IPv4 external network address that is assigned to the managed instance for this network interface.</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat.<br>ipVersion | **string**<br><p>External IP address version.</p> <ul> <li>IPV4: IPv4 address, for example 192.168.0.0.</li> <li>IPV6: IPv6 address, not available yet.</li> </ul> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat.<br>dnsRecords[] | **object**<br><p>External DNS configuration.</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat.<br>dnsRecords[].<br>fqdn | **string**<br><p>Required. Name of the A/AAAA record as specified when creating the instance. Note that if `fqdn' has no trailing '.', it is specified relative to the zone (@see dns_zone_id).</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat.<br>dnsRecords[].<br>dnsZoneId | **string**<br><p>DNS zone id (optional, if not set, some private zone is used).</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat.<br>dnsRecords[].<br>ttl | **string** (int64)<br><p>DNS record ttl (optional, if 0, a reasonable default is used).</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>oneToOneNat.<br>dnsRecords[].<br>ptr | **boolean** (boolean)<br><p>When true, indicates there is a corresponding auto-created PTR DNS record.</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>dnsRecords[] | **object**<br><p>Internal DNS configuration.</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>dnsRecords[].<br>fqdn | **string**<br><p>Required. Name of the A/AAAA record as specified when creating the instance. Note that if `fqdn' has no trailing '.', it is specified relative to the zone (@see dns_zone_id).</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>dnsRecords[].<br>dnsZoneId | **string**<br><p>DNS zone id (optional, if not set, some private zone is used).</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>dnsRecords[].<br>ttl | **string** (int64)<br><p>DNS record ttl (optional, if 0, a reasonable default is used).</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
instances[].<br>networkInterfaces[].<br>primaryV4Address.<br>dnsRecords[].<br>ptr | **boolean** (boolean)<br><p>When true, indicates there is a corresponding auto-created PTR DNS record.</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address | **object**<br><p>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 is not available yet.</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>address | **string**<br><p>An IPv4 internal network address that is assigned to the managed instance for this network interface. If not specified by the user, an unused internal IP is assigned by the system.</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat | **object**<br><p>One-to-one NAT configuration. If missing, NAT has not been set up.</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat.<br>address | **string**<br><p>An IPv4 external network address that is assigned to the managed instance for this network interface.</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat.<br>ipVersion | **string**<br><p>External IP address version.</p> <ul> <li>IPV4: IPv4 address, for example 192.168.0.0.</li> <li>IPV6: IPv6 address, not available yet.</li> </ul> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat.<br>dnsRecords[] | **object**<br><p>External DNS configuration.</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat.<br>dnsRecords[].<br>fqdn | **string**<br><p>Required. Name of the A/AAAA record as specified when creating the instance. Note that if `fqdn' has no trailing '.', it is specified relative to the zone (@see dns_zone_id).</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat.<br>dnsRecords[].<br>dnsZoneId | **string**<br><p>DNS zone id (optional, if not set, some private zone is used).</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat.<br>dnsRecords[].<br>ttl | **string** (int64)<br><p>DNS record ttl (optional, if 0, a reasonable default is used).</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>oneToOneNat.<br>dnsRecords[].<br>ptr | **boolean** (boolean)<br><p>When true, indicates there is a corresponding auto-created PTR DNS record.</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>dnsRecords[] | **object**<br><p>Internal DNS configuration.</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>dnsRecords[].<br>fqdn | **string**<br><p>Required. Name of the A/AAAA record as specified when creating the instance. Note that if `fqdn' has no trailing '.', it is specified relative to the zone (@see dns_zone_id).</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>dnsRecords[].<br>dnsZoneId | **string**<br><p>DNS zone id (optional, if not set, some private zone is used).</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>dnsRecords[].<br>ttl | **string** (int64)<br><p>DNS record ttl (optional, if 0, a reasonable default is used).</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
instances[].<br>networkInterfaces[].<br>primaryV6Address.<br>dnsRecords[].<br>ptr | **boolean** (boolean)<br><p>When true, indicates there is a corresponding auto-created PTR DNS record.</p> 
instances[].<br>statusChangedAt | **string** (date-time)<br><p>The timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format when the status of the managed instance was last changed.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is more than <a href="/docs/compute/api-ref/InstanceGroup/listInstances#query_params">pageSize</a>, use <a href="/docs/compute/api-ref/InstanceGroup/listInstances#responses">nextPageToken</a> as the value for the <a href="/docs/compute/api-ref/InstanceGroup/listInstances#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/compute/api-ref/InstanceGroup/listInstances#responses">nextPageToken</a> to continue paging through the results.</p> 