---
title: How to work with {{ sf-full-name }}
description: In this article, you will learn how to work with {{ sf-full-name }} in {{ yandex-cloud }}. Find out how to manage a function (create, modify, invoke, and delete a function) and a trigger (create a timer or trigger for {{ message-queue-name }}, {{ iot-full-name }}, {{ container-registry-name }}).
---

# Step-by-step guides for {{ sf-name }}

* [{#T}](function-sa.md)
* [{#T}](database-connection.md)

## Getting information about a function {#function-info}

* [{#T}](function/function-list.md)
* [{#T}](function/version-list.md)
* [{#T}](function/function-info.md)
* [{#T}](function/version-info.md)

## Managing rights to access functions {#function-access-rights}

* [{#T}](function/function-public.md)
* [{#T}](function/function-private.md)
* [{#T}](function/role-list.md)
* [{#T}](function/role-add.md)
* [{#T}](function/role-revoke.md)

## Creating a function {#create-function}

* [{#T}](function/function-create.md)
* [{#T}](function/version-manage.md)

## Invoking a function {#function-invoke}

* [{#T}](function/function-invoke.md)
* [{#T}](function/function-invoke-async.md)
* [{#T}](function/auth.md)

## Managing functions {#function-manage}

* [Updating a name](function/name-update.md)
* [Updating a description](function/description-update.md)
* [Viewing scaling settings](function/scaling-settings-list.md)
* [Adding scaling settings](function/scaling-settings-add.md)
* [Deleting scaling settings](function/scaling-settings-delete.md)
* [Adding environment variables](function/environment-variables-add.md)
* [{#T}](function/network-add.md)
* [{#T}](function/lockbox-secret-transmit.md)
* [Allocating memory for the /tmp directory](function/allocate-memory-tmp.md)
* [Mounting a bucket](function/mount-bucket.md)
* [Adding a tag](function/tag-add.md)
* [Removing a tag](function/tag-delete.md)
* [Adding a label](function/label-add.md)
* [Updating a label](function/label-update.md)
* [Removing a label](function/label-delete.md)
* [Viewing monitoring charts](function/function-monitoring.md)
* [Viewing logs](function/function-logs.md)
* [Logging data to the execution log](function/logs-write.md)
* [{#T}](function/migration.md)
* [{#T}](function/function-delete.md)


## Getting information about a trigger {#trigger-info}

* [Getting a list of triggers](trigger/trigger-list.md)
* [Getting information about a trigger](trigger/trigger-info.md)

## Creating a trigger {#trigger-create}

* [Creating a timer](trigger/timer-create.md)
* [Creating a trigger for {{ message-queue-name }}](trigger/ymq-trigger-create.md)
* [Creating a trigger for {{ objstorage-name }}](trigger/os-trigger-create.md)
* [Creating a trigger for {{ container-registry-name }}](trigger/cr-trigger-create.md)
* [Creating a trigger for {{ cloud-logging-name }}](trigger/cloud-logging-trigger-create.md)
* [Creating a trigger for {{ iot-name }} (device)](trigger/iot-core-trigger-create.md)
* [Creating a trigger for {{ iot-name }} (broker)](trigger/iot-core-trigger-broker-create.md)
* [Creating a trigger for budgets](trigger/budget-trigger-create.md)
* [Creating a trigger for {{ yds-name }}](trigger/data-streams-trigger-create.md)
* [Creating an email trigger](trigger/mail-trigger-create.md)

## Managing triggers {#trigger-manage}

* [Updating a trigger](trigger/trigger-update.md)
* [Adding a label](trigger/label-add.md)
* [Updating a label](trigger/label-update.md)
* [Removing a label](trigger/label-delete.md)
* [Viewing monitoring charts](trigger/trigger-monitoring.md)
* [Deleting a trigger](trigger/trigger-delete.md)
