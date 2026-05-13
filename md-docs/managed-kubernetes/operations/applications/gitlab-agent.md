# Установка GitLab Agent


Приложение [GitLab Agent](https://yandex.cloud/ru/marketplace/products/yc/gitlab-agent) используется для подключения [кластера Managed Service for Kubernetes](../../concepts/index.md#kubernetes-cluster) к GitLab. Вы можете развернуть приложение как в [инстансе](../../../managed-gitlab/concepts/index.md#instance) [Yandex Managed Service for GitLab](../../../managed-gitlab/index.md), так и в standalone-инстансе GitLab.

GitLab Agent позволяет:
* Работать с кластерами Managed Service for Kubernetes, находящимися за NAT.
* Получать доступ к API кластера Managed Service for Kubernetes в реальном времени.
* Получать информацию о событиях в кластере Managed Service for Kubernetes.
* Включить кеш объектов Kubernetes, которые обновляются с очень низкой задержкой.

{% note info %}

GitLab Agent не исполняет конвейеры [CI/CD](https://yandex.cloud/ru/blog/posts/2022/10/ci-cd). Для этой цели установите приложение [GitLab Runner](https://yandex.cloud/ru/marketplace/products/yc/gitlab-runner).

{% endnote %}

## Перед началом работы {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. [Убедитесь](../connect/security-groups.md), что группы безопасности для кластера Managed Service for Kubernetes и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте его](../../../vpc/operations/security-group-add-rule.md).

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

1. Подготовьтесь к установке GitLab Agent:

    1. [Создайте инстанс Managed Service for GitLab](../../../managed-gitlab/operations/instance/instance-create.md) или standalone-инстанс.
    1. Создайте файл конфигурации агента в репозитории:
       1. Откройте ваш [инстанс GitLab](../../../managed-gitlab/concepts/index.md#instance) и перейдите в ваш проект.
       1. В ветке `main` создайте новый каталог `.gitlab/agents/<имя_агента_GitLab>`.
       1. В каталоге `<имя_агента_GitLab>` создайте пустой файл `config.yaml`.
    1. Зарегистрируйте агента в GitLab и получите токен доступа:
       1. Откройте ваш инстанс GitLab и перейдите в ваш проект.
       1. На панели слева выберите пункт **Operate** и в выпадающем меню выберите пункт **Kubernetes clusters**.
       1. Нажмите кнопку **Connect a cluster** и выберите имя агента `<имя_агента_GitLab>`.
       1. Нажмите кнопку **Register**.
       1. GitLab создаст токен, который потребуется для установки приложения. Сохраните токен в безопасном месте.

    {% note info %}

    Подробнее о настройке и регистрации агента см. в [документации GitLab](https://docs.gitlab.com/ee/user/clusters/agent/install/).

    {% endnote %}

## Установка с помощью Yandex Cloud Marketplace {#marketplace-install}

1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;Kubernetes**.
1. Нажмите на имя нужного кластера Managed Service for Kubernetes и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **Marketplace**.
1. В разделе **Доступные для установки приложения** выберите [GitLab Agent](https://yandex.cloud/ru/marketplace/products/yc/gitlab-agent) и нажмите кнопку **Перейти к установке**.
1. Задайте настройки приложения:
   * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) (например, `gitlab-agent-space`). Если вы оставите пространство имен по умолчанию, GitLab Agent может работать некорректно.
   * **Название приложения** — укажите название приложения, например `gitlab-agent`.
   * **Имя домена GitLab** — укажите имя вашего домена GitLab, например `gitlab-test.gitlab.yandexcloud.net`.
   * **Токен доступа агента** — скопируйте в это поле токен доступа GitLab, [полученный ранее](#before-you-begin).
1. Нажмите кнопку **Установить**.
1. Дождитесь, пока статус приложения изменится на `Deployed`.
1. Откройте ваш инстанс GitLab и перейдите на страницу **Infrastucture → Kubernetes clusters**. Убедитесь, что агент перешел в состояние `Connected`.

## Установка с помощью Helm-чарта {#helm-install}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.
1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).
1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с GitLab Agent выполните команду:

   ```bash
   helm pull oci://cr.yandex/yc-marketplace/yandex-cloud/gitlab-org/gitlab-agent/chart/gitlab-agent \
     --version 1.16.1 \
     --untar && \
   helm upgrade --install \
     --namespace <пространство_имен> \
     --create-namespace \
     --set config.kasAddress='wss://<имя_вашего_домена_GitLab>/-/kubernetes-agent/' \
     --set config.token='<токен_доступа_GitLab>' \
     gitlab-agent ./gitlab-agent/
   ```

   Эта команда также создаст новое пространство имен, необходимое для работы приложения.

   Если вы укажете в параметре `namespace` пространство имен по умолчанию, GitLab Agent может работать некорректно. Рекомендуем указывать значение, отличное от всех существующих пространств имен (например, `gitlab-agent-space`).

   {% note info %}
   
   Если вы используете версию Helm ниже 3.8.0, добавьте в начало команды строку `export HELM_EXPERIMENTAL_OCI=1 && \`, чтобы включить поддержку [Open Container Initiative](https://opencontainers.org/) (OCI) в клиенте Helm.
   
   {% endnote %}

1. Убедитесь, что под GitLab Agent перешел в состояние `Running`:

   ```bash
   kubectl get pods --namespace=<пространство_имен>
   ```

1. Откройте ваш инстанс GitLab и перейдите на страницу **Infrastucture → Kubernetes clusters**. Убедитесь, что агент перешел в состояние `Connected`.

## Примеры использования {#examples}

* [Непрерывное развертывание контейнеризованных приложений с помощью GitLab](../../tutorials/gitlab-containers.md).

## См. также {#see-also}

* [Документация GitLab Agent](https://docs.gitlab.com/ee/user/clusters/agent/).
* [Документация Managed Service for GitLab](../../../managed-gitlab/index.md).