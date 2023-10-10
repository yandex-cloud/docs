1. Создайте [переменные окружения {{ GL }}](https://docs.gitlab.com/ee/ci/variables/README.html).
   1. На панели слева в {{ GL }} перейдите в раздел **Settings** и во всплывающем списке выберите пункт **CI/CD**.
   1. Нажмите кнопку **Expand** напротив пункта **Variables**.
   1. Добавьте две переменные окружения:
      * `CI_REGISTRY` — адрес созданного ранее [реестра](../../container-registry/concepts/registry.md) в формате `{{ registry }}/<идентификатор_реестра>`.
      * `CI_REGISTRY_KEY` — ключ, который {{ GL }} будет использовать для доступа к реестру. Скопируйте содержимое файла статического ключа `key.json` для доступа к реестру, полученного ранее.

      Для добавления переменной:
      * Нажмите кнопку **Add variable**.
      * В появившемся окне в поле **Key** укажите имя переменной, в поле **Value** — значение переменной.
      * Нажмите кнопку **Add variable**.
1. {{ GL }} позволяет настраивать [сценарии сборки](https://docs.gitlab.com/ee/ci/README.html) в YAML-файле. Создайте файл конфигурации `.gitlab-ci.yml`:
   1. На панели слева в {{ GL }} перейдите в раздел **Repository** и выберите вкладку **Files**.
   1. Справа от имени проекта нажмите кнопку **+** и в выпадающем меню выберите пункт **New file**.
   1. Назовите файл `.gitlab-ci.yml`. Добавьте в него шаги сборки и загрузки [Docker-образа](../../container-registry/concepts/docker-image.md) и обновления конфигурации приложения в [кластере {{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster):

      ```yaml
      stages:
        - build
        - deploy

      build:
        image:
          name: gcr.io/kaniko-project/executor:debug
          entrypoint: [""]
        stage: build
        script:
          - mkdir -p /kaniko/.docker
          - echo "{\"auths\":{\"$CI_REGISTRY\":{\"auth\":\"$(echo -n "json_key:${CI_REGISTRY_KEY}" | base64 | tr -d '\n' )\"}}}" > /kaniko/.docker/config.json
          - >-
            /kaniko/executor \
              --context "${CI_PROJECT_DIR}" \
              --dockerfile "${CI_PROJECT_DIR}/Dockerfile" \
              --destination "${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}"

      deploy:
        image: bitnami/kubectl:latest
        stage: deploy
        script:
          - kubectl config use-context ${CI_PROJECT_PATH}:<имя_агента_в_{{ GL }}>
          - cat k8s.yaml | sed -e "s,__IMAGE__,${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}," | kubectl -n default apply -f -
      ```

   1. Напишите комментарий к коммиту в поле **Commit message**: `CI scripts`.
   1. Нажмите кнопку **Commit changes**.

   В файле `.gitlab-ci.yml` описаны два шага сборки проекта:
   * Сборка Docker-образа с использованием `Dockerfile` из предыдущего этапа и загрузка образа в [{{ container-registry-full-name }}](../../container-registry/).
     * Используется приложение [Kaniko](https://github.com/GoogleContainerTools/kaniko) для сборки Docker-образов внутри контейнера.
     * Для аутентификации в {{ container-registry-name }} используется [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), подключенный к [узлам {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#node-group). При создании кластера {{ managed-k8s-name }} этому аккаунту была назначена [роль](../../iam/concepts/access-control/roles.md) [{{ roles-cr-pusher }}](../../container-registry/security/index.md#required-roles).
   * Применение конфигурации `k8s.yaml` к кластеру {{ managed-k8s-name }} с помощью {{ GLA }} и Docker-образа с `kubectl`.
1. После сохранения файла запустится сценарий сборки. Чтобы посмотреть его выполнение, выберите в выпадающем меню пункт **CI/CD** → **Pipelines**. Дождитесь успешного завершения обоих этапов сборки.
1. Подключитесь к тестовому приложению:
   1. Настройте переадресацию порта сервиса на локальный компьютер:

      ```bash
      kubectl port-forward service/dummy 30000:80 \
        --namespace default
      ```

   1. Откройте в браузере адрес приложения: `http://localhost:30000`. Должна отобразиться строка `Hello, World!`.