# Установка {{ GLR }}

[{{ GLR }}](https://docs.gitlab.com/runner/) — приложение с открытым исходным кодом, которое выполняет задания конвеерной обработки {{ GL }} {% if lang == "ru" %}[CI/CD](https://cloud.yandex.ru/blog/posts/2022/10/ci-cd){% else %}CI/CD{% endif %} по инструкциям из специального файла `.gitlab-ci.yml`. Оно позволяет запускать автоматизированные сборки внутри [кластера {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster).

## Перед началом работы {#before-you-begin}

Получите регистрационный токен (registration token):
* Для настройки {{ GLR }} на весь [инстанс {{ GL }}](../../../managed-gitlab/concepts/index.md) (требуются права администратора {{ GL }}):
  1. Откройте в браузере административную панель {{ GL }}, используя [FQDN](../../../compute/concepts/network.md#hostname) инстанса.
  1. Нажмите кнопку **Menu** и выберите пункт **Admin**.
  1. Перейдите в раздел **Runners**.
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

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/application-load-balancer/k8s-ingress-controller-install-helm.md) %}

1. {% include [Настройка kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с {{ GLR }} выполните команду:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://cr.yandex/yc-marketplace/yandex-cloud/gitlab-org/gitlab-runner/chart/gitlab-runner \
     --version 0.43.1-34 \
     --untar && \
   helm install \
     --namespace <пространство имен> \
     --create-namespace \
     --set gitlabUrl=<публичный IP-адрес ВМ или FQDN инстанса Managed Service for GitLab> \
     --set runnerRegistrationToken=<регистрационный токен, полученный ранее> \
     gitlab-runner gitlab/gitlab-runner
   ```

## См. также {#see-also}

[Документация {{ mgl-full-name }}](../../../managed-gitlab/).
[Документация {{ GL }}](https://docs.gitlab.com/).
[Документация {{ GL }} CI/CD](https://docs.gitlab.com/ee/ci/).
[Справочник по .gitlab-ci.yml](https://docs.gitlab.com/ee/ci/yaml/index.html).
