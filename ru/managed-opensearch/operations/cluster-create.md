---
title: "Создание кластера {{ OS }}"
description: "Кластер управляемого сервиса {{ OS }} — это группа из нескольких связанных друг с другом хостов {{ OS }}."
keywords:
  - создание кластера OpenSearch
  - кластер OpenSearch
  - OpenSearch
---

# Создание кластера {{ OS }}

Кластер {{ mos-name }} — это группа из нескольких связанных друг с другом хостов {{ OS }} и [Dashboards]({{ os.docs }}/dashboards/index/). Кластер обеспечивает высокую производительность поиска путем распределения задач поиска и индексации по всем хостам кластера с ролью `DATA`. Подробнее о ролях в кластере см. в разделе [Роли хостов](../concepts/host-roles.md).

Доступные типы диска [зависят](../concepts/storage.md) от выбранного [класса хостов](../concepts/instance-types.md).

Подробнее см. в разделе [{#T}](../concepts/index.md).

## Создать кластер {#create-cluster}

При создании кластера для каждой [группы хостов](../concepts/host-groups.md) указываются отдельные параметры.

{% list tabs %}

- Консоль управления

  Чтобы создать кластер:

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}**:

      1. Введите имя кластера. Оно должно быть уникальным в рамках каталога.
      1. (Опционально) Введите описание кластера.
      1. Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):

          * `PRODUCTION` — для стабильных версий ваших приложений.
          * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.

      1. Выберите версию {{ OS }}.
      1. Выберите [плагины](plugins.md#supported-plugins), которые нужно установить в кластер.

  
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите облачную сеть для размещения кластера и группы безопасности для сетевого трафика кластера. Может потребоваться дополнительная [настройка групп безопасности](connect.md#security-groups) для того, чтобы можно было подключаться к кластеру.


  1. В блоке **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_virtual-node-group }} 1** задайте конфигурацию [группы хостов](../concepts/host-groups.md) `{{ OS }}`:

      1. Выберите тип группы хостов: `{{ OS }}`.

      1. Введите имя группы хостов. Оно должно быть уникальным в кластере.

      1. Выберите [роли хостов](../concepts/host-roles.md) `DATA` и `MANAGER`.

      1. Выберите платформу, тип и класс хостов.

          Класс хостов определяет технические характеристики виртуальных машин, на которых будут развернуты ноды {{ OS }}. Все доступные варианты перечислены в разделе [Классы хостов](../concepts/instance-types.md).

      1. Выберите [тип диска](../concepts/storage.md) и объем хранилища, который будет использоваться для данных.

          {% include [storages-step-settings](../../_includes/mdb/settings-storages-no-broadwell.md) %}

      1. Укажите расположение хостов по зонам доступности и подсетям.

      1. Выберите количество создаваемых хостов.

      
      1. Включите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**, если вы хотите, чтобы к хостам можно было [подключаться](connect.md) через интернет.

          {% note tip %}

          Не рекомендуется включать публичный доступ для хостов с ролью `MANAGER`, т. к. это может быть небезопасно.

          {% endnote %}


      {% note warning %}

      Изменить конфигурацию хостов после создания кластера можно только с помощью [API](../../glossary/rest-api.md), однако при необходимости вы сможете создать новую группу хостов с другой конфигурацией.

      {% endnote %}

  1. При необходимости задайте конфигурацию [группы хостов](../concepts/host-groups.md) `Dashboards` в блоке **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_virtual-node-group }} 2**:

      1. Выберите платформу, тип и класс хостов.
      1. Настройте хранилище по аналогии с хостами `{{ OS }}`.
      1. Укажите расположение хостов по зонам доступности и подсетям.
      1. Выберите количество создаваемых хостов.
        
      
      1. Включите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**, если вы хотите, чтобы к хостам можно было [подключаться](connect.md) через интернет.

          {% include [mos-tip-public-dashboards](../../_includes/mdb/mos/public-dashboards.md) %}


  1. При необходимости добавьте еще одну или несколько групп хостов, нажав кнопку **{{ ui-key.yacloud.opensearch.cluster.node-groups.action_add-virtual-node-group }}**.

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_service-settings }}**:

      1. Укажите пароль для пользователя `admin`.

          {% include [Superuser](../../_includes/mdb/mos/superuser.md) %}

      1. При необходимости задайте дополнительные настройки кластера:

          {% include [Дополнительные настройки кластера](../../_includes/mdb/mos/extra-settings.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.

- API

  Чтобы создать кластер, воспользуйтесь методом REST API [create](../api-ref/Cluster/create.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Create](../api-ref/grpc/cluster_service.md#Create) и передайте в запросе:

  * Идентификатор каталога, в котором должен быть размещен кластер, в параметре `folderId`.
  * Имя кластера в параметре `name`.
  * Версию {{ OS }} в параметре `configSpec.version`.
  * Пароль пользователя `admin` в параметре `configSpec.adminPassword`.
  * Конфигурацию одной или нескольких групп хостов с [ролями](../concepts/host-roles.md) `DATA` и `MANAGER` (опционально) в параметре `configSpec.opensearchSpec.nodeGroups`.
  * Конфигурацию одной или нескольких групп хостов с [ролью](../concepts/host-roles.md#dashboards) `DASHBOARDS` в параметре `configSpec.dashboardsSpec.nodeGroups`.
  * Список плагинов в параметре `configSpec.opensearchSpec.plugins`.
  * Настройки доступа из других сервисов в параметре `configSpec.access`.
  * Идентификатор сети в параметре `networkId`.

  
  * Идентификаторы групп безопасности в параметре `securityGroupIds`. Может потребоваться дополнительная [настройка групп безопасности](connect.md#security-groups) для того, чтобы можно было подключаться к кластеру.
  * Идентификатор [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), используемого для работы с кластером, в параметре `serviceAccountId`.


  * Настройки защиты от удаления кластера в параметре `deletionProtection`.

      {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-db.md) %}

  * Настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров) в параметре `maintenanceWindow`.

{% endlist %}
