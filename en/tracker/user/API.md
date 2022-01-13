# {{ tracker-name }} API

Manage your {{ tracker-name }} issues using HTTP requests to the [{{ tracker-full-name }} REST API](../about-api.md).

The {{ tracker-full-name }} API is designed for web services and apps that work with your organization's issues on behalf of a user. The API features depend on the access rights of the user on whose behalf requests are made.

Use the {{ tracker-name }} API to:

- Integrate {{ tracker-name }} with other services. For example, use a chatbot to manage tasks or link {{ tracker-name }} to your CRM system.
- Automate processes like creating, mass changing, and finding tasks with particular parameters.
- Set specific rules for processing certain actions. For example, you can set a timer for updating a task's status.
- Create web browser extensions for managing {{ tracker-name }}.

For more information about how to use the {{ tracker-name }} API, see the [Reference](../about-api.md).

{% if audience == "internal" %}

You can also find information about the API [in automatically generated documents.](https://st-api.yandex-team.ru/docs/)

{% endif %}

{% note tip %}

Try using our [Python client](python.md) with the {{ tracker-name }} API. This will make it easier for you to integrate the Tracker API into your apps.

{% endnote %}

