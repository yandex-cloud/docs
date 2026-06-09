# Основы работы с Cloud Marketplace

Managed Service for Kubernetes позволяет использовать в кластерах приложения из [Yandex Cloud Marketplace](https://yandex.cloud/ru/marketplace).

## Получение списка установленных приложений {#list-apps}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Marketplace**.

{% endlist %}

## Получение подробной информации об установленном приложении {#app-info}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Marketplace**.
  1. В разделе **Установленные приложения** нажмите на имя нужного вам приложения.

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

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Marketplace**.
  1. В разделе **Доступные для установки приложения** нажмите на имя нужного вам приложения.
  1. В открывшемся окне нажмите кнопку **Использовать**.
  1. Укажите настройки приложения и нажмите кнопку **Установить**.

{% endlist %}

{% note info %}

Устанавливать приложения из Cloud Marketplace также можно [с помощью манифестов Terraform](../apply-helm-provider.md).

{% endnote %}

## Редактирование приложения {#edit-app}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Marketplace**.
  1. В разделе **Установленные приложения** нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) в строке приложения, которое требуется изменить.
  1. В открывшемся меню нажмите кнопку **Редактировать**.
  1. Внесите нужные изменения и нажмите кнопку **Сохранить**.

{% endlist %}

## Удаление приложений {#delete-apps}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Marketplace**.
  1. В разделе **Установленные приложения** нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) в строке приложения, которое требуется удалить.
  1. В открывшемся меню нажмите кнопку **Удалить**.

{% endlist %}

## Сбор статистики {#statics}

Чтобы собирать статистику использования приложений, Yandex Cloud Marketplace просматривает пользовательские ресурсы во всех кластерах Kubernetes, в том числе [секреты](../../concepts/encryption.md#k8s-secrets-encryption) Kubernetes, которые имеют метку `owner: helm`. Для этого используются [сервисные аккаунты](../../../iam/concepts/users/service-accounts.md) `k8s-marketplace-analytics` и `k8s-marketplace-distributor`. Статистика собирается каждые 15 минут.

Если вы хотите запретить сбор статистики для кластера Kubernetes:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Marketplace**.
  1. В правом верхнем углу нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/ban.svg) **Запретить Marketplace собирать статистику**.

{% endlist %}