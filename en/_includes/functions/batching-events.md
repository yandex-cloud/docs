## Event batching {#batching}

The batching settings allow you to send several events to a target at the same time. They set a top limit on the event batch size and accumulation time. For example, if the event batch size is `3`, the target can receive batches of one to three events.

You can configure the following triggers to batch events before sending them to a target:

* Trigger for {{ message-queue-name }}.
* Trigger for {{ cloud-logging-name }}.
* Trigger for {{ objstorage-name }}.
* Trigger for {{ container-registry-name }}.
* Trigger for {{ iot-name }}.
* Trigger for {{ yds-name }}.
* Email trigger.
* Trigger for Telegram.
