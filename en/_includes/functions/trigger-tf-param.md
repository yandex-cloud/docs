* `mail`: Trigger parameters:

   * `attachments_bucket_id`: Name of the bucket to save email attachments to. This is an optional parameter.
   * `service_account_id`: ID of the service account authorized to upload objects to the {{ objstorage-name }} bucket. This is an optional parameter.
   * `batch_cutoff`: Maximum wait time. This is an optional parameter. The values may range from 1 to 60 seconds. The default value is 1 second. The trigger groups messages for a period not exceeding `batch-cutoff` and sends them to a function. The number of messages cannot exceed `batch-size`.
   * `batch_size`: Message batch size. This is an optional parameter. The values may range from 1 to 10. The default value is 1.

* `dlq`: Dead-letter queue parameters:

   * `queue_id`: Dead-letter queue ID. This is an optional parameter.
   * `service_account_id`: Service account with write permissions to the dead-letter queue. This is an optional parameter.
