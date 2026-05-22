---
title: Statistics
description: In {{ postbox-full-name }}, you can view statistics for sent emails, e.g., how many emails were sent, delivered/not delivered, opened, and the number of email clicks.
---

# Statistics

In {{ postbox-full-name }}, you can view statistics for sent emails, e.g., how many emails were sent, delivered, not delivered, or opened.

## Metrics {#metrics}

{{ postbox-name }} offers the following metrics:

#|
|| **Metrica** | **Description** | **When increases** ||
|| **{{ ui-key.yacloud.postbox.label_statistics_delivery-group-metrics }}** | > | > ||
|| `{{ ui-key.yacloud.postbox.label_statistics_sent-event }}` | Number of emails {{ postbox-name }} accepted for delivery. | {{ postbox-name }} accepts an email for delivery. ||
|| `{{ ui-key.yacloud.postbox.label_statistics_delivered-event }}` | Number of emails successfully delivered to the recipients' mail servers. | {{ postbox-name }} gets a confirmation from the recipient's email server that the email was accepted. ||
|| `{{ ui-key.yacloud.postbox.label_statistics_bounced-event }}` | Number of emails not delivered to the recipients' mail servers. | {{ postbox-name }} gets notified by the recipient's email server that the email cannot be delivered, or that the email is not delivered within a particular time. ||
|| **{{ ui-key.yacloud.postbox.label_statistics_interaction-group-metrics }}** | > | > ||
|| `{{ ui-key.yacloud.postbox.label_statistics_opens-event }}` | Number of emails opened by recipients. | {{ postbox-name }} gets notified that the email was opened.

Only emails with [open tracking](mail-opened.md#setup) on are counted. The opens is counted for the day the email was opened, not sent. If the recipient opens the same email multiple times, the metric increases by the same number of opens. ||
|| `{{ ui-key.yacloud.postbox.label_statistics_clicks-event }}` | Number of email clicks. | {{ postbox-name }} gets notified about an email click.

Only emails with [click tracking](click-tracking.md#setup) on are counted. If the recipient clicks the same link multiple times, the metric increases by the same number of clicks. ||
|| **{{ ui-key.yacloud.postbox.label_statistics_negative-group-metrics }}** | > | > ||
|| `{{ ui-key.yacloud.postbox.label_statistics_complaints-event }}` | Number of complaints about emails | {{ postbox-name }} receives an email-related complaint from an internet service provider (ISP). ||
|| `{{ ui-key.yacloud.postbox.label_statistics_unsubscribes-event }}` | Number of unsubscribe requests. | {{ postbox-name }} receives an unsubscribe request from the recipient. ||
|#


## Viewing statistics {#viewing}

You can view your sent email statistics on the **{{ ui-key.yacloud.postbox.label_statistics }}** page in the [management console]({{ link-console-postbox-statistics }}).

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
