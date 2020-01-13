---
editable: false
---

# Job

## JSON Representation {#representation}
```json 
{
  "id": "string",
  "clusterId": "string",
  "createdAt": "string",
  "startedAt": "string",
  "finishedAt": "string",
  "name": "string",
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
id | **string**<br><p>Unique ID of the Data Proc job. This ID is assigned by MDB in the process of creating Data Proc job.</p> 
clusterId | **string**<br><p>ID of the Data Proc cluster.</p> 
createdAt | **string** (date-time)<br><p>The time when the Data Proc job was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
startedAt | **string** (date-time)<br><p>The time when the Data Proc job was started.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
finishedAt | **string** (date-time)<br><p>The time when the Data Proc job was finished.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the Data Proc job.</p> 
status | **string**<br>Status.<br>
mapreduceJob | **object** <br> includes only one of the fields `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br><br>
mapreduceJob.<br>args[] | **string**<br><p>Optional arguments to the driver.</p> 
mapreduceJob.<br>jarFileUris[] | **string**<br><p>URIs of file to run.</p> 
mapreduceJob.<br>fileUris[] | **string**<br><p>URIs of files to be copied to the working directory of Data Proc drivers and distributed tasks.</p> 
mapreduceJob.<br>archiveUris[] | **string**<br><p>URIs of archives to be extracted in the working directory of Data Proc drivers and tasks.</p> 
mapreduceJob.<br>properties | **object**<br><p>A mapping of property names to values, used to configure Data Proc.</p> 
mapreduceJob.<br>mainJarFileUri | **string** <br>`mapreduceJob` includes only one of the fields `mainJarFileUri`, `mainClass`<br><br><p>The HCFS URI of the jar file containing the main class.</p> 
mapreduceJob.<br>mainClass | **string** <br>`mapreduceJob` includes only one of the fields `mainJarFileUri`, `mainClass`<br><br><p>The name of the driver's main class.</p> 
sparkJob | **object** <br> includes only one of the fields `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br><br>
sparkJob.<br>args[] | **string**<br><p>Optional arguments to the driver.</p> 
sparkJob.<br>jarFileUris[] | **string**<br><p>Jar file URIs to add to the CLASSPATHs of the Data Proc driver and tasks.</p> 
sparkJob.<br>fileUris[] | **string**<br><p>URIs of files to be copied to the working directory of Data Proc drivers and distributed tasks.</p> 
sparkJob.<br>archiveUris[] | **string**<br><p>URIs of archives to be extracted in the working directory of Data Proc drivers and tasks.</p> 
sparkJob.<br>properties | **object**<br><p>A mapping of property names to values, used to configure Data Proc.</p> 
sparkJob.<br>mainJarFileUri | **string**<br><p>The HCFS URI of the jar file containing the main class.</p> 
sparkJob.<br>mainClass | **string**<br><p>The name of the driver's main class.</p> 
pysparkJob | **object** <br> includes only one of the fields `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br><br>
pysparkJob.<br>args[] | **string**<br><p>Optional arguments to the driver.</p> 
pysparkJob.<br>jarFileUris[] | **string**<br><p>Jar file URIs to add to the CLASSPATHs of the Data Proc driver and tasks.</p> 
pysparkJob.<br>fileUris[] | **string**<br><p>URIs of files to be copied to the working directory of Data Proc drivers and distributed tasks.</p> 
pysparkJob.<br>archiveUris[] | **string**<br><p>URIs of archives to be extracted in the working directory of Data Proc drivers and tasks.</p> 
pysparkJob.<br>properties | **object**<br><p>A mapping of property names to values, used to configure Data Proc.</p> 
pysparkJob.<br>mainPythonFileUri | **string**<br><p>URI of the main Python file to use as the driver. Must be a .py file.</p> 
pysparkJob.<br>pythonFileUris[] | **string**<br><p>URIs of Python files to pass to the PySpark framework.</p> 
hiveJob | **object** <br> includes only one of the fields `mapreduceJob`, `sparkJob`, `pysparkJob`, `hiveJob`<br><br>
hiveJob.<br>properties | **object**<br><p>A mapping of property names to values, used to configure Hive.</p> 
hiveJob.<br>continueOnFailure | **boolean** (boolean)<br><p>Whether to continue executing queries if a query fails.</p> 
hiveJob.<br>scriptVariables | **object**<br><p>Mapping of query variable names to values.</p> 
hiveJob.<br>jarFileUris[] | **string**<br><p>Jar file URIs to add to the CLASSPATHs of the Hive driver and tasks.</p> 
hiveJob.<br>queryFileUri | **string** <br>`hiveJob` includes only one of the fields `queryFileUri`, `queryList`<br><br><p>URI of the script that contains Hive queries.</p> 
hiveJob.<br>queryList | **object** <br>`hiveJob` includes only one of the fields `queryFileUri`, `queryList`<br><br>
hiveJob.<br>queryList.<br>queries[] | **string**<br>

## Methods {#methods}
Method | Description
--- | ---