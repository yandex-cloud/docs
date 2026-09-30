Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}**, specify the following:

* **{{ ui-key.yacloud.serverless-functions.triggers.form.field_ymq-cutoff }}**. The values may range from 0 to 60 seconds. The default value is 10 seconds.
* **{{ ui-key.yacloud.serverless-functions.triggers.form.field_size }}**. The values may range from 1 to 1,000. The default value is 1.

The trigger groups events within the specified wait time and sends them to the target. The number of events cannot exceed the specified batch size.
