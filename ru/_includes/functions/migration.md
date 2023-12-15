# Миграция в зону {{ region-id }}-d

{% note info %}

{% include [zone-c-deprecation](../vpc/zone-c-deprecation.md) %}

{% endnote %}

Если вы создавали [подсети](../../vpc/concepts/network.md#subnet) для [функций](../../functions/concepts/function.md) {{ sf-name }}, [контейнеров](../../serverless-containers/concepts/container.md) {{ serverless-containers-name }} или [API-шлюзов](../../api-gateway/concepts/index.md) {{ api-gw-name }} и запрашивали их использование через техническую поддержку, выполните следующие действия, чтобы перенести ресурсы из зоны `{{ region-id }}-c`:

1. В [облачной сети](../../vpc/concepts/network.md#network), в которой находятся подсети, [создайте](../../vpc/operations/subnet-create.md) новую подсеть.

    Требования:
    * Подсеть должна находиться в зоне `{{ region-id }}-d`.
    * Подсеть должна быть одна для всех функций, контейнеров и API-шлюзов.
    * В подсети не должны находиться никакие ресурсы, кроме функций, контейнеров и API-шлюзов.
1. Напишите в [техническую поддержку]({{ link-console-support }}) идентификатор созданной подсети.

Мы перенесем ваши ресурсы в указанную подсеть.
