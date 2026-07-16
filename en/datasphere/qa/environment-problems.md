---
title: '{{ ml-platform-full-name }}. Troubleshooting issues with dependencies'
description: How to install libraries and fix related {{ ml-platform-full-name }} errors? Find answers to this and other questions in this article.
---

# Troubleshooting issues with dependencies in {{ ml-platform-full-name }}

By default, {{ ml-platform-name }} already contains popular machine learning packages and libraries. Library versions depend on the system image specified in the project settings. For the full list of installed packages, see [{#T}](../concepts/preinstalled-packages.md).

{% note tip %}

If your project uses multiple libraries, and you have conflicts with pre-installed libraries, see [Building your own Docker image](#docker). In {{ ml-platform-name }}, usage of the virtual environment and console is limited.

{% endnote %}


## What are problems with dependencies? {#dependencies}

Conflicts of library versions occur when two packages require different versions of the same library. Non-matching library versions make package installation more difficult and may cause errors when running the code.

If the packages you need are missing in the standard {{ ml-platform-name }} image, install them manually.

Some packages depend on system libraries which you cannot install in {{ ml-platform-name }} due to the restriction on the use of `sudo` and `apt`. If this is your case, you will need a workaround.

If you get errors when installing or using packages, this may be due to conflicting versions of dependent libraries. Such errors come with messages like `ModuleNotFoundError` (module not found) or `VersionConflict` (incompatible version).

If there is an error during package installation, `pip` usually gives you a message detailing the cause. For example, in case of a version conflict, `pip` will specify the package and version that have caused the problem. Analyze these messages to understand the root cause of the problem.

## Installing, deleting, or updating packages {#update-version}

To avoid conflicts, you can install a _specific version_ of a package. For example, to install `seaborn` 0.11.1, use the following command:

```bash
%pip install seaborn==0.11.1
```

Updating packages to the latest versions may sometimes help you solve problems with dependencies. To update a package, use this command:

```bash
%pip install --upgrade <package_name>
```

If you do not need the conflicting package, you can delete it:

```bash
%pip uninstall <package_name>
```

To avoid conflicts, specify the minimum required versions of the packages:

```bash
%pip install <package_name>>=<minimum_version>
```

{% note info %}

After installing, updating, or deleting a package, restart the {{ jlab }}Lab kernel. To do this, click **Kernel** → **Restart Kernel** in the top panel of the project window.

{% endnote %}


## Using dependency files {#requrements-txt}

By using the `requirements.txt` dependency file, you can create a list of all required packages and their versions for a project. Doing so will simplify dependency installation on other systems and help you avoid issues when running a cross-system environment migration.

To install the packages and libraries from the `requirements.txt` file residing in the project root, run this command:

```bash
%pip install -r requirements.txt
```

To save a list of installed libraries to `requirements.txt`, run this command:

```bash
%pip freeze > requirements.txt
```

{% note info %}

If you want to deploy the environment from a dependency file created in {{ ml-platform-name }} on another platform, delete the system packages installed via `@`.

{% endnote %}

## Using external repositories {#external-repos}

If the package you need is not available in PyPI, you can install it directly from a repository, e.g., GitHub:

```bash
%pip install git+https://github.com/username/repository
```

You can specify a particular branch or commit to install:

```bash
%pip install git+https://github.com/username/repository@branch_name
```

## Building your own Docker image {#docker}

Your own [Docker image](../concepts/docker.md) will allow you to set up an environment with the dependencies and tools you need, accelerate setting up new projects, and ensure stability of the environment. When creating your own Docker image, you can:

* Use your own image prepared in advance.
* Use clean Python images without pre-installed dependencies.
* Install tools via `apt`.
* Use library and driver versions that are different from the versions pre-installed in {{ ml-platform-name }}, e.g., install another CUDA version.
* Quickly install large libraries or download files.

To learn how to build your own image, see [{#T}](../operations/user-images.md).

## Known issues {#qa}

### ModuleNotFoundError {#module-not-found}

`ModuleNotFoundError` occurs when a package is not installed. To make sure the package is installed, run `%pip install <package_name>`. If you have just installed the package, restart the {{ jlab }}Lab kernel.

### VersionConflict {#version-conflict}

The `VersionConflict` error occurs when incompatible package versions are installed in the system. Check packages and install compatible versions:

```bash
%pip install <package_name>==<required_version>
```

After reinstalling the package, restart the {{ jlab }}Lab kernel.

### Could not find a version that satisfies the requirement {#not-found-version}

The `Could not find a version that satisfies the requirement` error may occur if you specify a non-existing package version or the package is not available in the repository. Make sure the package name and version are correct and try installing another version.

### What else you can do {#what-is-else}

If you encounter an error you cannot fix, contact [support]({{ link-console-support }}).