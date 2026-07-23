---
title: FAQ about {{ container-registry-full-name }}
description: This page covers questions and answers about {{ container-registry-name }}.
---

# FAQ about {{ container-registry-name }}

#### Why is the latest tag missing or applied to a Docker image that is not the last one pushed? {#latest}

This is because you specified a different [tag](../concepts/docker-image.md#version) when pushing the [Docker image](../concepts/docker-image.md).

The Docker client supplies the `latest` tag automatically if the Docker image is created and uploaded without a tag. You can also specify the `latest` tag explicitly.

{% include [latest-info](../../_includes/container-registry/info-about-latest.md) %}

#### How do I make a registry public? {#public-registry}

You can grant the [container-registry.images.puller](../security/index.md#container-registry-images-puller) [role](../../iam/concepts/access-control/roles.md) for your [registry](../concepts/registry.md) to the [All users](../../iam/concepts/access-control/public-group.md) public group.

{% note alert %}

This makes all Docker images in the registry available without [authentication](../operations/authentication.md).

Do not assign the `container-registry.images.pusher`, `editor`, or `admin` roles for the registry to a public group. This will enable anyone with your registry ID to use the registry.

{% endnote %}

#### I got an error. What should I do? {#error}

See [{#T}](../error/index.md) for a list of common errors and fixes.

{% include [logs](../../_qa/logs.md) %}

#### What does the "Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock" error mean? {#permission-denied}

You are not running commands as a `root` user.

You can use `sudo` or configure [non-root access](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user).

#### How do I diagnose Credential Helper performance? {#cred-helper}

* Check under which OS user and on which host the [CLI](../../cli/) commands are run. This must be a user with a [Credential Helper](../operations/authentication.md#cred-helper) configured on whose behalf the `yc container registry configure-docker` command was run. The relevant entry should appear in the `/home/<user>/.docker/config.json` file. If using a [virtual machine](../../compute/concepts/vm.md), make sure a credential helper is configured there as well.
* Check if there is a credential helper in `PATH` when calling commands. During authentication to {{ container-registry-name }} via a credential helper, Docker accesses the `docker-credential-yc` binary file. Make sure this binary file is available in `PATH` for the user working with Docker. For example, if you are using Docker with `sudo`, then `configure-docker` should also be called with `sudo`. You can check it using the following command: `echo {{ registry }} | docker-credential-yc get` or `echo {{ registry }} | sudo docker-credential-yc get`, if the commands are called using `sudo`. If everything works, the output will look as follows: `{"Username":"iam","Secret":"***<IAM_token>***"}`.
* If the commands work in interactive mode but fail in non-interactive mode, check the `.bashrc` file. The `yc` and `docker-credential-yc` programs are installed into a directory that is not normally accessible in the default `PATH`. The following lines get written into the `.bashrc` file:

  ```text
  # The next line updates PATH for {{ yandex-cloud }} CLI
  if [ -f '/home/<user>/yandex-cloud/path.bash.inc' ]; then source '/home/<user>/yandex-cloud/path.bash.inc'; fi
  ```

  The top section of the `.bashrc` file contains a condition stating that the commands listed there must not run non-interactively. Due to this condition, the commands can run when you access the VM manually but fail to run over SSH.

#### What is the meaning of the following error: Error response from daemon: pull access denied for <{{ registry }}/registry_ID/Docker_image_name>, repository does not exist or may require 'docker login': denied: Permission denied ; requestId = <request_ID>"? {#permission-denied-ip}

The [IP address](../../vpc/concepts/address.md) that the pull Docker image request is received from has no PULL permission.

[Add rules that allow pulling image](../operations/registry/registry-access.md) for this IP in the registry settings or delete all rules and try again.