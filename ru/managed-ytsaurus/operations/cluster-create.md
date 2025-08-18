---
title: Создание кластера {{ ytsaurus-name }}
description: Каждый кластер {{ mtr-name }} состоит из набора компонентов {{ ytsaurus-name }}, каждый из которых может быть представлен в нескольких экземплярах. Экземпляры могут находиться в разных зонах доступности.
keywords:
  - создание кластера {{ ytsaurus-name }}
  - кластер {{ ytsaurus-name }}
  - '{{ ytsaurus-name }}'
---

# Создание кластера {{ ytsaurus-name }}

{% include [preview](../../_includes/managed-ytsaurus/note-preview.md) %}

Каждый [кластер](../../glossary/cluster.md) {{ myt-name }} состоит из набора компонентов {{ ytsaurus-name }}.

Компоненты, доступные для настройки:
* exec- и tablet-ноды;
* хранилища;
* HTTP- и RPC-прокси.

Служебные компоненты, недоступные для настройки:
* master-ноды;
* storage-ноды;
* system-ноды.

## Роли для создания кластера {#roles}

Для создания кластера {{ myt-name }} вашему аккаунту в {{ yandex-cloud }} нужны роли:

* [managed-ytsaurus.editor](../security/index.md#managed-ytsaurus-editor) — чтобы создать кластер;
* [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) — чтобы работать с [сетью](../../vpc/concepts/network.md#network) кластера.

О назначении ролей читайте в [документации {{ iam-full-name }}](../../iam/operations/roles/grant.md).

## Создать кластер {#create-cluster}

{% note info %}

Создание кластера {{ ytsaurus-name }} занимает длительное время. В зависимости от выбранной конфигурации время создания может занимать от одного часа.

{% endnote %}

В {{ myt-name }} можно создать [{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.cluster-kind-card_demo_title_4B7zu }}](#demo-cluster) с минимальной рабочей конфигурацией для ознакомления с сервисом или [{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.cluster-kind-card_production_title_dVEmq }}](#production-cluster) с ручной настройкой конфигурации кластера. 

### Demo-кластер {#demo-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include notitle [demo-cluster-create](../../_includes/managed-ytsaurus/demo-cluster-create.md) %}

{% endlist %}

### Production-кластер {#production-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер {{ myt-name }}.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-ytsaurus }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. Выберите **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.cluster-kind-card_production_title_dVEmq }}** для создания кластера с ручной настройкой конфигурации.
    1. В блоке **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.base-params-section_title_nfKo2 }}**:
        1. Задайте имя кластера. Имя должно быть уникальным в рамках каталога.
        1. (Опционально) Введите описание кластера.
        1. (Опционально) Создайте [метки](../../resource-manager/concepts/labels.md):
            1. Нажмите кнопку **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Введите метку в формате `ключ: значение`.
            1. Нажмите **Enter**.

    1. В блоке **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.net-settings-section_title_wo42X }}** выберите:
       * [Зону доступности](../../overview/concepts/geo-scope.md) для размещения кластера.
       * [Подсеть](../../vpc/operations/subnet-create.md).
       * (Опционально) [Группу безопасности](../../vpc/concepts/security-groups.md) для сетевого трафика кластера.

       {% note warning %}
       
       Сетевые настройки нельзя изменить после создания кластера.
       
       {% endnote %}

    1. В блоке **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.filestore-section_title_tYMR7 }}** нажмите кнопку **{{ ui-key.yacloud.common.add }}** и выберите тип, размер, количество дисков.

       От выбранного типа зависит, с каким шагом можно будет изменить размер диска:
          * Сетевые HDD- и SSD-диски — с шагом 1 ГБ.
          * Нереплицируемые SSD-диски — с шагом 93 ГБ.

       Хранилище с типом `HDD` является обязательным и добавлено по умолчанию. При необходимости отредактируйте количество и размер дисков.

       {% note warning %}
       
       Тип и размер диска для кластера {{ ytsaurus-name }} нельзя изменить после создания.
       
       {% endnote %}
    
    1. В блоке **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.exec-node-configuration-section_title_mfa54 }}** задайте:
       * количество нод;
       * [конфигурацию вычислительных ресурсов](../concepts/component-types.md#exec-node);
       * тип и размер хранилища, которое будет использоваться для выполнения заданий.

    1. В блоке **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.tablet-node-configuration-section_title_fHZeX }}** задайте:
       * количество нод;
       * [конфигурацию вычислительных ресурсов](../concepts/component-types.md#tablet-node).

       Для использования tablet-нод необходимо добавить хранилище с типом `SSD` или `Нереплицируемый SSD`.

       {% note warning %}
       
       Количество tablet-нод нельзя изменить после создания кластера.
       
       {% endnote %}
    
    1. В блоках **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.http-config-section_title_kMdci }}** и **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.rpc-config-section_title_tGACF }}** задайте количество прокси.

       {% note warning %}
       
       Количество proxy-нод нельзя изменить после создания кластера.
       
       {% endnote %}

    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
    1. Дождитесь, когда кластер будет готов к работе: его статус на панели {{ myt-name }} сменится на **Running**. Это может занять продолжительное время.

{% endlist %}