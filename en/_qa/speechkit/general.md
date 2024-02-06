# General questions about {{ speechkit-name }}

{% include [logs.md](../logs.md) %}

#### Where can I view API request statistics? {#api-stat}

You can view the statistics in the [management console]({{ link-console-main }}) under **{{ speechkit-short-name }}** → **Monitoring**.

As you use the service, your balance automatically decreases. Learn more about [paying for resources](../../billing/payment/index.md) in {{ yandex-cloud }}.

#### How do I increase quotas? / What should I do if the "429 Too Many Requests" error occurs? {#quotas}

The `429 Too Many Requests` error indicates that the quotas set for your folder have been exceeded. The default quota values are specified in [this table](../../{{ speechkit-slug }}/concepts/limits.md#speechkit-quotas).

To increase the quotas, contact support. In your request, specify the **folder ID** and the required quotas in "Name — Value" format.

#### What is the purpose of the folder ID (folderId)? {#folderid}

{{ speechkit-short-name }} uses `folderId` for authorization (verifying access rights) and payments for resources.

When making a request under a service account, you do not need to specify `folderId`, as by default the service uses the ID of the folder where this service account was created. If you specify a different folder, the service will return an error.

If you log in with a user account, you must specify `folderId`.

Depending on the API used, you should include the folder ID in the request header or body. For more information about authentication in {{ speechkit-name }}, see [{#T}](../../speechkit/concepts/auth.md).

#### How do I generate an IAM token? {#iam-token}

Among other methods, you can generate an IAM token using the {{ yandex-cloud }} command line interface. You can find all the possible ways of obtaining an IAM token for your [Yandex account](../../iam/operations/iam-token/create.md), [federated account](../../iam/operations/iam-token/create-for-federation.md), and [service account](../../iam/operations/iam-token/create-for-sa.md) in the {{ iam-full-name }} documentation.

Even though IAM tokens are only valid for 24 hours, we still recommend them as the most secure method for authentication in {{ speechkit-name }}.

#### What should I do if the "401 Unauthorized" error is returned? {#auth-err}

If the {{ speechkit-name }} server returns a `401 Unauthorized` error in response to a request, check if the account you are using to send requests has the [required roles](../../speechkit/security/index.md). In addition, check your authorization method and the key or token you are using for authorization: you may have obtained it for a different account than the one you are using for your request.

When using service accounts, do not specify the folder ID in your requests: the service uses the folder where the service account was created.

#### Under what conditions can I use {{ speechkit-short-name }} performance results? {#result-restrictions}

1. We do not impose any restrictions on the use of **{{ speechkit-short-name }}** performance results. You can use them at your discretion under the Russian law.
1. Feel free to use the [demo stand](/services/speechkit#demo). Please note that certain restrictions apply.
1. {{ speechkit-short-name }} offers an API designed for speech synthesis and recognition systems. No out-of-the-box web interface or executable application is currently available.
