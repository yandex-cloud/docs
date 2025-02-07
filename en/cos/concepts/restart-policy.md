---
title: Policies for restarting a Docker container
description: 'You can specify three Docker container restart policies in its description: Always, Never, and OnFailure.'
---

# Policies for restarting a Docker container

You can specify the Docker container restart policies in its description:
* `Always`: Always restart the Docker container when it stops. If the Docker container is stopped manually, it restarts only when the Docker daemon restarts.
* `Never`: Do not restart the Docker container automatically.
* `OnFailure`: Restart the Docker container only if it shut down with a non-zero return code.

If the Docker container description in the metadata changed when restarting the VM, the specified restart policy is ignored and a Docker container that corresponds to the new description is started.