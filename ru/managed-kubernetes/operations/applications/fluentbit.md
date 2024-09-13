# Установка Fluent Bit с плагином для {{ cloud-logging-name }}


[Fluent Bit](https://www.fluentbit.io/) — многоплатформенный инструмент с открытым исходным кодом для сбора и обработки логов. Fluent Bit собирает, парсит и фильтрует сообщения из различных источников ввода и сохраняет их в хранилище. Затем сообщения поступают в маршрутизатор, который определяет, в какой выход их отправить. Для работы с различными источниками ввода и выходами используются плагины.

[Плагин для {{ cloud-logging-name }}](/marketplace/products/yc/fluent-bit) позволяет выгружать в сервис [{{ cloud-logging-full-name }}](../../../logging/) логи, которые генерируются в кластере {{ managed-k8s-name }}, в том числе на уровне [подов](../../concepts/index.md#pod).

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md), необходимый для работы Fluent Bit.
1. [Назначьте сервисному аккаунту роли](../../../iam/operations/sa/assign-role-for-sa.md) `logging.writer` и `monitoring.editor`.
1. [Создайте авторизованный ключ](../../../iam/operations/sa/create-access-key.md) для сервисного аккаунта и сохраните его в файл `sa-key.json`.

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного кластера {{ managed-k8s-name }} и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [Fluent Bit с плагином для {{ cloud-logging-name }}](/marketplace/products/yc/fluent-bit) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) или создайте новое.
   * **Название приложения** — укажите название приложения.
   * **ID целевой лог-группы** — укажите [идентификатор лог-группы](../../../logging/operations/list.md), в которую будут сохраняться логи Fluent Bit.
   * **Идентификатор кластера** — укажите [идентификатор кластера {{ managed-k8s-name }}](../kubernetes-cluster/kubernetes-cluster-list.md).
   * **Ключ сервисной учетной записи для {{ cloud-logging-name }}** — вставьте содержимое файла `sa-key.json`.
1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
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

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

## Примеры использования {#examples}

* [{#T}](../../tutorials/fluent-bit-logging.md).

## См. также {#see-also}

* [Документация Fluent Bit](https://docs.fluentbit.io/manual).
* [Документация {{ cloud-logging-name }}](../../../logging/).
