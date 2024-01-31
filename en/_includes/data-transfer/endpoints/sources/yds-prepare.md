1. [Create a service account](../../../../iam/operations/sa/create.md) with the `yds.editor` role.
1. [Create a data stream](../../../../data-streams/operations/manage-streams.md#create-data-stream).
1. (Optional) [Create a processing function](../../../../functions/operations/function/function-create.md).

   {% cut "Processing function example" %}

   ```javascript
   const yc = require("yandex-cloud");
   const { Parser } = require("@robojones/nginx-log-parser");
   module.exports.handler = async function (event, context) {
       const schema =
           '$remote_addr - $remote_user [$time_local] "$request" $status $bytes_sent "$http_referer" "$http_user_agent"';
       const parser = new Parser(schema);
       return {
           Records: event.Records.map((record) => {
               const decodedData = new Buffer(record.kinesis.data, "base64")
                   .toString("ascii")
                   .trim();
               try {
                   const result = parser.parseLine(decodedData);
                   if (result.request == "") {
                       // empty request - drop message
                       return {
                           eventID: record.eventID,
                           invokeIdentityArn: record.invokeIdentityArn,
                           eventVersion: record.eventVersion,
                           eventName: record.eventName,
                           eventSourceARN: record.eventSourceARN,
                           result: "Dropped"
                       };
                   }
                   return {
                       // successfully parsed message
                       eventID: record.eventID,
                       invokeIdentityArn: record.invokeIdentityArn,
                       eventVersion: record.eventVersion,
                       eventName: record.eventName,
                       eventSourceARN: record.eventSourceARN,
                       kinesis: {
                           data: new Buffer(JSON.stringify(result)).toString(
                               "base64"
                           ),
                       },
                       result: "Ok"
                   };
               } catch (err) {
                   // error - fail message
                   return {
                       eventID: record.eventID,
                       invokeIdentityArn: record.invokeIdentityArn,
                       eventVersion: record.eventVersion,
                       eventName: record.eventName,
                       eventSourceARN: record.eventSourceARN,
                       result: "ProcessingFailed",
                   };
               }
           })
       };
   };
   ```

   {% endcut %}

1. (Optional) Prepare a data schema file in JSON format.

   Sample file with a data schema:

   ```json
   [
       {
           "name": "<field_name>",
           "type": "<type>"
       },
       ...
       {
           "name": "<field_name>",
           "type": "<type>"
       }
   ]
   ```

   Supported types:

   * `any`
   * `boolean`
   * `datetime`
   * `double`
   * `int8`
   * `int16`
   * `int32`
   * `int64`
   * `string`
   * `uint8`
   * `uint16`
   * `uint32`
   * `uint64`
   * `utf8`
