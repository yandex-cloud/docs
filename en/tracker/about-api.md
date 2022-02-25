---
title: Yandex Tracker API. Overview
description: Yandex Tracker API is designed for web services and applications that work with the tasks of your organization on behalf of a user. In this case, API capabilities depend on the access rights of the user on whose behalf the requests are made. You can control Tracker using HTTP REST API requests.
sourcePath: en/tracker/api-ref/about-api.md
---

# {{ api-name }}. Overview

You can manage {{ tracker-name }} using HTTP requests to the REST API.

{{ api-name }} is designed for web services and apps that work with your organization's issues on behalf of a user. The actions available in the API depend on the access rights of the user on whose behalf requests are made.

{% note info %}

{{ api-name }} sends and receives date and time parameters in the UTC±00:00 time zone. Therefore, the time and date received may differ from the time zone of the client that the request is made from.

{% endnote %}

{{ api-name }} lets you:

- Search, create, and edit issues.
- Create and edit issue boards.
- View queue settings.
- Add and edit issue fields.

For information on how to get started with {{ api-name }}, see [{#T}](concepts/access.md).

