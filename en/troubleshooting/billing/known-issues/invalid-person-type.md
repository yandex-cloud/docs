# Resolving the INVALID_PERSON_TYPE error when registering a billing account



## Issue description {#issue-description}

* When you try to create a billing account and click Register, you see the `INVALID_PERSON_TYPE` error message.

## Solution {#issue-resolution}

The problem arises because your Yandex ID account is currently listed as a customer representative in [Yandex Balance](https://balance.yandex.ru), and the representative's details does not match the details provided during registration.
Moreover, [Yandex Balance](https://balance.yandex.ru) might show one country, but you are trying to register from another country.

For example, you created a billing account with the Business account type for Russia. The payer of this account is a business and a resident of Russia. All the next billing accounts must also be created for Russia and issued to Russian resident payers (legal entities or individuals). Selecting another country will lead to an error.

To solve this problem, you can either select a different country or type of account when registering in Yandex Cloud, or log in to Yandex Cloud from another Yandex ID account before registering a billing account.

## If the issue persists {#if-issue-still-persists}

If the above actions didn't help, [create a request for support](https://console.cloud.yandex.ru/support?section=contact).

1. Full text of the error message
2. [HAR file](../../../support/create-har.md) with the recorded results of browser interaction with Yandex Cloud servers.