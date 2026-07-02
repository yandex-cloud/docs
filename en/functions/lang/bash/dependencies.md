---
title: How to build and manage Bash function dependencies in {{ sf-full-name }}
description: In this guide, you will learn how to build and manage Bash function dependencies in {{ sf-full-name }}.
---

# Building and managing Bash function dependencies

For the function to work correctly in the [Bash runtime](../../concepts/runtime/index.md#runtimes), you need to provide dependencies manually. Upload all executable [binary files](https://en.wikipedia.org/wiki/Binary_file) required for running the [request handler script](handler.md) to the root of the project archive.

Here is an example of a project structure:

```
 ├── handler.sh
 ├── ffmpeg
 └── git
```

Where:

* `handler.sh`: Request handler script in Bash.
* `ffmpeg` and `git`: Executables of the required dependencies. In this example, `ffmpeg` is a library for multimedia files and `git` is a library for the version control system. 

{% note info %}

All executable files you upload must be [statically linked](https://en.wikipedia.org/wiki/Static_build) to ensure they work correctly in an isolated runtime.

{% endnote %}

The dependency installation process has some technical limitations. For more information, see [{#T}](../../concepts/limits.md). You can view the dependency installation log via the link displayed in the list of operations.
