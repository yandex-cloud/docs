---
title: "How notifications and subscriptions work in {{ tracker-full-name }}"
description: "In this tutorial, you will learn how notifications and subscriptions work in {{ tracker-name }}."
---

# Notifications and subscriptions

## Email notifications {#mail_notif}

By default, {{ tracker-name }} sends you notifications about changes to issues if you have one of these roles:

- **{{ ui-key.startrek-backend.roles.role.name.author }}**: You created this issue.
- **{{ ui-key.startrek-backend.roles.role.name.assignee }}**: You are assigned to this issue.
- **{{ ui-key.startrek-backend.roles.role.name.follower-key-value }}**: You are subscribed to notifications about this issue.
- **{{ ui-key.startrek-backend.roles.role.name.queue-follower-key-value }}/version/component**: You are subscribed to notifications for the queue or component the issue belongs to.

Notifications include the information about any issue changes and are sent to the mailbox linked to your account.


If not satisfied with the standard notification rules, you can edit them:

- [{#T}](subscribe.md)
- [Receive regular update digests](notification-digest.md)
- [Set up a list of events and roles you want to be notified about](notification-settings.md)
- [Subscribe other users to issue, component, or version updates](../manager/subscriptions.md)

## Notification center {#notif_center}


The {{ tracker-name }} notification center receives notifications from other {{ yandex-cloud }} services as well.



