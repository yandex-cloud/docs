---
title: AWS SDK for JavaScript
description: In this tutorial, you will learn what the AWS SDK for JavaScript is, how to install and configure it, and will also see some code snippets.
---

# AWS SDK for JavaScript


The [AWS SDK for JavaScript](https://docs.aws.amazon.com/sdk-for-javascript/) is a {{ objstorage-full-name }}-compatible software development kit for integration with AWS services.

With the AWS SDK for Node.js, you will create a bucket, upload objects, get a list of objects, extract an object, clear the bucket contents, and delete the bucket.

## Getting started {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Preparing a project {#setup-project}

### Preparing authentication data {#setup-project-aws-tools}

{% include [storage-sdk-setup](../_includes_service/storage-sdk-setup-storage-url.md) %}

### Preparing a project directory {#setup-project-folder}

{% include [nodejs-project-folder-setup](../_includes_service/storage-sdk-nodejs-project-setup.md) %}

## Code snippets {#js-sdk-examples}

Below we describe how to perform basic operations with a bucket using the AWS SDK for Node.js.
1. Add the following code to `index.js`:

    ```js
    import { readFileSync } from "node:fs"
    import
    {
        S3Client,
        PutObjectCommand,
        CreateBucketCommand,
        DeleteObjectCommand,
        DeleteBucketCommand,
        paginateListObjectsV2,
        GetObjectCommand,
        ListObjectsV2Command,
    } from "@aws-sdk/client-s3";

    (async function ()
    {
        // Creating an s3 client to interact with aws.
        // Authentication data is taken from your environment, but you can specify it explicitly. Here is an example:
        // `new S3Client({ region: 'ru-central1', credentials: {...} })`
        const s3Client = new S3Client({});

        const bucketName = `test-bucket-${Date.now()}`;
        // Creating a new bucket
        console.log(`Creating the bucket ${bucketName}.`);
        await s3Client.send(
            new CreateBucketCommand({
                Bucket: bucketName,
            }),
        );
        console.log(`The bucket ${bucketName} was created.\n\n`);

        // Uploading objects into a bucket
        // From a string
        console.log('Creating a object from string.');
        await s3Client.send(
            new PutObjectCommand({
                Bucket: bucketName,
                Key: "bucket-text",
                Body: 'Hello bucket!',
            }),
        );
        console.log('The object from string was created.\n');
        // From files
        console.log('Creating the first object from local file.');
        await s3Client.send(
            new PutObjectCommand({
                Bucket: bucketName,
                Key: "my-package.json",
                Body: readFileSync('package.json'),
            }),
        );
        console.log('The first object was created.\nCreating the second object from local file.');
        await s3Client.send(
            new PutObjectCommand({
                Bucket: bucketName,
                Key: "my-package-lock.json",
                Body: readFileSync('package-lock.json'),
            }),
        );
        console.log('The second object was created.\n');

        // Getting a list of objects
        console.log('Getting bucket objects list.');
        const command = new ListObjectsV2Command({ Bucket: bucketName });
        const { Contents } = await s3Client.send(command);
        const contentsList = Contents.map((c) => ` • ${c.Key}`).join("\n");
        console.log("Here's a list of files in the bucket:");
        console.log(`${contentsList}\n`);

        // Deleting multiple objects
        console.log('Deleting objects.');
        await s3Client.send(
            new DeleteObjectCommand({ Bucket: bucketName, Key: "my-package.json" }),
        );
        await s3Client.send(
            new DeleteObjectCommand({ Bucket: bucketName, Key: "my-package-lock.json" }),
        );
        console.log('The objects were deleted.\n');

        // Getting an object
        console.log('Getting your "bucket-text" object')
        const { Body } = await s3Client.send(
            new GetObjectCommand({
                Bucket: bucketName,
                Key: "bucket-text",
            }),
        );
        console.log('Your "bucket-text" content:')
        console.log(await Body.transformToString(), '\n');

        // Deleting bucket objects and the bucket itself
        // Getting a list of objects page by page
        const paginator = paginateListObjectsV2(
            { client: s3Client },
            { Bucket: bucketName },
        );
        for await (const page of paginator)
        {
            const objects = page.Contents;
            if (objects)
            {
                // Running the delete command for each object by iterating pages with objects
                for (const object of objects)
                {
                    // Sending the delete command
                    await s3Client.send(
                        new DeleteObjectCommand({ Bucket: bucketName, Key: object.Key }),
                    );
                }
            }
        }

        // Deleting the previously created bucket
        await s3Client.send(new DeleteBucketCommand({ Bucket: bucketName }));
        console.log('Your bucket was emptied and deleted.');
    })()
    ```
  
    In this code snippet, we added an [IIFE (Immediately Invoked Function Expression)](https://developer.mozilla.org/en-US/docs/Glossary/IIFE). This enables you to invoke the script when running the file.
1. Run the application:

    ```bash
    node index.js
    ```

    In the console output, you will see a step-by-step description of the operation results.

To learn more about using the AWS SDK for JavaScript, see the [AWS documentation](https://docs.aws.amazon.com/sdk-for-javascript/v3/developer-guide/getting-started-nodejs.html).