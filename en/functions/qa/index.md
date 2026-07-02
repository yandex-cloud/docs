---
title: '{{ sf-full-name }}. FAQ'
description: How do I get my activity logs in {{ sf-full-name }}? Find the answer to this and other questions in this article.
---

# General questions about {{ sf-name }}

{% include [logs](../../_qa/logs.md) %}

#### How do I upload a ZIP archive with source code to update a serverless function via CLI? {#version-create}

To create a [function](../concepts/function.md) version from a ZIP file, run this command:

```bash
yc serverless function version create --source-path
```

For more details on uploading code, see [this guide](../../functions/operations/function/version-manage.md).

#### How large can a source code archive be when uploading to {{ sf-name }}? {#file-size}

You can upload a file up to 3.5 MB directly. To [upload  larger files, use {{ objstorage-full-name }}](../../storage/operations/objects/upload.md). For more information, see [this guide](../../functions/operations/function/version-manage.md).

#### I am not the cloud owner, but I was granted access. What permissions/roles do I need to publish a function? {#roles}

To manage function access, you need the `{{ roles-admin }}` or `{{ roles-cloud-owner }}` role. For more information, see [this guide](../security/index.md).

#### How do I access an environment variable in a Node.js function? {#env}

To access environment variables, use the `process.env` global variable. For more information, see [this guide](https://nodejs.org/dist/latest-v8.x/docs/api/process.html#process_process_env).

#### Which Python modules can I use when working with {{ sf-name }}? How do I add new modules? {#python}

You can upload modules in a ZIP archive up to 3.5 MB. To [upload larger files, use {{ objstorage-name }}](../../storage/operations/objects/upload.md). For more information, see [this guide](../quickstart/create-function/python-function-quickstart.md).

#### Calling cloud functions for Alice skills is free. If I call another of my cloud functions from a skill function, will that also be free? {#alice-pricing}

Such calls will be charged according to [{#T}](../pricing.md).

#### I want to increase my quotas. How do I determine appropriate values for them? {#quotas}

For more information on which quotas to increase and to what extent, see [{#T}](../concepts/limits.md#related-quotas).

{% include [api-duration-format-qa](../../_qa/serverless/api-duration-format-qa.md) %}