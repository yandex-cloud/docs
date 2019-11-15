---
editable: false
---

# Method list
Retrieves a list of jobs for Dataproc cluster.
 

 
## HTTP request {#https-request}
```
GET https://dataproc.api.cloud.yandex.net/dataproc/v1/clusters/{clusterId}/jobs
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the cluster to list Dataproc jobs of.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a `next_page_token` that can be used to get the next page of results in subsequent ListJobs requests. Acceptable values are 0 to 1000, inclusive. Default value: 100.  The maximum value is 1000.
pageToken | Page token. Set `page_token` to the `next_page_token` returned by a previous ListJobs request to get the next page of results.  The maximum string length in characters is 100.
filter | String that describes a display filter.  The maximum string length in characters is 1000.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "jobs": [
    {
      "id": "string",
      "clusterId": "string",
      "createdAt": "string",
      "startedAt": "string",
      "finishedAt": "string",
      "name": "string",
      "status": "string",

      // `jobs[]` includes only one of the fields `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`
      "mapreduceJob": {
        "args": [
          "string"
        ],
        "jarFileUris": [
          "string"
        ],
        "fileUris": [
          "string"
        ],
        "archiveUris": [
          "string"
        ],
        "properties": "object",

        // `jobs[].mapreduceJob` includes only one of the fields `mainJarFileUri`, `mainClass`
        "mainJarFileUri": "string",
        "mainClass": "string",
        // end of the list of possible fields`jobs[].mapreduceJob`

      },
      "sparkJob": {
        "args": [
          "string"
        ],
        "jarFileUris": [
          "string"
        ],
        "fileUris": [
          "string"
        ],
        "archiveUris": [
          "string"
        ],
        "properties": "object",
        "mainJarFileUri": "string",
        "mainClass": "string"
      },
      "pysparkJob": {
        "args": [
          "string"
        ],
        "jarFileUris": [
          "string"
        ],
        "fileUris": [
          "string"
        ],
        "archiveUris": [
          "string"
        ],
        "properties": "object",
        "mainPythonFileUri": "string",
        "pythonFileUris": [
          "string"
        ]
      },
      "hiveJob": {
        "properties": "object",
        "continueOnFailure": true,
        "scriptVariables": "object",
        "jarFileUris": [
          "string"
        ],

        // `jobs[].hiveJob` includes only one of the fields `queryFileUri`, `queryList`
        "queryFileUri": "string",
        "queryList": {
          "queries": [
            "string"
          ]
        },
        // end of the list of possible fields`jobs[].hiveJob`

      },
      // end of the list of possible fields`jobs[]`

    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
jobs[] | **object**<br><p>Dataproc job.</p> 
jobs[].<br>id | **string**<br><p>Required. Unique ID of the Dataproc job. This ID is assigned by MDB in the process of creating Dataproc job.</p> 
jobs[].<br>clusterId | **string**<br><p>Required. Unique ID of the Dataproc cluster.</p> 
jobs[].<br>createdAt | **string** (date-time)<br><p>The time when the Dataproc job was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
jobs[].<br>startedAt | **string** (date-time)<br><p>The time when the Dataproc job was started.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
jobs[].<br>finishedAt | **string** (date-time)<br><p>The time when the Dataproc job was finished.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
jobs[].<br>name | **string**<br><p>Name of the Dataproc job.</p> 
jobs[].<br>status | **string**<br>Status.<br>
jobs[].<br>mapreduceJob | **object** <br>`jobs[]` includes only one of the fields `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br><br>
jobs[].<br>mapreduceJob.<br>args[] | **string**<br><p>Optional arguments to the driver.</p> 
jobs[].<br>mapreduceJob.<br>jarFileUris[] | **string**<br><p>URIs of file to run.</p> 
jobs[].<br>mapreduceJob.<br>fileUris[] | **string**<br><p>URIs of files to be copied to the working directory of Dataproc drivers and distributed tasks.</p> 
jobs[].<br>mapreduceJob.<br>archiveUris[] | **string**<br><p>URIs of archives to be extracted in the working directory of Dataproc drivers and tasks.</p> 
jobs[].<br>mapreduceJob.<br>properties | **object**<br><p>A mapping of property names to values, used to configure Dataproc.</p> 
jobs[].<br>mapreduceJob.<br>mainJarFileUri | **string** <br>`jobs[].mapreduceJob` includes only one of the fields `mainJarFileUri`, `mainClass`<br><br><p>The HCFS URI of the jar file containing the main class.</p> 
jobs[].<br>mapreduceJob.<br>mainClass | **string** <br>`jobs[].mapreduceJob` includes only one of the fields `mainJarFileUri`, `mainClass`<br><br><p>The name of the driver's main class.</p> 
jobs[].<br>sparkJob | **object** <br>`jobs[]` includes only one of the fields `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br><br>
jobs[].<br>sparkJob.<br>args[] | **string**<br><p>Optional arguments to the driver.</p> 
jobs[].<br>sparkJob.<br>jarFileUris[] | **string**<br><p>Jar file URIs to add to the CLASSPATHs of the Dataproc driver and tasks.</p> 
jobs[].<br>sparkJob.<br>fileUris[] | **string**<br><p>URIs of files to be copied to the working directory of Dataproc drivers and distributed tasks.</p> 
jobs[].<br>sparkJob.<br>archiveUris[] | **string**<br><p>URIs of archives to be extracted in the working directory of Dataproc drivers and tasks.</p> 
jobs[].<br>sparkJob.<br>properties | **object**<br><p>A mapping of property names to values, used to configure Dataproc.</p> 
jobs[].<br>sparkJob.<br>mainJarFileUri | **string**<br><p>The HCFS URI of the jar file containing the main class.</p> 
jobs[].<br>sparkJob.<br>mainClass | **string**<br><p>The name of the driver's main class.</p> 
jobs[].<br>pysparkJob | **object** <br>`jobs[]` includes only one of the fields `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br><br>
jobs[].<br>pysparkJob.<br>args[] | **string**<br><p>Optional arguments to the driver.</p> 
jobs[].<br>pysparkJob.<br>jarFileUris[] | **string**<br><p>Jar file URIs to add to the CLASSPATHs of the Dataproc driver and tasks.</p> 
jobs[].<br>pysparkJob.<br>fileUris[] | **string**<br><p>URIs of files to be copied to the working directory of Dataproc drivers and distributed tasks.</p> 
jobs[].<br>pysparkJob.<br>archiveUris[] | **string**<br><p>URIs of archives to be extracted in the working directory of Dataproc drivers and tasks.</p> 
jobs[].<br>pysparkJob.<br>properties | **object**<br><p>A mapping of property names to values, used to configure Dataproc.</p> 
jobs[].<br>pysparkJob.<br>mainPythonFileUri | **string**<br><p>URI of the main Python file to use as the driver. Must be a .py file.</p> 
jobs[].<br>pysparkJob.<br>pythonFileUris[] | **string**<br><p>URIs of Python files to pass to the PySpark framework.</p> 
jobs[].<br>hiveJob | **object** <br>`jobs[]` includes only one of the fields `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br><br>
jobs[].<br>hiveJob.<br>properties | **object**<br><p>A mapping of property names to values, used to configure Hive.</p> 
jobs[].<br>hiveJob.<br>continueOnFailure | **boolean** (boolean)<br><p>Whether to continue executing queries if a query fails.</p> 
jobs[].<br>hiveJob.<br>scriptVariables | **object**<br><p>Mapping of query variable names to values.</p> 
jobs[].<br>hiveJob.<br>jarFileUris[] | **string**<br><p>Jar file URIs to add to the CLASSPATHs of the Hive driver and tasks.</p> 
jobs[].<br>hiveJob.<br>queryFileUri | **string** <br>`jobs[].hiveJob` includes only one of the fields `queryFileUri`, `queryList`<br><br><p>URI of the script that contains Hive queries.</p> 
jobs[].<br>hiveJob.<br>queryList | **object** <br>`jobs[].hiveJob` includes only one of the fields `queryFileUri`, `queryList`<br><br>
jobs[].<br>hiveJob.<br>queryList.<br>queries[] | **string**<br>
nextPageToken | **string**<br><p>This token allows you to get the next page of results for ListJobs requests, if the number of results is larger than <code>page_size</code> specified in the request. To get the next page, specify the value of <code>next_page_token</code> as a value for the <code>page_token</code> parameter in the next ListClusters request. Subsequent ListClusters requests will have their own <code>next_page_token</code> to continue paging through the results.</p> 