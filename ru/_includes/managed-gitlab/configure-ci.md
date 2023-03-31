1. Создайте [переменные окружения {{ GL }}](https://docs.gitlab.com/ee/ci/variables/README.html).
   1. На панели слева в {{ GL }} перейдите в раздел **Settings** и во всплывающем списке выберите пункт **CI/CD**.
   1. Нажмите кнопку **Expand** напротив пункта **Variables**.
   1. Добавьте две переменные окружения:
      * `KUBE_URL` — адрес [мастера {{ k8s }}](../../managed-kubernetes/concepts/index.md#master). Узнайте его с помощью команды:

        ```bash
        yc managed-kubernetes cluster get <идентификатор или имя кластера {{ k8s }}> --format=json \
          | jq -r .master.endpoints.external_v4_endpoint
        ```

      * `KUBE_TOKEN` — токен, который будет использовать {{ GL }} для применения конфигурации. Используйте токен, полученный ранее.

      Для добавления переменной:
      1. Нажмите кнопку **Add variable**.
      1. В появившемся окне в поле **Key** укажите имя переменной, в поле **Value** — значение переменной.
      1. Нажмите кнопку **Add variable**.
1. {{ GL }} позволяет настраивать [сценарии сборки](https://docs.gitlab.com/ee/ci/README.html) в YAML-файле. Создайте файл конфигурации `.gitlab-ci.yml`:
   1. На панели слева в {{ GL }} перейдите в раздел **Repository** и выберите вкладку **Files**.
   1. Справа от имени проекта нажмите кнопку **+** и в выпадающем меню выберите пункт **New file**.
   1. Назовите файл `.gitlab-ci.yml`. Добавьте в него шаги сборки и загрузки [Docker-образа](../../container-registry/concepts/docker-image.md) и обновления конфигурации приложения в [кластере {{ k8s }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster):

      ```yaml
      stages:
        - build
        - deploy

      build:
        stage: build
        variables:
          DOCKER_DRIVER: overlay2
          DOCKER_TLS_CERTDIR: ""
          DOCKER_HOST: tcp://localhost:2375/
        image: {{ registry }}/yc/metadata-token-docker-helper:0.2
        services:
          - docker:19.03.1-dind
        script:
          - docker build . -t {{ registry }}/<идентификатор реестра>/hello:gitlab-$CI_COMMIT_SHORT_SHA
          - docker push {{ registry }}/<идентификатор реестра>/hello:gitlab-$CI_COMMIT_SHORT_SHA

      deploy:
        image: gcr.io/cloud-builders/kubectl:latest
        stage: deploy
        script:
          - kubectl config set-cluster k8s --server="$KUBE_URL" --insecure-skip-tls-verify=true
          - kubectl config set-credentials admin --token="$KUBE_TOKEN"
          - kubectl config set-context default --cluster=k8s --user=admin
          - kubectl config use-context default
          - sed -i "s/__VERSION__/gitlab-$CI_COMMIT_SHORT_SHA/" k8s.yaml
          - kubectl apply -f k8s.yaml
      ```

   1. Замените в приведенном файле `<идентификатор реестра>` на идентификатор вашего [реестра](../../container-registry/concepts/registry.md), созданного ранее.
   1. Напишите комментарий к коммиту в поле **Commit message**: `CI scripts`.
   1. Нажмите кнопку **Commit changes**.

   В файле `.gitlab-ci.yml` описаны два шага сборки проекта:
   * Сборка Docker-образа с использованием `Dockerfile` из предыдущего этапа и загрузка образа в [{{ container-registry-full-name }}](../../container-registry/).
     * Для этого шага используйте контейнер для сборки Docker-образов и запустите Docker-сервер как [{{ GL }}-сервис](https://docs.gitlab.com/ee/ci/yaml/README.html#services).
     * Для аутентификации в {{ container-registry-name }} используйте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), подключенный к узлам {{ k8s }}. В начале работы этому аккаунту была назначена роль [{{ roles-cr-pusher }}](../../container-registry/security/index.md#required-roles).
     * Чтобы получить из [метаданных](../../compute/concepts/vm-metadata.md) виртуальной машины данные для аутентификации, используется вспомогательный публичный Docker-образ `{{ registry }}/yc/metadata-token-docker-helper:0.2`. Внутри него работает [Docker credential helper](../../container-registry/operations/authentication.md#cred-helper), который получает {{ iam-name }}-токен из сервиса метаданных.
   * Настройка окружения для работы с {{ k8s }} и применение конфигурации `k8s.yaml` к кластеру {{ k8s }}. Таким образом приложение развертывается на созданном ранее кластере.
1. После сохранения файла запустится сценарий сборки. Чтобы посмотреть его выполнение, выберите в выпадающем меню пункт **CI/CD** → **Pipelines**. Дождитесь успешного завершения обоих этапов сборки.
1. Проверьте результат, посмотрев логи контейнера в кластере {{ k8s }}:

   ```bash
   kubectl logs deployment/hello-world-deployment -n hello-world
   ```

   Результат:

   ```text
   Hello
   ```