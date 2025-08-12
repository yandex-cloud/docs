# {{ er-name }}, {{ sw-name }}, and {{ yds-name }} comparison

**Criterion \ service** | **{{ er-name }}** | **{{ sw-name }}** | **{{ yds-name }}**
--- | --- | --- | ---
**Architecture approaches** | [Choreography](https://docs.aws.amazon.com/prescriptive-guidance/latest/cloud-design-patterns/saga-choreography.html), data bus.<br/>Independent integrations with other services and message processing, quick change of message processing settings | [Orchestration](https://docs.aws.amazon.com/prescriptive-guidance/latest/cloud-design-patterns/saga-orchestration.html).<br/>Sequential execution of interconnected workflow steps | Message broker
**What it can help with** | Delivery, routing, filtering, and transforming messages | Filtering and processing messages, integration across services, and sequentially executing steps| Storing messages, scaling in case of loads
**Restrictions** | Message delivery timeout, number of message targets, message size | Workflow timeout, message size | Message retention period
**Streaming message processing** | Yes | No | No
**Batch message processing** | Yes | No | No
**Sending messages from multiple sources to multiple targets** | Yes | Can be implemented in custom code | Yes
**Interface** | Rules that define where messages are delivered to, how they are processed, and where they are redirected to. | Visual constructor for designing workflows or a YAML specification. | [Amazon Kinesis Data Streams API](../data-streams/kinesisapi/api-ref.md), AWS CLI, [Kafka API](../data-streams/kafkaapi/index.md) (with limitations)
**Error handling** | You can redirect unprocessed messages to a dead letter queue; processing retry mechanisms are supported. | Compatible with processing retry mechanisms and the error handling logic. | No
**Monitoring and logging** | Compatible with monitoring and logging for message transmission over a bus. | Compatible with monitoring and logging for step execution with a visual timescale. | Compatible with monitoring and logging for message transmission over a data stream.
