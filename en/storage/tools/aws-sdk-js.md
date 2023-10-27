# AWS SDK for JavaScript

The [AWS SDK for JavaScript](https://aws.amazon.com/sdk-for-javascript/) is a set of developer tools to work AWS services, which is compatible with {{ objstorage-full-name }}.

## Getting started {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Installing {#installation}

{% include [install-js-sdk](../../_includes/aws-tools/install-js-sdk.md) %}

## Setup {#setup}

{% include [storage-sdk-setup](../_includes_service/storage-sdk-setup-storage-url.md) %}

## Code samples {#js-sdk-examples}

You can find a sample bucket creation code in the repository's `javascriptv3/example_code/nodegetstarted/src` directory.

To connect to {{ objstorage-name }} and create a bucket:

1. Install dependencies as described in the `javascriptv3/example_code/nodegetstarted/package.json` file:

   ```bash
   npm install node -g
   cd aws-doc-sdk-examples/javascriptv3/example_code/nodegetstarted
   npm install
   ```

1. In the `javascriptv3/example_code/nodegetstarted/src/libs/` directory, open the `s3Client.js` file with a description of the {{ objstorage-name }} client.
1. Replace the file contents with the code below:

   ```js
   import { S3Client } from "@aws-sdk/client-s3";
   // Setting the region {{ objstorage-name }}
   const REGION = "{{ region-id }}";
   // Setting the endpoint {{ objstorage-name }}
   const ENDPOINT = "https://{{ s3-storage-host }}";
   // Creating a client for {{ objstorage-name }}
   const s3Client = new S3Client({ region: REGION, endpoint: ENDPOINT });
   export { s3Client };
   ```

1. In the `javascriptv3/example_code/nodegetstarted/src/` directory, open the `sample.js` file with the code for creating a bucket and an object in it.

   {% cut "sample.js contents" %}

   ```js
   // Importing clients and AWS SDK commands to work with Node.js
   import { PutObjectCommand, CreateBucketCommand } from "@aws-sdk/client-s3";
   import { s3Client } from "./libs/s3Client.js";

   // Setting parameters
   const params = {
     Bucket: "<bucket_name>", // Bucket name, such as 'sample-bucket-101'.
     Key: "<object_name>", // Object name, such as 'sample_upload.txt'.
     Body: "<object_contents>", // Object contents, such as 'Hello world!".
   };

   const run = async () => {
     // Creating a bucket
     try {
       const data = await s3Client.send(
           new CreateBucketCommand({ Bucket: params.Bucket })
       );
       console.log(data);
       console.log("Successfully created a bucket called ", data.Location);
       return data; // For modular testing.
     } catch (err) {
       console.log("Error", err);
     }
     // Creating an object and uploading it to the bucket
     try {
       const results = await s3Client.send(new PutObjectCommand(params));
       console.log(
           "Successfully created " +
           params.Key +
           " and uploaded it to " +
           params.Bucket +
           "/" +
           params.Key
       );
       return results; // For modular testing.
     } catch (err) {
       console.log("Error", err);
     }
   };
   run();
   ```

   {% endcut %}

1. Under `const params`, set a name for the bucket and a name and contents for the bucket object.
1. Run the application:

   ```bash
   node sample.js
   ```

To learn more about using the AWS SDK for JavaScript, see the [AWS documentation](https://docs.aws.amazon.com/sdk-for-javascript/v3/developer-guide/getting-started-nodejs.html).
