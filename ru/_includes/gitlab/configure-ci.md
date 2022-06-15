1. Создайте [переменные окружения GitLab](https://docs.gitlab.com/ee/ci/variables/README.html).

    1. В GitLab в панели слева перейдите в раздел **Settings** и во всплывающем списке выберите пункт **CI/CD**.
    1. Нажмите кнопку **Expand** напротив пункта **Variables**.
    1. Добавьте две переменные окружения:
        - `KUBE_URL` – адрес [мастера](../../managed-kubernetes/concepts/index.md#master). Узнайте его с помощью команды:
            
          {% list tabs %}
          
          - Bash
          
              ```bash
              yc managed-kubernetes cluster get <cluster-id> --format=json \
                | jq -r .master.endpoints.external_v4_endpoint
              ```
          
          {% endlist %}
    
        - `KUBE_TOKEN` — токен, который будет использовать GitLab для применения конфигурации. Используйте токен, полученный перед началом работы.
    1. Нажмите кнопку **Save variables**.

1. GitLab позволяет настраивать [сценарии сборки](https://docs.gitlab.com/ee/ci/README.html) в YAML-файле. Создайте файл конфигурации `.gitlab-ci.yml`:
   1. На левой панели в {{ GL }} перейдите в раздел **Repository** и выберите вкладку **Files**.
   1. Справа от имени проекта нажмите кнопку **+** и в выпадающем меню выберите пункт **New file**.
   1. Назовите файл `.gitlab-ci.yml`. Добавьте в него шаги сборки и загрузки [Docker-образа](../../container-registry/concepts/docker-image.md) и обновления [кластера {{ k8s }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster):

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
        image: cr.yandex/yc/metadata-token-docker-helper:0.2
        services:
          - docker:19.03.1-dind
        script:
          - docker build . -t cr.yandex/<ID реестра>/hello:gitlab-$CI_COMMIT_SHORT_SHA
          - docker push cr.yandex/<ID реестра>/hello:gitlab-$CI_COMMIT_SHORT_SHA

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

   1. Замените в приведенном файле `<ID реестра>` на идентификатор вашего [реестра](../../container-registry/concepts/registry.md), созданного ранее.
   1. Напишите комментарий к коммиту в поле **Commit message**: `CI scripts`.
   1. Нажмите кнопку **Commit changes**.

   {% note info %}

   В файле `.gitlab-ci.yml` описаны два шага сборки проекта:
   * Сборка Docker-образа с использованием `Dockerfile` из предыдущего этапа и загрузка образа в [{{ container-registry-full-name }}](../../container-registry/).
     * Для этого шага используйте контейнер для сборки Docker-образов и запустить Docker-сервер как [GitLab-сервис](https://docs.gitlab.com/ee/ci/yaml/README.html#services).
     * Для аутентификации в {{ container-registry-name }} используйте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), подключенный к узлам {{ k8s }}. В начале работы этому аккаунту была назначена роль [{{ roles-cr-pusher }}](../../container-registry/security/index.md#required-roles).
     * Чтобы получить из [метаданных](../../compute/concepts/vm-metadata.md) виртуальной машины данные для аутентификации, используется вспомогательный публичный Docker-образ `cr.yandex/yc/metadata-token-docker-helper:0.2`. Внутри него работает [Docker credential helper](../../container-registry/operations/authentication.md#cred-helper), который получает {{ iam-full-name }}-токен из сервиса метаданных.
   * Настройка окружения для работы с {{ k8s }} и применение конфигурации `k8s.yaml` к кластеру {{ k8s }}. Таким образом приложение развертывается на созданном ранее кластере.

   {% endnote %}

1. После сохранения файла должен запуститься сценарий сборки. Посмотреть на его исполнение можно на вкладке слева **CI/CD**, выбрав в выпадающем меню пункт **Pipelines**. Дождитесь успешного завершения обоих этапов сборки.
1. Проверьте результат, посмотрев логи контейнера в кластере {{ k8s }}:

   ```bash
   kubectl logs deployment/hello-world-deployment -n hello-world
   ```

   Результат выполнения команды:

   ```text
   Hello
   ```
