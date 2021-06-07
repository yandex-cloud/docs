# Overview

{{ at-full-name }} allows you to collect audit logs about events happening to {{ yandex-cloud }} resources and load these logs to the user's bucket for further analysis or export.

{{ yandex-cloud }} services whose audit logs {{ at-name }} collects:

* {{ compute-name }}.
* {{ iam-name }}.
* {{ kms-name }}.
* {{ objstorage-name }}.
* {{ resmgr-name }}.
* {{ vpc-name }}.

The following events are logged:

* Modifying operations with a service resource.
* Issuing an IAM token for a federated account.

## Trail {#trail}

{% note info %}

The resource won't be visible at the [Preview stage](../../overview/concepts/launch-stages.md) stage. For information about how to create a resource, see [{#T}](../quickstart.md).

{% endnote %}

A trail is a {{ at-full-name }} resource responsible for collecting audit logs and uploading them to {{ objstorage-name }}.

You can specify what event types and source services need to be logged. Events are collected from resources in the same cloud as the trail. Events are buffered by the {{ at-name }} service and are saved to a JSON file once every 5 minutes in the specified bucket. For information about the file format, see [{#T}](format.md).

## Current service limitations {#known-restrictions}

For more information about service limits, see [{#T}](limits.md).

