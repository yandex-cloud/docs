---
editable: false
sourcePath: en/_api-ref/dataproc/api-ref/Job/list.md
---

# Method list
Retrieves a list of jobs for a cluster.
 

 
## HTTP request {#https-request}
```
GET https://dataproc.{{ api-host }}/dataproc/v1/clusters/{clusterId}/jobs
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the cluster to list jobs for.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/data-proc/api-ref/Job/list#query_params">pageSize</a>, the service returns a <a href="/docs/data-proc/api-ref/Job/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/data-proc/api-ref/Job/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters jobs listed in the response.</p> <p>The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering only on <a href="/docs/data-proc/api-ref/Job#representation">Job.name</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``. Example of a filter: ``name=my-job``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
 
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
      "createdBy": "string",
      "status": "string",
      "applicationInfo": {
        "id": "string",
        "applicationAttempts": [
          {
            "id": "string",
            "amContainerId": "string"
          }
        ]
      },

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
        "mainClass": "string",
        "packages": [
          "string"
        ],
        "repositories": [
          "string"
        ],
        "excludePackages": [
          "string"
        ]
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
        ],
        "packages": [
          "string"
        ],
        "repositories": [
          "string"
        ],
        "excludePackages": [
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
jobs[] | **object**<br><p>List of jobs for the specified cluster.</p> 
jobs[].<br>id | **string**<br><p>ID of the job. Generated at creation time.</p> 
jobs[].<br>clusterId | **string**<br><p>ID of the Data Proc cluster that the job belongs to.</p> 
jobs[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
jobs[].<br>startedAt | **string** (date-time)<br><p>The time when the job was started.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
jobs[].<br>finishedAt | **string** (date-time)<br><p>The time when the job was finished.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
jobs[].<br>name | **string**<br><p>Name of the job, specified in the <a href="/docs/data-proc/api-ref/Job/create">create</a> request.</p> 
jobs[].<br>createdBy | **string**<br><p>The id of the user who created the job</p> 
jobs[].<br>status | **string**<br>Job status.<br><ul> <li>PROVISIONING: Job is logged in the database and is waiting for the agent to run it.</li> <li>PENDING: Job is acquired by the agent and is in the queue for execution.</li> <li>RUNNING: Job is being run in the cluster.</li> <li>ERROR: Job failed to finish the run properly.</li> <li>DONE: Job is finished.</li> <li>CANCELLED: Job is cancelled.</li> <li>CANCELLING: Job is waiting for cancellation.</li> </ul> 
jobs[].<br>applicationInfo | **object**<br>Attributes of YARN application.
jobs[].<br>applicationInfo.<br>id | **string**<br><p>ID of YARN application</p> 
jobs[].<br>applicationInfo.<br>applicationAttempts[] | **object**<br><p>YARN application attempts</p> 
jobs[].<br>applicationInfo.<br>applicationAttempts[].<br>id | **string**<br><p>ID of YARN application attempt</p> 
jobs[].<br>applicationInfo.<br>applicationAttempts[].<br>amContainerId | **string**<br><p>ID of YARN Application Master container</p> 
jobs[].<br>mapreduceJob | **object**<br>Specification for a MapReduce job. <br>`jobs[]` includes only one of the fields `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br>
jobs[].<br>mapreduceJob.<br>args[] | **string**<br><p>Optional arguments to pass to the driver.</p> 
jobs[].<br>mapreduceJob.<br>jarFileUris[] | **string**<br><p>JAR file URIs to add to CLASSPATH of the Data Proc driver and each task.</p> 
jobs[].<br>mapreduceJob.<br>fileUris[] | **string**<br><p>URIs of resource files to be copied to the working directory of Data Proc drivers and distributed Hadoop tasks.</p> 
jobs[].<br>mapreduceJob.<br>archiveUris[] | **string**<br><p>URIs of archives to be extracted to the working directory of Data Proc drivers and tasks.</p> 
jobs[].<br>mapreduceJob.<br>properties | **object**<br><p>Property names and values, used to configure Data Proc and MapReduce.</p> 
jobs[].<br>mapreduceJob.<br>mainJarFileUri | **string** <br>`jobs[].mapreduceJob` includes only one of the fields `mainJarFileUri`, `mainClass`<br><br><p>HCFS URI of the .jar file containing the driver class.</p> 
jobs[].<br>mapreduceJob.<br>mainClass | **string** <br>`jobs[].mapreduceJob` includes only one of the fields `mainJarFileUri`, `mainClass`<br><br><p>The name of the driver class.</p> 
jobs[].<br>sparkJob | **object**<br>Specification for a Spark job. <br>`jobs[]` includes only one of the fields `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br>
jobs[].<br>sparkJob.<br>args[] | **string**<br><p>Optional arguments to pass to the driver.</p> 
jobs[].<br>sparkJob.<br>jarFileUris[] | **string**<br><p>JAR file URIs to add to CLASSPATH of the Data Proc driver and each task.</p> 
jobs[].<br>sparkJob.<br>fileUris[] | **string**<br><p>URIs of resource files to be copied to the working directory of Data Proc drivers and distributed Hadoop tasks.</p> 
jobs[].<br>sparkJob.<br>archiveUris[] | **string**<br><p>URIs of archives to be extracted to the working directory of Data Proc drivers and tasks.</p> 
jobs[].<br>sparkJob.<br>properties | **object**<br><p>Property names and values, used to configure Data Proc and Spark.</p> 
jobs[].<br>sparkJob.<br>mainJarFileUri | **string**<br><p>The HCFS URI of the JAR file containing the ``main`` class for the job.</p> 
jobs[].<br>sparkJob.<br>mainClass | **string**<br><p>The name of the driver class.</p> 
jobs[].<br>sparkJob.<br>packages[] | **string**<br><p>List of maven coordinates of jars to include on the driver and executor classpaths.</p> 
jobs[].<br>sparkJob.<br>repositories[] | **string**<br><p>List of additional remote repositories to search for the maven coordinates given with --packages.</p> 
jobs[].<br>sparkJob.<br>excludePackages[] | **string**<br><p>List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts.</p> 
jobs[].<br>pysparkJob | **object**<br>Specification for a PySpark job. <br>`jobs[]` includes only one of the fields `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br>
jobs[].<br>pysparkJob.<br>args[] | **string**<br><p>Optional arguments to pass to the driver.</p> 
jobs[].<br>pysparkJob.<br>jarFileUris[] | **string**<br><p>JAR file URIs to add to CLASSPATH of the Data Proc driver and each task.</p> 
jobs[].<br>pysparkJob.<br>fileUris[] | **string**<br><p>URIs of resource files to be copied to the working directory of Data Proc drivers and distributed Hadoop tasks.</p> 
jobs[].<br>pysparkJob.<br>archiveUris[] | **string**<br><p>URIs of archives to be extracted to the working directory of Data Proc drivers and tasks.</p> 
jobs[].<br>pysparkJob.<br>properties | **object**<br><p>Property names and values, used to configure Data Proc and PySpark.</p> 
jobs[].<br>pysparkJob.<br>mainPythonFileUri | **string**<br><p>URI of the file with the driver code. Must be a .py file.</p> 
jobs[].<br>pysparkJob.<br>pythonFileUris[] | **string**<br><p>URIs of Python files to pass to the PySpark framework.</p> 
jobs[].<br>pysparkJob.<br>packages[] | **string**<br><p>List of maven coordinates of jars to include on the driver and executor classpaths.</p> 
jobs[].<br>pysparkJob.<br>repositories[] | **string**<br><p>List of additional remote repositories to search for the maven coordinates given with --packages.</p> 
jobs[].<br>pysparkJob.<br>excludePackages[] | **string**<br><p>List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts.</p> 
jobs[].<br>hiveJob | **object**<br>Specification for a Hive job. <br>`jobs[]` includes only one of the fields `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br>
jobs[].<br>hiveJob.<br>properties | **object**<br><p>Property names and values, used to configure Data Proc and Hive.</p> 
jobs[].<br>hiveJob.<br>continueOnFailure | **boolean** (boolean)<br><p>Flag indicating whether a job should continue to run if a query fails.</p> 
jobs[].<br>hiveJob.<br>scriptVariables | **object**<br><p>Query variables and their values.</p> 
jobs[].<br>hiveJob.<br>jarFileUris[] | **string**<br><p>JAR file URIs to add to CLASSPATH of the Hive driver and each task.</p> 
jobs[].<br>hiveJob.<br>queryFileUri | **string** <br>`jobs[].hiveJob` includes only one of the fields `queryFileUri`, `queryList`<br><br><p>URI of the script with all the necessary Hive queries.</p> 
jobs[].<br>hiveJob.<br>queryList | **object**<br>List of Hive queries to be used in the job. <br>`jobs[].hiveJob` includes only one of the fields `queryFileUri`, `queryList`<br>
jobs[].<br>hiveJob.<br>queryList.<br>queries[] | **string**<br><p>List of Hive queries.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/data-proc/api-ref/Job/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/data-proc/api-ref/Job/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 