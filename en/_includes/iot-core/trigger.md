The trigger must be in the same cloud as the device, registry, or broker whose topic it reads messages from.

You can create a trigger:
* For a [standard topic](../../iot-core/concepts/topic/index.md) implemented by the service except for the `$monitoring/<device ID>/json` topic.
* For a topic with any [subtopics](../../iot-core/concepts/topic/subtopic.md) and wildcards.
* For an [alias](../../iot-core/concepts/topic/usage.md#aliases) topic.