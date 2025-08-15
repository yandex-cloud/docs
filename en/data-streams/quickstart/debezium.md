
# Debezium Change Data Capture (CDC) stream processing

[Debezium](https://debezium.io) is a service for capturing database changes (Change Data Capture / CDC) and sending them for processing to other systems. With {{ yds-full-name }}, you can capture these changes and send them to {{ sf-name }}.

The following architecture is used in this solution:
![debezium](../../_assets/data-streams/debezium.png)

## Setup {#setup}
To enable a data stream, do the following:
1. [Create](#create_stream) a {{ yds-full-name }} stream.
1. Configure {{ yds-full-name }} [connection settings](#credentials).
1. [Set up and launch](#debezium_server) Debezium Server.
1. Set up a {{ sf-name }} [trigger](#sftrigger) for data processing.

### Creating a data stream {#create_stream}

Create a {{ yds-full-name }} stream named `debezium`. The data stream creation procedure is detailed in the [{{ yds-full-name }} documentation](../../data-streams/operations/manage-streams.md).

### Configuring {{ yds-full-name }} connection settings {#credentials}

{% include [create-environment](../../_includes/data-streams/create-environment.md) %}

### Setting up Debezium Server {#debezium_server}

In our example, we will show how Debezium interacts with {{ PG }}. For this setup, Debezium will be installed on the server already running {{ PG }}.

{% include [debezium-setup](../../_includes/data-streams/debezium-setup.md) %}

## Setting up a {{ sf-name }} trigger {#sftrigger}

Create a {{ sf-name }} trigger for the `debezium` stream you previously created in {{ yds-full-name }}. 

The trigger creation procedure is detailed in [{{ sf-name }} documentation](../../functions/concepts/trigger/data-streams-trigger.md).

This trigger will be used by {{ sf-name }}, receiving notifications about any database changes. You can then process these changes by implementing the required business logic in the trigger code.

