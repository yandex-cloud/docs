# Getting started with {{ translate-short-name }}

{{ translate-full-name }} provides an API for integrating translation technologies into your applications. If you want to use a UI for translation, use [Yandex Translator](https://translate.yandex.com/).

In this section, you will learn how to translate text using the {{ translate-name }} API.

{% include [curl](../_includes/curl.md) %}

Refer to the [step-by-step guides](operations/index.md) for more examples in different programming languages.

To learn how to create a service account and an API key to integrate {{ translate-full-name }} into your application, see [{#T}](operations/sa-api-key.md).

## Getting started {#before-begin}

1. On the [**Billing**]({{ link-console-billing }}) page, make sure you have a [billing account](../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not have a billing account yet, [create one](../billing/quickstart/index.md#create_billing_account).

1. Get the authorization data for your account:

   {% include [user-auth](../_includes/translate/user-auth.md) %}

## Translating text {#translate-text}

{% list tabs group=programming_language %}

- Bash {#bash}

   {% include [translate](../_includes/translate/translate-bash.md) %}

{% endlist %}

#### What's next {#what-is-next}

* [Learn more about {{ yagpt-full-name }}](concepts/index.md)
* [See other examples](operations/index.md)
* [Learn about API authentication methods](api-ref/authentication.md)