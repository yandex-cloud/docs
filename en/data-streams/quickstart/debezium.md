# Handling the Debezium change stream

[Debezium](https://debezium.io) is a service for capturing changes in databases (Change Data Capture) and sending them to other systems for processing. Using {{yds-full-name}}, you can capture these changes and send them to {{sf-name}}.

The architecture of the solution is shown below:
![debezium](../../_assets/data-streams/debezium.png)

## Setup {#setup}

To get a data stream, you need:

1. [Create a data stream](#create_stream) {{yds-full-name}}.
1. [Configure connection details](#credentials) for {{yds-full-name}}
1. [Configure and run](#debezium_server) Debezium Server.
1. [Configure the trigger](#sftrigger) in {{sf-name}} for data processing.

### Create a data stream {#create_stream}

Create a data stream named `debezium`. The procedure for creating a data stream is described in detail in [{{yds-full-name}} documentation](../../data-streams/operations/manage-streams.md).

### Configure {{yds-full-name}} connection details {#credentials}

{% include [create-environment](../../_includes/data-streams/create-environment.md) %}

### Configuring Debezium Server {#debezium_server}

{% include [debezium-setup](../../_includes/data-streams/debezium-setup.md) %}

## Configure the trigger in {{sf-name}} {#sftrigger}

Create a trigger in {{sf-name}} to the data stream {{yds-full-name}} the `debezium` that was created above.

The procedure for creating a trigger is described in detail in [{{sf-name}} documentation](../../functions/concepts/trigger/data-streams-trigger.md).

Notifications about all changes in the database will be sent to the {{sf-name}} trigger. In the trigger code, you can process these changes by implementing any necessary software processing.

