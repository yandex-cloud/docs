```bash
aws sns create-topic \
  --name <topic_name> \
  --attributes "{\"SQSServiceAccountId\":\"<service_account_ID>\"}"
```

Where:

* `name`: Topic name, which can be any name unique within {{ cns-name }}.

{% include [sqs-service-account-attribute](sqs-service-account-attribute.md) %}

Learn more about the `aws sns create-topic` command in [this AWS guide](https://docs.amazonaws.cn/en_us/sns/latest/dg/sns-create-topic.html).
