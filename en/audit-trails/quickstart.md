# Getting started with {{ at-name }}

To enable the collection of audit logs, contact [technical support]({{ link-console-support }}). Specify in your request:

1. The ID of the folder where you want to locate the [trail](concepts/index.md#trail).

    The resource won't be visible at the [Preview stage](../overview/concepts/launch-stages.md).

1. The name of the bucket that audit logs are uploaded to.

1. The path to the folder in the bucket that audit log files are uploaded to.

1. If you want to enable audit logs only for certain services, specify these services.

{% cut "Example of contacting" %}

```text
1. The folder ID is b1g8jm1ska9r0ngh8ryk.
2. The bucket name is backet-for-audit-logs.
3. The folder path in the bucket is folder/for-logs.
4. {{ compute-name }} and {{ iam-name }} service logs.
```

{% endcut %}

Upon your request, a trail will be created and the audit logs will start to be uploaded to the bucket.

#### What's next

* Learn more about the [audit log format](concepts/format.md).

