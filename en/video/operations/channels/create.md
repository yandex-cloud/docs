---
title: How to create a channel in {{ video-full-name }}
description: Follow this guide to create a {{ video-full-name }} channel.
---

# Creating a channel

{% list tabs group=instructions %}

- {{ video-name }} interface {#console}

  {% include [create-channel](../../../_includes/video/create-channel.md) %}

- REST API {#api}

  Run this command:

  {% include [create-channel-rest-api-command](../../../_includes/video/create-channel-rest-api-command.md) %}

  Where:
  * `<IAM_token>`: [IAM token](../../../iam/concepts/authorization/iam-token.md) required for [authenticating](../../api-ref/authentication.md) with the {{ video-name }} API.
  * `<organization_ID>`: [ID](../../../organization/operations/organization-get-id.md) of the organization to create a {{ video-name }} channel in.
  * `<channel_name>`: Name of the channel you are creating in {{ video-name }}.

  {% include [create-channel-rest-api-output](../../../_includes/video/create-channel-rest-api-output.md) %}

- gRPC API {#grpc-api}

  Run this command:

  {% include [create-channel-grpc-api-command](../../../_includes/video/create-channel-grpc-api-command.md) %}

  Where:
  * `<IAM_token>`: [IAM token](../../../iam/concepts/authorization/iam-token.md) required for [authenticating](../../api-ref/authentication.md) with the {{ video-name }} API.
  * `<organization_ID>`: [ID](../../../organization/operations/organization-get-id.md) of the organization to create a {{ video-name }} channel in.
  * `<channel_name>`: Name of the channel you are creating in {{ video-name }}.

  {% include [create-channel-grpc-api-output](../../../_includes/video/create-channel-grpc-api-output.md) %}

{% endlist %}