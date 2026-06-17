# Установка GitLab Runner


[GitLab Runner](https://docs.gitlab.com/runner/) — приложение с открытым исходным кодом, которое выполняет задания конвейерной обработки GitLab [CI/CD](https://yandex.cloud/ru/blog/posts/2022/10/ci-cd) по инструкциям из специального файла `.gitlab-ci.yml`. Оно позволяет запускать автоматизированные сборки внутри [кластера Managed Service for Kubernetes](../../concepts/index.md#kubernetes-cluster).

## Перед началом работы {#before-you-begin}

1. [Убедитесь](../connect/security-groups.md), что группы безопасности для кластера Managed Service for Kubernetes и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте](../../../vpc/operations/security-group-add-rule.md) его.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

1. Откройте в браузере административную панель GitLab:
   * Если GitLab развернут на [виртуальной машине](../../../compute/concepts/vm.md) [Yandex Compute Cloud](../../../compute/index.md), используйте ее [публичный IP-адрес](../../../compute/concepts/network.md#public-ip).
   * Если GitLab развернут в [сервисе Yandex Managed Service for GitLab](../../../managed-gitlab/index.md), используйте [FQDN инстанса](../../../compute/concepts/network.md##hostname).
1. Получите токен аутентификации GitLab Runner (Runner authentication token):
   * Для настройки GitLab Runner для всего [инстанса GitLab](../../../managed-gitlab/concepts/index.md#instance) (требуются права администратора GitLab):
     1. Нажмите кнопку **Admin area** и выберите пункт **CI/CD** → **Runners**.
     1. Нажмите кнопку **New instance runner** и создайте новый GitLab Runner.
     1. Сохраните значение параметра `Runner authentication token`.
   * Для настройки GitLab Runner для группы или проекта:
     1. Выберите необходимую группу или проект.
     1. В открывшемся окне слева нажмите кнопку **Settings** и выберите пункт **CI/CD**.
     1. В блоке **Runners** нажмите кнопку **Expand**.
     1. Нажмите кнопку **New project runner** и создайте новый GitLab Runner.
     1. Сохраните значение параметра `Runner authentication token`.

## Установка с помощью Yandex Cloud Marketplace {#marketplace-install}

1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
1. Нажмите на имя нужного кластера Managed Service for Kubernetes и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **Marketplace**.
1. В разделе **Доступные для установки приложения** выберите [GitLab Runner](https://yandex.cloud/ru/marketplace/products/yc/gitlab-runner) и нажмите кнопку **Перейти к установке**.
1. Задайте настройки приложения:
   * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) (например, `gitlab-runner-space`). Если вы оставите пространство имен по умолчанию, GitLab Runner может работать некорректно.
   * **Название приложения** — укажите название приложения.
   * **Имя домена GitLab** — укажите домен вашего инстанса GitLab.
   * **Регистрационный токен** — укажите токен, [полученный ранее](#before-you-begin).
   * (Опционально) **Привилегированный режим для запуска docker:dind** — включите опцию, чтобы использовать образы docker:dind.

        {% note warning %}

        Привилегированный режим повышает риск возникновения инцидентов информационной безопасности. Предварительно ознакомьтесь с [документацией](https://docs.gitlab.com/runner/executors/kubernetes.html#using-dockerdind).

        {% endnote %}

    * (Опционально) **Список тэгов (через запятую)** — укажите список тегов для распределения задач между несколькими GitLab Runner.
1. Нажмите кнопку **Установить**.
1. Дождитесь перехода приложения в статус `Deployed`.
1. Вернитесь на страницу **Runners** инстанса GitLab, обновите ее и убедитесь, что появился новый GitLab Runner.

## Установка с помощью Helm-чарта {#helm-install}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с GitLab Runner выполните команду:

   ```bash
   helm pull oci://cr.yandex/yc-marketplace/yandex-cloud/gitlab-org/gitlab-runner/chart/gitlab-runner \
     --version 0.54.1 \
     --untar && \
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
     --set gitlabDomain=<публичный_IP-адрес_ВМ_или_FQDN_инстанса_GitLab> \
     --set runnerRegistrationToken=<ранее_полученный_токен> \
     gitlab-runner ./gitlab-runner/
   ```

   Если вы укажете в параметре `namespace` пространство имен по умолчанию, GitLab Runner может работать некорректно. Рекомендуем указывать значение, отличное от всех существующих пространств имен (например, `gitlab-runner-space`).

   {% note info %}
   
   Если вы используете версию Helm ниже 3.8.0, добавьте в начало команды строку `export HELM_EXPERIMENTAL_OCI=1 && \`, чтобы включить поддержку [Open Container Initiative](https://opencontainers.org/) (OCI) в клиенте Helm.
   
   {% endnote %}

## Примеры использования {#examples}

* [Непрерывное развертывание контейнеризованных приложений с помощью GitLab](../../tutorials/gitlab-containers.md).
* [Сканирование уязвимостей Container Registry при непрерывном развертывании приложений с помощью GitLab](../../tutorials/cr-scanner-with-k8s-and-gitlab.md).
* [Хранение Docker-образов в Yandex Container Registry](../../../managed-gitlab/tutorials/image-storage.md).

## Полезные ссылки {#see-also}

* [Документация Managed Service for GitLab](../../../managed-gitlab/index.md).
* [Документация GitLab](https://docs.gitlab.com/).
* [Документация GitLab CI/CD](https://docs.gitlab.com/ee/ci/).
* [Справочник по .gitlab-ci.yml](https://docs.gitlab.com/ee/ci/yaml/index.html).