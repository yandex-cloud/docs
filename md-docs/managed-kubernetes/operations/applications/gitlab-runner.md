# Установка {{ GLR }}


[{{ GLR }}](https://docs.gitlab.com/runner/) — приложение с открытым исходным кодом, которое выполняет задания конвейерной обработки {{ GL }} [CI/CD](https://yandex.cloud/ru/blog/posts/2022/10/ci-cd) по инструкциям из специального файла `.gitlab-ci.yml`. Оно позволяет запускать автоматизированные сборки внутри [кластера {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster).

## Перед началом работы {#before-you-begin}

1. [Убедитесь](../connect/security-groups.md), что группы безопасности для кластера {{ managed-k8s-name }} и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте](../../../vpc/operations/security-group-add-rule.md) его.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

1. Откройте в браузере административную панель {{ GL }}:
   * Если {{ GL }} развернут на [виртуальной машине](../../../compute/concepts/vm.md) [{{ compute-full-name }}](../../../compute/index.md), используйте ее [публичный IP-адрес](../../../compute/concepts/network.md#public-ip).
   * Если {{ GL }} развернут в [сервисе {{ mgl-full-name }}](../../../managed-gitlab/index.md), используйте [FQDN инстанса](../../../compute/concepts/network.md##hostname).
1. Получите токен аутентификации {{ GLR }} (Runner authentication token):
   * Для настройки {{ GLR }} для всего [инстанса {{ GL }}](../../../managed-gitlab/concepts/index.md#instance) (требуются права администратора {{ GL }}):
     1. Нажмите кнопку **Admin area** и выберите пункт **CI/CD** → **Runners**.
     1. Нажмите кнопку **New instance runner** и создайте новый {{ GLR }}.
     1. Сохраните значение параметра `Runner authentication token`.
   * Для настройки {{ GLR }} для группы или проекта:
     1. Выберите необходимую группу или проект.
     1. В открывшемся окне слева нажмите кнопку **Settings** и выберите пункт **CI/CD**.
     1. В блоке **Runners** нажмите кнопку **Expand**.
     1. Нажмите кнопку **New project runner** и создайте новый {{ GLR }}.
     1. Сохраните значение параметра `Runner authentication token`.

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. В [консоли управления]({{ link-console-main }}) выберите каталог.
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного кластера {{ managed-k8s-name }} и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [{{ GLR }}](https://yandex.cloud/ru/marketplace/products/yc/gitlab-runner) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:
   * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) (например, `gitlab-runner-space`). Если вы оставите пространство имен по умолчанию, {{ GLR }} может работать некорректно.
   * **Название приложения** — укажите название приложения.
   * **Имя домена {{ GL }}** — укажите домен вашего инстанса {{ GL }}.
   * **Регистрационный токен** — укажите токен, [полученный ранее](#before-you-begin).
   * (Опционально) **Привилегированный режим для запуска docker:dind** — включите опцию, чтобы использовать образы docker:dind.

        {% note warning %}

        Привилегированный режим повышает риск возникновения инцидентов информационной безопасности. Предварительно ознакомьтесь с [документацией](https://docs.gitlab.com/runner/executors/kubernetes.html#using-dockerdind).

        {% endnote %}

    * (Опционально) **Список тэгов (через запятую)** — укажите список тегов для распределения задач между несколькими {{ GLR }}.
1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `Deployed`.
1. Вернитесь на страницу **Runners** инстанса {{ GL }}, обновите ее и убедитесь, что появился новый {{ GLR }}.

## Установка с помощью Helm-чарта {#helm-install}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.

1. [Установите kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с {{ GLR }} выполните команду:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_gitlab-runner.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_gitlab-runner.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
     --set gitlabDomain=<публичный_IP-адрес_ВМ_или_FQDN_инстанса_{{ GL }}> \
     --set runnerRegistrationToken=<ранее_полученный_токен> \
     gitlab-runner ./gitlab-runner/
   ```

   Если вы укажете в параметре `namespace` пространство имен по умолчанию, {{ GLR }} может работать некорректно. Рекомендуем указывать значение, отличное от всех существующих пространств имен (например, `gitlab-runner-space`).

   {% note info %}
   
   Если вы используете версию Helm ниже 3.8.0, добавьте в начало команды строку `export HELM_EXPERIMENTAL_OCI=1 && \`, чтобы включить поддержку [Open Container Initiative](https://opencontainers.org/) (OCI) в клиенте Helm.
   
   {% endnote %}

## Примеры использования {#examples}

* [{#T}](../../tutorials/gitlab-containers.md).
* [{#T}](../../tutorials/cr-scanner-with-k8s-and-gitlab.md).
* [{#T}](../../../managed-gitlab/tutorials/image-storage.md).

## См. также {#see-also}

* [Документация {{ mgl-name }}](../../../managed-gitlab/index.md).
* [Документация {{ GL }}](https://docs.gitlab.com/).
* [Документация {{ GL }} CI/CD](https://docs.gitlab.com/ee/ci/).
* [Справочник по .gitlab-ci.yml](https://docs.gitlab.com/ee/ci/yaml/index.html).