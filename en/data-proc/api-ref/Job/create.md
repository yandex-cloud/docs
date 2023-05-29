---
editable: false
sourcePath: en/_api-ref/dataproc/v1/api-ref/Job/create.md
---

# Data Proc API, REST: Job.create
Creates a job for a cluster.
 

 
## HTTP request {#https-request}
```
POST https://dataproc.{{ api-host }}/dataproc/v1/clusters/{clusterId}/jobs
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the cluster to create a job for.</p> <p>The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "name": "string",

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

 
Field | Description
--- | ---
name | **string**<br><p>Name of the job.</p> <p>Value must match the regular expression ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
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