# Building and managing dependencies

At the build stage, {{ sf-name }} automatically installs dependencies necessary for a function to run. This is done when creating a new [function version](../../operations/function/version-manage.md#func-version-create).

{% note info %}

The `ycf` build tag is set for the build.

{% endnote %}

{{ sf-name }} supports two ways to automatically manage dependencies: using modules and the `dep` utility.

### mod

[Modules](https://github.com/golang/go/wiki/Modules) are built-in dependency management mechanisms for the `Go` programming language. This is the main and recommended way to manage dependencies in {{ sf-name }}.

To install dependencies using modules, import the `go.mod` file together with the function source code. This installs the latest versions of the packages specified in this file. To explicitly specify the versions, you should also import the `go.sum` file.

{% note warning %}

Make sure the module name in the `go.mod` file is not `main`.

{% endnote %}

### dep

{% note warning %}

This way of dependency management is deprecated and no longer supported since version 1.16.

{% endnote %}

[Dep](https://golang.github.io/dep/docs/introduction.html) is the dependency management system for `Go`.

To install dependencies using the `dep` utility, import the `Gopkg.toml` and `Gopkg.lock` files together with the function source code. In this case, the `dep ensure` command is run just before the code is built.

{% note info %}

If you have both the `go.mod` and `Gopkg.toml` files, builder performance isn't guaranteed. **We don't recommend** using these two files at the same time.

{% endnote %}

The process of installing dependencies has resource and execution time limits. For more information, see [{#T}](../../concepts/limits.md). You can view the dependency installation log using the link that appears in the list of operations.

