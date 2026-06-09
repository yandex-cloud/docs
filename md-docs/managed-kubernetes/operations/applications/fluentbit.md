# Установка Fluent Bit с плагином для {{ cloud-logging-full-name }}

[Fluent Bit](https://www.fluentbit.io/) — многоплатформенный инструмент с открытым исходным кодом для сбора и обработки логов. Fluent Bit собирает, парсит и фильтрует сообщения из различных источников ввода и сохраняет их в хранилище. Затем сообщения поступают в маршрутизатор, который определяет, в какой выход их отправить. Для работы с различными источниками ввода и выходами используются плагины.

[Плагин для {{ cloud-logging-name }}](https://yandex.cloud/ru/marketplace/products/yc/fluent-bit) позволяет выгружать в сервис [{{ cloud-logging-full-name }}](../../../logging/index.md) логи, которые генерируются в кластере {{ managed-k8s-name }}, в том числе на уровне [подов](../../concepts/index.md#pod).

## Перед началом работы {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md), необходимый для работы Fluent Bit.
1. [Назначьте сервисному аккаунту роли](../../../iam/operations/sa/assign-role-for-sa.md) `logging.writer` и `monitoring.editor`.
1. [Создайте авторизованный ключ](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) для сервисного аккаунта и сохраните его в файл `sa-key.json`.

1. [Убедитесь](../connect/security-groups.md), что группы безопасности для кластера {{ managed-k8s-name }} и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте](../../../vpc/operations/security-group-add-rule.md) его.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. В [консоли управления]({{ link-console-main }}) выберите каталог.
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного кластера {{ managed-k8s-name }} и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [Fluent Bit с плагином для {{ cloud-logging-name }}](https://yandex.cloud/ru/marketplace/products/yc/fluent-bit) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:
   * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) (например, `fluent-bit-space`). Если вы оставите пространство имен по умолчанию, Fluent Bit может работать некорректно.
   * **Название приложения** — укажите название приложения.
   * **ID целевой лог-группы** — укажите [идентификатор лог-группы](../../../logging/operations/list.md), в которую будут сохраняться логи Fluent Bit.
   * **Идентификатор кластера** — укажите [идентификатор кластера {{ managed-k8s-name }}](../kubernetes-cluster/kubernetes-cluster-list.md).
   * **Ключ сервисной учетной записи для {{ cloud-logging-name }}** — вставьте содержимое файла `sa-key.json`.
1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.
1. [Установите kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).
1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Fluent Bit выполните команду:

   ```bash
   cat sa-key.json | helm registry login {{ registry }} --username 'json_key' --password-stdin && \
   helm pull oci://{{ mkt-k8s-key.yc_fluent-bit.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_fluent-bit.helmChart.tag }} \
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

* [{#T}](../../tutorials/fluent-bit-logging.md).

## См. также {#see-also}

* [Документация Fluent Bit](https://docs.fluentbit.io/manual).
* [Документация {{ cloud-logging-name }}](../../../logging/index.md).