# Working with {{ container-registry-short-name }} in GitLab

[GitLab](https://about.gitlab.com/) is a [continuous integration](https://en.wikipedia.org/wiki/Continuous_integration) tool. GitLab lets you build, test, and run containerized applications. You can configure GitLab to use {{ container-registry-short-name }} to store and retrieve Docker images of your applications by running build scripts.

To build a Docker image by running a GitLab script:

- [Before you start](#before-you-begin)
  - [Create a VM from the GitLab image](#create-gitlab)
  - [Configure GitLab](#configure-gitlab)
- [Configure a Docker image build from CI](#docker-build)
- [Authenticate with {{ container-registry-short-name }}](#auth)

## Before you start {#before-you-begin}

### Create a VM from the GitLab image {#create-gitlab}

Run GitLab on a VM with a public IP address:

{% include [create-gitlab](../../_includes/gitlab/create.md) %}

### Configure GitLab {#configure-gitlab}

{% include [create-gitlab](../../_includes/gitlab/initialize.md) %}

{% include [docker-build-gitlab](../../_includes/gitlab/docker-build.md) %}

#### See also {#see-also}

- [{#T}](../../managed-kubernetes/solutions/gitlab.md)
- [{#T}](../../solutions/testing/ci-for-snapshots.md)
- [{#T}](../../solutions/infrastructure-management/gitlab-containers.md)

