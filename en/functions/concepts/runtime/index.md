---
title: Runtime. Overview
description: The runtime environment is selected when creating a function. It provides additional libraries and environment variables that can be accessed from the function code. You can change the selected runtime environment by updating the function configuration.
---

# Runtime. Overview

The runtime environment is selected when creating a function. It provides additional libraries and environment variables that can be accessed from the function code. You can change the selected runtime environment by updating the function configuration.

Runtime environment characteristics:

- Operating system: Ubuntu 18.04 LTS.
- Linux Kernel v. 4.14.

When invoking a function, the service tries to use the runtime environment from the previous invocation if it's still available. This lets you save time preparing the runtime environment and resources, such as DB connections and temporary files, which don't have to be re-created when the runtime environment is used again.

{% note info %}

The runtime environment is updated while relevant language version updates are released. We don't recommend using obsolete language versions.

{% endnote %}

## Runtime environments {#runtimes}

Runtime environments available in {{ sf-name }}.

| Name | ID | Preloaded |
| ---- | ---- | ---- |
| **Node.js** |  |  |
| Node.js 16 | `nodejs16` | Yes |
| Node.js 14 | `nodejs14` | No |
| Node.js 12 | `nodejs12` | No |
| **PHP** |  |  |
| PHP 7.4 | `php74` | No |
| **Python** |  |  |
| Python 3.9 | `python39` | Yes |
| Python 3.8 | `python38` | No |
| Python 3.7 | `python37` | No |
| **Go** |  |  |
| Go 1.17 | `golang117` | No |
| Go 1.16 | `golang114` | No |
| **Java** |  |  |
| Java 11 | `java11` | No |
| **.NET Core** |  |  |
| .NET Core 3.1 | `dotnetcore31` | No |
| **R** |  |  |
| R 4.0.2 | `r402` | No |
| **Other** |  |  |
| Bash | `bash` | No |

