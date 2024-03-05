The script works as follows:

1. Connect to the schema registry and provide to it the data format schemas for the key and value.
1. Generate the key and value based on the schemas provided.
1. Send a `message` consisting of the `key:meaning` pair to the messages topic. The schema versions are added to the message automatically.
