# Установка Jaeger over {{ ydb-short-name }} Backend

[Jaeger](https://www.jaegertracing.io/) — платформа для распределенной трассировки с открытым исходным кодом. Jaeger позволяет выполнять мониторинг состояния запросов и отладку после сбоев в распределенных системах микросервисных приложений.

В качестве хранилища данных Jaeger может использовать:
* [{{ ydb-full-name }}](../../../ydb/) при установке через [{{ marketplace-full-name }}](/marketplace).
* [Другие системы хранения данных](https://github.com/jaegertracing/helm-charts/tree/main/charts/jaeger#storage) при установке через Helm-чарт.

## Установка с помощью {{ marketplace-name }} {#marketplace-install}

### Перед началом работы {#before-you-begin}

1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Для потоковой обработки JSON-файлов установите [утилиту `jq`](https://stedolan.github.io/jq/):

   ```bash
   sudo apt update && sudo apt install jq
   ```

1. Чтобы разрешить [подам](../../concepts/index.md#pod) кластера {{ k8s }} подключаться к {{ ydb-name }}, настройте [группы безопасности](../connect/security-groups.md). Добавьте правило для входящего трафика:
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `2135`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`).

### Подготовка {{ ydb-name }} {#create-ydb}

1. [Создайте базу данных](../../../ydb/operations/manage-databases.md#create-db-dedicated) подходящей вам конфигурации с [типом БД](../../../ydb/concepts/serverless-and-dedicated.md) `Dedicated`.

   {% note warning %}

   БД в режиме `Dedicated` — обязательное условие корректной работы сервиса Jaeger.

   {% endnote %}

1. [Создайте директорию](../../../ydb/operations/schema.md#directories) с именем `jaeger`.

### Создание сервисного аккаунта {#create-sa-key}

Чтобы Jaeger мог взаимодействовать с {{ ydb-name }}, создайте [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) и получите для него ключ.
1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) с подходящей вам [ролью в кластере {{ k8s }}](../../security/index.md#yc-api).
1. Создайте ключ для сервисного аккаунта и сохраните его на локальный компьютер:

   ```bash
   yc iam key create \
     --service-account-id <идентификатор_сервисного_аккаунта> \
     --folder-id <идентификатор_каталога> \
     --cloud-id <идентификатор_облака> \
     --description jaeger-over-ydb \
     --format json \
     -o key.json
   ```

   Результат:

   ```text
   {
     "id": "<идентификатор_ключа_сервисного_аккаунта>",
     "service_account_id": "<идентификатор_сервисного_аккаунта>",
     "created_at": "2022-01-27T03:29:45.139311367Z",
     "description": "jaeger-over-ydb",
     "key_algorithm": "RSA_2048"
   }
   ```

   {% note info %}

   Сохраните идентификаторы сервисного аккаунта и его ключа — они понадобятся при дальнейшей установке.

   {% endnote %}

1. Сохраните ключ сервисного аккаунта в формате Base64:

   ```bash
   jq -r .private_key key.json > key.pem
   ```

### Установка Jaeger {#install-jaeger}

1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного кластера и выберите вкладку ![Marketplace](../../../_assets/marketplace.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **Доступные для установки приложения** выберите [Jaeger over {{ ydb-name }} Backend](/marketplace/products/yc/jaeger-ydb-store) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) или создайте новое.
   * **Название приложения** — укажите название приложения.
   * **{{ ydb-name }} эндпоинт** — укажите имя эндпоинта {{ ydb-name }}, например `lb.etnk1hv0jol3********.{{ ydb.host-dedicated }}:{{ ydb.port-dedicated }}`.
   * **База данных** — укажите имя БД, например `/{{ region-id }}/b1gkgm9daf46********/etnk2hv0jol5********`.
   * **Директория в базе данных** — `jaeger`.
   * **Использовать сервис метаданных для аутентификации изнутри ВМ** — выберите эту опцию, если требуется аутентификация внутри виртуальной машины.
   * **ID ключа сервисного аккаунта** — укажите идентификатор ключа сервисного аккаунта.
   * **Ключ сервисного аккаунта** — укажите идентификатор сервисного аккаунта.
   * **Приватный ключ сервисного аккаунта** — скопируйте в это поле содержимое файла `key.pem`.
   * **Установить jaeger-agent** — выберите эту опцию, чтобы установить [jaeger-agent](https://hub.docker.com/r/jaegertracing/jaeger-agent/).

   Имя эндпоинта и БД были получены при [подготовке БД {{ ydb-name }}](#create-ydb), настройки для сервисного аккаунта — [в предыдущем подразделе](#create-sa-key).
1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `{{ ui-key.yacloud.k8s.cluster.marketplace.label_release-status-DEPLOYED }}`.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. {% include [install-kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Добавьте репозиторий `jaegertracing`:

   ```bash
   helm repo add jaegertracing https://jaegertracing.github.io/helm-charts
   ```

1. Установите Jaeger:

   ```bash
   helm install jaeger jaegertracing/jaeger
   ```

1. При необходимости установите {{ k8s }}-оператор [jaeger-operator](https://github.com/jaegertracing/jaeger-operator):

   ```bash
   helm install jaegertracing/jaeger-operator
   ```

   Подробнее о таком типе установки см. в [документации платформы Jaeger](https://github.com/jaegertracing/helm-charts).