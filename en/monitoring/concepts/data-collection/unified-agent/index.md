# Agent for delivering metrics

{{unified-agent-full-name}}: The agent for delivering metrics for virtual machines and user applications.

The agent supports:

- Collecting Linux system metrics (CPU, RAM, disk).
- Collecting metrics in the [Prometheus](https://prometheus.io/) format.
- Delivering metrics to {{monitoring-full-name}}.
- File storage for reliable data delivery.

To install the agent configured for [delivering Linux system metrics](../../../operations/unified-agent/linux_metrics.md), run this Docker command:

```bash
docker run \
    -p 16241:16241 -it --detach --uts=host \
    --name=ua \
    -v /proc:/ua_proc \
    -e PROC_DIRECTORY=/ua_proc \
    -e FOLDER_ID=a1bs81qpemb4******** \
    {{ registry }}/yc/unified-agent
```

Where `FOLDER_ID` is the ID of the folder to write metrics to.

For other examples of how to use the agent, see [{#T}](../../../operations/index.md#working-with-metrics). Learn more about {{unified-agent-short-name}} installation methods in [{#T}](./installation.md). The syntax of the agent's configuration file is described in [{#T}](./configuration.md).

{% note info %}

{{unified-agent-full-name}} is distributed under Apache License 2.0.
To learn more about the license, run these commands:

- `unified_agent --license`: Displays the full text of the license.
- `unified_agent --credits`: Displays the list of and licenses for libraries used by the agent.

{% endnote %}

## Concepts {#basics}

{{unified-agent-full-name}} is intended for transmitting the streaming data represented as messages, for example, metrics or logs. The data stream in {{unified-agent-short-name}} is called a session. Multiple sessions can be set up at the same time.

The agent receives messages via the input and delivers them to one or more outputs. Filters are used to process messages on an interim basis, while storages are used to save messages to the disk. Inputs, outputs, filters, and storages are implemented using plugins.

Delivery routes are used for message routing and consist of an input and channel. Channels consist of a pipe and a node that is an output, a channel, or a splitter. Pipes can include filters and storage references. The pipe can be omitted.

You can create named channels and pipes. That avoids duplicate configurations and route messages from multiple inputs to one output.

### Messages {#messages}

Messages are the minimum indivisible unit of user information transmitted to {{unified-agent-short-name}}.

Messages consist of a body, a timestamp, custom metadata in the format `key:value`, and a serial number.

### Sessions {#sessions}

Sessions are an ordered stream of messages. Sessions have an ID that must be unique among all running sessions as well as user metadata in the `key:value` format.

All messages sent during a session contain both message metadata and session metadata.

### Inputs {#inputs}
The agent receives messages transmitted during sessions via an input. Inputs can contain settings for session infrastructure limits.

Sample input definition in the configuration file:

```yaml
- input:
    plugin: ... # plugin name
    id: ... # A recommended input ID used in metrics and logs
    flow_control: # A setting for the session infrastructure
    ...
```

See also:

- [List of implemented inputs](configuration.md#inputs).
- [Session infrastructure settings](configuration.md#flow_control).

### Outputs {#outputs}

The output is used by the agent to send messages to third-party systems. The currently supported outputs are `yc_metrics`, which writes a metric to the {{monitoring-full-name}} API, and several debug outputs.

Sample output definition in the configuration file:
```yaml
- output:
    plugin: ... # plugin name
    id: ... # A recommended output ID that's used in metrics and agent operation logs
```

See also [the list of available outputs](configuration.md#outputs).

### Filters {#filters}

Filters are designed to dispose of, convert, and aggregate messages.

Filter types:

- regular: Handle each message separately.
- cumulative: Transform a set of input messages into one output message.

Sample filter definition in the configuration file:

```yaml
- filter:
    plugin: ... # plugin name
    id: ... # A recommended filter ID that's used in metrics and logs
    config: # filter configuration
        ...
```

See also the [list of available filters](configuration.md#filters).

### Storages {#storages}
Storages are intended to store messages on an interim basis.

Sample storage definition in the configuration file:
```yaml
- input:
    plugin: ... # plugin name
    id: ... # A recommended storage ID that's used in metrics and logs
    flow_control: # A setting for the session infrastructure
    ...
```

See also the [list of available storages](configuration.md#storages).

### Routing {#routing}

#### Pipes {#pipes}
Pipes define a sequence of filters or storages that messages pass through.

Pipes can be named.

Sample pipe definition in the configuration file:
```yaml
...
- pipe:
    - filter:
        plugin: ...
        config: ...
    - filter:
        plugin: ...
        config: ...
    - storage_ref:
        storage: ...
    - filter:
        plugin: ...
        config: ...
    ...
```

Sample named pipe definition in the configuration file:

```yaml
pipes:
    - name: named_pipe
      pipe:
         ...
```

For a complete example of a pipe configuration, see [{#T}](configuration.md#pipes).

#### Channels {#channels}

Channels group a pipe with a node, one of an output, a named channel, or a splitter.

Splitters let you specify a set of channels, copying incoming messages to each of them. You can use splitters to duplicate streams to different outputs. By combining splitters and filters, you can send different messages to different channels based on particular attributes such as metadata.

Channels can be named.

Sample channel definition in the configuration file:

```yaml
channel:
    pipe:
        ...
    output:
        plugin: ...
        config: ...

channel:
    pipe:
        ...
    channel_ref: named_channel

channel:
    pipe:
        ...
    fanout:
        - channel:
            output:
                ...
        - channel:
            pipe:
                pipe_ref: named_pipe
            output:
                ...
        - channel:
            channel_ref: named_channel

        - channel:
            fanout:
                ...
```

Sample named channel definition in the configuration file:

```yaml
channels:
    - name: named_pipe
      channel:
         ...
```

See also a [sample named channel configuration](configuration.md#channels).

#### Routes {#routes}

Routes combine an input and a channel.

Sample route definition in the configuration file:

```yaml
routes:
    - input:
        plugin: ...
        id: ...
        config: ...

      channel:
        ...

    # Sending messages from different inputs to a single output
    - input:
        ... (input 1)
      channel:
        channel_ref: named_channel
        output:
            output_ref: named_output

    - input:
        ... (input 2)
      channel:
        channel_ref: named_channel
        output:
            output_ref: named_output

channels:
    - name: named_channel
      channel:
        output:
            ...
```

Routes, channels, and pipes let you set up any message processing tree you like.
