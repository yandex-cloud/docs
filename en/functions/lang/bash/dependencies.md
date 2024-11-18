---
title: How to build and manage Bash function dependencies in {{ sf-full-name }}
description: In this tutorial, you will learn how to build and manage Bash function dependencies in {{ sf-full-name }}.
---

# Building and managing Bash function dependencies

For the function to work correctly in the [Bash runtime environment](../../concepts/runtime/index.md#runtimes), dependencies should be delivered manually. Upload all executable [binary files](https://en.wikipedia.org/wiki/Binary_file) needed to run the [request handler script](handler.md) to the root of the project archive.

Example of the project structure:

```
 ├── handler.sh
 ├── ffmpeg
 └── git
```

Where:

* `handler.sh`: Request handler script in the Bash language.
* `ffmpeg` and `git`: Executable files of the required dependencies. In this example, `ffmpeg` is a library for multimedia files and `git` is a library for the version control system. 

{% note info %}

All executable files you upload must be [statically linked](https://en.wikipedia.org/wiki/Static_build) to ensure correct operation in an isolated runtime environment.

{% endnote %}

The dependency installation process has some technical restrictions. For more information, see [{#T}](../../concepts/limits.md). You can view the dependency installation log using the link that appears in the list of operations.
