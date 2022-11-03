---
editable: false
sourcePath: en/_api-ref/dataproc/api-ref/Job/get.md
---

# Method get
Returns the specified job.
 

 
## HTTP request {#https-request}
```
GET https://dataproc.{{ api-host }}/dataproc/v1/clusters/{clusterId}/jobs/{jobId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the cluster to request a job from.</p> <p>The maximum string length in characters is 50.</p> 
jobId | <p>Required. ID of the job to return.</p> <p>To get a job ID make a <a href="/docs/data-proc/api-ref/Job/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
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

  //  includes only one of the fields `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`
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

    // `mapreduceJob` includes only one of the fields `mainJarFileUri`, `mainClass`
    "mainJarFileUri": "string",
    "mainClass": "string",
    // end of the list of possible fields`mapreduceJob`

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

    // `hiveJob` includes only one of the fields `queryFileUri`, `queryList`
    "queryFileUri": "string",
    "queryList": {
      "queries": [
        "string"
      ]
    },
    // end of the list of possible fields`hiveJob`

  },
  // end of the list of possible fields

}
```
A Data Proc job. For details about the concept, see [documentation](/docs/data-proc/concepts/jobs).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the job. Generated at creation time.</p> 
clusterId | **string**<br><p>ID of the Data Proc cluster that the job belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
startedAt | **string** (date-time)<br><p>The time when the job was started.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
finishedAt | **string** (date-time)<br><p>The time when the job was finished.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the job, specified in the <a href="/docs/data-proc/api-ref/Job/create">create</a> request.</p> 
createdBy | **string**<br><p>The id of the user who created the job</p> 
status | **string**<br>Job status.<br><ul> <li>PROVISIONING: Job is logged in the database and is waiting for the agent to run it.</li> <li>PENDING: Job is acquired by the agent and is in the queue for execution.</li> <li>RUNNING: Job is being run in the cluster.</li> <li>ERROR: Job failed to finish the run properly.</li> <li>DONE: Job is finished.</li> <li>CANCELLED: Job is cancelled.</li> <li>CANCELLING: Job is waiting for cancellation.</li> </ul> 
applicationInfo | **object**<br>Attributes of YARN application.
applicationInfo.<br>id | **string**<br><p>ID of YARN application</p> 
applicationInfo.<br>applicationAttempts[] | **object**<br><p>YARN application attempts</p> 
applicationInfo.<br>applicationAttempts[].<br>id | **string**<br><p>ID of YARN application attempt</p> 
applicationInfo.<br>applicationAttempts[].<br>amContainerId | **string**<br><p>ID of YARN Application Master container</p> 
mapreduceJob | **object**<br>Specification for a MapReduce job. <br> includes only one of the fields `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br>
mapreduceJob.<br>args[] | **string**<br><p>Optional arguments to pass to the driver.</p> 
mapreduceJob.<br>jarFileUris[] | **string**<br><p>JAR file URIs to add to CLASSPATH of the Data Proc driver and each task.</p> 
mapreduceJob.<br>fileUris[] | **string**<br><p>URIs of resource files to be copied to the working directory of Data Proc drivers and distributed Hadoop tasks.</p> 
mapreduceJob.<br>archiveUris[] | **string**<br><p>URIs of archives to be extracted to the working directory of Data Proc drivers and tasks.</p> 
mapreduceJob.<br>properties | **object**<br><p>Property names and values, used to configure Data Proc and MapReduce.</p> 
mapreduceJob.<br>mainJarFileUri | **string** <br>`mapreduceJob` includes only one of the fields `mainJarFileUri`, `mainClass`<br><br><p>HCFS URI of the .jar file containing the driver class.</p> 
mapreduceJob.<br>mainClass | **string** <br>`mapreduceJob` includes only one of the fields `mainJarFileUri`, `mainClass`<br><br><p>The name of the driver class.</p> 
sparkJob | **object**<br>Specification for a Spark job. <br> includes only one of the fields `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br>
sparkJob.<br>args[] | **string**<br><p>Optional arguments to pass to the driver.</p> 
sparkJob.<br>jarFileUris[] | **string**<br><p>JAR file URIs to add to CLASSPATH of the Data Proc driver and each task.</p> 
sparkJob.<br>fileUris[] | **string**<br><p>URIs of resource files to be copied to the working directory of Data Proc drivers and distributed Hadoop tasks.</p> 
sparkJob.<br>archiveUris[] | **string**<br><p>URIs of archives to be extracted to the working directory of Data Proc drivers and tasks.</p> 
sparkJob.<br>properties | **object**<br><p>Property names and values, used to configure Data Proc and Spark.</p> 
sparkJob.<br>mainJarFileUri | **string**<br><p>The HCFS URI of the JAR file containing the ``main`` class for the job.</p> 
sparkJob.<br>mainClass | **string**<br><p>The name of the driver class.</p> 
sparkJob.<br>packages[] | **string**<br><p>List of maven coordinates of jars to include on the driver and executor classpaths.</p> 
sparkJob.<br>repositories[] | **string**<br><p>List of additional remote repositories to search for the maven coordinates given with --packages.</p> 
sparkJob.<br>excludePackages[] | **string**<br><p>List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts.</p> 
pysparkJob | **object**<br>Specification for a PySpark job. <br> includes only one of the fields `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br>
pysparkJob.<br>args[] | **string**<br><p>Optional arguments to pass to the driver.</p> 
pysparkJob.<br>jarFileUris[] | **string**<br><p>JAR file URIs to add to CLASSPATH of the Data Proc driver and each task.</p> 
pysparkJob.<br>fileUris[] | **string**<br><p>URIs of resource files to be copied to the working directory of Data Proc drivers and distributed Hadoop tasks.</p> 
pysparkJob.<br>archiveUris[] | **string**<br><p>URIs of archives to be extracted to the working directory of Data Proc drivers and tasks.</p> 
pysparkJob.<br>properties | **object**<br><p>Property names and values, used to configure Data Proc and PySpark.</p> 
pysparkJob.<br>mainPythonFileUri | **string**<br><p>URI of the file with the driver code. Must be a .py file.</p> 
pysparkJob.<br>pythonFileUris[] | **string**<br><p>URIs of Python files to pass to the PySpark framework.</p> 
pysparkJob.<br>packages[] | **string**<br><p>List of maven coordinates of jars to include on the driver and executor classpaths.</p> 
pysparkJob.<br>repositories[] | **string**<br><p>List of additional remote repositories to search for the maven coordinates given with --packages.</p> 
pysparkJob.<br>excludePackages[] | **string**<br><p>List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts.</p> 
hiveJob | **object**<br>Specification for a Hive job. <br> includes only one of the fields `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br>
hiveJob.<br>properties | **object**<br><p>Property names and values, used to configure Data Proc and Hive.</p> 
hiveJob.<br>continueOnFailure | **boolean** (boolean)<br><p>Flag indicating whether a job should continue to run if a query fails.</p> 
hiveJob.<br>scriptVariables | **object**<br><p>Query variables and their values.</p> 
hiveJob.<br>jarFileUris[] | **string**<br><p>JAR file URIs to add to CLASSPATH of the Hive driver and each task.</p> 
hiveJob.<br>queryFileUri | **string** <br>`hiveJob` includes only one of the fields `queryFileUri`, `queryList`<br><br><p>URI of the script with all the necessary Hive queries.</p> 
hiveJob.<br>queryList | **object**<br>List of Hive queries to be used in the job. <br>`hiveJob` includes only one of the fields `queryFileUri`, `queryList`<br>
hiveJob.<br>queryList.<br>queries[] | **string**<br><p>List of Hive queries.</p> 