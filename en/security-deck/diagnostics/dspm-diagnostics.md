---
title: Possible errors when using Data Security Posture Management (DSPM) in {{ sd-full-name }}
description: In this tutorial, you will learn about possible errors related to Data Security Posture Management (DSPM).
---

# Troubleshooting Data Security Posture Management (DSPM)

## Unable to list dataSource `Id` {#unable-to-list-datasource}
Failed to get the contents of the data source. It may have been deleted during scanning.


## Error while listing bucket `bucket-name`. Not found {#bucket-not-found}
The bucket existed at the time of discovering the resources but was deleted by the time the scan started or during the scan.


## Error while listing bucket `bucket-name`. Permission denied {#unable-to-access-bucket}
The service account performing the scan has no access to the specified bucket. Verify that the account has the [necessary roles](../security/dspm-roles.md), and access to the bucket is not restricted by [access policies](../../storage/security/policy.md).


## Error while listing folder, cloud or organization {#access-error}
The service account performing the scan has no access to the folder, cloud, or organization. Verify that the account has the [necessary roles](../../storage/security/index.md#service-roles).


## Failed to list resources {#unable-to-list-resources}
The scanning of user resources for the specified user will not be performed because this functionality is not available for the {{ yandex-360 }} Minimum [plan]({{ link-yandex }}/support/yandex-360/business/purchase/{{ lang }}/plans/payment-plans-ru).


## Error while listing user disk `user-name`. Unauthenticated {#wrong-credentials}
Invalid OAuth token or `client secret` specified for connection to Yandex Disk. Check the data source connection settings.


## Error while listing user disk `user-name`. Internal {#unable-to-list-datasource}
{{ yandex-360 }} does not allow connection to the organization administrator's disk.


## Failed to list user {#user-not-found}
Unable to find user. Make sure the user had previously logged in to Yandex Disk.


## Failed to list mailbox {#mailbox-not-found}
Unable to find user mailbox. Make sure the user had previously logged in to Yandex Mail.


## Failed to list virtual disk {#unable-to-access-disk}
Failed to get the contents of the shared disk. Check the data source connection settings.


## Failed to process parsing of data stream. It was skipped {#unable-to-parse-file}
Failure to recognize the file's contents.


## Failed to process parsing data stream. Unsupported format {#data-stream-process-error}
Scanning of the specified file types is not supported. For more information about supported scan areas, see the [Data source](../concepts/dspm.md#data-source) section.


## File contains unsupported image types {#unsupported-image-types}
Scanning of the specified image types is not supported. For more information about supported scan areas, see the [Data source](../concepts/dspm.md#data-source) section.


