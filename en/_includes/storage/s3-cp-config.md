{% cut "Configuring parameters for the `yc storage s3 cp` command" %}

You can set the following parameters for the `yc storage s3 cp` command:

* `s3.max-queue-size`: Maximum number of issues per queue. The default value is `1,000`.
* `s3.max-concurrent-requests`: Maximum number of simultaneous requests. The default value is `10`.
* `s3.multipart-threshold`: Object threshold size to trigger a multipart upload if exceeded. The default value is `8MB`.
* `s3.multipart-chunksize`: Size of parts the object will be split into in a multipart upload. The default value is `8MB`.

To set these parameters, use the `yc config set <parameter> <value>` command.

{% endcut %}