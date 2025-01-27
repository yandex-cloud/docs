---
title: Message routing in {{ monitoring-full-name }}
description: Message routing features routes, channels, and pipes.
---

# Routing

Message routing features routes, channels, and pipes.

## routes section {#routes}
This section contains a list of [delivery routes](index.md#routing).

Delivery routes consist of the following elements:

- `input`: [Input](index.md#inputs):
  - `plugin`: [Input](inputs.md) plugin.
  - `config`: [Input](#inputs) configuration.
  - `flow_control`: Configuration of the input session creation mechanism.
- `channel`: [Channel](index.md#channels):
  - `pipe`: Pipe:
    - `filter`: [Filter](filters.md).
    - `storage`: [Storage](storage.md).
  - One of the following elements:
    - `output`: [Output](outputs.md).
    - `channel_ref`: Link to a named channel.
    - `case`: Splitter that directs the input stream to one or more child channels based on a condition.
    - `fanout`: Splitter that unconditionally directs the input stream to all child channels.

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

Example of the `case` element:

```yaml
- input:
    plugin: console
  channel:
    # The `case` element directs the input stream to the first child channel satisfying the "when" condition.
    # The message will be discarded if no matching channel is found for it.
    # This fact will be counted by the health counters (Errors) and pipeline counters (DroppedMessages/DroppedBytes).
    # An ERROR-level entry will be added to the agent's logs.
    # A situation like this is seen as abnormal.
    # To avoid it, add "catch all channel" as the last element to `case` without the 'when' filter.
    case:
      # Inside `when`, you can define conditions for mapping the message and session metadata, similar to the "match" filter.
      - when:
          message:
            message-key: v1
          session:
            session-key: v2
        channel:
          output:
            plugin: dev_null

      # Any of the message and session elements can be omitted inside `when`.
      # The `continue` property is supported. It instructs not to stop searching for a suitable channel if the `when` condition is met.
      # This way you can direct incoming messages to multiple suitable channels.
      - when:
          message:
            message-key: v1
        channel:
          output:
            plugin: dev_null
        continue: true

      # You may omit the `when` element, in which case the input stream will be unconditionally directed to this channel if a session was successfully created for it (none of its nested filters rejected the session).
      - channel:
          output:
            plugin: dev_null
```

## channels section {#channels}

You can describe a [channel](index.md#channels) in the `routes`:`channel` section or in the separate `channels` section. You can use channels listed in the separate section in delivery routes, referring to them by name.

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
        # This ID will be substituted into the plugin_id label in monitoring.
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

You can describe a [pipe](index.md#pipes) in the `routes` section within the `channel`:`pipe` element or in the separate `pipes` section. You can use pipes from the separate section in channels, referring to them by name.

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
