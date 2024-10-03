---
editable: false
sourcePath: en/_api-ref/k8s/v1/managed-kubernetes/api-ref/Version/list.md
---

# Managed Services for Kubernetes API, REST: Version.list
Retrieves the list of versions in the specified release channel.
 

 
## HTTP request {#https-request}
```
GET https://mks.{{ api-host }}/managed-kubernetes/v1/versions
```
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "availableVersions": [
    {
      "releaseChannel": "string",
      "versions": [
        "string"
      ]
    }
  ]
}
```

 
Field | Description
--- | ---
availableVersions[] | **object**<br><p>Versions available in the specified release channel.</p> 
availableVersions[].<br>releaseChannel | **string**<br><p>Release channel: ``RAPID``, ``REGULAR`` or ``STABLE``. For more details see <a href="/docs/managed-kubernetes/concepts/release-channels-and-updates">documentation</a>.</p> <ul> <li>RAPID: Minor updates with new functions and improvements are often added. You can't disable automatic updates in this channel, but you can specify a time period for automatic updates.</li> <li>REGULAR: New functions and improvements are added in chunks shortly after they appear on ``RAPID``.</li> <li>STABLE: Only updates related to bug fixes or security improvements are added.</li> </ul> 
availableVersions[].<br>versions[] | **string**<br><p>Version of Kubernetes components.</p> 