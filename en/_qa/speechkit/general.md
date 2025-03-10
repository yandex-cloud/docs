# General questions about {{ speechkit-name }}

{% include [logs.md](../logs.md) %}

#### Where can I view API request statistics? {#api-stat}

You can view the statistics in the [management console]({{ link-console-main }}) under **{{ speechkit-short-name }}** → **Monitoring**.

As you use the service, your balance automatically decreases. Learn more about [paying for resources](../../billing/payment/index.md) in {{ yandex-cloud }}.

#### How do I increase quotas? / What should I do if the "429 Too Many Requests" error occurs? {#quotas}

The `429 Too Many Requests` error indicates that the quotas set for your folder have been exceeded. The default quota values are specified in this [table](../../{{ speechkit-slug }}/concepts/limits.md#speechkit-quotas).

To increase the quotas, contact support. In your request, specify the **folder ID** and the required quotas in "Name — Value" format.

#### What is the purpose of the folder ID (folderId)? {#folderid}

{{ speechkit-short-name }} uses `folderId` for authorization (access permission verification) and payments for resources.

When sending a request under a service account, you do not need to specify `folderId`: by default, the account's home folder ID is used. If you specify a different folder, the service will return an error.

If logged in under a user account, you must specify `folderId`.

Depending on the API used, you should include the folder ID in the request header or body. For more information about authentication in {{ speechkit-name }}, see [{#T}](../../speechkit/concepts/auth.md).

#### How do I generate an IAM token? {#iam-token}

Among other methods, you can generate an IAM token using the {{ yandex-cloud }} command line interface. You can find all the possible ways of obtaining an IAM token for your [Yandex account](../../iam/operations/iam-token/create.md), [federated account](../../iam/operations/iam-token/create-for-federation.md), and [service account](../../iam/operations/iam-token/create-for-sa.md) in the {{ iam-full-name }} documentation.

Even though IAM tokens are only valid for {{ iam-token-lifetime }}, we still recommend them as the most secure authentication method for {{ speechkit-name }}.

#### What should I do if I get the "401 Unauthorized" error? {#auth-err}

If the {{ speechkit-name }} server returns the `401 Unauthorized` error in response to a request, check if your account has the [required roles](../../speechkit/security/index.md). In addition, check your authorization method and the key or token you are using for authorization: you may have obtained it for a different account than the one you are using for your request.

If using a service account, do not specify folder ID in your requests: {{ speechkit-short-name }} uses the service account's home folder.

#### Under what conditions can I use {{ speechkit-short-name }} performance results? {#result-restrictions}

1. We do not impose any restrictions on the use of **{{ speechkit-short-name }}** performance results. You can use them at your discretion under the Russian law.
1. Feel free to use the [demo stand](/services/speechkit#demo). Please note that certain restrictions apply.
1. You can work with {{ speechkit-name }} via the API or [Playground](../../speechkit/quickstart/index.md) web interface.

For terms of use, see the [{{ speechkit-full-name }}](https://yandex.ru/legal/cloud_terms_speechkit) Terms of Use.
