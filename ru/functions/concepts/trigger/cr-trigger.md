# Триггер для {{ container-registry-name }}

[Триггер](../trigger/) для {{ container-registry-name }} запускает [функцию](../function.md) {{ sf-name }} или [контейнер](../../../serverless-containers/concepts/container.md) {{ serverless-containers-name }}, когда с [Docker-образом](../../../container-registry/concepts/docker-image.md) {{ container-registry-full-name }} происходят определенные события. Триггер должен находиться в одном облаке с [реестром](../../../container-registry/concepts/registry.md), на события которого он подписан.

{% include [cr-trigger](../../../_includes/functions/cr-trigger.md) %}