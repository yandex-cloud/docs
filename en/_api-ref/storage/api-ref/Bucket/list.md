---
editable: false
---

# Method list
Returns the list of buckets for specified folder id.
The following fields will not be set in listing:
* "cors"
* "website_settings"
* "lifecycle_rules"
* "acl"
* "policy"
will be empty.
 

 
## HTTP request {#https-request}
```
GET https://storage.api.cloud.yandex.net/storage/v1/buckets
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. Folder id for requested buckets.  The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "buckets": [
    {
      "id": "string",
      "name": "string",
      "folderId": "string",
      "anonymousAccessFlags": {
        "read": true,
        "list": true,
        "configRead": true
      },
      "defaultStorageClass": "string",
      "versioning": "string",
      "maxSize": "string",
      "policy": "object",
      "acl": {
        "grants": [
          {
            "permission": "string",
            "grantType": "string",
            "granteeId": "string"
          }
        ]
      },
      "createdAt": "string",
      "cors": [
        {
          "id": "string",
          "allowedMethods": [
            "string"
          ],
          "allowedHeaders": [
            "string"
          ],
          "allowedOrigins": [
            "string"
          ],
          "exposeHeaders": [
            "string"
          ],
          "maxAgeSeconds": "integer"
        }
      ],
      "websiteSettings": {
        "index": "string",
        "error": "string",
        "redirectAllRequests": {
          "protocol": "string",
          "hostname": "string"
        },
        "routingRules": [
          {
            "condition": {
              "httpErrorCodeReturnedEquals": "string",
              "keyPrefixEquals": "string"
            },
            "redirect": {
              "hostname": "string",
              "httpRedirectCode": "string",
              "protocol": "string",
              "replaceKeyPrefixWith": "string",
              "replaceKeyWith": "string"
            }
          }
        ]
      },
      "lifecycleRules": [
        {
          "id": "string",
          "enabled": true,
          "filter": {
            "prefix": "string"
          },
          "expiration": {
            "date": "string",
            "days": "integer",
            "expiredObjectDeleteMarker": true
          },
          "transitions": [
            {
              "date": "string",
              "days": "integer",
              "storageClass": "string"
            }
          ],
          "abortIncompleteMultipartUpload": {
            "daysAfterExpiration": "integer"
          },
          "noncurrentExpiration": {
            "noncurrentDays": "integer"
          },
          "noncurrentTransitions": [
            {
              "noncurrentDays": "integer",
              "storageClass": "string"
            }
          ]
        }
      ]
    }
  ]
}
```

 
Field | Description
--- | ---
buckets[] | **object**<br><p>Bucket is a core entity of the storage service. For more information, see <a href="/docs/storage/concepts/bucket">Bucket</a>.</p> 
buckets[].<br>id | **string**<br><p>Bucket's ID, treated as name. Properties id and name are equal to each other, but name has priority over id.</p> 
buckets[].<br>name | **string**<br><p>Bucket's uniqe name.</p> 
buckets[].<br>folderId | **string**<br><p>Folder id to which this bucket belongs.</p> 
buckets[].<br>anonymousAccessFlags | **object**<br><p>Access flags for anonymous access. For more information, see <a href="/docs/storage/concepts/bucket#bucket-access">Bucket Access</a></p> 
buckets[].<br>anonymousAccessFlags.<br>read | **boolean** (boolean)<br>
buckets[].<br>anonymousAccessFlags.<br>list | **boolean** (boolean)<br>
buckets[].<br>anonymousAccessFlags.<br>configRead | **boolean** (boolean)<br>
buckets[].<br>defaultStorageClass | **string**<br><p>Storage class of bucket. For more information, see <a href="/docs/storage/concepts/storage-class">Storage Class</a></p> 
buckets[].<br>versioning | **string**<br><p>Bucket's versioning mode. For more information, see <a href="/docs/storage/concepts/versioning">Versioning</a></p> 
buckets[].<br>maxSize | **string** (int64)<br><p>Maximum size of bucket. For more information, see <a href="/docs/storage/operations/buckets/limit-max-volume">Size limits</a></p> 
buckets[].<br>policy | **object**<br><p>Bucket's policy. For more information, see <a href="/docs/storage/concepts/policy">Bucket Policy</a></p> 
buckets[].<br>acl | **object**<br><p>Bucket's ACL. For more information, see <a href="/docs/storage/concepts/acl">ACL</a></p> <p>ACL model.</p> 
buckets[].<br>acl.<br>grants[] | **object**<br>
buckets[].<br>acl.<br>grants[].<br>permission | **string**<br><p>Required.</p> <ul> <li>PERMISSION_FULL_CONTROL: header X-Amz-Grant-Full-Control</li> <li>PERMISSION_WRITE: header X-Amz-Grant-Write</li> <li>PERMISSION_WRITE_ACP: header X-Amz-Grant-Write-Acp</li> <li>PERMISSION_READ: header X-Amz-Grant-Read</li> <li>PERMISSION_READ_ACP: header X-Amz-Grant-Read-Acp</li> </ul> 
buckets[].<br>acl.<br>grants[].<br>grantType | **string**<br><p>Required.</p> <ul> <li>GRANT_TYPE_ACCOUNT: equal to 'id' grantee value</li> <li>GRANT_TYPE_ALL_AUTHENTICATED_USERS: equal to 'uri' authenticated users</li> <li>GRANT_TYPE_ALL_USERS: equal to 'uri' all users</li> </ul> 
buckets[].<br>acl.<br>grants[].<br>granteeId | **string**<br><p>[semi-optional] grantee id is used only when grant_type is TO_ACCOUNT</p> 
buckets[].<br>createdAt | **string** (date-time)<br><p>Creating date.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
buckets[].<br>cors[] | **object**<br><p>CORS settings for bucket, hosted as website. For more information, see <a href="/docs/storage/concepts/cors">CORS</a></p> 
buckets[].<br>cors[].<br>id | **string**<br>
buckets[].<br>cors[].<br>allowedMethods[] | **string**<br><p>Required. Must contain at least one element.</p> 
buckets[].<br>cors[].<br>allowedHeaders[] | **string**<br><p>allowed_headers elements might be either as exact value (i.e. Test-Header-Field) or as pattern (i.e. Test-*-Field) But only one star allowed.</p> 
buckets[].<br>cors[].<br>allowedOrigins[] | **string**<br><p>Required. allowed_origins elements might be either as exact value (i.e. some-value) or as pattern (i.e. some*value) But only one star allowed.</p> <p>Must contain at least one element.</p> 
buckets[].<br>cors[].<br>exposeHeaders[] | **string**<br>
buckets[].<br>cors[].<br>maxAgeSeconds | **integer** (int64)<br>
buckets[].<br>websiteSettings | **object**<br><p>Website settings of bucket. For more information, see <a href="/docs/storage/concepts/hosting">Static site hosting</a></p> 
buckets[].<br>websiteSettings.<br>index | **string**<br><p>index points to entrypoint of the website. Either property &quot;index&quot; or &quot;redirect_all_requests&quot; should be set in order to operate.</p> 
buckets[].<br>websiteSettings.<br>error | **string**<br>
buckets[].<br>websiteSettings.<br>redirectAllRequests | **object**<br><p>redirect_all_requests redirects all requests to other uri. If this field  used, no other fields should be defined.</p> 
buckets[].<br>websiteSettings.<br>redirectAllRequests.<br>protocol | **string**<br><p>by default, http will be used.</p> 
buckets[].<br>websiteSettings.<br>redirectAllRequests.<br>hostname | **string**<br>
buckets[].<br>websiteSettings.<br>routingRules[] | **object**<br>
buckets[].<br>websiteSettings.<br>routingRules[].<br>condition | **object**<br>
buckets[].<br>websiteSettings.<br>routingRules[].<br>condition.<br>httpErrorCodeReturnedEquals | **string**<br>
buckets[].<br>websiteSettings.<br>routingRules[].<br>condition.<br>keyPrefixEquals | **string**<br>
buckets[].<br>websiteSettings.<br>routingRules[].<br>redirect | **object**<br>
buckets[].<br>websiteSettings.<br>routingRules[].<br>redirect.<br>hostname | **string**<br>
buckets[].<br>websiteSettings.<br>routingRules[].<br>redirect.<br>httpRedirectCode | **string**<br><p>http_redirect_code allowed values ranges between 301 and 399. by default value 301 will be used.</p> <p>Value must match the regular expression ``3(0[1-9]\|[1-9][0-9])``.</p> 
buckets[].<br>websiteSettings.<br>routingRules[].<br>redirect.<br>protocol | **string**<br>
buckets[].<br>websiteSettings.<br>routingRules[].<br>redirect.<br>replaceKeyPrefixWith | **string**<br>
buckets[].<br>websiteSettings.<br>routingRules[].<br>redirect.<br>replaceKeyWith | **string**<br>
buckets[].<br>lifecycleRules[] | **object**<br><p>Objects's lifecycle rules. For more information, see <a href="/docs/storage/concepts/lifecycles">Lifecycles</a></p> 
buckets[].<br>lifecycleRules[].<br>id | **string**<br>
buckets[].<br>lifecycleRules[].<br>enabled | **boolean** (boolean)<br>
buckets[].<br>lifecycleRules[].<br>filter | **object**<br>
buckets[].<br>lifecycleRules[].<br>filter.<br>prefix | **string**<br>
buckets[].<br>lifecycleRules[].<br>expiration | **object**<br>
buckets[].<br>lifecycleRules[].<br>expiration.<br>date | **string** (date-time)<br><p>If date is set, days parameter not allowed</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
buckets[].<br>lifecycleRules[].<br>expiration.<br>days | **integer** (int64)<br><p>If days are set, date parameter not allowed</p> 
buckets[].<br>lifecycleRules[].<br>expiration.<br>expiredObjectDeleteMarker | **boolean** (boolean)<br><p>if expired_object_delete_marker is set, other parameters are not allowed.</p> 
buckets[].<br>lifecycleRules[].<br>transitions[] | **object**<br>
buckets[].<br>lifecycleRules[].<br>transitions[].<br>date | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
buckets[].<br>lifecycleRules[].<br>transitions[].<br>days | **integer** (int64)<br>
buckets[].<br>lifecycleRules[].<br>transitions[].<br>storageClass | **string**<br><p>Required.</p> 
buckets[].<br>lifecycleRules[].<br>abortIncompleteMultipartUpload | **object**<br>
buckets[].<br>lifecycleRules[].<br>abortIncompleteMultipartUpload.<br>daysAfterExpiration | **integer** (int64)<br>
buckets[].<br>lifecycleRules[].<br>noncurrentExpiration | **object**<br>
buckets[].<br>lifecycleRules[].<br>noncurrentExpiration.<br>noncurrentDays | **integer** (int64)<br>
buckets[].<br>lifecycleRules[].<br>noncurrentTransitions[] | **object**<br>
buckets[].<br>lifecycleRules[].<br>noncurrentTransitions[].<br>noncurrentDays | **integer** (int64)<br>
buckets[].<br>lifecycleRules[].<br>noncurrentTransitions[].<br>storageClass | **string**<br><p>Required.</p> 