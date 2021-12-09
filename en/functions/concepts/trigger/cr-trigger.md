# Trigger for {{ container-registry-name }}

[A trigger](../trigger/) for {{ container-registry-name }} activates a [function](../function.md) in {{ sf-name }} or a [container](../../../serverless-containers/concepts/container.md) in {{ serverless-containers-name }} when certain events happen to a [Docker image](../../../container-registry/concepts/docker-image.md) in {{ container-registry-full-name }}. The trigger must be in the same cloud as the [registry](../../../container-registry/concepts/registry.md) to the events it's subscribed to.

{% include [cr-trigger](../../../_includes/functions/cr-trigger.md) %}

