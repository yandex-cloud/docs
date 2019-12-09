# Working with {{ k8s }} from GitLab

[GitLab](https://about.gitlab.com/) is a [continuous integration](https://en.wikipedia.org/wiki/Continuous_integration) tool. GitLab lets you build, test, and run containerized applications.

There are two ways that you can work with {{ k8s }} in GitLab:
- [Connect the {{ k8s }} cluster to GitLab runners](#runners).
- [Automatically deploy {{ k8s }} resources from CI](#k8s-apply).

To use either method, complete the preparatory steps first.

## Before you start {#before-you-begin}

### Create a VM from the GitLab image {#create-gitlab}

Run GitLab on a VM with a public IP address:

{% include [create-gitlab](../../_includes/gitlab/create.md) %}

### Configure GitLab {#configure-gitlab}

{% include [create-gitlab](../../_includes/gitlab/initialize.md) %}

### Create resources {{ k8s }} {#k8s-create}

Create the {{ k8s }} resources necessary to run the scripts:

1. [Create a {{ k8s }} cluster](../quickstart.md#kubernetes-cluster-create).
1. [Create a {{ k8s }} node group](../quickstart.md#node-group-create).

{% include [k8s-get-token](../../_includes/gitlab/k8s-get-token.md) %}

{% include [k8s-runner-gitlab](../../_includes/gitlab/k8s-runner.md) %}

{% include [kubectl-apply-gitlab](../../_includes/gitlab/kubectl-apply.md) %}

#### See also {#see-also}

- [{#T}](../../container-registry/solutions/gitlab.md)
- [{#T}](../../solutions/testing/ci-for-snapshots.md)
- [{#T}](../../solutions/infrastructure-management/gitlab-containers.md)

