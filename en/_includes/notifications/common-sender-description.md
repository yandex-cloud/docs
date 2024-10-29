An SMS notification channel with a _shared sender_ is a good option for testing the service's features and has the following advantages:
* You do not have to register the sender's name with the telecom operator.
* No monthly subscription fee is charged.

There are restrictions in place for this type of sender:
* All SMS messages are signed with a shared service name.
* Promotional SMS messages are not allowed.
* A [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) can contain only one SMS notification channel with a shared sender.
* A channel can only operate in a [sandbox](../../notifications/concepts/sms.md#sandbox) with a limited number of test phone numbers.