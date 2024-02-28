---
editable: false
sourcePath: en/_api-ref/audittrails/v1/api-ref/Trail/create.md
---

# Audit Trails API, REST: Trail.create
Creates a trail in the specified folder.
 

 
## HTTP request {#https-request}
```
POST https://audit-trails.{{ api-host }}/audit-trails/v1/trails
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "destination": {

    // `destination` includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`
    "objectStorage": {
      "bucketId": "string",
      "objectPrefix": "string"
    },
    "cloudLogging": {
      "logGroupId": "string"
    },
    "dataStream": {
      "databaseId": "string",
      "streamName": "string"
    },
    // end of the list of possible fields`destination`

  },
  "serviceAccountId": "string",
  "filter": {
    "pathFilter": {
      "root": {

        // `filter.pathFilter.root` includes only one of the fields `anyFilter`, `someFilter`
        "anyFilter": {
          "resource": {
            "id": "string",
            "type": "string"
          }
        },
        "someFilter": {
          "resource": {
            "id": "string",
            "type": "string"
          },
          "filters": [
            {

              // `filter.pathFilter.root.someFilter.filters[]` includes only one of the fields `anyFilter`, `someFilter`
              "anyFilter": {
                "resource": {
                  "id": "string",
                  "type": "string"
                }
              },
              "someFilter": {},
              // end of the list of possible fields`filter.pathFilter.root.someFilter.filters[]`

            }
          ]
        },
        // end of the list of possible fields`filter.pathFilter.root`

      }
    },
    "eventFilter": {
      "filters": [
        {
          "service": "string",
          "categories": [
            {
              "plane": "string",
              "type": "string"
            }
          ],
          "pathFilter": {
            "root": {

              // `filter.eventFilter.filters[].pathFilter.root` includes only one of the fields `anyFilter`, `someFilter`
              "anyFilter": {
                "resource": {
                  "id": "string",
                  "type": "string"
                }
              },
              "someFilter": {
                "resource": {
                  "id": "string",
                  "type": "string"
                },
                "filters": [
                  {

                    // `filter.eventFilter.filters[].pathFilter.root.someFilter.filters[]` includes only one of the fields `anyFilter`, `someFilter`
                    "anyFilter": {
                      "resource": {
                        "id": "string",
                        "type": "string"
                      }
                    },
                    "someFilter": {},
                    // end of the list of possible fields`filter.eventFilter.filters[].pathFilter.root.someFilter.filters[]`

                  }
                ]
              },
              // end of the list of possible fields`filter.eventFilter.filters[].pathFilter.root`

            }
          }
        }
      ]
    }
  }
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. ID of the folder to create a trail in.</p> <p>The maximum string length in characters is 50.</p> 
name | **string**<br><p>Name of the trail.</p> <p>Value must match the regular expression ``\|[a-z]([-a-z0-9]{0,61}[a-z0-9])?``.</p> 
description | **string**<br><p>Description of the trail.</p> <p>The maximum string length in characters is 1024.</p> 
labels | **object**<br><p>Custom labels for the secret as ``key:value`` pairs. Maximum 64 per key. For example, ``"type": "critical"`` or ``"source": "dictionary"``.</p> <p>No more than 64 per resource. The maximum string length in characters for each key is 63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
destination | **object**<br><p>Required. Destination configuration for the trail</p> 
destination.<br>objectStorage | **object**<br>Configuration for event delivery to Object Storage  Uploaded objects will have prefix <trail_id>/ by default <br>`destination` includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`<br>
destination.<br>objectStorage.<br>bucketId | **string**<br><p>Name of the destination bucket</p> <p>The string length in characters must be 3-63.</p> 
destination.<br>objectStorage.<br>objectPrefix | **string**<br><p>Prefix for exported objects. Optional If specified, uploaded objects will have prefix &lt;object_prefix&gt;/&lt;trail_id&gt;/</p> 
destination.<br>cloudLogging | **object**<br>Configuration for event delivery to Cloud Logging <br>`destination` includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`<br>
destination.<br>cloudLogging.<br>logGroupId | **string**<br><p>ID of the Cloud Logging destination group</p> <p>The maximum string length in characters is 64.</p> 
destination.<br>dataStream | **object**<br>Configuration for event delivery to YDS <br>`destination` includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`<br>
destination.<br>dataStream.<br>databaseId | **string**<br><p>ID of the database hosting the destination YDS</p> 
destination.<br>dataStream.<br>streamName | **string**<br><p>Name of the destination YDS</p> 
serviceAccountId | **string**<br><p>Required. Service account ID of the trail</p> <p>The maximum string length in characters is 50.</p> 
filter | **object**<br><p>Required. Event filtering configuration of the trail</p> 
filter.<br>pathFilter | **object**<br><p>Configuration of default events gathering for the trail If not specified, default events won't be gathered for the trail</p> 
filter.<br>pathFilter.<br>root | **object**<br><p>Required. Root element of the resource path filter for the trail Resource described in that filter node must contain the trail itself</p> 
filter.<br>pathFilter.<br>root.<br>anyFilter | **object**<br>Filter element with ANY type. If used, configures the trail to gather any events from the resource <br>`filter.pathFilter.root` includes only one of the fields `anyFilter`, `someFilter`<br>
filter.<br>pathFilter.<br>root.<br>anyFilter.<br>resource | **object**<br><p>Required. Resource definition</p> 
filter.<br>pathFilter.<br>root.<br>anyFilter.<br>resource.<br>id | **string**<br><p>Required. ID of the resource</p> <p>The maximum string length in characters is 64.</p> 
filter.<br>pathFilter.<br>root.<br>anyFilter.<br>resource.<br>type | **string**<br><p>Required. Type of the resource</p> <p>The maximum string length in characters is 50.</p> 
filter.<br>pathFilter.<br>root.<br>someFilter | **object**<br>Filter element with SOME type. If used, configures the trail to gather some of the events from the resource <br>`filter.pathFilter.root` includes only one of the fields `anyFilter`, `someFilter`<br>
filter.<br>pathFilter.<br>root.<br>someFilter.<br>resource | **object**<br><p>Required. Definition of the resource that contains</p> 
filter.<br>pathFilter.<br>root.<br>someFilter.<br>resource.<br>id | **string**<br><p>Required. ID of the resource</p> <p>The maximum string length in characters is 64.</p> 
filter.<br>pathFilter.<br>root.<br>someFilter.<br>resource.<br>type | **string**<br><p>Required. Type of the resource</p> <p>The maximum string length in characters is 50.</p> 
filter.<br>pathFilter.<br>root.<br>someFilter.<br>filters[] | **object**<br><p>Required. Filters for the resources contained in the parent resource</p> <p>Must contain at least one element.</p> 
filter.<br>pathFilter.<br>root.<br>someFilter.<br>filters[].<br>anyFilter | **object**<br>Filter element with ANY type. If used, configures the trail to gather any events from the resource <br>`filter.pathFilter.root.someFilter.filters[]` includes only one of the fields `anyFilter`, `someFilter`<br>
filter.<br>pathFilter.<br>root.<br>someFilter.<br>filters[].<br>anyFilter.<br>resource | **object**<br><p>Required. Resource definition</p> 
filter.<br>pathFilter.<br>root.<br>someFilter.<br>filters[].<br>anyFilter.<br>resource.<br>id | **string**<br><p>Required. ID of the resource</p> <p>The maximum string length in characters is 64.</p> 
filter.<br>pathFilter.<br>root.<br>someFilter.<br>filters[].<br>anyFilter.<br>resource.<br>type | **string**<br><p>Required. Type of the resource</p> <p>The maximum string length in characters is 50.</p> 
filter.<br>pathFilter.<br>root.<br>someFilter.<br>filters[].<br>someFilter | **object**<br>Filter element with SOME type. If used, configures the trail to gather some of the events from the resource <br>`filter.pathFilter.root.someFilter.filters[]` includes only one of the fields `anyFilter`, `someFilter`<br>
filter.<br>eventFilter | **object**<br><p>Required. Configuration of additional events gathering from specific services</p> 
filter.<br>eventFilter.<br>filters[] | **object**<br><p>List of filters for services</p> <p>The minimum number of elements is 0.</p> 
filter.<br>eventFilter.<br>filters[].<br>service | **string**<br><p>Required. Service ID of the gathered events</p> 
filter.<br>eventFilter.<br>filters[].<br>categories[] | **object**<br><p>Required. List of the event categories gathered for a specified service</p> <p>Must contain at least one element.</p> 
filter.<br>eventFilter.<br>filters[].<br>categories[].<br>plane | **string**<br><p>Required. Plane of the gathered category</p> <ul> <li>CONTROL_PLANE: The events that are generated during the interaction with the service's resources</li> <li>DATA_PLANE: Events that are generated during interaction with data within the service's resources</li> </ul> 
filter.<br>eventFilter.<br>filters[].<br>categories[].<br>type | **string**<br><p>Required. Type of the gathered category</p> <ul> <li>WRITE: Events for operations that do perform some modification</li> <li>READ: Events for operations that do not perform any modifications</li> </ul> 
filter.<br>eventFilter.<br>filters[].<br>pathFilter | **object**<br><p>Required. Resource path filter for a specified service</p> 
filter.<br>eventFilter.<br>filters[].<br>pathFilter.<br>root | **object**<br><p>Required. Root element of the resource path filter for the trail Resource described in that filter node must contain the trail itself</p> 
filter.<br>eventFilter.<br>filters[].<br>pathFilter.<br>root.<br>anyFilter | **object**<br>Filter element with ANY type. If used, configures the trail to gather any events from the resource <br>`filter.eventFilter.filters[].pathFilter.root` includes only one of the fields `anyFilter`, `someFilter`<br>
filter.<br>eventFilter.<br>filters[].<br>pathFilter.<br>root.<br>anyFilter.<br>resource | **object**<br><p>Required. Resource definition</p> 
filter.<br>eventFilter.<br>filters[].<br>pathFilter.<br>root.<br>anyFilter.<br>resource.<br>id | **string**<br><p>Required. ID of the resource</p> <p>The maximum string length in characters is 64.</p> 
filter.<br>eventFilter.<br>filters[].<br>pathFilter.<br>root.<br>anyFilter.<br>resource.<br>type | **string**<br><p>Required. Type of the resource</p> <p>The maximum string length in characters is 50.</p> 
filter.<br>eventFilter.<br>filters[].<br>pathFilter.<br>root.<br>someFilter | **object**<br>Filter element with SOME type. If used, configures the trail to gather some of the events from the resource <br>`filter.eventFilter.filters[].pathFilter.root` includes only one of the fields `anyFilter`, `someFilter`<br>
filter.<br>eventFilter.<br>filters[].<br>pathFilter.<br>root.<br>someFilter.<br>resource | **object**<br><p>Required. Definition of the resource that contains</p> 
filter.<br>eventFilter.<br>filters[].<br>pathFilter.<br>root.<br>someFilter.<br>resource.<br>id | **string**<br><p>Required. ID of the resource</p> <p>The maximum string length in characters is 64.</p> 
filter.<br>eventFilter.<br>filters[].<br>pathFilter.<br>root.<br>someFilter.<br>resource.<br>type | **string**<br><p>Required. Type of the resource</p> <p>The maximum string length in characters is 50.</p> 
filter.<br>eventFilter.<br>filters[].<br>pathFilter.<br>root.<br>someFilter.<br>filters[] | **object**<br><p>Required. Filters for the resources contained in the parent resource</p> <p>Must contain at least one element.</p> 
filter.<br>eventFilter.<br>filters[].<br>pathFilter.<br>root.<br>someFilter.<br>filters[].<br>anyFilter | **object**<br>Filter element with ANY type. If used, configures the trail to gather any events from the resource <br>`filter.eventFilter.filters[].pathFilter.root.someFilter.filters[]` includes only one of the fields `anyFilter`, `someFilter`<br>
filter.<br>eventFilter.<br>filters[].<br>pathFilter.<br>root.<br>someFilter.<br>filters[].<br>anyFilter.<br>resource | **object**<br><p>Required. Resource definition</p> 
filter.<br>eventFilter.<br>filters[].<br>pathFilter.<br>root.<br>someFilter.<br>filters[].<br>anyFilter.<br>resource.<br>id | **string**<br><p>Required. ID of the resource</p> <p>The maximum string length in characters is 64.</p> 
filter.<br>eventFilter.<br>filters[].<br>pathFilter.<br>root.<br>someFilter.<br>filters[].<br>anyFilter.<br>resource.<br>type | **string**<br><p>Required. Type of the resource</p> <p>The maximum string length in characters is 50.</p> 
filter.<br>eventFilter.<br>filters[].<br>pathFilter.<br>root.<br>someFilter.<br>filters[].<br>someFilter | **object**<br>Filter element with SOME type. If used, configures the trail to gather some of the events from the resource <br>`filter.eventFilter.filters[].pathFilter.root.someFilter.filters[]` includes only one of the fields `anyFilter`, `someFilter`<br>
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 