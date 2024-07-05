# Routing

Message routing features routes, channels, and pipes.

## routes section {#routes}
This section contains a list of [delivery routes](index.md#routing).

Delivery routes consist of the following elements:

- `input`: [Input](index.md#inputs):
   - `plugin`: [Input](inputs.md) plugin
   - `config`: [Input](#inputs) configuration
   - `flow_control`: Configuration of the mechanism for creating input sessions
- `channel`: [Channel](index.md#channels):
   - `pipe`: Pipe:
      - `filter`: [Filter](filters.md)
      - `storage`: [Storage](storage.md)
   - One of the following elements:
      - `output`: [Output](outputs.md).
      - `channel_ref`: Link to a named channel.
      - `case`: Splitter that redirects the input stream to one or more child channels based on a condition.
      - `fanout`: Splitter that unconditionally directs the input stream to all child channels.

Example of the `routes` section:

```yaml
routes:
  - input:
      plugin: someinput
    channel:
      pipe:
        - filter:
            plugin: somefilter
            config: ...
        - filter:
            plugin: somefilter
            config: ...
        - storage:
            storage_ref:
              name: mystorage
      output:
        plugin: someoutput
        config: ...

  - input:
      plugin: someinput
    channel:
      pipe:
        - filter:
            plugin: somefilter
            config: ...
      channel_ref:
        name: mychannel

  - input:
      plugin: someinput
    channel:
      pipe:
        - filter:
            plugin: somefilter
            config: ...
      fanout:
        - channel:
            ...
        - channel:
            ...
```

An example of the `case` element:

```yaml
- input:
    plugin: console
  channel:
    # The "case" element directs the input stream to the first child channel that matches the "when" condition.
    # The message is discarded if no matching channel is found for it.
    # This event is added to the health counters (Errors) and pipeline counters (DroppedMessages/DroppedBytes).
    # An ERROR-level entry is added to the agent logs.
    # Situations like this are seen as abnormal.
    # To avoid them, add the last "catch all channel" element to the case without the 'when' filter.
    case:
      # Inside "when", you can define the conditions for matching between the message and session metadata, similar to the "match" filter.
      - when:
          message:
            message-key: v1
          session:
            session-key: v2
        channel:
          output:
            plugin: dev_null

      # Any message and session elements can be omitted inside when.
      # The "continue" property is supported — do not stop searching for a suitable channel if the "when" condition is met.
      # This way you can send incoming messages to multiple matching channels.
      - when:
          message:
            message-key: v1
        channel:
          output:
            plugin: dev_null
        continue: true

      # The "when" element may not be there, in which case the input stream is sent to the channel unconditionally if a session can be created for it (if none of its nested filters rejected the session creation).
      - channel:
          output:
            plugin: dev_null
```

## channels section {#channels}

You can describe a [channel](index.md#channels) in the `routes`:`channel` section or in a separate `channels` section. You can use channels from the separate section in delivery routes, referring to them by name.

Example of the `channels` section:

```yaml
channels:
  - name: named_channel
    channel:
      # Named channels can reference other named channels.
      channel_ref:
        name: other_named_channel

  - name: other_named_channel
    channel:
      output:
        plugin: dev_null

        # You can add an input ID, output ID, storage ID, and filter ID to any plugin.
        # This ID will replace the plugin_id label in the monitoring system.
        # This ID will also be used to label the plugin's entries in the agent log.
        id: my_dev_null_output
```

Here is an example of a delivery route that uses a named channel:

```yaml
- input:
    plugin: console
  channel:
    channel_ref:
      name: named_channel
```

## pipes section {#pipes}

You can describe a [pipe](index.md#pipes) in the `routes` section within the `channel`:`pipe` element or in a separate `pipes` section. You can use pipes from the separate section in channels, referring to them by name.

Example of the `pipes` section:

```yaml
pipes:
  - name: named_pipe
    pipe:
      - filter:
          plugin: batch
          config:
              limit:
                bytes: 100kb
      - filter:
            plugin: assign
            config:
              message:
                - _payload: "{_timestamp:%b %d %H:%M:%S} {_payload}"
```

Here is an example of a delivery route that uses a named pipe:

```yaml
- input:
    plugin: console
  channel:
    pipe:
      - pipe_ref:
          name: named_pipe
    output:
      plugin: debug
```
