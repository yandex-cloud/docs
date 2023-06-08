# Установка {{ GL }} Agent

Приложение [{{ GL }} Agent](/marketplace/products/yc/gitlab-agent) используется для подключения [кластера {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster) к {{ GL }}. Вы можете развернуть приложение как в инстансе [{{ mgl-full-name }}](../../../managed-gitlab/), так и в standalone-инстансе {{ GL }}.

{{ GL }} Agent позволяет:
* Работать с кластерами {{ k8s }}, находящимися за NAT.
* Получать доступ к API кластера {{ k8s }} в реальном времени.
* Получать информацию о событиях в кластере {{ k8s }}.
* Включить кеш объектов {{ k8s }}, которые обновляются с очень низкой задержкой.

{% note info %}

{{ GL }} Agent не исполняет конвейеры [CI/CD](/blog/posts/2022/10/ci-cd). Для этой цели установите приложение [{{ GL }} Runner](/marketplace/products/yc/gitlab-runner).

{% endnote %}

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. {% include [Настройка kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. [Создайте инстанс {{ mgl-name }}](../../../managed-gitlab/operations/instance/instance-create.md) или standalone-инстанс.
1. Создайте файл конфигурации агента в репозитории:
   1. Откройте ваш [инстанс {{ GL }}](../../../managed-gitlab/concepts/index.md#instance) и перейдите в ваш проект.
   1. В ветке `main` создайте новый каталог `.gitlab/agents/<имя_агента_{{ GL }}>`.
   1. В каталоге `<имя_агента_{{ GL }}>` создайте пустой файл `config.yaml`.
1. Зарегистрируйте агента в {{ GL }} и получите токен доступа:
   1. Откройте ваш инстанс {{ GL }} и перейдите в ваш проект.
   1. Нажмите кнопку **Infrastructure** и выберите пункт **{{ k8s }} clusters**.
   1. Нажмите кнопку **Connect a cluster** и выберите имя агента `<имя_агента_{{ GL }}>`.
   1. Нажмите кнопку **Register an agent**.
   1. {{ GL }} создаст токен, который потребуется для установки приложения. Сохраните токен в безопасном месте.

{% note info %}

Подробнее о настройке и регистрации агента см. в [документации {{ GL }}](https://docs.gitlab.com/ee/user/clusters/agent/install/).

{% endnote %}

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ managed-k8s-name }}**.
1. Нажмите на имя нужного кластера {{ k8s }} и выберите вкладку ![image](../../../_assets/marketplace.svg) **{{ marketplace-short-name }}**.
1. В разделе **Доступные для установки приложения** выберите [{{ GL }} Agent](/marketplace/products/yc/gitlab-agent) и нажмите кнопку **Использовать**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) или создайте новое.
   * **Название приложения** — укажите название приложения, например `gitlab-agent`.
   * **Имя домена {{ GL }}** — укажите имя вашего домена {{ GL }}, например `gitlab-test.gitlab.yandexcloud.net`.
   * **Токен доступа агента** — скопируйте в это поле токен доступа {{ GL }}, [полученный ранее](#before-you-begin).
1. Нажмите кнопку **Установить**.
1. Дождитесь, пока статус приложения изменится на `Deployed`.
1. Откройте ваш инстанс {{ GL }} и перейдите на страницу **Infrastucture → {{ k8s }} clusters**. Убедитесь, что агент перешел в состояние `Connected`.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с {{ GL }} Agent выполните команду:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
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
1. Убедитесь, что под {{ GL }} Agent перешел в состояние `Running`:

   ```bash
   kubectl get pods --namespace gitlab-agent
   ```

1. Откройте ваш инстанс {{ GL }} и перейдите на страницу **Infrastucture → {{ k8s }} clusters**. Убедитесь, что агент перешел в состояние `Connected`.

## См. также {#see-also}

* [Документация {{ mgl-name }}](../../../managed-gitlab/).
* [Документация {{ GL }} Agent](https://docs.gitlab.com/ee/user/clusters/agent/).