[Документация Yandex Cloud](../../index.md) > [Yandex Serverless Containers](../index.md) > [Пошаговые инструкции](index.md) > Управление контейнером > Миграция в зону ru-central1-d

# Миграция контейнеров в зону ru-central1-d

# Миграция между зонами

Чтобы перенести [подсети](../../vpc/concepts/network.md#subnet) для [функций](../../functions/concepts/function.md) Cloud Functions, [контейнеров](../concepts/container.md) Serverless Containers или [API-шлюзов](../../api-gateway/concepts/index.md) API Gateway в другую зону, выполните следующие действия:

1. В [облачной сети](../../vpc/concepts/network.md#network), в которой находятся подсети, [создайте](../../vpc/operations/subnet-create.md) новую подсеть.

    Требования:
    * Подсеть должна находиться в зоне, в которую вы хотите перенести ресурсы.
    * Подсеть должна быть одна для всех функций, контейнеров и API-шлюзов.
    * В подсети не должны находиться никакие ресурсы, кроме функций, контейнеров и API-шлюзов.
1. Напишите в [техническую поддержку](https://center.yandex.cloud/support) идентификатор созданной подсети.

Мы перенесем ваши ресурсы в указанную подсеть.