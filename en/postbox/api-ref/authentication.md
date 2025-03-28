---
title: Authentication with the {{ postbox-full-name }} API
description: To perform operations via the {{ postbox-name }} API, get a static access key.
---

# Authentication with the {{ postbox-name }} API

You can access {{ postbox-name }} using the [Amazon API](../aws-compatible-api/api-ref/index.md). For authentication, use a [static access key](../../iam/concepts/authorization/access-key.md) or an [IAM token](../../iam/concepts/authorization/iam-token.md). This way, you will run all operations as the [service account](../../iam/concepts/users/service-accounts.md) the static key or IAM token was issued to. For more information, see [How to use the API](../aws-compatible-api/index.md).

To access the Amazon API directly, without the [AWS CLI](../tools/aws-cli.md) or apps, use one of these methods:

* Manually generate a request signature and provide it in the `Authorization` header. To learn more about signing requests and verifying signatures, see [{#T}](../aws-compatible-api/signing-requests.md).
* Authenticate with an IAM token you get for the service account and provide it in the `X-YaCloud-SubjectToken` header. In this case, you do not need the `Authorization` header and signature.

## Amazon API use cases {#ses-api-example}

The examples below show how to get a list of [configurations](../concepts/glossary.md#configuration) with a request sent via [cURL](https://curl.se/).

Before you start, [create a service account](../../iam/operations/sa/create.md#create-sa) with the appropriate [role](../security/index.md#service-roles). The `postbox.viewer` role works well for these examples.

### Authentication with a static key {#access-key-ses-example}

1. [Create a static key](../../iam/operations/authentication/manage-access-keys.md#create-access-key) for the service account.
1. Run this request:

    ```bash
    export AWS_KEY_ID="<static_key_ID>" && \
    export AWS_SECRET_KEY="<secret_key>" && \
    curl \
       --request GET \
       --user "${AWS_KEY_ID}:${AWS_SECRET_KEY}" \
       --aws-sigv4 "aws:amz:{{ region-id }}:ses" \
       --url '{{ postbox-endpoint }}/v2/email/configuration-sets' \
       --verbose
    ```

### Authentication using an IAM token {#iam-ses-example}

1. [Get an IAM token](../../iam/operations/iam-token/create-for-sa.md#via-cli) for the service account.
1. Run this request:

    ```bash
    export IAM_TOKEN="<IAM_token>" && \
    curl \
       --request GET \
       --header "X-YaCloud-SubjectToken: ${IAM_TOKEN}" \
       --url 'https://postbox.cloud.yandex.net/v2/email/configuration-sets' \
       --verbose
    ```
