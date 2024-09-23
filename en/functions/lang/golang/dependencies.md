# Building and managing Go function dependencies

At the build stage, {{ sf-name }} automatically installs dependencies required for a Go function to run when creating a new [function version](../../operations/function/version-manage.md).

{% note info %}

The build gets the `ycf` build tag.

{% endnote %}

{{ sf-name }} supports two automatic dependency management methods for this purpose: modules and the `dep` utility.

### mod

[Modules](https://github.com/golang/go/wiki/Modules) are a built-in dependency management mechanism for the `Go` language. They represent the main and recommended dependency management method for {{ sf-name }}.

To deliver dependencies using modules, upload the `go.mod` file together with the function source code. This will install the latest versions of the packages specified in this file. To specify the versions explicitly, also upload the `go.sum` file.

{% note warning %}

Make sure the module name in the `go.mod` file is not `main`.

{% include [move-groups-api](../../../_includes/functions/go-mod-lang-version-notice.md) %}

{% endnote %}

### dep

{% note warning %}

This method of managing dependencies is obsolete and deprecated for version 1.16 of the language.

{% endnote %}

[Dep](https://golang.github.io/dep/docs/introduction.html) is a dependency management system for `Go`.

To deliver dependencies using `dep`, upload the `Gopkg.toml` and `Gopkg.lock` files together with the function source code. In which case the `dep ensure` command will be invoked just ahead of building the code.

{% note info %}

If you have both `go.mod` and `Gopkg.toml` among the files, builder performance is not guaranteed. **We do not recommend** using these two files at the same time.

{% endnote %}

The process of installing dependencies has resource and execution time limits. For more information, see [{#T}](../../concepts/limits.md). You can view the dependency installation log using the link that appears in the list of operations.
