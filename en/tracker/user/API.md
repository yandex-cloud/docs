# API {{ tracker-name }}

Manage your {{ tracker-name }} issues using HTTP requests to the [{{ tracker-full-name }} REST API](../about.md).

The {{ tracker-full-name }} API is used by web services and apps that process your company's issues on behalf of the user. Users may have different features available in the API depending on their access rights.

With the {{ tracker-name }} API, you can:

- Integrate {{ tracker-name }} with other services. For example, use a chat bot to manage issues, or link {{ tracker-name }} to your CRM system.
- Automatically create issues, batch edit, and search for issues using filters.
- Set specific handling rules for specific actions, such as updating the status at a particular time.
- Create web browser extensions for managing {{ tracker-name }}.

To learn more about the {{ tracker-name }} API features, see the [reference](../about.md).

{% if audience == "internal" %}

- [The API documentation on Wiki.](https://wiki.yandex-team.ru/tracker/api/)
- [Generated documents.](https://st-api.yandex-team.ru/docs/)

{% endif %}

{% note tip %}

Try using our [Python client](python.md) for working with the {{ tracker-name }} API. This will make it easier for you to integrate the Tracker API into your apps.

{% endnote %}

{% if audience == "external" %}

[Contact support](../troubleshooting.md)

{% endif %}

