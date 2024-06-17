# Основы работы с {{ marketplace-name }}


{{ managed-k8s-name }} позволяет использовать в кластерах приложения из [{{ marketplace-full-name }}](/marketplace).

{% note info %}

Работа с {{ marketplace-name }} находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}

## Получение списка установленных приложений {#list-apps}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.

{% endlist %}

## Получение подробной информации об установленном приложении {#app-info}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
  1. В разделе **{{ ui-key.yacloud.k8s.cluster.marketplace.section_releases }}** нажмите на имя нужного вам приложения.

{% endlist %}

## Установка приложений {#install-apps}

{% note info %}

Для развертывания приложений необходима хотя бы одна [активная группа узлов](../node-group/node-group-create.md).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
  1. В разделе **Доступные для установки приложения** нажмите на имя нужного вам приложения.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
  1. Укажите настройки приложения и нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.

{% endlist %}

## Редактирование приложения {#edit-app}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
  1. В разделе **{{ ui-key.yacloud.k8s.cluster.marketplace.section_releases }}** нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) в строке приложения, которое требуется изменить.
  1. В открывшемся меню нажмите кнопку **{{ ui-key.yacloud.common.edit }}**.
  1. Внесите нужные изменения и нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Удаление приложений {#delete-apps}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
  1. В разделе **{{ ui-key.yacloud.k8s.cluster.marketplace.section_releases }}** нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) в строке приложения, которое требуется удалить.
  1. В открывшемся меню нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_release-uninstall }}**.

{% endlist %}