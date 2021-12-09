[Trigger](../../functions/concepts/trigger/index.md) for {{ iot-short-name }} is designed for managing messages exchanged by devices and registries. The trigger is created for topics: it picks up copies of messages from them and passes them to a [function](../../functions/concepts/function.md) in {{ sf-name }} or a [container](../../serverless-containers/concepts/container.md) in {{ serverless-containers-name }} for processing. The trigger must be in the same cloud as the device or register as the topic it reads messages from.

You can create a trigger:

* For a [standard topic](../../iot-core/concepts/index.md) implemented by the service except for the `$monitoring/<device ID>/json` topic.
* For a topic with any [subtopics](../../iot-core/concepts/topic/subtopic.md) and wildcards.
* For an [alias](../../iot-core/concepts/topic/usage.md#aliases) of a topic.

A trigger for {{ iot-short-name }} needs a [service account](../../iam/concepts/users/service-accounts.md) to invoke a function or a container.

