---
title: Suppression lists in {{ postbox-full-name }}
description: In this article, you will learn about suppression lists in {{ postbox-name }} and the effect they have on outgoing mail.
---

# Suppression lists

{{ postbox-name }} features two suppression lists: custom and global. Before a message goes to each recipient, {{ postbox-name }} checks it independently against both lists.

If the recipient's address is found:
* In the global suppression list, {{ postbox-name }} does not send the message to this recipient.
* In the custom suppression list, {{ postbox-name }} does not send the message if the reason for having the address listed [blocks the send](#reasons).

Before it adds an address to a suppression list or checks if it is listed, {{ postbox-name }} brings it to the canonical form by converting the domain to lowercase and dropping everything between `+` and `@`. For example, `user+promo@Example.COM` is stored and searched as `user@example.com`.

If there is an attempt to send to a suppressed address, {{ postbox-name }} accepts the send request, returns the email ID, but does not send the email to the recipient's mail server. This email is displayed as [not delivered](#blocked).

The suppression lists are checked separately for each recipient. If an address is suppressed, only that recipient is not getting the email. Other recipients are processed as usual.

#|
|| **Parameter** | **Custom suppression list** | **Global suppression list** ||
|| Managed by | User | {{ postbox-name }} ||
|| Action scope | Cloud | All {{ postbox-name }} addresses ||
|| Available to user | Yes | None ||
|| Who adds addresses to the list | User or {{ postbox-name }} due to user complaints | {{ postbox-name }} due to delivery errors ||
|| How long addresses remain listed | Until deleted from the suppression list by the user | Up to six months ||
|#

## Custom suppression list {#user}

The _custom suppression list_ is a list of addresses to which {{ postbox-name }} will not send messages if the reason for having the address listed [blocks the send](#reasons). You can create only one custom suppression list per cloud and use it for all folders, [addresses](glossary.md#address), and [configurations](glossary.md#configuration) within the cloud.

The custom suppression list helps you to:

* Proactively block unwanted addresses without waiting for the first delivery error.
* Automatically exclude recipients who have complained about the mail from your mailing lists.
* Migrate a suppression list from another mailing list service.
* Figure out why a particular message was not sent, and unblock the address if needed.

There is no support for bulk export of suppression lists from third-party services to {{ postbox-name }}, each address must be migrated individually.

### How an address ends up on the custom suppression list {#user-adding}

Addresses end up on the custom suppression list in one of two ways:

* [Manually](../operations/manage-suppression-list.md#add): A user puts the address on the list and states the reason for doing so.
* Automatically due to a complaint: When a recipient complains about a message, {{ postbox-name }} puts the recipient's address on the suppression list with `COMPLAINT` for reason. It also saves the ID of the message due to which the address was listed.

The suppression lust uses an asynchronous index, so a newly added or deleted address may appear or disappear from the list with a few seconds' delay. However, if you request information about an address, you get up-to-date data right away; and the sending block for the address takes effect immediately, too.

The number of addresses on the custom suppression list is not limited.

### Reasons for adding an address to the custom suppression list {#reasons}

For each address on the custom suppression list, a reason is stated for its listing:

* `COMPLAINT`: Recipient complained about an email.
* `BOUNCE`: Emails are not delivered to the address, e.g., because the address does not exist. Addresses can be added to the suppression list for the reason of `BOUNCE` only manually.

Each address can have only one reason for being listed. Re-adding an address to the suppression list overrides the reason, e.g., if a user lists the address for the reason of `BOUNCE`, and then a user complaint is filed, the reason will change to `COMPLAINT`.

The suppression list settings in the [configuration](../operations/create-configuration.md#options) applied to the message decide the following:
* Reasons blocking the send.
* Whether or not recipient addresses will be automatically added to the custom suppression list due to `COMPLAINT`.

#|
|| **Suppression list settings** {align="center"} | > | > | **Reasons blocking the send** | **Addresses automatically added to the suppression due to `COMPLAINT`**||
|| **Check the list** enabled | `COMPLAINT` selected | `BOUNCE` selected | ^ | ^ ||
|| ![no](../../_assets/common/no.svg) | — {align="center"} | > | `COMPLAINT` | ![yes](../../_assets/common/yes.svg) ||
|| ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) | ^ | ^ ||
|| ^ | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | `COMPLAINT`, `BOUNCE` | ^ ||
|| ^ | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | `BOUNCE` | ![no](../../_assets/common/no.svg) ||
|| ^ | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | Send not blocked | ^
|#

If the configuration is not applied to the message, by default only `COMPLAINT` blocks the send, with addresses of recipients who had complained about messages automatically added to the custom suppression list.

## Global suppression list {#global}

The *global suppression list (GSL)* is a system-level list of email addresses managed by {{ postbox-name }}. This list is the same for all [addresses](glossary.md#address) and is updated automatically.

The global suppression list is on by default for all {{ postbox-name }} addresses and cannot be disabled. The global suppression list contents cannot be accessed via the public API.

### How an address ends up on the global suppression list {#global-adding}

If the recipient's mail server returns an error which {{ postbox-name }} classifies as persistent and not calling for another attempt to deliver, the service registers a bounce for the address. No email address ends up on the global suppression list due to temporary delivery errors.

Blocking depends on the number of bounces. The first bounce gets registered but delivery attempts continue. If bounces persist, {{ postbox-name }} blocks sends to this address. The blocking period increases with each new bounce up to the maximum of 14 days.

### How an address gets removed from the global suppression list {#global-removing}

After the blocking period has expired, {{ postbox-name }} will remove the address from the global suppression list the next time there is a successful send to that address. If no successful send takes place, the address remains on the suppression list for about six months.

You cannot remove an address from the global suppression list manually, so contact [support]({{ link-console-support }}).

## How to understand that an email was not sent because the address is on a suppression list {#blocked}

Look up the following:

* [Execution log](../operations/logs-write.md). If [logging is configured](../operations/logs-write.md) for the address and **{{ ui-key.yacloud.postbox.label_mail-statuses }}** is on, the execution log will feature a `WARN` entry saying `Message suppressed`. The regular delivery error will say `Message bounced`.

    Entry example:

    ```json
    {
      "level": "WARN",
      "data": {
        "msg": "Message suppressed",
        "identity_id": "...",
        "message": {
          "message_id": "...",
          "reason": "Recipient is on your account suppression list",
          "mail": { "recipient": "user@example.com", "from": "...", "to": "...", "subject": "..." }
        }
      }
    }
    ```

    The `reason` field indicates which suppression list has blocked the send:

    * `Recipient is on your account suppression list`: Custom suppression list.
    * `Recipient is on the global suppression list`: Global suppression list.

* [Sent history](../operations/messages.md). The reasons for failure to deliver the message will state that the send was blocked by either the custom or global suppression list.

* [Email operation notifications](notification.md#bounce). If the send was blocked by:

    * the custom suppression list, you will get a `Bounce` event with error subtype `bounceSubType : OnAccountSuppressionList` and `diagnosticCode: Blocked by Account Suppression List`.
    * the global suppression list, you will get a `Bounce` event with error subtype `bounceSubType : Suppressed` and `diagnosticCode: Blocked by Global Suppression List`.

#### Useful links {#see-also}

* [{#T}](../operations/manage-suppression-list.md)
* [{#T}](configuration.md)
* [{#T}](notification.md)
