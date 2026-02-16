Here is how the script works:

1. Connect to the `messages` topic and Confluent Schema Registry.
1. Continuously read messages arriving in the `messages` topic.
1. When receiving a message, request the required schemas from Confluent Schema Registry to parse the message.
1. Parse the message binary data based on the key and value schemas and display the result.
