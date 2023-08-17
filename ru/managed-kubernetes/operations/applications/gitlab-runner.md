# Установка {{ GLR }}

[{{ GLR }}](https://docs.gitlab.com/runner/) — приложение с открытым исходным кодом, которое выполняет задания конвеерной обработки {{ GL }} [CI/CD](/blog/posts/2022/10/ci-cd) по инструкциям из специального файла `.gitlab-ci.yml`. Оно позволяет запускать автоматизированные сборки внутри [кластера {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster).

## Перед началом работы {#before-you-begin}

Получите регистрационный токен (registration token):
* Для настройки {{ GLR }} на весь [инстанс {{ GL }}](../../../managed-gitlab/concepts/index.md) (требуются права администратора {{ GL }}):
  1. Откройте в браузере административную панель {{ GL }}, используя [FQDN](../../../compute/concepts/network.md#hostname) инстанса.
  1. Нажмите кнопку **Menu** и выберите пункт **Admin**.
  1. Перейдите в раздел **CI/CD** → **Runners**.
  1. Нажмите кнопку **Register an instance runner** и сохраните значения параметра `registration token`.
* Для настройки {{ GLR }} для группы или проекта:
  1. Откройте в браузере административную панель {{ GL }}, используя FQDN инстанса.
  1. Выберите необходимую группу или проект.
  1. В открывшемся окне слева нажмите кнопку **Settings** и выберите пункт **CI/CD**.
  1. В блоке **Runners** нажмите кнопку **Expand**.
  1. Сохраните значения параметра `registration token`.

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ managed-k8s-name }}**.
1. Нажмите на имя нужного кластера {{ k8s }} и выберите вкладку ![image](../../../_assets/marketplace.svg) **{{ marketplace-short-name }}**.
1. В разделе **Доступные для установки приложения** выберите [{{ GLR }}](/marketplace/products/yc/gitlab-runner) и нажмите кнопку **Использовать**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) для {{ GLR }} или создайте новое.
   * **Название приложения** — укажите название приложения.
   * **Имя домена {{ GL }}** — укажите домен вашего инстанса {{ GL }}.
   * **Регистрационный токен** — укажите регистрационный токен, [полученный ранее](#before-you-begin).
1. Нажмите кнопку **Установить**.
1. Дождитесь перехода приложения в статус `Deployed`.
1. Вернитесь на страницу Runners инстанса {{ GL }}, обновите ее и убедитесь, что появился новый {{ GLR }}.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. {% include [Настройка kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с {{ GLR }} выполните команду:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ mkt-k8s-key.yc_gitlab-runner.helmChart.name }}  \
     --version {{ mkt-k8s-key.yc_gitlab-runner.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
     --set gitlabDomain=<публичный_IP-адрес_ВМ_или_FQDN_инстанса_Yandex_Managed_Service_for_GitLab> \
     --set runnerToken=<ранее_полученный_регистрационный_токен> \
     gitlab-runner ./gitlab-runner/
   ```

## Примеры использования {#examples}

* [{#T}](../../tutorials/gitlab-containers.md).
* [{#T}](../../tutorials/cr-scanner-with-k8s-and-gitlab.md).
* [{#T}](../../../managed-gitlab/tutorials/image-storage.md).

## См. также {#see-also}

* [Документация {{ mgl-name }}](../../../managed-gitlab/).
* [Документация {{ GL }}](https://docs.gitlab.com/).
* [Документация {{ GL }} CI/CD](https://docs.gitlab.com/ee/ci/).
* [Справочник по .gitlab-ci.yml](https://docs.gitlab.com/ee/ci/yaml/index.html).
