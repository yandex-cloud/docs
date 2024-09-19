---
editable: false
sourcePath: en/_api-ref/audittrails/v1/api-ref/Trail/list.md
---

# Audit Trails API, REST: Trail.list
Retrieves the list of trails in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://audit-trails.{{ api-host }}/audit-trails/v1/trails
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list trails in.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``page_size``, the service returns a <a href="/docs/audit-trails/api-ref/Trail/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the [ListTrailsRequest.next_page_token] returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters subscription locks listed in the response.</p> <p>The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering on [Trail.name, Trail.created_at] fields.</li> <li>An operator. Can be either ``=`` or ``!=`` for single values, ``IN`` or ``NOT IN`` for lists of values.</li> <li>The value. Must be in double quotes ``""``. Must be 3-63 characters long and match the regular expression ``^[a-z][-a-z0-9]{1,61}[a-z0-9]``. Example of a filter: ``name="my-name"``.</li> </ol> 
orderBy | <p>By which column the listing should be ordered and in which direction. format is "<field> desc\|acs"</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "trails": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "updatedAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "destination": {

        // `trails[].destination` includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`
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
        // end of the list of possible fields`trails[].destination`

      },
      "serviceAccountId": "string",
      "status": "string",
      "filter": {
        "pathFilter": {
          "root": {

            // `trails[].filter.pathFilter.root` includes only one of the fields `anyFilter`, `someFilter`
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

                  // `trails[].filter.pathFilter.root.someFilter.filters[]` includes only one of the fields `anyFilter`, `someFilter`
                  "anyFilter": {
                    "resource": {
                      "id": "string",
                      "type": "string"
                    }
                  },
                  "someFilter": {},
                  // end of the list of possible fields`trails[].filter.pathFilter.root.someFilter.filters[]`

                }
              ]
            },
            // end of the list of possible fields`trails[].filter.pathFilter.root`

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

                  // `trails[].filter.eventFilter.filters[].pathFilter.root` includes only one of the fields `anyFilter`, `someFilter`
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

                        // `trails[].filter.eventFilter.filters[].pathFilter.root.someFilter.filters[]` includes only one of the fields `anyFilter`, `someFilter`
                        "anyFilter": {
                          "resource": {
                            "id": "string",
                            "type": "string"
                          }
                        },
                        "someFilter": {},
                        // end of the list of possible fields`trails[].filter.eventFilter.filters[].pathFilter.root.someFilter.filters[]`

                      }
                    ]
                  },
                  // end of the list of possible fields`trails[].filter.eventFilter.filters[].pathFilter.root`

                }
              }
            }
          ]
        }
      },
      "statusErrorMessage": "string",
      "cloudId": "string",
      "filteringPolicy": {
        "managementEventsFilter": {
          "resourceScopes": [
            {
              "id": "string",
              "type": "string"
            }
          ]
        },
        "dataEventsFilters": [
          {
            "service": "string",
            "resourceScopes": [
              {
                "id": "string",
                "type": "string"
              }
            ],

            // `trails[].filteringPolicy.dataEventsFilters[]` includes only one of the fields `includedEvents`, `excludedEvents`
            "includedEvents": {
              "eventTypes": [
                "string"
              ]
            },
            "excludedEvents": {
              "eventTypes": [
                "string"
              ]
            },
            // end of the list of possible fields`trails[].filteringPolicy.dataEventsFilters[]`

          }
        ]
      }
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
trails[] | **object**<br><p>List of trails in the specified folder.</p> 
trails[].<br>id | **string**<br><p>ID of the trail</p> 
trails[].<br>folderId | **string**<br><p>Required. ID of the folder that the trail belongs to</p> <p>The maximum string length in characters is 50.</p> 
trails[].<br>createdAt | **string** (date-time)<br><p>Required. The timestamp for the creation operation</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
trails[].<br>updatedAt | **string** (date-time)<br><p>Required. The timestamp of the last update operation</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
trails[].<br>name | **string**<br><p>Name of the trail</p> <p>Value must match the regular expression ``\|[a-z]([-a-z0-9]{0,61}[a-z0-9])?``.</p> 
trails[].<br>description | **string**<br><p>Description of the trail</p> <p>The maximum string length in characters is 1024.</p> 
trails[].<br>labels | **object**<br><p>Custom labels of the trail as ``key:value`` pairs. Maximum 64 per key</p> <p>No more than 64 per resource. The maximum string length in characters for each key is 63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
trails[].<br>destination | **object**<br><p>Required. Destination configuration of the trail</p> 
trails[].<br>destination.<br>objectStorage | **object**<br>Configuration for event delivery to Object Storage  Uploaded objects will have prefix <trail_id>/ by default <br>`trails[].destination` includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`<br>
trails[].<br>destination.<br>objectStorage.<br>bucketId | **string**<br><p>Name of the destination bucket</p> <p>The string length in characters must be 3-63.</p> 
trails[].<br>destination.<br>objectStorage.<br>objectPrefix | **string**<br><p>Prefix for exported objects. Optional If specified, uploaded objects will have prefix &lt;object_prefix&gt;/&lt;trail_id&gt;/</p> 
trails[].<br>destination.<br>cloudLogging | **object**<br>Configuration for event delivery to Cloud Logging <br>`trails[].destination` includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`<br>
trails[].<br>destination.<br>cloudLogging.<br>logGroupId | **string**<br><p>ID of the Cloud Logging destination group</p> <p>The maximum string length in characters is 64.</p> 
trails[].<br>destination.<br>dataStream | **object**<br>Configuration for event delivery to YDS <br>`trails[].destination` includes only one of the fields `objectStorage`, `cloudLogging`, `dataStream`<br>
trails[].<br>destination.<br>dataStream.<br>databaseId | **string**<br><p>ID of the database hosting the destination YDS</p> 
trails[].<br>destination.<br>dataStream.<br>streamName | **string**<br><p>Name of the destination YDS</p> 
trails[].<br>serviceAccountId | **string**<br><p>Service account ID of the trail</p> <p>The maximum string length in characters is 50.</p> 
trails[].<br>status | **string**<br><p>Required. Status of the trail</p> <ul> <li>ACTIVE: The trail is active and Audit events are processed</li> <li>ERROR: The trail configuration has issues that are preventing Audit Trails from delivering events</li> <li>DELETED: The trail is being deleted</li> </ul> 
trails[].<br>filter | **object**<br><p>Filtering configuration of the trail deprecated: use filtering_policy instead</p> 
trails[].<br>filter.<br>pathFilter | **object**<br><p>Configuration of default events gathering for the trail If not specified, default events won't be gathered for the trail</p> 
trails[].<br>filter.<br>pathFilter.<br>root | **object**<br><p>Required. Root element of the resource path filter for the trail Resource described in that filter node must contain the trail itself</p> 
trails[].<br>filter.<br>pathFilter.<br>root.<br>anyFilter | **object**<br>Filter element with ANY type. If used, configures the trail to gather any events from the resource <br>`trails[].filter.pathFilter.root` includes only one of the fields `anyFilter`, `someFilter`<br>
trails[].<br>filter.<br>pathFilter.<br>root.<br>anyFilter.<br>resource | **object**<br><p>Required. Resource definition</p> 
trails[].<br>filter.<br>pathFilter.<br>root.<br>anyFilter.<br>resource.<br>id | **string**<br><p>Required. ID of the resource</p> <p>The maximum string length in characters is 64.</p> 
trails[].<br>filter.<br>pathFilter.<br>root.<br>anyFilter.<br>resource.<br>type | **string**<br><p>Required. Type of the resource</p> <p>The maximum string length in characters is 50.</p> 
trails[].<br>filter.<br>pathFilter.<br>root.<br>someFilter | **object**<br>Filter element with SOME type. If used, configures the trail to gather some of the events from the resource <br>`trails[].filter.pathFilter.root` includes only one of the fields `anyFilter`, `someFilter`<br>
trails[].<br>filter.<br>pathFilter.<br>root.<br>someFilter.<br>resource | **object**<br><p>Required. Definition of the resource that contains nested resources</p> 
trails[].<br>filter.<br>pathFilter.<br>root.<br>someFilter.<br>resource.<br>id | **string**<br><p>Required. ID of the resource</p> <p>The maximum string length in characters is 64.</p> 
trails[].<br>filter.<br>pathFilter.<br>root.<br>someFilter.<br>resource.<br>type | **string**<br><p>Required. Type of the resource</p> <p>The maximum string length in characters is 50.</p> 
trails[].<br>filter.<br>pathFilter.<br>root.<br>someFilter.<br>filters[] | **object**<br><p>Required. Filters for the resources contained in the parent resource</p> <p>Must contain at least one element.</p> 
trails[].<br>filter.<br>pathFilter.<br>root.<br>someFilter.<br>filters[].<br>anyFilter | **object**<br>Filter element with ANY type. If used, configures the trail to gather any events from the resource <br>`trails[].filter.pathFilter.root.someFilter.filters[]` includes only one of the fields `anyFilter`, `someFilter`<br>
trails[].<br>filter.<br>pathFilter.<br>root.<br>someFilter.<br>filters[].<br>anyFilter.<br>resource | **object**<br><p>Required. Resource definition</p> 
trails[].<br>filter.<br>pathFilter.<br>root.<br>someFilter.<br>filters[].<br>anyFilter.<br>resource.<br>id | **string**<br><p>Required. ID of the resource</p> <p>The maximum string length in characters is 64.</p> 
trails[].<br>filter.<br>pathFilter.<br>root.<br>someFilter.<br>filters[].<br>anyFilter.<br>resource.<br>type | **string**<br><p>Required. Type of the resource</p> <p>The maximum string length in characters is 50.</p> 
trails[].<br>filter.<br>pathFilter.<br>root.<br>someFilter.<br>filters[].<br>someFilter | **object**<br>Filter element with SOME type. If used, configures the trail to gather some of the events from the resource <br>`trails[].filter.pathFilter.root.someFilter.filters[]` includes only one of the fields `anyFilter`, `someFilter`<br>
trails[].<br>filter.<br>eventFilter | **object**<br><p>Required. Configuration of additional events gathering from specific services</p> 
trails[].<br>filter.<br>eventFilter.<br>filters[] | **object**<br><p>List of filters for services</p> <p>The minimum number of elements is 0.</p> 
trails[].<br>filter.<br>eventFilter.<br>filters[].<br>service | **string**<br><p>Required. Service ID of the gathered events</p> 
trails[].<br>filter.<br>eventFilter.<br>filters[].<br>categories[] | **object**<br><p>Required. List of the event categories gathered for a specified service</p> <p>Must contain at least one element.</p> 
trails[].<br>filter.<br>eventFilter.<br>filters[].<br>categories[].<br>plane | **string**<br><p>Required. Plane of the gathered category</p> <ul> <li>CONTROL_PLANE: The events that are generated during the interaction with the service's resources</li> <li>DATA_PLANE: Events that are generated during interaction with data within the service's resources</li> </ul> 
trails[].<br>filter.<br>eventFilter.<br>filters[].<br>categories[].<br>type | **string**<br><p>Required. Type of the gathered category</p> <ul> <li>WRITE: Events for operations that do perform some modification</li> <li>READ: Events for operations that do not perform any modifications</li> </ul> 
trails[].<br>filter.<br>eventFilter.<br>filters[].<br>pathFilter | **object**<br><p>Required. Resource path filter for a specified service</p> 
trails[].<br>filter.<br>eventFilter.<br>filters[].<br>pathFilter.<br>root | **object**<br><p>Required. Root element of the resource path filter for the trail Resource described in that filter node must contain the trail itself</p> 
trails[].<br>filter.<br>eventFilter.<br>filters[].<br>pathFilter.<br>root.<br>anyFilter | **object**<br>Filter element with ANY type. If used, configures the trail to gather any events from the resource <br>`trails[].filter.eventFilter.filters[].pathFilter.root` includes only one of the fields `anyFilter`, `someFilter`<br>
trails[].<br>filter.<br>eventFilter.<br>filters[].<br>pathFilter.<br>root.<br>anyFilter.<br>resource | **object**<br><p>Required. Resource definition</p> 
trails[].<br>filter.<br>eventFilter.<br>filters[].<br>pathFilter.<br>root.<br>anyFilter.<br>resource.<br>id | **string**<br><p>Required. ID of the resource</p> <p>The maximum string length in characters is 64.</p> 
trails[].<br>filter.<br>eventFilter.<br>filters[].<br>pathFilter.<br>root.<br>anyFilter.<br>resource.<br>type | **string**<br><p>Required. Type of the resource</p> <p>The maximum string length in characters is 50.</p> 
trails[].<br>filter.<br>eventFilter.<br>filters[].<br>pathFilter.<br>root.<br>someFilter | **object**<br>Filter element with SOME type. If used, configures the trail to gather some of the events from the resource <br>`trails[].filter.eventFilter.filters[].pathFilter.root` includes only one of the fields `anyFilter`, `someFilter`<br>
trails[].<br>filter.<br>eventFilter.<br>filters[].<br>pathFilter.<br>root.<br>someFilter.<br>resource | **object**<br><p>Required. Definition of the resource that contains nested resources</p> 
trails[].<br>filter.<br>eventFilter.<br>filters[].<br>pathFilter.<br>root.<br>someFilter.<br>resource.<br>id | **string**<br><p>Required. ID of the resource</p> <p>The maximum string length in characters is 64.</p> 
trails[].<br>filter.<br>eventFilter.<br>filters[].<br>pathFilter.<br>root.<br>someFilter.<br>resource.<br>type | **string**<br><p>Required. Type of the resource</p> <p>The maximum string length in characters is 50.</p> 
trails[].<br>filter.<br>eventFilter.<br>filters[].<br>pathFilter.<br>root.<br>someFilter.<br>filters[] | **object**<br><p>Required. Filters for the resources contained in the parent resource</p> <p>Must contain at least one element.</p> 
trails[].<br>filter.<br>eventFilter.<br>filters[].<br>pathFilter.<br>root.<br>someFilter.<br>filters[].<br>anyFilter | **object**<br>Filter element with ANY type. If used, configures the trail to gather any events from the resource <br>`trails[].filter.eventFilter.filters[].pathFilter.root.someFilter.filters[]` includes only one of the fields `anyFilter`, `someFilter`<br>
trails[].<br>filter.<br>eventFilter.<br>filters[].<br>pathFilter.<br>root.<br>someFilter.<br>filters[].<br>anyFilter.<br>resource | **object**<br><p>Required. Resource definition</p> 
trails[].<br>filter.<br>eventFilter.<br>filters[].<br>pathFilter.<br>root.<br>someFilter.<br>filters[].<br>anyFilter.<br>resource.<br>id | **string**<br><p>Required. ID of the resource</p> <p>The maximum string length in characters is 64.</p> 
trails[].<br>filter.<br>eventFilter.<br>filters[].<br>pathFilter.<br>root.<br>someFilter.<br>filters[].<br>anyFilter.<br>resource.<br>type | **string**<br><p>Required. Type of the resource</p> <p>The maximum string length in characters is 50.</p> 
trails[].<br>filter.<br>eventFilter.<br>filters[].<br>pathFilter.<br>root.<br>someFilter.<br>filters[].<br>someFilter | **object**<br>Filter element with SOME type. If used, configures the trail to gather some of the events from the resource <br>`trails[].filter.eventFilter.filters[].pathFilter.root.someFilter.filters[]` includes only one of the fields `anyFilter`, `someFilter`<br>
trails[].<br>statusErrorMessage | **string**<br><p>Current error message of the trail. Empty in case if the trail is active</p> 
trails[].<br>cloudId | **string**<br><p>Required. ID of the cloud that the trail belongs to</p> <p>The maximum string length in characters is 50.</p> 
trails[].<br>filteringPolicy | **object**<br><p>Event filtering policy Describes which groups of events will be sent and which resources will be monitored</p> <p>Combination of policies describing event filtering process of the trail At least one filed must be filled</p> 
trails[].<br>filteringPolicy.<br>managementEventsFilter | **object**<br><p>Singular filter describing gathering management events</p> <p>Policy for gathering management events</p> 
trails[].<br>filteringPolicy.<br>managementEventsFilter.<br>resourceScopes[] | **object**<br><p>Required. A list of resources which will be monitored by the trail</p> <p>The number of elements must be in the range 1-1024.</p> 
trails[].<br>filteringPolicy.<br>managementEventsFilter.<br>resourceScopes[].<br>id | **string**<br><p>Required. ID of the resource</p> <p>The maximum string length in characters is 64.</p> 
trails[].<br>filteringPolicy.<br>managementEventsFilter.<br>resourceScopes[].<br>type | **string**<br><p>Required. Type of the resource</p> <p>The maximum string length in characters is 50.</p> 
trails[].<br>filteringPolicy.<br>dataEventsFilters[] | **object**<br><p>List of filters describing gathering data events</p> <p>The number of elements must be less than 128.</p> 
trails[].<br>filteringPolicy.<br>dataEventsFilters[].<br>service | **string**<br><p>Required. Name of the service whose events will be delivered</p> 
trails[].<br>filteringPolicy.<br>dataEventsFilters[].<br>resourceScopes[] | **object**<br><p>Required. A list of resources which will be monitored by the trail</p> <p>The number of elements must be in the range 1-1024.</p> 
trails[].<br>filteringPolicy.<br>dataEventsFilters[].<br>resourceScopes[].<br>id | **string**<br><p>Required. ID of the resource</p> <p>The maximum string length in characters is 64.</p> 
trails[].<br>filteringPolicy.<br>dataEventsFilters[].<br>resourceScopes[].<br>type | **string**<br><p>Required. Type of the resource</p> <p>The maximum string length in characters is 50.</p> 
trails[].<br>filteringPolicy.<br>dataEventsFilters[].<br>includedEvents | **object**<br>Explicitly included events of specified service New events of the service won't be delivered by default <br>`trails[].filteringPolicy.dataEventsFilters[]` includes only one of the fields `includedEvents`, `excludedEvents`<br>
trails[].<br>filteringPolicy.<br>dataEventsFilters[].<br>includedEvents.<br>eventTypes[] | **string**<br><p>Required. The number of elements must be in the range 1-1024.</p> 
trails[].<br>filteringPolicy.<br>dataEventsFilters[].<br>excludedEvents | **object**<br>Explicitly excluded events of specified service New events of the service will be delivered by default <br>`trails[].filteringPolicy.dataEventsFilters[]` includes only one of the fields `includedEvents`, `excludedEvents`<br>
trails[].<br>filteringPolicy.<br>dataEventsFilters[].<br>excludedEvents.<br>eventTypes[] | **string**<br><p>Required. The number of elements must be in the range 1-1024.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is greater than the specified <a href="/docs/audit-trails/api-ref/Trail/list#query_params">pageSize</a>, use the ``next_page_token`` as the value for the <a href="/docs/audit-trails/api-ref/Trail/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own ``next_page_token`` to continue paging through the results.</p> 