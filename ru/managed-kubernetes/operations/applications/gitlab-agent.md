---
title: Установка {{ GL }} Agent
description: Следуя данной инструкции, вы сможете установить {{ GL }} Agent.
---

# Установка {{ GL }} Agent


Приложение [{{ GLA }}](/marketplace/products/yc/gitlab-agent) используется для подключения [кластера {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster) к {{ GL }}. Вы можете развернуть приложение как в [инстансе](../../../managed-gitlab/concepts/index.md#instance) [{{ mgl-full-name }}](../../../managed-gitlab/), так и в standalone-инстансе {{ GL }}.

{{ GL }} Agent позволяет:
* Работать с кластерами {{ managed-k8s-name }}, находящимися за NAT.
* Получать доступ к API кластера {{ managed-k8s-name }} в реальном времени.
* Получать информацию о событиях в кластере {{ managed-k8s-name }}.
* Включить кеш объектов {{ k8s }}, которые обновляются с очень низкой задержкой.

{% note info %}

{{ GL }} Agent не исполняет конвейеры [CI/CD](/blog/posts/2022/10/ci-cd). Для этой цели установите приложение [{{ GL }} Runner](/marketplace/products/yc/gitlab-runner).

{% endnote %}

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. Подготовьтесь к установке {{ GL }} Agent:

    1. [Создайте инстанс {{ mgl-name }}](../../../managed-gitlab/operations/instance/instance-create.md) или standalone-инстанс.
    1. Создайте файл конфигурации агента в репозитории:
       1. Откройте ваш [инстанс {{ GL }}](../../../managed-gitlab/concepts/index.md#instance) и перейдите в ваш проект.
       1. В ветке `main` создайте новый каталог `.gitlab/agents/<имя_агента_{{ GL }}>`.
       1. В каталоге `<имя_агента_{{ GL }}>` создайте пустой файл `config.yaml`.
    1. Зарегистрируйте агента в {{ GL }} и получите токен доступа:
       1. Откройте ваш инстанс {{ GL }} и перейдите в ваш проект.
       1. На панели слева выберите пункт **Operate** и в выпадающем меню выберите пункт **{{ k8s }} clusters**.
       1. Нажмите кнопку **Connect a cluster** и выберите имя агента `<имя_агента_{{ GL }}>`.
       1. Нажмите кнопку **Register**.
       1. {{ GL }} создаст токен, который потребуется для установки приложения. Сохраните токен в безопасном месте.

    {% note info %}

    Подробнее о настройке и регистрации агента см. в [документации {{ GL }}](https://docs.gitlab.com/ee/user/clusters/agent/install/).

    {% endnote %}

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного кластера {{ managed-k8s-name }} и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [{{ GLA }}](/marketplace/products/yc/gitlab-agent) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:
   * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) (например, `gitlab-agent-space`). Если вы оставите пространство имен по умолчанию, {{ GL }} Agent может работать некорректно.
   * **Название приложения** — укажите название приложения, например `gitlab-agent`.
   * **Имя домена {{ GL }}** — укажите имя вашего домена {{ GL }}, например `gitlab-test.gitlab.yandexcloud.net`.
   * **Токен доступа агента** — скопируйте в это поле токен доступа {{ GL }}, [полученный ранее](#before-you-begin).
1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь, пока статус приложения изменится на `Deployed`.
1. Откройте ваш инстанс {{ GL }} и перейдите на страницу **Infrastucture → {{ k8s }} clusters**. Убедитесь, что агент перешел в состояние `Connected`.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с {{ GL }} Agent выполните команду:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_gitlab-agent.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_gitlab-agent.helmChart.tag }} \
     --untar && \
   helm upgrade --install \
     --namespace <пространство_имен> \
     --create-namespace \
     --set config.kasAddress='wss://<имя_вашего_домена_{{ GL }}>/-/kubernetes-agent/' \
     --set config.token='<токен_доступа_{{ GL }}>' \
     gitlab-agent ./gitlab-agent/
   ```

   Эта команда также создаст новое пространство имен, необходимое для работы приложения.

   Если вы укажете в параметре `namespace` пространство имен по умолчанию, {{ GL }} Agent может работать некорректно. Рекомендуем указывать значение, отличное от всех существующих пространств имен (например, `gitlab-agent-space`).

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

1. Убедитесь, что под {{ GL }} Agent перешел в состояние `Running`:

   ```bash
   kubectl get pods --namespace=<пространство_имен>
   ```

1. Откройте ваш инстанс {{ GL }} и перейдите на страницу **Infrastucture → {{ k8s }} clusters**. Убедитесь, что агент перешел в состояние `Connected`.

## Примеры использования {#examples}

* [{#T}](../../tutorials/gitlab-containers.md).

## См. также {#see-also}

* [Документация {{ GL }} Agent](https://docs.gitlab.com/ee/user/clusters/agent/).
* [Документация {{ mgl-name }}](../../../managed-gitlab/).
