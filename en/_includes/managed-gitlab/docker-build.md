## Configure a Docker image build from CI {#docker-build}

To build a Docker image, connect to the Docker server.

{{ GL }} lets you define your [build scripts](https://docs.gitlab.com/ee/ci/README.html) in a YAML file. The `.gitlab-ci.yml` configuration file looks as follows:

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
* Environment variables for the Docker server are passed.
* The Docker server is deployed as a [{{ GL }} service](https://docs.gitlab.com/ee/ci/yaml/README.html#services) next to a Docker container used to build Docker images. To read more about the build process, see the [{{ GL }} Docker container build documentation](https://docs.gitlab.com/ee/ci/docker/using_docker_build.html).

To read more about building Docker images from the CI, see the [{{ GL }} Docker integration documentation](https://docs.gitlab.com/ee/ci/docker/README.html).

When the build is complete, upload the Docker image to {{ container-registry-full-name }} to make it available. To do this, authenticate in {{ container-registry-name }}.

### Authenticate in {{ container-registry-name }} {#auth}

There are two ways to authenticate in {{ container-registry-name }} from {{ GLR }}:
* (recommended) Dynamic: Use the metadata service.
* Static: Use environment variables.

#### Dynamic {#auth-dynamic}

This authentication option only works if the VM with {{ GL }} is linked to a [service account](../../iam/concepts/users/service-accounts.md). To learn how to link a service account, see [Working with {{ yandex-cloud }} from inside an instance](../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance).

To allow Docker to get metadata from the metadata service, use a public Docker image named `cr.yandex/yc/metadata-token-docker-helper:0.1`. It runs [Docker credential helper](../../container-registry/operations/authentication.md#cred-helper), which gets an IAM token from the metadata service. [Use this Docker image](https://docs.gitlab.com/ee/ci/docker/using_docker_images.html#define-image-and-services-from-gitlab-ciyml) while building your app.

The [configuration file](https://docs.gitlab.com/ee/ci/README.html) `.gitlab-ci.yml` looks as follows:

```
build:
  stage: build
  variables:
    DOCKER_DRIVER: overlay2
    DOCKER_TLS_CERTDIR: ""
    DOCKER_HOST: tcp://localhost:2375/
  image: {{ registry }}/yc/metadata-token-docker-helper:0.1
  services:
    - docker:19.03.1-dind
  script:
    - docker build . -t {{ registry }}/<registry-id>/<image-name>
    - docker push {{ registry }}/<registry-id>/<image-name>
```

#### Static {#auth-static}

In the [{{ GL }} environment variable](https://docs.gitlab.com/ee/ci/variables/README.html), enter the contents of the [authorized key](../../iam/concepts/users/service-accounts.md#sa-key) for your service account (with the [applicable rights](../../container-registry/security/index.md)) and use this variable when building the Docker image. Learn more about [using json-key in {{ container-registry-name }}](../../container-registry/operations/authentication.md#sa-json).

The [configuration file](https://docs.gitlab.com/ee/ci/README.html) `.gitlab-ci.yml` looks as follows:

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
    - docker build . -t {{ registry }}/<registry-id>/<image-name>
    - docker push {{ registry }}/<registry-id>/<image-name>
```