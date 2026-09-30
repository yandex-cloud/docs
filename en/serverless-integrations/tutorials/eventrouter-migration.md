# Migrating from {{ er-name }} to triggers

{% include [sunset-note](../../_includes/serverless-integrations/sunset-note.md) %}

As an alternative to {{ er-name }}, you can use:
* [Triggers](../../functions/concepts/trigger/index.md) to invoke {{ sf-name }}.
* [Triggers](../../serverless-containers/concepts/trigger/index.md) to invoke {{ serverless-containers-name }}.
* [Triggers](../../api-gateway/concepts/trigger/index.md) to send events to WebSocket connections.
* Triggers to start {{ sw-name }}.

Unlike {{ er-name }}, where a bus is a set of rules and connectors, a trigger is a single source and one or more targets.

## What is migrated automatically {#auto-migration}

Some buses will be migrated automatically: each connector will become a separate trigger source, and the bus rule targets will become trigger targets. Some buses you will need to migrate by yourself.

The bus will be migrated automatically only if it has processed events in the last 30 days prior to the migration start date.

The bus will not be migrated automatically if at least one of the following conditions is met:

* Filter or transformation template is specified in the bus rules.
* The connector type is **{{ at-name }}** or **{{ er-name }} API**.
* There is a {{ yds-full-name }} data stream, a {{ cloud-logging-full-name }} log group, or a {{ message-queue-full-name }} message queue among the targets of any bus rule.
* The connector status is neither `Started` nor `Stopped`.
* A time zone set for the **Timer** type connector.

{% note warning %}

We recommend that you migrate all buses by yourself. With automatic migration, there is no guarantee that the system will function completely the same after the migration.

{% endnote %}

## Map of {{ er-name }} entities and triggers {#entity-mapping}

{{ er-name }} | Triggers | What to consider when migrating
 --- | --- | --- 
