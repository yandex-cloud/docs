---
title: Ресурсы, на которые можно назначать роли в {{ iam-full-name }}
description: Из статьи вы узнаете, на какие ресурсы {{ yandex-cloud }} можно назначить роли.
---

# Ресурсы, на которые можно назначать роли


Для управления правами доступа в {{ yandex-cloud }} используются [роли](./roles.md).

{% include [operate-via-roles-paragraph](../../../_includes/iam/operate-via-roles-paragraph.md) %}

## Наследование прав доступа {#permission-inheritance}

Роли [назначаются](../../operations/roles/grant.md) на [ресурсы](../../../resource-manager/concepts/resources-hierarchy.md) {{ yandex-cloud }}. Для ресурсов большинства [сервисов](../../../overview/concepts/services.md) {{ yandex-cloud }} действует стандартный механизм [наследования](../../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) прав доступа:

{% include [basic-role-inheritance-chain](../../../_includes/basic-role-inheritance-chain.md) %}

### Исключения из правил наследования прав доступа {#inheritance-exceptions}

Несколько сервисов {{ yandex-cloud }} не подчиняются стандартному механизму наследования ролей. Для этих сервисов роли должны быть назначены пользователям отдельно:

* [{{ billing-name }}](../../../billing/security/index.md);
* [{{ tracker-full-name }}]({{ link-tracker-cloudless }}access);
* [{{ datalens-full-name }}](../../../datalens/security/index.md);
* [{{ wiki-full-name }}]({{ link-wiki-cloudless }}/page-management/access-setup);
* [{{ forms-full-name }}]({{ link-forms-cloudless }}/access);
* [{{ ml-platform-full-name }}](../../../datasphere/security/index.md);
* [{{ speechsense-full-name }}](../../../speechsense/security/index.md).

## Гранулярное назначение ролей {#granular-assignment}

Некоторые сервисы {{ yandex-cloud }} позволяют назначать роли более гранулярно — на отдельные ресурсы сервиса. Например, в [{{ compute-full-name }}](../../../compute/index.yaml) роли можно назначать на такие ресурсы:

{% include notitle [compute-resources](../../../_includes/iam/resources-with-access-control/compute.md) %}

При этом в некоторых случаях гранулярное назначение ролей на ресурсы может быть недоступно для некоторых [интерфейсов](../../../overview/concepts/interfaces.md). Например, роль на [группу виртуальных машин](../../../compute/concepts/instance-groups/index.md) в {{ compute-name }} можно назначить с помощью [консоли управления]({{ link-console-main }}), [{{ yandex-cloud }} CLI](../../../cli/index.yaml) и [API](../../../api-design-guide/index.yaml), но нельзя с помощью [{{ TF }}](../../../terraform/index.yaml).

Подробную информацию о ресурсах, на которые можно назначить роли, доступных ролях и особенностях их назначения смотрите на странице **Управление доступом** в документации нужного сервиса. Например: [{#T}](../../../compute/security/index.md).