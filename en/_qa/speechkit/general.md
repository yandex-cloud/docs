# General questions about {{ speechkit-name }}

{% include [logs.md](../logs.md) %}

#### Where can I view API request statistics {#api-stat}

You can view the statistics in the [management console]({{ link-console-main }}) under **AI API** → **{{ speechkit-short-name }}** → **Monitoring**.

The balance is reduced automatically as you consume resources. See [{#T}](../../billing/payment/index.md) for billing at {{ yandex-cloud }}. 

#### How to increase quotas / What should I do if the «429 Too Many Requests» error occurs {#quotas}

The `429 Too Many Requests` error means that the quotas set for your folder have been exceeded. The default quota values are specified in the [table](../../speechkit/concepts/limits.md#speechkit-quotas).

To increase the quotas, contact support. In your request, be sure to specify the **folder ID** and the desired quotas in «Name — Value» format.

#### What is folderId used for {#folderid}

{{ speechkit-short-name }} uses the `folderId` for authorization (verifying access rights) and billing.

When making a request under a service account, you don't need to specify any `folderId`, since, by default, the service uses the `folderId` that this account was created in. If you specify a different ID, the service returns an error.

When logging in as a user account, specifying the `folderId` is required.

Please note that it is only possible to recognize long audio files under a service account.

#### How to generate an IAM token {#iam-token}

To generate an [IAM token](../../iam/operations/iam-token/create.md), send a request with your OAuth token in the following format:
`"yandexPassportOauthToken":"<OAuth-token>"`. If you're using cURL, run the command:

```bash
curl -d "{\"yandexPassportOauthToken\":\"<OAuth-token>\"}" "https://iam.api.cloud.yandex.net/iam/v1/tokens"
```

Follow the recommendations and examples given in the **API** tab of the instructions: [Getting an IAM token](../../iam/operations/iam-token/create.md).

#### What should I do if the «401 Unauthorized» error occurs {#auth-err}

Assign the service account [the role](../../speechkit/security/) `editor` or a higher role for the folder it was created in.

When using service accounts, don't specify the folder ID in your requests: the service uses the folder where the service account was created.

Follow the instructions: [Before you start](../../speechkit/quickstart.md#before-you-begin).

#### What should I do if HTTP/1.1 «426 Upgrade Required» is returned {#http-err}

Make sure you're using `HTTP 1.1` and not `HTTP 1.0`.

#### What should I do in the event of a «TLS Handshake error» {#tls-err}

Make sure the **TLS** version you're using is not lower than `1.2`. 

#### What should I do if the «OAuth token is invalid or expired» error occurs {#oauth-err}

You need to issue a new [OAuth token](../../iam/concepts/authorization/oauth-token.md) because your token has expired.
To do this, follow the [link]({{ link-cloud-oauth }}).
A token is valid for 1 year.

#### Under what conditions can I use {{ speechkit-short-name }} performance results {#result-restrictions}

1. We do not impose any restrictions on the use of **{{ speechkit-short-name }}** performance results. You can use them at your discretion under the Russian law.
1. You can freely use the [demo stand]{% if lang == "ru" %}(https://cloud.yandex.ru/services/speechkit#demo){% endif %}{% if lang == "en" %}(https://cloud.yandex.com/services/speechkit#demo){% endif %}. Note that it has a number of limitations.
1. Currently, {{ speechkit-short-name }} is provided as a software API to be used in systems where speech generation or recognition is required. So far, there is no off-the-shelf software product in the form of a web interface or app that you can run.