Bus | No analog | The trigger connects the source and targets directly, there is no intermediate bus.
Connector | Trigger source | One connector corresponds to one trigger.
Rule | Trigger target | Rules belong to the bus, not the connector: each event passes through all the rules of the bus. Therefore, each trigger contains targets of all the bus rules.
Rule filter | Target filter | In {{ er-name }}, there is one filter for all the rule targets; in a trigger, the filter is set separately for each target.
Target | Trigger target | Not more than five targets per trigger. Calculated as a total for all the bus rules.
Target transformation template | Target transformation template | Applies to an event of a different format, see [{#T}](#message-format) for details.
Grouping settings | Grouping settings for source | In {{ er-name }}, grouping settings are individual for each target; in a trigger, they are the same for all targets. Maximum group size is reduced from 256 KiB to 64 KiB.
Number of resend attempts | Number of resend attempts | In {{ er-name }}, from 0 to 10; in triggers, from 1 to 5. For a trigger with a {{ message-queue-full-name }} source, resend attempts are not available.
No analog | Interval between retries | In {{ er-name }}, it is not configurable; in triggers, you can set it in the range from 10 seconds to 1 minute.
Maximum event lifetime | No analog | In {{ er-name }}, an event is redirected to a dead letter queue when its age exceeds a specified value. This setting is not available in triggers.
Dead letter queue of the target | Dead letter queue of the target | Not available for a trigger with a {{ message-queue-full-name }} source: use the queue's own redirection policy instead.
Timer time zone | No analog | The trigger schedule can be set only based on UTC\+0.
Queue read settings | Partially | Visibility timeout is transferable; group size when reading and polling timeout have no analogs.
Deletion protection | No analog | —
Bus logging | No analog | —
Stopping the connector, disabling the rule | Pausing a trigger | For the message queue and data stream, events are accumulated and processed after the trigger resumes operation. For timers and other bufferless sources, idle time events are lost.
API {{ er-name }} | No analog | For more information, see [{#T}](#api-connector).

## Migration plan {#migration-plan}

### Step 1: Make a list of resources {#step-1-list-resources}

Make a list of all buses, connectors, and rules you need to migrate:

```bash
yc serverless eventrouter bus list
yc serverless eventrouter connector list
yc serverless eventrouter rule list
```

The `connector list` and `rule list` commands display all connectors and rules in a folder: select the ones you need based on the `bus_id` field in the output. You cannot filter by bus using a command.

For each bus, lock its connectors with source settings and all its rules with filters and targets. Each connector will become a separate trigger, and the targets of **all bus rules** will become targets of each of these triggers.

{% note warning %}

In {{ er-name }}, each event goes through all the bus rules, no matter which connector has delivered it. Therefore, in each trigger, migrate the targets of all the bus rules, not just those pertaining to this particular connector. If there were several connectors in the bus, the same set of actions would be repeated in each trigger.

{% endnote %}

### Step 2: Check the limits {#step-2-check-limits}

Before you create triggers, make sure your scenario can be migrated without modifications. Extra work will be required if:

* The source {{ er-name }} API or events are sent to the bus directly: you need to modify your sending application.

* There is a {{ message-queue-name }} message queue, {{ yds-name }} data stream, or {{ cloud-logging-name }} log group among the targets: you need a wrapper function.

* There are more than five targets in total in the bus rules. The proper action depends on the source:

  * {{ yds-name }} data flow: add an additional consumer to the data flow and create a second trigger with the same data flow. Each consumer receives a full copy of the events, so targets can be distributed among several triggers. You cannot specify the same consumer in two triggers: then they will divide the events between themselves.
  * Timer: create a second trigger with the same schedule.
  * {{ message-queue-name }} message queue: you cannot create several triggers per queue; therefore, you will have to delegate extra calls to a wrapper function, which will call the other targets.

* The timer specifies a time zone or seconds in a cron expression.

* Targets have different grouping settings: in the trigger, they are common for all targets, so you will have to select a single option. In cases like these, automatic migration takes the minimum values ​​across all targets.

* Total group size exceeds 64 KiB: in {{ er-name }}, the limit is 256 KiB.

* Targets are configured for repeated invocations or dead letter queue, and the source is a message queue: neither of these are supported for such a trigger; retries are configured by the redirection policy of the queue itself, and this requires the `ymq.admin` role.

* An individual event exceeds 230 KB in size.

{% note warning %}

An event larger than the allowed size is discarded by the trigger without a retry and without a record to the dead letter queue. Make sure there are no such events in the source.

{% endnote %}

Make sure there are no more than 100 triggers in your cloud. This quota is shared between the {{ sf-name }}, {{ serverless-containers-name }}, and {{ api-gw-name }} triggers; and a multiple-connector bus goes through it quickly. To have the quota increased, contact [support]({{ link-console-support }}).

### Step 3: Prepare triggers for switching {#step-3-prepare-triggers}

1. Grant service accounts the roles required for the trigger to work. The set of roles depends on the source and target type; for more details, see the description of the relevant trigger.

1. Create a test trigger; as the target, specify a function that logs the incoming event. Select a source so it does not interfere with the connector's operation:

   * Data stream: you can take a production data stream but it must have a **separate consumer**. In which case the test trigger will get a full copy of the events and will not affect the connector.
   * Message queue: only a **separate test queue**. The production queue trigger will start parsing the same events, and some of the events will not reach the {{ er-name }} targets.
   * Timer: create a test trigger with the same schedule.

1. Make sure the event format matches your expectations and prepare jq templates and target code updates.

### Step 4: Switch to triggers {#step-4-switch}

The switching depends on the source type:

Source | Sequence of actions | What happens to the events
--- | ---| --- |
{{ message-queue-full-name }} | Stop the connector, wait for the accumulated events to get processed, create a trigger. | Events are stored in a queue. A connector and a trigger can read one queue at the same time, but in that case they will split the events between themselves; therefore, you cannot check two circuits in parallel on the same queue: you will need a second queue for that.
{{ yds-full-name }} | Stop the connector, create a trigger with the same consumer. | Events are stored in a stream. If you create a trigger with a new consumer, reading will not start from the same place.
Timer | Stop the connector, create a trigger. | One trigger action can be missed or duplicated.
{{ er-name }} API, direct send to the bus | Send an event from the application to a message queue or data stream, create a trigger. | Events sent to the bus after the stop are lost.

Triggers, same as {{ er-name }}, guarantee delivery `At least once`, so repeated invocations are possible during switching. Ensure that handlers are idempotent.

### Step 5: Test the operation {#step-5-verify}

* Send a test event and make sure the target has been called.
* Compare the target call metrics before and after the switching.
* If the target settings specify a dead letter queue, check that it is not being added to. There is no such check for a trigger with a {{ message-queue-full-name }} source; see the DLQ specified in the queue redirection policy settings.

### Step 6: Delete the {{ er-name }} resources {#step-6-cleanup}

Disable deletion protection if it is on and delete the rules, connectors, and buses. When done, revoke the roles that were issued to service accounts only for the purposes of {{ er-name }}.

## Bus migration example {#migration-example}

Below is a typical case: a bus with one connector and two rules turns into one trigger with two targets.

### What was in {{ er-name }} {#example-before}

One connector named `orders-queue` with a {{ message-queue-full-name }} source connected to the bus named `orders-bus`: the `orders` queue. The events in the queue look like this:

```json
{"orderId": "1234", "status": "new", "amount": 500}
```

The bus has two rules linked to it, both targets are set up to group by 10 events or 5 seconds:

Rule | Filter | Target
--- | --- | ---
`process-orders` | `.status == "new"` | `order-processor` container
`notify-orders` | Not specified | `order-notifier` function

### What will the triggers do {#example-after}

One trigger with a {{ message-queue-full-name }} source and two targets:

Before | After
--- | ---
`orders-queue` connector | Trigger source: `orders` queue.
Individual grouping settings for each target | One set of grouping settings on the source: 10 messages or 5 seconds.
`process-orders` rule | Target 1: Invoking the `order-processor` container with a filter.
`notify-orders` rule | Target 2: Invoking the `order-notifier` function.

In {{ er-name }}, grouping settings are specified for each target, so they could be different from target to target. In the trigger they are the same for all targets, and you have to select one value when migrating. In the event of automatic migration, the minimum values ​​will be used for all targets.

If the target of one of the rules were a log group, a message queue, or a data stream, then you would need a [wrapper function](#shim) instead of a target: these targets have no direct analogs.

### Step 1: Describe the actions {#example-step-1}

You cannot migrate the `process-orders` rule filter verbatim: it was written for the event body, whereas the trigger target receives a JSON object with the event. Use the [migration recipe](#message-format-jq) to add the unpacking of the body on the left. Use the same expression to set a template for the container to receive event bodies inside the JSON object, not the queue message service wrapper.

Target 1: Container invocation.

```json
{
  "invokeContainer": {
    "containerId": "<order_processor_container_ID>",
    "serviceAccountId": "<service_account_ID>"
  },
  "filter": {"jq": ".details.message.body | fromjson | .status == \"new\""},
  "transformer": {"jq": ".details.message.body | fromjson"}
}
```

Target 2: Function invocation. The `notify-orders` rule did not have a filter, so there is none in the target either.

```json
{
  "invokeFunction": {
    "functionId": "<order_notifier_function_ID>",
    "serviceAccountId": "<service_account_ID>"
  },
  "transformer": {"jq": ".details.message.body | fromjson"}
}
```

None of the targets have either repeated invocations or a dead letter queue: the source is a message queue, and they are not supported for such a trigger. If you specify `retryPolicy` or `deadLetter` for the target, the trigger creation will fail. Configure reprocessing using the queue's redirection policy; you need the `ymq.admin` role for that.

### Step 2: Create a trigger {#example-step-2}

Save the descriptions of the targets to files named `action-1.json` and `action-2.json` and create a trigger:

```bash
yc serverless trigger v2 create message-queue orders \
  --queue-arn <queue_ARN> \
  --service-account-id <service_account_ID> \
  --batch-max-count 10 \
  --batch-cutoff 5s \
  --action @action-1.json \
  --action @action-2.json
```

You can provide the `--action` parameter as a string or as a link to a file via `@`. We recommend the second method: jq expressions contain quotes, and these need to be escaped in the embedded JSON.

You can get the finished template using the `yc serverless trigger v2 help-action --invoke-container` command. Same for `--invoke-function`, `--start-workflow`, and `--gateway-websocket-broadcast`.

{% note warning %}

Be sure to state `v2` in the command path. Without it, the legacy `yc serverless trigger v1` command group is called, which is still the default option and does not support `--action`, filters, templates, and consumer selection. If you try to run the command without `v2`, you will get the `unknown flag: --action` error.

{% endnote %}

You cannot create a trigger with multiple targets, filters, and templates using separate parameters of the `--invoke-function-id` type: they specify a single target without any additional settings. Use the management console, `yc serverless trigger v2`, API v2, or Terraform.

There is one `--action` parameter per target; a trigger can have a maximum of five targets.

### What will change for targets {#example-consumer-changes}

Grouping was enabled even earlier; therefore, the `order-processor` container was no longer receiving a single event, but a JSON array of bodies:

```json
[
  {"orderId": "1234", "status": "new", "amount": 500}
]
```

It will continue to receive only events with the `new` status, but now the array will be stored in the JSON object under the `messages` key:

```json
{
  "messages": [
    {"orderId": "1234", "status": "new", "amount": 500}
  ]
}
```

You need to teach the container code to unwrap the JSON object: [you cannot remove it with a template](#message-format).

The same applies to the `order-notifier` function: it will receive all events as a batch, in a JSON object, and still without filtering.

### If the source is a data stream {#example-yds-source}

For a connector with a {{ yds-full-name }} source, the procedure is the same, with two differences:

* When creating a trigger, specify the same consumer that was named in the connector, otherwise reading will not start from the same place.
* The filter and template are migrated unchanged: the elements of the JSON object match the stream records; there is no need to unpack the body. The rule filter remains as the `.status == "new"` expression; no template is required.

## Migrating sources (connectors) {#source-migration}

### Timer {#source-timer}

Create a [timer](../../functions/concepts/trigger/timer.md).

You cannot move a cron expression from a connector to a trigger without changes: {{ er-name }} and triggers have different field orders. There will be no hidden substitution of the schedule: the trigger will refuse to accept the copied expression. In {{ er-name }}, one of the fields `Day of month` and `Day of week` always contains `?`, and when fields shift, this character ends up in `Month` or `Year`, where it is not allowed. Creating a trigger will result in the `'?' can only be specified for Day-of-Month or Day-of-Week` error. Transform the expression based on the table below.

Features | Cron expression field order
--- | ---
{{ er-name }} | `Seconds Minutes Hours Day-of-month Month Day-of-week [Year]`
Triggers | `Minutes Hours Day-of-month Month Day-of-week [Year]`

To transform the expression, remove the first `Seconds` field. The `Year` field is optional in both functionalities: if it was specified in the connector, migrate it unchanged; if not, you can leave the five-field expression or add `*`.

Examples of cron expressions:

{{ er-name }} | Triggers | Description
--- | --- | ---
`0 * * * * ?` | `* * * * ? *` | Every minute
`0 0 * ? * *` | `0 * ? * * *` | Every hour
`0 15 10 ? * *` | `15 10 ? * * *` | Every day at 10:15

Same as in {{ er-name }}, you cannot fill the `Day of month` and `Day of week` fields at the same time: if there is a value in one, the other one must contain `?`. When migrating, make sure that `?` is not lost in the field shift.

The numbering of days of the week in both services is the same: `1` stands for Sunday, `7` for Saturday.

{% note warning %}

Triggers do not support seconds in a cron expression. The minimum unit of measurement is 1 minute. If the scenario requires more frequent action, revise the logic of the application.

{% endnote %}

{% note warning %}

You cannot set a time zone in triggers; the cron expression always uses UTC\+0. If a different time zone was specified in the connector, recalculate the time in the schedule yourself. Note that this conversion will cause the schedule to stop automatically consulting the daylight saving time changes, if any, in your time zone.

{% endnote %}

### {{ message-queue-full-name }} {#source-ymq}

Create a [trigger for {{ message-queue-full-name }}](../../functions/concepts/trigger/ymq-trigger.md).

The format of the message the trigger sends to {{ message-queue-name }} is different from the format used in {{ er-name }}. See details, see [{#T}](#message-format). We recommend using a transformation template in the trigger settings or changing the configuration of the called resources to adapt it to your needs. For example, to receive only the message body, specify the `.details.message.body` template in the trigger settings.

{% note warning %}

The targets of such a trigger do not support resend attempts and dead letter queue. Configure reprocessing using the queue's redirection policy; you need the `ymq.admin` role for that.

{% endnote %}

Only the message visibility timeout is migrated from the connector settings. The group size when reading from the queue and the polling timeout have no analogs in triggers.

Note that the queue ARN is specified as the trigger source, just like in the {{ er-name }} target. The queue URL will only be needed by the [wrapper function](#shim) if the queue was also a target.

### {{ yds-full-name }} {#source-yds}

Create a [trigger for {{ yds-full-name }}](../../functions/concepts/trigger/data-streams-trigger.md).

To avoid event reprocessing, make sure you specify the **same consumer** that was configured in the connector when creating the trigger. The legacy `yc serverless trigger` command group does not have such a field: the service will create its own consumer named after the trigger ID, and the read position will be lost. Specify the consumer via `yc serverless trigger v2 create yds` or API v2.

The trigger provides the contents of the records unchanged but wraps them in `{"messages": [...]}` JSON object. See details, see [{#T}](#message-format).

### {{ at-name }} {#source-audit-trails}

There is no direct trigger for {{ at-name }} events in the current implementation. If you use {{ er-name }} to process audit events for {{ container-registry-name }} or {{ objstorage-name }}, a [trigger for {{ container-registry-name }}](../../functions/concepts/trigger/cr-trigger.md) or [trigger for {{ objstorage-name }}](../../functions/concepts/trigger/os-trigger.md) will suit you.

For other scenarios, proceed as follows:

1. Export events to a [data stream](../../data-streams/concepts/glossary.md#stream-concepts).
1. Set up integration with {{ at-name }} by [creating a trail](../../audit-trails/concepts/trail.md) and specifying the new data stream as the destination.
1. [Create a trigger for {{ yds-full-name }}](../../functions/concepts/trigger/data-streams-trigger.md) with the new data stream as the source.

### {{ er-name }} API and direct send to the bus {#api-connector}

There is no direct analog in triggers for any of the methods for sending custom events to {{ er-name }}:

* Via a connector with the **{{ er-name }} API** source type: `EventService/Send` call or `yc serverless eventrouter send-event` command.
* Directly into the bus, without using a connector: `EventService/Put` call or `yc serverless eventrouter put-event` command.

Both methods will stop working. For a trigger to fire on events generated by your application, the application must write them directly to a {{ message-queue-full-name }} queue or {{ yds-full-name }} data stream, and the trigger must read from that queue or stream.

Note the differences in access control: in {{ er-name }}, sending permissions were granted to a specific connector or bus; after migration, you will have to grant permissions to write to a queue or data stream.

#### Option 1: Sending via {{ yds-full-name }} {#api-option-yds}

1. Create a [data stream in {{ yds-full-name }}](../../data-streams/concepts/glossary.md#stream-concepts). You can write via:
    * [AWS SDK](../../data-streams/operations/aws-sdk/send.md)
    * [Kafka API](../../data-streams/kafkaapi/auth.md#example)
    * [HTTP API compatible with Amazon Kinesis Data Streams](../../data-streams/kinesisapi/methods/putrecord.md)
1. Configure a [trigger for {{ yds-full-name }}](../../functions/concepts/trigger/data-streams-trigger.md) with the new data stream as the source.

#### Option 2: Sending via {{ message-queue-full-name }} {#api-option-ymq}

1. Create a {{ message-queue-full-name }} queue. Message recording is [done using cURL](../../message-queue/operations/message-queue-send-message.md#curl).
1. Create a [trigger for {{ message-queue-full-name }}](../../functions/concepts/trigger/ymq-trigger.md) with the new queue as the source.

## Message formats {#message-format}

{{ er-name }} and triggers deliver events to the target in different formats; therefore, after switching, you will have to either set a transformation template in the target or change the target code.

General rule: {{ er-name }} delivers the event body as is, or, if grouping is enabled, as a JSON array of bodies. The trigger always wraps the event in a `{"messages": [...]}` JSON object, even if there is one event only.


Source | What was delivered by {{ er-name }} | What is delivered by the trigger
--- | --- | ---
Timer | **Data** field value as is. If the field is empty, the target was still called but with an empty body. | JSON object with the `event_metadata` and `details` fields, which contain the trigger ID and the **Data** field value.
{{ message-queue-full-name }} | Message body as is. | JSON object with the `event_metadata` and `details` fields. The `string` type message body is in `details.message.body`; next to it are the queue ID and message attributes.
{{ yds-full-name }} | Record as is. | JSON object containing records from the data stream without additional fields.

Exact message examples are provided in the description of each trigger type.

{% note warning %}

The filter and transformation template are applied to each message inside the JSON object, with the result once again packed into a JSON object. You cannot remove the `{"messages": [...]}` JSON object with the template; therefore, you will have to teach the target to unwrap it anyway.

{% endnote %}

Please note:

* Event metadata, i.e., ID, creation time, message attributes – did not reach the target in {{ er-name }}. They are available in triggers and you can use them, for example, for deduplication by `event_metadata.event_id`.
* The trigger for {{ yds-full-name }} receives and sends events in JSON format only.
* The body of the {{ message-queue-full-name }} event is provided as a string, no matter what it contains. If the target expects a JSON object, you need to parse the body with the help of a transformation template or in the target's code.

### Transformation templates {#message-format-jq}

For the content of the JSON object elements to match that delivered by {{ er-name }}, specify a transformation template in the trigger's target.

**Timer**

To get the **Data** field value:

```jq
.details.payload
```

The value will come as a string. If the field contains JSON, parse it:

```jq
.details.payload | fromjson
```

**{{ message-queue-full-name }}**

To get the message body only:

```jq
.details.message.body
```

The body will come as a string. If JSON is written to the queue, parse it:

```jq
.details.message.body | fromjson
```

If the queue may contain messages that are not valid JSON, use the safe option: it will return either the parsed object or the original string:

```jq
.details.message.body | fromjson? // .
```

You can supplement the body with metadata that was not there in {{ er-name }}. For example, to provide the body along with the event ID to the target:

```jq
{body: (.details.message.body | fromjson), event_id: .event_metadata.event_id}
```

**{{ yds-full-name }}**

No template is needed: the elements of the JSON object are records from the stream, and they match the content delivered by {{ er-name }}. Only the JSON object is different.

### Migrating existing filters and transformation templates {#migrate-existing-jq}

If filters and transformation templates were already specified in the rule or the {{ er-name }} target, add the event body unpacking to them on the left. The `<expression>` below is the filter or template specified in {{ er-name }}.

**Timer**

```jq
.details.payload | fromjson | <expression>
```

For example, the `.firstName == "Ivan"` filter for the {{ message-queue-full-name }} queue becomes:

```jq
.details.message.body | fromjson | .firstName == "Ivan"
```

And the `{name: .firstName, city: .address.city}` template becomes:

```jq
.details.message.body | fromjson | {name: .firstName, city: .address.city}
```

If the expression failed to be calculated (e.g., the message body is not a valid JSON), the event is routed to the target's dead letter queue or, if the latter is not configured, is lost. For a trigger with the {{ message-queue-full-name }} source, the dead letter queue is not available, so such an event will be lost. For queues that can contain messages of any format, it is best to use the safe option with `fromjson? // .`.

**{{ message-queue-full-name }}**

```jq
.details.message.body | fromjson | <expression>
```

**{{ yds-full-name }}**

The expression is migrated unchanged:

```jq
<expression>
```

## Target migration {#target-migration}

One trigger supports up to five targets. For each target, you can specify a transformation template or filter, so that the targets of all the bus rules become targets of a single trigger. You can combine target types: a single trigger can call functions, containers, and workflows and send messages to WebSocket connections at the same time.

Target {{ er-name }} | Trigger target | What this changes
--- | --- | ---
Function | Function | Grouping settings are set on the source, not target.
Container | Container | Grouping settings are set on the source, not destination; you cannot pin a container revision.
Workflow | Workflow | Grouping settings are set on the source, not target.
WebSocket connections | WebSocket connections | Grouping settings are set on the source, not target; repeated invocations and dead letter queue are not supported.
Log group | No analog | [Wrapper function](#shim) required.
Stream | No analog | [Wrapper function](#shim) required.
Message queue | No analog | [Wrapper function](#shim) required.

In all cases, the service account used to invoke the target is migrated unchanged.

### Functions {#target-functions}

Create a [trigger to call the function](../../functions/concepts/trigger/index.md). The function ID, version tag, and service account are migrated from the target unchanged.

The service account needs the `functions.functionInvoker` role for the function the trigger is calling.

Same as in {{ er-name }}, the trigger calls a function with the `?integration=raw` query string parameter, so you do not need to change the way the input data is parsed in the function code: only the [message format](#message-format) changes.

### Containers {#target-containers}

Create a [trigger that calls the container](../../serverless-containers/concepts/trigger/index.md). The container ID, path, and service account are migrated from the target unchanged.

The service account needs the `serverless-containers.containerInvoker` role for the container that is calling the trigger.

{% note warning %}

In the {{ er-name }} target, you could specify a particular container revision. The trigger does not have such a setting so it always calls the active revision. If you had pinned a revision to control the new version rollout moment, consider a replacement, e.g., separate containers for the stable and testing versions.

{% endnote %}

### Workflows {#target-workflows}

In the trigger target, specify the workflow ID and the service account which will be used to run it. Both parameters are migrated from the target unchanged.

The service account needs the `serverless.workflows.executor` role for the workflow that launches the trigger.

The input data for the launch is the message as it was when delivered by the trigger. If grouping is configured on the source, one launch receives a batch of messages all at once.

### WebSocket connections {#target-websocket}

Create a [trigger that sends messages to WebSocket connections](../../api-gateway/concepts/trigger/index.md). The API gateway ID, path, and service account are migrated from the target unchanged.

The service account needs the `api-gateway.websocketBroadcaster` role for the folder containing the API gateway.

{% note warning %}

Repeated invocations and dead letter queue are not supported for this target type. If you specify them when creating a trigger, there will be no error but the settings will not be applied. If the {{ er-name }} target had retries or a dead letter queue configured, you will not be able to transfer them.

{% endnote %}

### Log groups, data streams, and message queues {#shim}

Triggers cannot write events directly to a {{ cloud-logging-name }} log group, {{ yds-full-name }} stream, or {{ message-queue-full-name }} queue. Instead of a target of this type, specify in the trigger a target with a wrapper function routing events to the required destination.

All the functions below work the same way: they accept a `{"messages": [...]}` JSON object and write each of its elements as a separate record. If you need to send only a portion of an event, not the entire event, to a destination, do not change the function code; specify the transformation template in the trigger target. See details, see [{#T}](#message-format-jq).

Things common to all three functions listed in the sections below:

* Runtime environment: `golang123`, entry point: `index.Handler`.
* Upload the `go.mod` file together with `index.go`. The module name in it must not be `main`. To pin the dependency versions, upload `go.sum` too; otherwise, the latest ones will be installed.
* There should not be any `go.mod` and `go` strings in `toolchain`. The Go version in the compiled plugin must match the runtime version, and the compiler substitutes it itself; whereas these directives will force it to take a different one. In which case the function will be compiled but will crash with the `fatal error: runtime: no plugin module data` error as soon as you call it. Go automatically adds the `toolchain` string if you have `go get` and `go mod tidy`, so check the file before uploading: only `module` and `require` should remain.
* The function is called by a trigger, so if there is an error, the trigger will retry the call with the entire batch. This may cause some events to be rerecorded. Keep this in mind during processing. If the trigger source is a message queue, there will be no repeated invocations.
* The service account specified in the function settings needs a role to write to a log group, data stream, or message queue. For more details, see the descriptions of each function.

Note that the wrapper changes the operating model:
* Instead of declarative delivery, there is now a code that has to be followed up on.
* To write to the queue and data stream you need a static service account access key instead of managed access permissions.
* Function calls come at a charge.

#### Writing to a log group {#shim-logs}

This function writes each event to the standard output stream. The entries end up in the log group specified in the function's [logging settings](../../functions/operations/function/logs-write.md). Specify in them the log group that was the target in {{ er-name }}.

`index.go`:

```go
package main

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
)

type Request struct {
	Messages []json.RawMessage `json:"messages"`
}

func Handler(ctx context.Context, req *Request) (string, error) {
	var buf bytes.Buffer
	for _, message := range req.Messages {
		buf.Reset()
		if err := json.Compact(&buf, message); err != nil {
			// The event is not a valid JSON: writing as is.
			fmt.Println(string(message))
			continue
		}
		fmt.Println(buf.String())
	}
	return "ok", nil
}
```

Each line output by the function becomes a separate entry in the log group. The trigger provides the JSON object with indents; therefore, the event within it spans several lines, and you cannot print it without first collapsing it: a single event would then turn into multiple records. `json.Compact` removes line breaks and indents.

What to configure:

* Specify the required log group in the function settings.
* Add the `STRUCTURED_LOGGING` environment variable set to `false`.

{% note warning %}

Without the `STRUCTURED_LOGGING=false` variable, a single-line JSON entry containing the `message` or `msg` field would be recognized as a [structured log](../../functions/concepts/logs.md#structured-logs). This field's value will then become the text of the entry, and the remaining fields of the event will go to `json_payload`. If events can contain a field with this name, you must set this variable; otherwise, the log group entries will not match what {{ er-name }} wrote.

{% endnote %}

#### Writing to a data stream {#shim-yds}

This function writes events to a data stream using an Amazon Kinesis Data Streams compatible protocol in batches of up to 500 records.

`index.go`:

```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"
	"time"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/credentials"
	"github.com/aws/aws-sdk-go-v2/service/kinesis"
	"github.com/aws/aws-sdk-go-v2/service/kinesis/types"
)

const (
	endpoint     = "https://yds.serverless.yandexcloud.net"
	region       = "ru-central1"
	maxBatchSize = 500
)

type Request struct {
	Messages []json.RawMessage `json:"messages"`
}

var streamName = os.Getenv("STREAM_NAME")

var client = kinesis.NewFromConfig(aws.Config{
	Region: region,
	Credentials: credentials.NewStaticCredentialsProvider(
		os.Getenv("AWS_ACCESS_KEY_ID"),
		os.Getenv("AWS_SECRET_ACCESS_KEY"),
		"",
	),
}, func(o *kinesis.Options) {
	o.BaseEndpoint = aws.String(endpoint)
})

func Handler(ctx context.Context, req *Request) (string, error) {
	for start := 0; start < len(req.Messages); start += maxBatchSize {
		end := start + maxBatchSize
		if end > len(req.Messages) {
			end = len(req.Messages)
		}

		records := make([]types.PutRecordsRequestEntry, 0, end-start)
		for i, message := range req.Messages[start:end] {
			records = append(records, types.PutRecordsRequestEntry{
				Data:         []byte(message),
				PartitionKey: aws.String(fmt.Sprintf("%d-%d", time.Now().UnixNano(), start+i)),
			})
		}

		out, err := client.PutRecords(ctx, &kinesis.PutRecordsInput{
			StreamName: aws.String(streamName),
			Records:    records,
		})
		if err != nil {
			return "", err
		}
		if failed := aws.ToInt32(out.FailedRecordCount); failed > 0 {
			return "", fmt.Errorf("failed to write %d records", failed)
		}
	}
	return "ok", nil
}
```

`go.mod`:

```
module ydswriter

require (
	github.com/aws/aws-sdk-go-v2 v1.40.1
	github.com/aws/aws-sdk-go-v2/credentials v1.19.10
	github.com/aws/aws-sdk-go-v2/service/kinesis v1.43.1
)
```

What to configure:

* The `STREAM_NAME` environment variable: full name of the stream in `/{{ region-id }}/<cloud_ID>/<database_ID>/<stream_name>` format.
* Environment variables `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`: [Static access key](../../iam/concepts/authorization/access-key.md) of the service account. Send the secret part of the key via {{ lockbox-full-name }}, not in plaintext.
* The `yds.writer` role for the data stream for the service account owning the key.

#### Writing to a message queue {#shim-ymq}

This function writes events to a queue using an Amazon SQS compatible protocol in batches of up to 10 messages.

`index.go`:

```go
package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/credentials"
	"github.com/aws/aws-sdk-go-v2/service/sqs"
	"github.com/aws/aws-sdk-go-v2/service/sqs/types"
)

const (
	endpoint     = "https://message-queue.api.cloud.yandex.net/"
	region       = "ru-central1"
	maxBatchSize = 10
)

type Request struct {
	Messages []json.RawMessage `json:"messages"`
}

var queueURL = os.Getenv("QUEUE_URL")

var client = sqs.NewFromConfig(aws.Config{
	Region: region,
	Credentials: credentials.NewStaticCredentialsProvider(
		os.Getenv("AWS_ACCESS_KEY_ID"),
		os.Getenv("AWS_SECRET_ACCESS_KEY"),
		"",
	),
}, func(o *sqs.Options) {
	o.BaseEndpoint = aws.String(endpoint)
})

func Handler(ctx context.Context, req *Request) (string, error) {
	for start := 0; start < len(req.Messages); start += maxBatchSize {
		end := start + maxBatchSize
		if end > len(req.Messages) {
			end = len(req.Messages)
		}

		entries := make([]types.SendMessageBatchRequestEntry, 0, end-start)
		for i, message := range req.Messages[start:end] {
			entries = append(entries, types.SendMessageBatchRequestEntry{
				Id:          aws.String(fmt.Sprintf("%d", start+i)),
				MessageBody: aws.String(string(message)),
			})
		}

		out, err := client.SendMessageBatch(ctx, &sqs.SendMessageBatchInput{
			QueueUrl: aws.String(queueURL),
			Entries:  entries,
		})
		if err != nil {
			return "", err
		}
		if len(out.Failed) > 0 {
			return "", fmt.Errorf("failed to send %d messages, first error: %s",
				len(out.Failed), aws.ToString(out.Failed[0].Message))
		}
	}
	return "ok", nil
}
```

`go.mod`:

```
module ymqwriter

require (
	github.com/aws/aws-sdk-go-v2 v1.40.1
	github.com/aws/aws-sdk-go-v2/credentials v1.19.10
	github.com/aws/aws-sdk-go-v2/service/sqs v1.42.21
)
```

What to configure:

* `QUEUE_URL` environment variable: queue URL. Note that, in {{ er-name }}, the target was specified by the queue ID in ARN format, but here you need a URL.
* Environment variables `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`: static access key of the service account.
* The `ymq.writer` role for the queue for the service account owning the key.
