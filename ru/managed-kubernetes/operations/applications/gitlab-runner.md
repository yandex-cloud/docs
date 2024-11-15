---
title: Установка {{ GLR }}
description: Следуя данной инструкции, вы сможете установить {{ GLR }}.
---

# Установка {{ GLR }}


[{{ GLR }}](https://docs.gitlab.com/runner/) — приложение с открытым исходным кодом, которое выполняет задания конвейерной обработки {{ GL }} [CI/CD](/blog/posts/2022/10/ci-cd) по инструкциям из специального файла `.gitlab-ci.yml`. Оно позволяет запускать автоматизированные сборки внутри [кластера {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster).

## Перед началом работы {#before-you-begin}

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. Откройте в браузере административную панель {{ GL }}:
   * Если {{ GL }} развернут на [виртуальной машине](../../../compute/concepts/vm.md) [{{ compute-full-name }}](../../../compute/), используйте ее [публичный IP-адрес](../../../compute/concepts/network.md#public-ip).
   * Если {{ GL }} развернут в [сервисе {{ mgl-full-name }}](../../../managed-gitlab/), используйте [FQDN инстанса](../../../compute/concepts/network.md##hostname).
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

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного кластера {{ managed-k8s-name }} и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [{{ GLR }}](/marketplace/products/yc/gitlab-runner) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) для {{ GLR }} или создайте новое.
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
1. Вернитесь на страницу Runners инстанса {{ GL }}, обновите ее и убедитесь, что появился новый {{ GLR }}.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. {% include [Настройка kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

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

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

## Примеры использования {#examples}

* [{#T}](../../tutorials/gitlab-containers.md).
* [{#T}](../../tutorials/cr-scanner-with-k8s-and-gitlab.md).
* [{#T}](../../../managed-gitlab/tutorials/image-storage.md).

## См. также {#see-also}

* [Документация {{ mgl-name }}](../../../managed-gitlab/).
* [Документация {{ GL }}](https://docs.gitlab.com/).
* [Документация {{ GL }} CI/CD](https://docs.gitlab.com/ee/ci/).
* [Справочник по .gitlab-ci.yml](https://docs.gitlab.com/ee/ci/yaml/index.html).
