---
title: How to use the Amazon API for accessing {{ postbox-name }}
description: In this article, you will learn how to get started with the {{ postbox-name }} API and what an API request looks like.
keywords:
  - ses
  - simple email service
  - aws
  - ses api
  - aws api
  - api
  - api postbox
  - aws api postbox
  - postbox
  - cloud postbox
  - yandex cloud postbox
  - ses api
  - aws api
---

# How to use the Amazon API to access {{ postbox-name }}

## Getting started {#before-you-begin}

1. [Create a service account](../../iam/operations/sa/create.md).
1. [Assign the required roles to the service account](../../iam/operations/sa/assign-role-for-sa.md).

   You can select the appropriate role from the [Access management](../security/index.md#service-roles) section. For example, to get [configuration](../concepts/glossary.md#configuration) info, the `postbox.viewer` role is enough. To send emails, the service account needs the `postbox.sender` role.

1. [Create a static access key](../../iam/operations/authentication/manage-access-keys.md#create-access-key).

   It is required for authorization when submitting requests to the Amazon API. To store the key safely, use [{{ lockbox-full-name }}](../../lockbox/tutorials/static-key-in-lockbox/index.md).

## General API request format {#common-request-form}

```text
<HTTP_method> <endpoint> HTTP/2
Host: {{ postbox-host }}
{Authorization|X-YaCloud-SubjectToken}: <authentication_credentials>
X-Amz-Date: <time_in_ISO_8601_format>

<request_body>
```

For a list of endpoints and relevant HTTP methods, see the [API reference](api-ref/index.md). For a list of available headers, see [{#T}](api-ref/request-headers.md).

A request must include one of the authentication headers:

* `X-YaCloud-SubjectToken`: Contains a service account IAM token. Learn more about authentication with an IAM token [here](../api-ref/authentication.md).
* `Authorization`: Contains a static access key and request signature. The signature is required when accessing the API directly without the [AWS CLI](../tools/aws-cli.md) or apps. {{ postbox-name }} supports [Amazon Signature Version 4](https://docs.amazonaws.cn/en_us/IAM/latest/UserGuide/reference_aws-signing.html). For more information, see the [`Authorization` header description](signing-requests.md#authorization-header).

   You can test the signature generation process using the AWS CLI in debug mode. For this, add the `--debug` flag to the `aws` command. For more information, see [this debug example](signing-requests.md#debugging).

   To avoid generating the signature manually, use the [cURL](https://curl.se/) utility: it automatically signs requests to the Amazon API. For more information, see [this API use case](#ses-api-example).
