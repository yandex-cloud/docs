---
title: How to work with {{ si-full-name }}
description: In this article, you will learn how to work with {{ si-full-name }} in {{ yandex-cloud }}.
---

# Step-by-step guides for {{ si-name }}

## {{ sw-name }} {#workflows}

### Getting information about a workflow {#workflow-get-info}

* [{#T}](workflows/workflow/get-list.md)
* [{#T}](workflows/workflow/get-info.md)

### Managing a workflow {#workflow-control}

* [{#T}](workflows/workflow/create-constructor.md)
* [{#T}](workflows/workflow/create-yawl.md)
* [{#T}](workflows/workflow/update.md)
* [{#T}](workflows/workflow/network-add.md)
* [Adding a label](workflows/workflow/label-add.md)
* [Updating a label](workflows/workflow/label-update.md)
* [Deleting a label](workflows/workflow/label-delete.md)
* [{#T}](workflows/workflow/logs-read.md)
* [{#T}](workflows/workflow/logs-write.md)
* [{#T}](workflows/workflow/monitoring.md)
* [{#T}](workflows/workflow/delete.md)

### Workflow step constructor {#constructor}

* [{{ sf-short-name }}](workflows/constructor/functioncall.md)
* [{{ serverless-containers-name }}](workflows/constructor/containercall.md)
* [{{ postbox-short-name }}](workflows/constructor/postbox.md)
* [{{ tracker-name }}](workflows/constructor/tracker.md)
* [HTTP](workflows/constructor/httpcall.md)
* [gRPC](workflows/constructor/grpccall.md)
* [{{ objstorage-name }}](workflows/constructor/objectstorage.md)
* [{{ foundation-models-name }}](workflows/constructor/foundationmodelscall.md)
* [{{ ydb-name }}](workflows/constructor/ydbdocument.md)
* [{{ yds-name }}](workflows/constructor/yds.md)
* [{{ message-queue-name }}](workflows/constructor/ymq.md)
* [Yandex Disk](workflows/constructor/yadisk.md)
* [{{ sw-name }}](workflows/constructor/workflow.md)
* [AI agent](workflows/constructor/aiagent.md)
* [Switch](workflows/constructor/switch.md)
* [Foreach](workflows/constructor/foreach.md)
* [While](workflows/constructor/while.md)
* [Parallel](workflows/constructor/parallel.md)
* [No op](workflows/constructor/noop.md)
* [Fail](workflows/constructor/fail.md)
* [Success](workflows/constructor/success.md)
* [Wait](workflows/constructor/wait.md)
* [{#T}](workflows/constructor/setup-restart-policy.md)

### Getting workflow execution information {#execution-get-info}

* [{#T}](workflows/execution/get-list.md)
* [{#T}](workflows/execution/get-info.md)
* [{#T}](workflows/execution/get-history.md)

### Managing a workflow execution {#execution-control}

* [{#T}](workflows/execution/start.md)
* [{#T}](workflows/execution/stop.md)
* [{#T}](workflows/execution/terminate.md)

### Getting additional information {#get-additional-info}

* [Viewing operations with service resources](operation-logs.md)

## {{ er-name }} {#event-router}

### Getting information about a bus {#bus-get-info}

* [{#T}](eventrouter/bus/get-list.md)
* [{#T}](eventrouter/bus/get-info.md)

### Managing a bus {#bus-control}

* [{#T}](eventrouter/bus/create.md)
* [{#T}](eventrouter/bus/update.md)
* [Adding a label](eventrouter/bus/label-add.md)
* [Updating a label](eventrouter/bus/label-update.md)
* [Deleting a label](eventrouter/bus/label-delete.md)
* [{#T}](eventrouter/bus/delete.md)

### Sending events to a bus {#bus-deliver-data}

* [{#T}](eventrouter/bus/data-put.md)
* [{#T}](eventrouter/bus/data-send.md)

### Getting information about a connector {#connector-get-info}

* [{#T}](eventrouter/connector/get-list.md)
* [{#T}](eventrouter/connector/get-info.md)

### Managing a connector {#connector-control}

* [{#T}](eventrouter/connector/create-timer.md)
* [{#T}](eventrouter/connector/create-api-eventrouter.md)
* [{#T}](eventrouter/connector/create-yds.md)
* [{#T}](eventrouter/connector/create-message-queue.md)
* [{#T}](eventrouter/connector/update.md)
* [Adding a label](eventrouter/connector/label-add.md)
* [Updating a label](eventrouter/connector/label-update.md)
* [Deleting a label](eventrouter/connector/label-delete.md)
* [{#T}](eventrouter/connector/start.md)
* [{#T}](eventrouter/connector/stop.md)
* [{#T}](eventrouter/connector/delete.md)

### Getting information about a rule {#rule-get-info}

* [{#T}](eventrouter/rule/get-list.md)
* [{#T}](eventrouter/rule/get-info.md)

### Managing a rule {#rule-control}

* [{#T}](eventrouter/rule/create-api-gw.md)
* [{#T}](eventrouter/rule/create-functions.md)
* [{#T}](eventrouter/rule/create-logging.md)
* [{#T}](eventrouter/rule/create-data-streams.md)
* [{#T}](eventrouter/rule/create-message-queue.md)
* [{#T}](eventrouter/rule/create-serverless-containers.md)
* [{#T}](eventrouter/rule/create-workflows.md)
* [{#T}](eventrouter/rule/update.md)
* [{#T}](eventrouter/rule/add-target.md)
* [{#T}](eventrouter/rule/update-target.md)
* [{#T}](eventrouter/rule/delete-target.md)
* [Adding a label](eventrouter/rule/label-add.md)
* [Updating a label](eventrouter/rule/label-update.md)
* [Deleting a label](eventrouter/rule/label-delete.md)
* [{#T}](eventrouter/rule/enable.md)
* [{#T}](eventrouter/rule/disable.md)
* [{#T}](eventrouter/rule/delete.md)

### Managing resource access permissions {#access-rights}

* [{#T}](eventrouter/access-rights/role-list.md)
* [{#T}](eventrouter/access-rights/role-add.md)
* [{#T}](eventrouter/access-rights/role-revoke.md)

### Getting additional information {#get-additional-info}

* [Viewing operations with service resources](operation-logs.md)
