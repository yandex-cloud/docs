# General questions about {{ speechkit-name }}

{% include [logs.md](../logs.md) %}

#### Where can I view API request statistics? {#api-stat}

You can view the statistics in the [management console]({{ link-console-main }}) under **AI API** → **{{ speechkit-short-name }}** → **Monitoring**.

As you use resources, the balance automatically decreases. Learn more about [paying for resources](../../billing/payment/index.md) in {{ yandex-cloud }}.

#### How do I increase quotas? / What should I do if the "429 Too Many Requests" error occurs? {#quotas}

The `429 Too Many Requests` error indicates that the quotas set for your folder have been exceeded. The default quota values are specified in this [table](../../{{ speechkit-slug }}/concepts/limits.md#speechkit-quotas).

To increase the quotas, contact support. In your request, specify the **folder ID** and the desired quotas in "Name — Value" format.

#### What is folderId used for? {#folderid}

{{ speechkit-short-name }} uses the `folderId` for authorization (verifying access rights) and payments for resources.

When making a request under a service account, you don't need to specify any `folderId`, since, by default, the service uses the `folderId` of the folder that this service account was created in. If you specify a different ID, the service returns an error.

When logging in as a user account, specifying the `folderId` is required.

Please note that it is only possible to recognize long audio files under a service account.

#### How are IAM tokens generated? {#iam-token}

To generate an [IAM token](../../iam/operations/iam-token/create.md), send a request with your OAuth token in
`"yandexPassportOauthToken":"<OAuth token>"` format. If you are using cURL, run this command:

```bash
curl -d "{\"yandexPassportOauthToken\":\"<OAuth-token>\"}" "https://iam.{{ api-host }}/iam/v1/tokens"
```

Follow the recommendations and examples given in the **API** tab for [Getting an IAM token](../../iam/operations/iam-token/create.md).

#### What should I do if the "401 Unauthorized" error is returned? {#auth-err}

Assign the `editor` or a higher [role](../../{{ speechkit-slug }}/security/) to the service account for the folder where it was created.

When using service accounts, do not specify the folder ID in your requests: the service uses the folder where the service account was created.

Follow the [Getting started](../../{{ speechkit-slug }}/quickstart/index.md#before-you-begin) guide.

#### What should I do if I get the 426 Upgrade Required HTTP/1.1 response? {#http-err}

Make sure you are using `HTTP 1.1` rather than `HTTP 1.0`.

#### What should I do if I get a TLS Handshake error? {#tls-err}

Make sure the **TLS** version you are using is not lower than `1.2`.

#### What should I do if the "OAuth token is invalid or expired" error occurs? {#oauth-err}

You need to issue a new [OAuth token](../../iam/concepts/authorization/oauth-token.md) because your token has expired.
To do this, follow the [link]({{ link-cloud-oauth }}). The token is valid for 1 year.

#### Under what conditions can I use {{ speechkit-short-name }} performance results? {#result-restrictions}

1. We do not impose any restrictions on the use of **{{ speechkit-short-name }}** performance results. You can use them at your discretion under the Russian law.
1. Feel free to use the [demo stand](/services/speechkit#demo). Please note that it has a number of limitations.
1. {{ speechkit-short-name }} is provided as an API designed for speech generation and recognition systems. No web interface or executable application is currently available.
