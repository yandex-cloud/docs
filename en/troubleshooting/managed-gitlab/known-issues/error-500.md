# Resolving an HTTP 500 error in {{ mgl-name }}


## Issue description {#issue-description}

When trying to access a {{ mgl-name }} instance, you see an `HTTP 500` or `HTTP 502` error message.

## Solution {#issue-resolution}

This issue usually occurs when a {{ mgl-name }} instance runs out of free disk space. Container images and build artifacts often take up a significant amount of disk space.

To track the amount of free disk space on your {{ mgl-name }} instance and avoid running out of it moving forward, you may want to set up monitoring for your {{ mgl-name }} instance by following [this guide](../../../managed-gitlab/operations/instance/monitoring.md) (please note that this feature is still [at the Preview stage](../../../overview/concepts/launch-stages.md)).

{% note info %}

When creating a {{ mgl-name }} instance, **{{ ui-key.yacloud.gitlab.field_delete-untagged }}** is enabled by default. This option enables periodic deletion of images not referenced by build manifests.

{% endnote %}

To resolve this issue, you need to run the disk partition cleanup as per [this guide](../../../managed-gitlab/operations/instance/clean-up-disk-space.md).
Alternatively, you can [increase the {{ mgl-name }} instance’s disk size](../../../managed-gitlab/operations/instance/instance-update.md).

If this does not help, [create a support ticket]({{ link-console-support }}). 
When creating a ticket, specify the ID of the problematic {{ mgl-name }} instance and supply the screen capture with error details.
