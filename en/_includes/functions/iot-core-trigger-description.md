[Trigger](../../functions/concepts/trigger/index.md) for {{ iot-short-name }} is designed for managing messages exchanged by the devices and registries. The trigger is created for topics: it picks up copies of messages from them and passes them to the function for processing. The trigger must be in the same cloud as the device or register as the topic it reads messages from.

You can create a trigger:

- For a [standard topic](../../iot-core/concepts/topic.md) implemented by the service.
- For a topic with any [subtopics](../../iot-core/concepts/topic.md#subtopic) and wildcards.
- For an [alias](../../iot-core/concepts/topic.md#aliases) of a topic.

A trigger for {{ iot-short-name }} needs a [service account](../../iam/concepts/users/service-accounts.md) to call the function.

