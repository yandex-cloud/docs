---
title: Yandex Tracker API. Overview
description: Yandex Tracker API is designed for web services and applications that work with the tasks of your organization on behalf of a user. In this case, API capabilities depend on the access rights of the user on whose behalf the requests are made. You can control Tracker using HTTP REST API requests.
---

# Overview

You can manage {{ tracker-name }} using HTTP requests to the REST API.

{{ api-name }} is designed for web services and apps that work with your organization's issues on behalf of a user. Users may have different features available in the API depending on their access rights.

{% note info %}

{{ api-name }} sends and receives date and time parameters in the UTC±00:00 time zone. Therefore, the time and date received may differ from the time zone of the client that the request is made from.

{% endnote %}

{{ api-name }} lets you:

- Search, create, and edit issues.
- View queue settings.

[Access to the {{ api-short-name }}](concepts/access.md)

#### Issues

- [Search](concepts/issues/search-issues.md)
- [Create](concepts/issues/create-issue.md)
- [Edit](concepts/issues/patch-issue.md)

#### Queues

- [View](concepts/queues/get-queue.md)
- [Get all queues](concepts/queues/get-queues.md)

