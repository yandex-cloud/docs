# Integration with messengers

By using messengers, you can quickly notify your employees about important events. If a messenger has an API, you can use {{ tracker-name }} to set up a trigger that sends HTTP requests to the messenger API when certain events occur. For example, this might be handy when a severe error occurs in your queue.{% if lang == "ru" and audience != "internal" %} What is [REST API](../glossary/rest-api.md)?{% endif %}

Let's look at how we can set up triggers that send notifications to:

- [Slack](slack.md)
- [Telegram](telegram.md)

{% if audience == "internal" %}

- [Yandex Messenger](yamessenger.md)

{% endif %}

