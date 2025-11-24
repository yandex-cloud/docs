---
title: Pushing a binary artifact to a {{ cloud-registry-full-name }} registry
description: Follow this guide to push a binary artifact to a registry in {{ cloud-registry-full-name }}.
---

# Binary artifact

_Binary artifact_ is a file containing any type of package, e.g., an installation script, an executable, a [CSV](https://en.wikipedia.org/wiki/Comma-separated_values) file, a document, an image, etc. A binary artifact package always contains exactly one file. The maximum size of the file to push is 100 MB.

In the [registry](./registry.md), any binary artifact is defined by the `<artifact_name>`/`<artifact_version>` pair and stored at `<registry_URL>/<artifact_name>/<artifact_version>/<file_name>`. Here is an example:

```text
https://{{ cloud-registry }}/binaries/cn15fqbr806r********/sample-package/3.5.4/agent-installer.sh
```

You can [push](../operations/binary/push.md) and [pull](../operations/binary/pull.md) a binary artifact using [HTTP](https://{{ lang }}.wikipedia.org/wiki/HTTP) requests with [IAM token](../../iam/concepts/authorization/iam-token.md) authentication.

You can delete a binary artifact from the [management console]({{ link-console-main }}). You cannot overwrite the existing version of a binary artifact.

#### See also {#see-also}

* [Docker image](./docker-image.md)
* [{#T}](./art-java.md)
* [{#T}](./art-nodejs.md)
* [{#T}](./art-nuget.md)
* [{#T}](./art-python.md)