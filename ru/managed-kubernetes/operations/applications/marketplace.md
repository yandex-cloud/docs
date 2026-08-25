---
title: Основы работы с {{ marketplace-full-name }}
description: Следуя данной инструкции, вы научитесь работать с {{ marketplace-name }}.
---

# Основы работы с {{ marketplace-name }}

{{ managed-k8s-name }} позволяет использовать в кластерах приложения из [{{ marketplace-full-name }}](/marketplace).

## Получение списка установленных приложений {#list-apps}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/managed-kubernetes) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Выберите [кластер {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster).
  1. Нажмите на вкладку **{{ ui-key.yacloud.shared.layout.PageTabs.button_other_hnYwF }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и выберите **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.

{% endlist %}

## Получение подробной информации об установленном приложении {#app-info}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/managed-kubernetes) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Выберите кластер {{ managed-k8s-name }}.
  1. Нажмите на вкладку **{{ ui-key.yacloud.shared.layout.PageTabs.button_other_hnYwF }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и выберите **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
  1. В разделе **{{ ui-key.yacloud.k8s.cluster.marketplace.section_releases }}** нажмите на имя нужного вам приложения.

{% endlist %}

## Установка приложений {#install-apps}

{% note info %}

Для развертывания приложений необходима хотя бы одна [активная группа узлов](../node-group/node-group-create.md).

{% endnote %}

{% note warning %}

Создайте новое [пространство имен](../../concepts/index.md#namespace) для установки приложения, если не указано явно системное пространство имен. Если вы оставите пространство имен по умолчанию, приложение может работать некорректно.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/managed-kubernetes) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Выберите кластер {{ managed-k8s-name }}.
  1. Нажмите на вкладку **{{ ui-key.yacloud.shared.layout.PageTabs.button_other_hnYwF }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и выберите **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
  1. В разделе **Доступные для установки приложения** нажмите на имя нужного вам приложения.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
  1. Укажите настройки приложения и нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.

{% endlist %}

{% note info %}

Устанавливать приложения из {{ marketplace-name }} также можно [с помощью манифестов {{ TF }}](../apply-helm-provider.md).

{% endnote %}

## Редактирование приложения {#edit-app}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/managed-kubernetes) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Выберите кластер {{ managed-k8s-name }}.
  1. Нажмите на вкладку **{{ ui-key.yacloud.shared.layout.PageTabs.button_other_hnYwF }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и выберите **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
  1. В разделе **{{ ui-key.yacloud.k8s.cluster.marketplace.section_releases }}** в строке приложения, которое нужно изменить, нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Внесите нужные изменения и нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Удаление приложений {#delete-apps}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/managed-kubernetes) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Выберите кластер {{ managed-k8s-name }}.
  1. Нажмите на вкладку **{{ ui-key.yacloud.shared.layout.PageTabs.button_other_hnYwF }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и выберите **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
  1. В разделе **{{ ui-key.yacloud.k8s.cluster.marketplace.section_releases }}** в строке приложения, которое нужно удалить, нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.k8s.cluster.marketplace.button_release-uninstall }}**.
  1. В открывшемся окне подтвердите удаление.

{% endlist %}

## Сбор статистики {#statics}

Чтобы собирать статистику использования приложений, {{ marketplace-full-name }} просматривает пользовательские ресурсы во всех кластерах {{ k8s }}, в том числе [секреты](../../concepts/encryption.md#k8s-secrets-encryption) {{ k8s }}, которые имеют метку `owner: helm`. Для этого используются [сервисные аккаунты](../../../iam/concepts/users/service-accounts.md) `k8s-marketplace-analytics` и `k8s-marketplace-distributor`. Статистика собирается каждые 15 минут.

Если вы хотите запретить сбор статистики для кластера {{ k8s }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. [Перейдите]({{ link-console-main }}/link/managed-kubernetes) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Выберите кластер {{ managed-k8s-name }}.
  1. Нажмите на вкладку **{{ ui-key.yacloud.shared.layout.PageTabs.button_other_hnYwF }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и выберите **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
  1. В блоке **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/ban.svg) **{{ ui-key.yacloud.marketplace-v2.button_disallow-analytics-scanning }}**.

{% endlist %}