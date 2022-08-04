# Messenger integration

Messengers are a great way to quickly notify employees about important events. If a messenger has an API, you can use {{ tracker-name }} to set up a trigger that sends HTTP requests to the messenger's API when certain events occur. For instance, a request can be triggered once an error with the critical priority status is added to the queue.

Let's look at how we can set up triggers that send notifications to:

- [Slack](slack.md)
- [Telegram](telegram.md)

{% if audience == "internal" %}

- [Yandex Messenger](yamessenger.md)

{% endif %}

