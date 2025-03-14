---
title: Docker container restart policies
description: 'You can specify three Docker container restart policies in its description: Always, Never, and OnFailure.'
---

# Docker container restart policies

You can specify the Docker container restart policies in its description:
* `Always`: Always restart the Docker container when it stops. If you stop the Docker container manually, it only restarts along with the Docker daemon.
* `Never`: Do not restart the Docker container automatically.
* `OnFailure`: Restart the Docker container only if it shut down with a non-zero return code.

If the Docker container description in the metadata changed when restarting the VM, the specified restart policy will be ignored and a Docker container matching the new description will start.