You can set up Maven access in two ways:

* In your cluster's [security group](../../vpc/concepts/security-groups.md), allow network access to the [Maven Central](https://repo.maven.apache.org/maven2/) repository.
* Configure an [alternative Maven repository](https://maven.apache.org/guides/mini/guide-mirror-settings.html) and allow traffic to it in the cluster [security group](../../vpc/concepts/security-groups.md).
