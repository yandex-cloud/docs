---
title: Step-by-step guides for {{ cloud-registry-full-name }}
description: This section contains step-by-step guides for {{ cloud-registry-name }}.
---

# Step-by-step guides for {{ cloud-registry-name }}

## Managing a registry {#registry}

### Creating a registry {#create-registry}

* [Creating a local registry](registry/local.md)
* [Creating a remote registry](registry/remote.md)
* [Creating a virtual registry](registry/virtual.md)

### Managing registry access permissions {#access-registry}

* [{#T}](registry/list-role.md)
* [Assigning a role](registry/add-role.md)
* [Revoking a role](registry/remove-role.md)

### IP address access policy {#ip}

* [Getting information about an access policy](registry/list-access-policy.md)
* [Setting up an access policy](registry/create-access-policy.md)
* [Deleting an access policy](registry/remove-access-policy.md)


## Managing artifacts {#artifact}

### Docker {#docker}

* [Installing and configuring Docker](docker/installation.md)
* [{#T}](docker/authentication.md)
* [Creating a Docker image](docker/create.md)
* [Pushing a Docker image](docker/push.md)
* [Pulling a Docker image](docker/pull.md)

### Helm {#helm}

* [Getting information about existing Helm charts](helm/list.md)
* [Pushing a Helm chart](helm/push.md)
* [Pulling a Helm chart](helm/pull.md)
* [Deleting a Helm chart](helm/delete.md)

### Java {#java}

* [Setting up Maven](maven/installation.md)

### Node.js {#nodejs}

* [Setting up npm](npm/installation.md)

### NuGet {#nuget}

* [Setting up NuGet](nuget/installation.md)

### Python {#python}

* [Setting up PyPI](pypi/installation.md)
* [Creating a Python package](pypi/create.md)
* [Pushing a Python package](pypi/push.md)
* [Pulling a Python package](pypi/pull.md)
* [Examples of working with PyPI registries](pypi/examples.md)

### Binary {#binary}

* [Pushing a binary artifact](binary/push.md)
* [Pulling a binary artifact](binary/pull.md)

### Go {#go}

* [Creating a Go module](go/create.md)
* [Pushing a Go module](go/push.md)
* [Pulling a Go module](go/pull.md)

### Debian {#debian}

* [Configuring the APT package manager](debian/installation.md)
* [Pushing a Debian package](debian/push.md)
* [Pulling a Debian package](debian/pull.md)


## Other guides {#other}

* [Deleting an artifact from the registry](artifacts/delete.md)
* [Creating a lifecycle policy](lifecycle-policy/create.md)
