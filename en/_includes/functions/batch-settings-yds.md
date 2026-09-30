Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}**, specify the following:

* Message batch size in bytes. The values may range from 1 B to 64 KB. The default value is 1 B.
* Maximum wait time. The values may range from 1 to 60 seconds. The default value is 1 second.

The trigger groups events within the specified wait time and sends them to the target. The total amount of data transmitted to connections may exceed the specified batch size if the data is transmitted as a single message. In all other cases, the amount of data does not exceed the batch size.
