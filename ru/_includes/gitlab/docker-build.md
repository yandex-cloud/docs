## Настройте сборку Docker-образа из CI {#docker-build}
Для того, чтобы собрать Docker-образ, вам необходимо подключиться к Docker-серверу.

GitLab позволяет задавать [сценарии сборки](https://docs.gitlab.com/ee/ci/README.html) в YAML-файле. Файл конфигурации 
`.gitlab-ci.yml` будет выглядеть следующим образом:
```
build:
  stage: build
  variables: 
    DOCKER_DRIVER: overlay2
    DOCKER_TLS_CERTDIR: ""
    DOCKER_HOST: tcp://localhost:2375/
  image: docker:19.03.1
  services:
    - docker:19.03.1-dind
  script: 
    - docker build . -t cr.yandex/<registry-id>/<image-name>
```
Здесь:
* передаются переменные окружения для использования Docker-сервера;
* Docker-сервер поднимается как [GitLab сервис](https://docs.gitlab.com/ee/ci/yaml/README.html#services), рядом с 
Docker-контейнером для сборки Docker-образа. Подробнее про сборку вы можете прочитать
в документации [GitLab про сборку Docker-контейнеров](https://docs.gitlab.com/ee/ci/docker/using_docker_build.html).

Подробнее про то, как настроить сборку Docker-образа из CI, читайте в 
[документации GitLab про интеграцию с Docker](https://docs.gitlab.com/ee/ci/docker/README.html).  

После успешной сборки, загрузите Docker-образ в {{ container-registry-name }}, чтобы он был доступен для 
дальнейшей работы. 
Для этого [аутентифицируйтесь в {{ container-registry-name }}](../../container-registry/solutions/gitlab.md#auth).

### Аутентифицируйтесь в {{ container-registry-short-name }} {#auth}
Есть два способа аутентификации из GitLab Runner в {{ container-registry-name }}:
- (рекомендованный) [Динамическая](../../container-registry/solutions/gitlab.md#auth-dynamic) – использовать сервер 
метаданных;
- [Статическая](../../container-registry/solutions/gitlab.md#auth-static) – использовать переменные окружения.

#### Динамическая {#auth-dynamic}
Этот вариант аутентификации работает только если к виртуальной машине с GitLab привязан 
[сервисный аккаунт](../../iam/concepts/users/service-accounts.md). О том, как привязать сервисный аккаунт, читайте в 
разделе
[Работа с Яндекс.Облаком изнутри ВМ](../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance).  

Для того, чтобы Docker мог получать метаданные из сервера метаданных, воспользуйтесь публичным Docker-образом с именем
`cr.yandex/yc/metadata-token-docker-helper:0.1`. Внутри него работает [
Docker credential helper](../../container-registry/operations/authentication.md#cred-helper), который получает 
IAM-токен из сервера метаданных. [Используйте данный 
Docker-образ](https://docs.gitlab.com/ee/ci/docker/using_docker_images.html#define-image-and-services-from-gitlab-ciyml)
на этапе сборки вашего приложения.

Файл [конфигурации](https://docs.gitlab.com/ee/ci/README.html) `.gitlab-ci.yml` будет выглядеть 
следующим образом:
```
build:
  stage: build
  variables: 
    DOCKER_DRIVER: overlay2
    DOCKER_TLS_CERTDIR: ""
    DOCKER_HOST: tcp://localhost:2375/
  image: cr.yandex/yc/metadata-token-docker-helper:0.1
  services:
    - docker:19.03.1-dind
  script: 
    - docker build . -t cr.yandex/<registry-id>/<image-name>
    - docker push cr.yandex/<registry-id>/<image-name>
```

#### Статическая {#auth-static}
В [переменную окружения GitLab](https://docs.gitlab.com/ee/ci/variables/README.html) пропишите содержимое 
[авторизованного ключа](../../iam/concepts/users/service-accounts.md#sa-key) вашего сервисного аккаунта 
(с [необходимыми правами](../../container-registry/security/index.md)) и используйте данную переменную при сборке 
Docker-образа. Подробнее про [использование json-key в 
{{ container-registry-short-name }}](../../container-registry/operations/authentication.md#sa-json).

Файл [конфигурации](https://docs.gitlab.com/ee/ci/README.html) `.gitlab-ci.yml` будет выглядеть следующим 
образом:
```
build:
  stage: build
  variables: 
    DOCKER_DRIVER: overlay2
    DOCKER_TLS_CERTDIR: ""
    DOCKER_HOST: tcp://localhost:2375/
  image: docker:19.03.1
  services:
    - docker:19.03.1-dind
  script: 
    - echo <your env-variable> | docker login -u json_key --password-stdin cr.yandex
    - docker build . -t cr.yandex/<registry-id>/<image-name>
    - docker push cr.yandex/<registry-id>/<image-name>
```
