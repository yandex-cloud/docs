### Contact information of the person in charge of your organization is valid {#organization-contacts}

#|
|| **kind** | **severity** | **ID** ||
|| manual | low | procedure.organization-contacts ||
|#

#### Description

{% note warning "**Manual verification**" %}

This rule requires manual check. After checking and update, please change the rule status.

{% endnote %}

When registering a cloud in Yandex Cloud, customers enter their contact information. For example, an email address is used for notifications about incidents, scheduled maintenance activities, and so on.

For instance, if abnormal activities in the customer's organization are detected on the cloud side or the IAM cloud keys get available in external GitHub repositories, the customer receives a notification. This feature is implemented thanks to Yandex Cloud participating in the [Github Secret scanning partner program](https://docs.github.com/en/developers/overview/secret-scanning-partner-program) and analyzing secrets in Yandex search. If any keys are compromised in a public repository, delete the secret from the repository and its [history](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository), as well as revoke the [keys](https://yandex.cloud/en/docs/iam/operations/compromised-credentials).

Make sure the contact information is valid and messages are sent to multiple persons in charge from the specified email address.

#### Guides and solutions

Specify up-to-date contact information using the [guide](https://yandex.cloud/en/docs/billing/operations/change-data#change-address).
