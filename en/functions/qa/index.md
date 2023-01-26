---
title: "{{ sf-full-name }}. Questions and answers"
description: "How do I get the logs of my activity in {{ sf-full-name }}? Find the answer to this and other questions in this article."
---

# General questions about {{ sf-name }}

{% include [logs](../../_qa/logs.md) %}

#### Using the CLI to upload a ZIP file with the source code for a Serverless function update? {#version-create}

To create a [function](../concepts/function.md) version from a ZIP file, execute:

```bash
yc serverless function version create --source-path
```

For more about downloading the code, read the instructions on [{#T}](../../functions/operations/function/version-manage.md).

#### Size of source code archive for uploading to {{ sf-name }}? {#file-size}

You can upload a file up to 3.5 MB in size directly. A larger file must be [uploaded via {{ objstorage-full-name }}](../../storage/operations/objects/upload.md). For more see the [documentation](../../functions/operations/function/version-manage.md).

#### I am not the cloud owner, but I was granted access. Rights/roles required to publish a function? {#roles}

For function access, you need the `admin` or `resource-manager.clouds.owner` role. For more information, see the [documentation](../security/).

#### Accessing an environment variable in {{ sf-name }} from Node.js code? {#env}

To access environment variables, use the `process.env` global variable. For more information, see the [documentation](https://nodejs.org/dist/latest-v8.x/docs/api/process.html#process_process_env).

#### Python modules available for working with {{ sf-name }}? Connecting new modules? {#python}

You can upload modules as a ZIP file up to 3.5 MB in size. A larger file must be [uploaded via {{ objstorage-name }}](../../storage/operations/objects/upload.md). For more see the [documentation](../quickstart/create-function/python-function-quickstart.md).

#### Invoking cloud functions for Alice's skills is free. What if I invoke another one of my cloud functions from a skill cloud function? Will that be free as well? {#alice-pricing}

Such calls will be charged per the [{#T}](../pricing.md).