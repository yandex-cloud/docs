---
editable: false
sourcePath: en/_api-ref/audittrails/v1/api-ref/Trail/index.md
---

# Audit Trails API, REST: Trail methods
A set of methods for managing trails.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "updatedAt": "string",
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
  "status": "string",
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
  },
  "statusErrorMessage": "string",
  "cloudId": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the trail</p> 
folderId | **string**<br><p>Required. ID of the folder that the trail belongs to</p> <p>The maximum string length in characters is 50.</p> 
createdAt | **string** (date-time)<br><p>Required. The timestamp for the creation operation</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
updatedAt | **string** (date-time)<br><p>Required. The timestamp of the last update operation</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the trail</p> <p>Value must match the regular expression ``\|[a-z]([-a-z0-9]{0,61}[a-z0-9])?``.</p> 
description | **string**<br><p>Description of the trail</p> <p>The maximum string length in characters is 1024.</p> 
labels | **object**<br><p>Custom labels of the trail as ``key:value`` pairs. Maximum 64 per key</p> <p>No more than 64 per resource. The maximum string length in characters for each key is 63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
destination | **object**<br><p>Required. Destination configuration of the trail</p> 
destination.<br>objectStorage | **object** <br>`destination` includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`<br>
destination.<br>objectStorage.<br>bucketId | **string**<br><p>Name of the destination bucket</p> <p>The string length in characters must be 3-63.</p> 
destination.<br>objectStorage.<br>objectPrefix | **string**<br><p>Prefix for exported objects. Optional If specified, uploaded objects will have prefix &lt;object_prefix&gt;/&lt;trail_id&gt;/</p> 
destination.<br>cloudLogging | **object** <br>`destination` includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`<br>
destination.<br>cloudLogging.<br>logGroupId | **string**<br><p>ID of the Cloud Logging destination group</p> <p>The maximum string length in characters is 64.</p> 
destination.<br>dataStream | **object** <br>`destination` includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`<br>
destination.<br>dataStream.<br>databaseId | **string**<br><p>ID of the database hosting the destination YDS</p> 
destination.<br>dataStream.<br>streamName | **string**<br><p>Name of the destination YDS</p> 
serviceAccountId | **string**<br><p>Service account ID of the trail</p> <p>The maximum string length in characters is 50.</p> 
status | **string**<br><p>Required. Status of the trail</p> <ul> <li>ACTIVE: The trail is active and Audit events are processed</li> <li>ERROR: The trail configuration has issues that are preventing Audit Trails from delivering events</li> <li>DELETED: The trail is being deleted</li> </ul> 
filter | **object**<br><p>Required. Filtering configuration of the trail</p> 
filter.<br>pathFilter | **object**<br><p>Configuration of default events gathering for the trail If not specified, default events won't be gathered for the trail</p> 
filter.<br>pathFilter.<br>root | **object**<br><p>Required. Root element of the resource path filter for the trail Resource described in that filter node must contain the trail itself</p> 
filter.<br>pathFilter.<br>root.<br>anyFilter | **object** <br>`filter.pathFilter.root` includes only one of the fields `anyFilter`, `someFilter`<br>
filter.<br>pathFilter.<br>root.<br>anyFilter.<br>resource | **object**<br><p>Required. Resource definition</p> 
filter.<br>pathFilter.<br>root.<br>anyFilter.<br>resource.<br>id | **string**<br><p>Required. ID of the resource</p> <p>The maximum string length in characters is 64.</p> 
filter.<br>pathFilter.<br>root.<br>anyFilter.<br>resource.<br>type | **string**<br><p>Required. Type of the resource</p> <p>The maximum string length in characters is 50.</p> 
filter.<br>pathFilter.<br>root.<br>someFilter | **object** <br>`filter.pathFilter.root` includes only one of the fields `anyFilter`, `someFilter`<br>
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
statusErrorMessage | **string**<br><p>Current error message of the trail. Empty in case if the trail is active</p> 
cloudId | **string**<br><p>Required. ID of the cloud that the trail belongs to</p> <p>The maximum string length in characters is 50.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a trail in the specified folder.
[delete](delete.md) | Deletes the specified trail.
[get](get.md) | Returns the specified trail.
[list](list.md) | Retrieves the list of trails in the specified folder.
[listAccessBindings](listAccessBindings.md) | Lists existing access bindings for the specified trail.
[listOperations](listOperations.md) | Lists operations for the specified trail.
[setAccessBindings](setAccessBindings.md) | Sets access bindings for the trail.
[update](update.md) | Updates the specified trail.
[updateAccessBindings](updateAccessBindings.md) | Updates access bindings for the trail.