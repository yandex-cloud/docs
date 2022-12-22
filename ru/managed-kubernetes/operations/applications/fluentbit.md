# Установка Fluent Bit с плагином для {{ cloud-logging-name }}

[Fluent Bit ](https://www.fluentbit.io/) — многоплатформенный инструмент с открытым исходным кодом для сбора и обработки логов. Fluent Bit собирает, парсит и фильтрует сообщения из различных источников ввода и сохраняет их в хранилище. Затем сообщения поступают в маршрутизатор, который определяет, в какой выход их отправить. Для работы с различными источниками ввода и выходами используются плагины.

[Плагин для {{ cloud-logging-name }}](/marketplace/products/yc/fluent-bit) позволяет выгружать в сервис {{ cloud-logging-full-name }} логи, которые генерируются в кластере {{ managed-k8s-name }}, в том числе на уровне подов.

## Создание сервисного аккаунта {#create-sa-key}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md), необходимый для работы Fluent Bit.
1. [Назначьте ему роли](../../../iam/operations/sa/assign-role-for-sa.md) `logging.writer` и `monitoring.editor`.
1. Создайте [авторизованный ключ](../../../iam/operations/sa/create-access-key.md) и сохраните его в файл `sa-key.json`.

## Установка с помощью {{ marketplace-full-name }} {#install-fb-marketplace}

1. Перейдите на страницу каталога и выберите сервис **{{ managed-k8s-name }}**.
1. Нажмите на имя нужного кластера и выберите вкладку **{{ marketplace-short-name }}**.
1. В разделе **Доступные для установки приложения** выберите [Fluent Bit с плагином для {{ cloud-logging-name }}](/marketplace/products/yc/fluent-bit) и нажмите кнопку **Использовать**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) или создайте новое.
   * **Название приложения** — укажите название приложения.
   * **ID целевой лог-группы** — укажите [идентификатор лог-группы](../../../logging/operations/list.md), в которую будут сохраняться логи Fluent Bit.
   * **Идентификатор кластера** — укажите [идентификатор кластера](../kubernetes-cluster/kubernetes-cluster-list.md).
   * **Ключ сервисной учетной записи для {{ cloud-logging-name }}** — вставьте содержимое файла `sa-key.json`.
1. Нажмите кнопку **Установить**.

## Установка с помощью Helm-чарта {#install-fb-helm}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Fluent Bit выполните команду:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   cat sa-key.json | helm registry login {{ registry }} --username 'json_key' --password-stdin && \
   helm pull oci://{{ registry }}/yc-marketplace/yandex-cloud/fluent-bit/fluent-bit-cloud-logging \
     --version <версия Fluent Bit> \
     --untar && \
   helm install \
     --namespace <пространство имен> \
     --create-namespace \
     --set loggingGroupId=<идентификатор лог-группы> \
     --set loggingFilter=<идентификатор кластера> \
     --set-file auth.json=sa-key.json \
     fluentbit ./fluent-bit-cloud-logging/
   ```

   Эта команда также создаст новое пространство имен, необходимое для работы Fluent Bit.

## См. также {#see-also}

* [Документация Fluent Bit](https://docs.fluentbit.io/manual).
* [Документация {{ cloud-logging-name }}](../../../logging/).