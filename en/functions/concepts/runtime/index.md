---
title: Runtime environment. Overview
description: You select the runtime environment when creating a function. It provides additional libraries and environment variables that can be accessed from the function code. You can change the selected runtime environment by updating the function configuration.
---

# Runtime environment. Overview

You select the runtime environment when creating a function. It provides additional libraries and environment variables that can be accessed from the function code. You can change the selected runtime environment by updating the function configuration. A [preloaded runtime environment](./preload-runtime.md) is automatically updated in the function version settings to the latest minor version available in {{ sf-name }}. For more information about its update, see [{#T}](preload-runtime.md#update).

Runtime environment characteristics:

- Operating system: Ubuntu 22.04 LTS
- Linux kernel: 5.15

A first function call creates a function instance. The service uses existing function instances for new calls, if available. This allows you to save time preparing the runtime environment and resources, such as DB connections and temporary files, which do not have to be re-created when the runtime environment is used again.

## Runtime environments {#runtimes}

{% note info %}

The runtime environment is updated while relevant language version updates are released. We do not recommend using language versions no longer supported by {{ sf-name }}, as they get no security updates, patches, and new custom features.

{% endnote %}

Runtime environments available in {{ sf-name }}.

| Name | ID | Preloaded | Supported by the service |
| ---- | ---- | ---- | ---- |
| **Node.js** |  |  |
| Node.js 10 | `nodejs10` | No | No |
| Node.js 12 | `nodejs12` | No | No |
| Node.js 14 | `nodejs14` | No | No |
| Node.js 16 | `nodejs16` | Yes | No |
| Node.js 18 | `nodejs18` | Yes | Yes |
| **PHP** |  |  |
| PHP 7.4 | `php74` | No | No |
| PHP 8.0 | `php8`  | No | No |
| PHP 8.2 | `php82`  | No | Yes |
| **Python** |  |  |
| Python 3.7 | `python37` | No | No |
| Python 3.8 | `python38` | No | No |
| Python 3.9 | `python39` | No | No |
| Python 3.11 | `python311` | Yes | No |
| Python 3.12 | `python312` | Yes | Yes |
| **Go** |  |  |
| Go 1.16 | `golang116` | No | No |
| Go 1.17 | `golang117` | No | No |
| Go 1.18 | `golang118` | No | No |
| Go 1.19 | `golang119` | No | No |
| Go 1.21 | `golang121` | No | Yes |
| **Java** |  |  |
| Java 11 | `java11` | No | No |
| Java 17 | `java17` | No | No |
| Java 21 | `java21` | No | Yes |
| **Kotlin** |  |  |
| Kotlin 2.0 | `kotlin20` | No | Yes |
| **.NET Core** |  |  |
| .NET Core 3.1 | `dotnetcore31` | No | No |
| .NET Core 6 | `dotnet6` | No | No |
| .NET Core 8 | `dotnet8` | No | Yes |
| **R** |  |  |
| R 4.2 | `r42` | No | No |
| R 4.3 | `r43` | No | Yes |
| **Other** |  |  |
| Bash 18.04 | `bash` | No | No |
| Bash 22.04 | `bash-2204` | No | Yes |

## Function instance resources {#resources}

Each function instance is allocated CPU and RAM resources based on the following ratios:

| RAM | CPU |
--- | ---
| 128 MB to less than 2 GB | 1 vCPU core with a guaranteed vCPU share of up to 100%, proportional to RAM |
| 2 GB to less than 4 GB | 1 vCPU core with a guaranteed vCPU share of 100% |
| 4 GB | 2 vCPU cores with a guaranteed vCPU share of 100% |
