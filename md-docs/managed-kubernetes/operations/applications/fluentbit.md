# Установка Fluent Bit с плагином для Yandex Cloud Logging

[Fluent Bit](https://www.fluentbit.io/) — многоплатформенный инструмент с открытым исходным кодом для сбора и обработки логов. Fluent Bit собирает, парсит и фильтрует сообщения из различных источников ввода и сохраняет их в хранилище. Затем сообщения поступают в маршрутизатор, который определяет, в какой выход их отправить. Для работы с различными источниками ввода и выходами используются плагины.

[Плагин для Cloud Logging](https://yandex.cloud/ru/marketplace/products/yc/fluent-bit) позволяет выгружать в сервис [Yandex Cloud Logging](../../../logging/index.md) логи, которые генерируются в кластере Managed Service for Kubernetes, в том числе на уровне [подов](../../concepts/index.md#pod).

## Перед началом работы {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md), необходимый для работы Fluent Bit.
1. [Назначьте сервисному аккаунту роли](../../../iam/operations/sa/assign-role-for-sa.md) `logging.writer` и `monitoring.editor`.
1. [Создайте авторизованный ключ](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) для сервисного аккаунта и сохраните его в файл `sa-key.json`.

1. [Убедитесь](../connect/security-groups.md), что группы безопасности для кластера Managed Service for Kubernetes и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте](../../../vpc/operations/security-group-add-rule.md) его.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

## Установка с помощью Yandex Cloud Marketplace {#marketplace-install}

1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
1. Нажмите на имя нужного кластера Managed Service for Kubernetes и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **Marketplace**.
1. В разделе **Доступные для установки приложения** выберите [Fluent Bit с плагином для Cloud Logging](https://yandex.cloud/ru/marketplace/products/yc/fluent-bit) и нажмите кнопку **Перейти к установке**.
1. Задайте настройки приложения:
   * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) (например, `fluent-bit-space`). Если вы оставите пространство имен по умолчанию, Fluent Bit может работать некорректно.
   * **Название приложения** — укажите название приложения.
   * **ID целевой лог-группы** — укажите [идентификатор лог-группы](../../../logging/operations/list.md), в которую будут сохраняться логи Fluent Bit.
   * **Идентификатор кластера** — укажите [идентификатор кластера Managed Service for Kubernetes](../kubernetes-cluster/kubernetes-cluster-list.md).
   * **Ключ сервисной учетной записи для Cloud Logging** — вставьте содержимое файла `sa-key.json`.
1. Нажмите кнопку **Установить**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.
1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).
1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Fluent Bit выполните команду:

   ```bash
   cat sa-key.json | helm registry login cr.yandex --username 'json_key' --password-stdin && \
   helm pull oci://cr.yandex/yc-marketplace/yandex-cloud/fluent-bit/fluent-bit \
     --version 4.2.3-1 \
     --untar && \
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
     --set loggingGroupId=<идентификатор_лог-группы> \
     --set loggingFilter=<идентификатор_кластера> \
     --set-file auth.json=sa-key.json \
     fluentbit ./fluent-bit/
   ```

   Эта команда также создаст новое пространство имен, необходимое для работы Fluent Bit.

   Если вы укажете в параметре `namespace` пространство имен по умолчанию, Fluent Bit может работать некорректно. Рекомендуем указывать значение, отличное от всех существующих пространств имен (например, `fluent-bit-space`).

   {% note info %}
   
   Если вы используете версию Helm ниже 3.8.0, добавьте в начало команды строку `export HELM_EXPERIMENTAL_OCI=1 && \`, чтобы включить поддержку [Open Container Initiative](https://opencontainers.org/) (OCI) в клиенте Helm.
   
   {% endnote %}

## Примеры использования {#examples}

* [Настройка Fluent Bit для работы с Yandex Cloud Logging](../../tutorials/fluent-bit-logging.md).

## Полезные ссылки {#see-also}

* [Документация Fluent Bit](https://docs.fluentbit.io/manual).
* [Документация Cloud Logging](../../../logging/index.md).