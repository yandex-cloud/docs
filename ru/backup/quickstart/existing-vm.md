---
title: Как начать работать с {{ backup-full-name }} на существующей ВМ
description: Следуя данной инструкции, вы сможете подключиться к {{ backup-name }} и начать работать с сервисом на существующих виртуальных машинах.
---

# Как начать работать с {{ backup-full-name }} на существующей ВМ


{% include [quickstart-billing-paragraph](../../_includes/backup/quickstart-billing-paragraph.md) %}

Убедитесь также, что у вас есть [виртуальная машина](../../compute/concepts/vm.md) {{ compute-full-name }}. В этой инструкции вы подключите к {{ backup-name }} виртуальную машину под управлением ОС [Linux](https://ru.wikipedia.org/wiki/Linux). Если у вас нет виртуальной машины, воспользуйтесь инструкцией [{#T}](./new-vm.md).

{% include [quickstart-paid-resources](../../_includes/backup/quickstart-paid-resources.md) %}

Чтобы начать работать с {{ backup-name }}:

1. [Подготовьте инфраструктуру](#deploy-infrastructure).
1. [Активируйте {{ backup-name }}](#activate-provider).
1. [Установите агент {{ backup-name }}](#connect-vm).
1. [Привяжите ВМ к политике резервного копирования](#add-policy).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте инфраструктуру {#deploy-infrastructure}

1. В [облачной сети](../../vpc/concepts/network.md#network) с подключаемой к {{ backup-name }} виртуальной машиной [создайте](../../vpc/operations/security-group-create.md) группу безопасности со следующими [правилами](../../vpc/concepts/security-groups.md#security-groups-rules) для исходящего трафика:

    {% include [outgoing-rules](../../_includes/backup/outgoing-rules.md) %}

1. Назначьте подключаемой к {{ backup-name }} ВМ созданную [группу безопасности](../../vpc/concepts/security-groups.md):

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      {% include [attach-sg-to-vm-console](../../_includes/backup/operations/attach-sg-to-vm-console.md) %}

    {% endlist %}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему [роль](../security/index.md#backup-editor) `backup.editor`. 
1. Привяжите к подключаемой к {{ backup-name }} ВМ созданный [сервисный аккаунт](../../iam/concepts/users/service-accounts.md):

    {% include [connect-sa-to-vm-intro](../../_includes/connect-sa-to-vm-intro.md) %}

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      {% include [connect-sa-to-vm-console](../../_includes/backup/operations/connect-sa-to-vm-console.md) %}

    {% endlist %}

## Активируйте {{ backup-name }} {#activate-provider}

{% include [quickstart-activate-provider](../../_includes/backup/quickstart-activate-provider.md) %}

## Установите агент {{ backup-name }} {#connect-vm}

{% include [install-agent-linux](../../_includes/backup/operations/install-agent-linux.md) %}

## Привяжите ВМ к политике резервного копирования {#add-policy}

{% include [quickstart-attach-to-policy-after-agent-setup](../../_includes/backup/quickstart-attach-to-policy-after-agent-setup.md) %}

1. {% include [quickstart-check-vm-agent-status](../../_includes/backup/quickstart-check-vm-agent-status.md) %}
1. {% include [quickstart-attach-vm-to-policy](../../_includes/backup/quickstart-attach-vm-to-policy.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. Если для ВМ были созданы резервные копии, [удалите](../operations/backup-vm/delete.md) их.
1. [Удалите](../operations/delete-vm.md) ВМ из {{ backup-name }}.

## Что дальше {#what-is-next}

* [Узнайте об особенностях сервиса](../concepts/index.md)
* [Посмотрите другие инструкции по работе с сервисом](../operations/index.md)

#### См. также {#see-also}

{% include [see-also-snapshot](../../_includes/backup/see-also-snapshot.md) %}

* [{#T}](./index.md)