# Continuous deployment of containerized applications using GitLab

[GitLab](https://about.gitlab.com/) is a [continuous integration](https://en.wikipedia.org/wiki/Continuous_integration) tool. This scenario describes how to build applications in a Docker container and apply {{ k8s }} resource configurations in GitLab using Yandex.Cloud tools:
- [Before you start](#before-begin)
  - [Create a VM from the GitLab image](#create-gitlab)
  - [Configure GitLab](#configure-gitlab)
  - [Create {{ k8s }} resources](#k8s-create)
  - [Connect the {{ k8s }} cluster to the GitLab runners](#runners)
- [Configure Docker image building from CI](#docker-build)
- [Authenticate with {{ container-registry-short-name }}](#auth)
- [Configure automatic deployment of {{ k8s }} resources from CI](#k8s-apply)

## Before you start {#before-begin}

### Create a VM from the GitLab image {#create-gitlab}

Run GitLab on a VM with a public IP address:

{% include [create-gitlab](../../_includes/gitlab/create.md) %}

### Configure GitLab {#configure-gitlab}

{% include [create-gitlab](../../_includes/gitlab/initialize.md) %}

### Create resources {{ k8s }} {#k8s-create}

Create the {{ k8s }} resources necessary to run the scripts:
1. [Create a {{ k8s }} cluster](../../managed-kubernetes/quickstart.md#kubernetes-cluster-create).
1. [Create a {{ k8s }} node group](../../managed-kubernetes/quickstart.md#node-group-create).

{% include [k8s-get-token](../../_includes/gitlab/k8s-get-token.md) %}

### Connect the {{ k8s }} cluster to the GitLab runners {#runners}

{% include notitle [k8s-runner-gitlab](../../_includes/gitlab/k8s-runner.md) %}

{% include [docker-build-gitlab](../../_includes/gitlab/docker-build.md) %}

{% include [kubectl-apply-gitlab](../../_includes/gitlab/kubectl-apply.md) %}

#### See also {#see-also}

- [{#T}](../../solutions/testing/ci-for-snapshots.md)

