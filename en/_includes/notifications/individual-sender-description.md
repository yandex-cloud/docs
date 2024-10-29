An SMS notification channel with an _individual sender_ is suitable for the product environment and has the following advantages:
* All SMS messages are signed with the sender's unique text name.
* After leaving the [sandbox](#sandbox) you can send SMS to any Russian phone numbers in [E.164](https://en.wikipedia.org/wiki/E.164) format.

There are restrictions and rules in place for this type of sender:
* The sender's text name will be registered with the service provider.
* You will be charged a monthly subscription fee for using the sender's text name.
* In the [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), one sender's text name can correspond to one SMS notification channel.