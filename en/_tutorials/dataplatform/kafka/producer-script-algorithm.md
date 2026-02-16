Here is how the script works:

1. Connect to the schema registry and send the key and value data format schemas.
1. Generate the key and value based on the schemas you sent.
1. Send a message containing a `key:value` pair to the `messages` topic. The system will automatically add the schema versions to your message.
