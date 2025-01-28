# Uploading {{ at-full-name }} audit logs to KUMA SIEM

In this tutorial, you will create an {{ at-short-name }} [trail](../../audit-trails/concepts/trail.md) to provide audit logs to the [KUMA](https://www.kaspersky.com/enterprise-security/unified-monitoring-and-analysis-platform) collector.

The [solution](https://support.kaspersky.com/help/KUMA/3.2/en-US/290821.htm) described in the tutorial works as follows:

1. A trail uploads logs to an {{ objstorage-full-name }} [bucket](../../storage/concepts/bucket.md) with [encryption](../../storage/concepts/encryption.md) enabled.
1. The bucket is mounted as a part of the [file system](https://{{ lang }}.wikipedia.org/wiki/Filesystem_in_Userspace) on the server with the KUMA collector installed.
1. The KUMA collector receives event data from the mounted bucket and forwards it for processing.

You can use the following tools to create an audit log upload infrastructure:
