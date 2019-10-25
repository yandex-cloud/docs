## Configure a Docker image build from CI {#docker-build}

To build a Docker image, connect to the Docker server.

GitLab lets you define your [build scripts](https://docs.gitlab.com/ee/ci/README.html) in a YAML file. The 
`.gitlab-ci.yml` configuration file looks as follows:

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

Where:

- Environment variables for the Docker server are passed.
- Docker server is installed as a [GitLab service](https://docs.gitlab.com/ee/ci/yaml/README.html#services) next to a Docker container used to build Docker images. To read more about the build process, see the [GitLab Docker container build](https://docs.gitlab.com/ee/ci/docker/using_docker_build.html) documentation.

To read more about building Docker images from CI, see [GitLab Docker integration documentation](https://docs.gitlab.com/ee/ci/docker/README.html).

When the build is complete, upload the Docker image to {{ container-registry-name }} to make it available. To do this, [authenticate in {{ container-registry-name }}](../../container-registry/solutions/gitlab.md#auth).

### Authenticate in {{ container-registry-short-name }} {#auth}

There are two ways to authenticate in {{ container-registry-name }} from GitLab Runner:

- (recommended) [Dynamic](../../container-registry/solutions/gitlab.md#auth-dynamic): Use the metadata server.
- [Static](../../container-registry/solutions/gitlab.md#auth-static): Use environment variables.

#### Dynamic {#auth-dynamic}

This authentication option only works if the VM with GitLab is linked to a [service account](../../iam/concepts/users/service-accounts.md). To learn how to link a service account, see [Working with Yandex.Cloud from inside an instance](../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance).

To allow Docker to get metadata from the metadata server, use a public Docker image named `cr.yandex/yc/metadata-token-docker-helper:0.1`. It runs [Docker credential helper](../../container-registry/operations/authentication.md#credit-helper), which gets an IAM token from the metadata server. [Use this Docker image](https://docs.gitlab.com/ee/ci/docker/using_docker_images.html#define-image-and-services-from-gitlab-ciyml) during the build phase of your application.

The [configuration file](https://docs.gitlab.com/ee/ci/README.html) `.gitlab-ci.yml` looks as follows:

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

#### Static {#auth-static}

In the [GitLab environment variable](https://docs.gitlab.com/ee/ci/variables/README.html), insert the contents [of the authorized key](../../iam/concepts/users/service-accounts.md#sa-key) for your service account (with [the applicable rights](../../container-registry/security/index.md)) and use this variable when building the Docker image. Learn more about [using json-key in {{ container-registry-short-name }}](../../container-registry/operations/authentication.md#sa-json).

The [configuration file](https://docs.gitlab.com/ee/ci/README.html) `.gitlab-ci.yml` will look as follows:

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

