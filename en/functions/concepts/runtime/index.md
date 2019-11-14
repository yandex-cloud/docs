# Overview

The runtime environment is selected when creating a function. It provides additional libraries and environment variables that can be accessed from the function code. You can change the selected runtime environment by updating the function configuration.

Runtime environment characteristics:

- Operating system: Ubuntu 18.04 LTS.
- Linux Kernel v. 4.14.

When invoking a function, the service tries to use the runtime environment from the previous call if it's still available. This lets you save time preparing the runtime environment and resources, such as DB connections and temporary files, which don't have to be re-created when the runtime environment is used again.

{% note info %}

The runtime environment is updated while relevant language version updates are released. We don't recommend using obsolete language versions.

{% endnote %}

## Runtime environments {#runtimes}

Runtime environments available in {{ sf-name }}.

| Name | ID |
| ---- | ---- |
| **Node.js** |  |
| Node.js 12 | `nodejs12` |
| Node.js 10 | `nodejs10` |
| **Python** |  |
| Python 3.7 | `python37` |
| Python 2.7 | `python27` |

