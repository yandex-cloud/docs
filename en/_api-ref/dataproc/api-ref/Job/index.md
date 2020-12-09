---
editable: false
---

# Job
A set of methods for managing Data Proc jobs.
## JSON Representation {#representation}
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
 
Field | Description
--- | ---
id | **string**<br><p>ID of the job. Generated at creation time.</p> 
clusterId | **string**<br><p>ID of the Data Proc cluster that the job belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
startedAt | **string** (date-time)<br><p>The time when the job was started.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
finishedAt | **string** (date-time)<br><p>The time when the job was finished.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the job, specified in the <a href="/docs/data-proc/api-ref/Job/create">create</a> request.</p> 
createdBy | **string**<br><p>The id of the user who created the job</p> 
status | **string**<br>Job status.<br><ul> <li>PROVISIONING: Job is logged in the database and is waiting for the agent to run it.</li> <li>PENDING: Job is acquired by the agent and is in the queue for execution.</li> <li>RUNNING: Job is being run in the cluster.</li> <li>ERROR: Job failed to finish the run properly.</li> <li>DONE: Job is finished.</li> </ul> 
mapreduceJob | **object** <br> includes only one of the fields `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br><br>
mapreduceJob.<br>args[] | **string**<br><p>Optional arguments to pass to the driver.</p> 
mapreduceJob.<br>jarFileUris[] | **string**<br><p>JAR file URIs to add to CLASSPATH of the Data Proc driver and each task.</p> 
mapreduceJob.<br>fileUris[] | **string**<br><p>URIs of resource files to be copied to the working directory of Data Proc drivers and distributed Hadoop tasks.</p> 
mapreduceJob.<br>archiveUris[] | **string**<br><p>URIs of archives to be extracted to the working directory of Data Proc drivers and tasks.</p> 
mapreduceJob.<br>properties | **object**<br><p>Property names and values, used to configure Data Proc and MapReduce.</p> 
mapreduceJob.<br>mainJarFileUri | **string** <br>`mapreduceJob` includes only one of the fields `mainJarFileUri`, `mainClass`<br><br><p>HCFS URI of the .jar file containing the driver class.</p> 
mapreduceJob.<br>mainClass | **string** <br>`mapreduceJob` includes only one of the fields `mainJarFileUri`, `mainClass`<br><br><p>The name of the driver class.</p> 
sparkJob | **object** <br> includes only one of the fields `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br><br>
sparkJob.<br>args[] | **string**<br><p>Optional arguments to pass to the driver.</p> 
sparkJob.<br>jarFileUris[] | **string**<br><p>JAR file URIs to add to CLASSPATH of the Data Proc driver and each task.</p> 
sparkJob.<br>fileUris[] | **string**<br><p>URIs of resource files to be copied to the working directory of Data Proc drivers and distributed Hadoop tasks.</p> 
sparkJob.<br>archiveUris[] | **string**<br><p>URIs of archives to be extracted to the working directory of Data Proc drivers and tasks.</p> 
sparkJob.<br>properties | **object**<br><p>Property names and values, used to configure Data Proc and Spark.</p> 
sparkJob.<br>mainJarFileUri | **string**<br><p>The HCFS URI of the JAR file containing the `main` class for the job.</p> 
sparkJob.<br>mainClass | **string**<br><p>The name of the driver class.</p> 
pysparkJob | **object** <br> includes only one of the fields `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br><br>
pysparkJob.<br>args[] | **string**<br><p>Optional arguments to pass to the driver.</p> 
pysparkJob.<br>jarFileUris[] | **string**<br><p>JAR file URIs to add to CLASSPATH of the Data Proc driver and each task.</p> 
pysparkJob.<br>fileUris[] | **string**<br><p>URIs of resource files to be copied to the working directory of Data Proc drivers and distributed Hadoop tasks.</p> 
pysparkJob.<br>archiveUris[] | **string**<br><p>URIs of archives to be extracted to the working directory of Data Proc drivers and tasks.</p> 
pysparkJob.<br>properties | **object**<br><p>Property names and values, used to configure Data Proc and PySpark.</p> 
pysparkJob.<br>mainPythonFileUri | **string**<br><p>URI of the file with the driver code. Must be a .py file.</p> 
pysparkJob.<br>pythonFileUris[] | **string**<br><p>URIs of Python files to pass to the PySpark framework.</p> 
hiveJob | **object** <br> includes only one of the fields `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br><br>
hiveJob.<br>properties | **object**<br><p>Property names and values, used to configure Data Proc and Hive.</p> 
hiveJob.<br>continueOnFailure | **boolean** (boolean)<br><p>Flag indicating whether a job should continue to run if a query fails.</p> 
hiveJob.<br>scriptVariables | **object**<br><p>Query variables and their values.</p> 
hiveJob.<br>jarFileUris[] | **string**<br><p>JAR file URIs to add to CLASSPATH of the Hive driver and each task.</p> 
hiveJob.<br>queryFileUri | **string** <br>`hiveJob` includes only one of the fields `queryFileUri`, `queryList`<br><br><p>URI of the script with all the necessary Hive queries.</p> 
hiveJob.<br>queryList | **object** <br>`hiveJob` includes only one of the fields `queryFileUri`, `queryList`<br><br>
hiveJob.<br>queryList.<br>queries[] | **string**<br><p>List of Hive queries.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a job for a cluster.
[get](get.md) | Returns the specified job.
[list](list.md) | Retrieves a list of jobs for a cluster.
[listLog](listLog.md) | Returns a log for specified job.