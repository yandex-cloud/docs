# Building and managing Go function dependencies

At the build stage, {{ sf-name }} automatically installs dependencies required for a Go function when creating a new [function version](../../operations/function/version-manage.md).

{% note info %}

The build gets the `ycf` build tag.

{% endnote %}

For this, {{ sf-name }} supports two methods of automatic dependency management: modules and the `dep` utility.

### mod

[Modules](https://github.com/golang/go/wiki/Modules) are a built-in dependency management solution for `Go`. They are the primary and recommended way to manage dependencies in {{ sf-name }}.

To deliver dependencies using modules, upload the `go.mod` file together with the function source code. This will install the latest versions of the packages specified in this file. To specify the versions explicitly, also upload the `go.sum` file.

{% note warning %}

Make sure the module name in the `go.mod` file is not `main`.

{% include [move-groups-api](../../../_includes/functions/go-mod-lang-version-notice.md) %}

{% endnote %}

### dep

{% note warning %}

This method of managing dependencies is deprecated and no longer supported in language version 1.16.

{% endnote %}

[Dep](https://golang.github.io/dep/docs/introduction.html) is a dependency management system for `Go`.

To deliver dependencies using `dep`, upload the `Gopkg.toml` and `Gopkg.lock` files together with the function source code. In this case, the `dep ensure` command runs just before building the code.

{% note info %}

If you have both `go.mod` and `Gopkg.toml` among the files, the build system may not work as expected. **We do not recommend** using these two files at the same time.

{% endnote %}

Dependency installation is limited in terms of resources and execution time. For more information, see [{#T}](../../concepts/limits.md). You can view the dependency installation log via the link displayed in the list of operations.
