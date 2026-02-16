# Fixing the `INVALID_PERSON_TYPE` error when registering a billing account



## Issue description {#issue-description}

When trying to create a billing account, clicking **Register** triggers the `INVALID_PERSON_TYPE` error.

## Solution {#issue-resolution}

This issue arises because your Yandex ID is currently listed as a customer representative in [Yandex Balance](https://balance.yandex.ru), and the representative's details do not match the details provided at registration.
Additionally, [Yandex Balance](https://balance.yandex.com) might show one country, while you are trying to register from another.


For example, you created a **Business account** for Russia. The payer of this account is a business and a resident of Russia. In this case, you will need to create all subsequent billing accounts for Russia and for Russian resident payers (legal entities or individuals). Selecting another country will lead to an error.

To resolve this issue, you can either select a different account type or country when signing up for {{ yandex-cloud }}, or log in to {{ yandex-cloud }} using another Yandex ID to create a billing account.

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. Full text of the error message.
1. [HAR file](../../../support/create-har.md) with the recorded communications between the browser and {{ yandex-cloud }} servers.