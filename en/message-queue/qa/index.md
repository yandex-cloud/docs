---
title: "{{ message-queue-full-name }}. Questions and answers"
description: "How do I get the logs of my activity in {{ message-queue-full-name }}? Find the answer to this and other questions in this article."
---

# General questions about {{ message-queue-name }}

#### What does the "Cannot create queue: Too many queues" error mean when returned at creating a new queue? {#to-many-queues-err}

This error means that the limit on the maximum number of queues has been reached. To increase the limit, contact [support]({{ link-console-support }}). In your request, specify:

1. ID of the cloud to increase the limit for.
1. Required number of queues.
1. Reason for having that many queues.

{% include [logs](../../_qa/logs.md) %}

