---
title: Statistics
description: 'In {{ postbox-full-name }}, you can view statistics for sent emails: how many emails were sent, delivered/not delivered, opened, the number of email clicks.'
---

# Statistics

In {{ postbox-full-name }}, you can view statistics for sent emails, e.g., how many emails were sent, delivered, not delivered, or opened.

## {#metrics} metrics

{{ postbox-name }} offers the following metrics:

#|
|| **Metrica** | **Description** | **When increases** ||
|| **Email delivery** | > | > ||
|| `Sent` | Number of emails {{ postbox-name }} accepted for delivery. | When {{ postbox-name }} accepts an email for delivery. ||
|| `Delivered` | Number of emails successfully delivered to the recipients' mail servers. | When {{ postbox-name }} gets a confirmation from the recipient's email server that the email was accepted. ||
|| `Not delivered` | Number of emails not delivered to the recipients' mail servers. | When {{ postbox-name }} gets notified by the recipient's email server that the email cannot be delivered, or if the email is not delivered within a particular time. ||
|| **Engagement** | > | > ||
|| `Opens` | Number of emails opened by recipients. | When {{ postbox-name }} gets notified that the email was opened.

Only emails with [open tracking](mail-opened.md#setup) on are counted. The opens is counted for the day the email was opened, not sent. If the recipient opens the same email multiple times, the metric increases by the same number of opens. ||
|| `Clicks` | Number of email clicks. | When {{ postbox-name }} gets notified about an email click.

Only emails with [click tracking](click-tracking.md#setup) on are counted. If the recipient clicks the same link multiple times, the metric increases by the same number of clicks. ||
|| `Unsubscribes` | Number of unsubscribe requests. | When {{ postbox-name }} receives an unsubscribe request from the recipient. ||
|#


## Viewing statistics {#viewing}

You can view your sent email statistics on the **Statistics** page in the [management console]({{ link-console-postbox-statistics }}).

## Breakdown by provider {#isp}

In your sent email statistics, you can look up data on the main email providers (ISPs):

#|
|| **Provider** | **Domains** ||
|| Yandex | yandex.ru, yandex.com, ya.ru, yandex.by, yandex.kz ||
|| Google | gmail.com, googlemail.com ||
|| Mail.Ru Group | mail.ru, bk.ru, list.ru, inbox.ru, internet.ru ||
|| Microsoft | outlook.com, hotmail.com, live.com, msn.com, windowslive.com ||
|#

Other target domains fall into the **Other** category.

Breakdown by provider only considers the domain from the recipient's email address.
