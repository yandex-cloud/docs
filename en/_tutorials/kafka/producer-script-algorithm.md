The script works as follows:

1. Connect to the schema registry and pass to it the data format schemas for the key and value.
1. Generate the key and value based on the passed schemas.
1. Send a `message` consisting of the `key:meaning` pair to the messages topic. The schema versions are added to the message automatically.
