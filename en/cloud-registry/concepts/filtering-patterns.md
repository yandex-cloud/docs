# Filtering patterns

Filtering patterns are [Ant-style](https://docs.spring.io/spring-framework/docs/5.3.15/javadoc-api/org/springframework/util/AntPathMatcher.html) templates that allow you to restrict user access to artifacts in the registry based on artifact path. There are two types of patterns:
* Include patterns, which describe allowed paths to artifacts.
* Exclude patterns, which describe prohibited paths to artifacts.

An artifact will be accessible to the user if its path matches at least one include pattern and does not match any exclude patterns.

You specify the patterns when [creating](../operations/registry/create.md) or updating the registry.

## Docker {#docker}

`<repository>` can consist of several segments (e.g., `library/nginx`, `traefik/whoami`, or `team/service/sidecar`) and must contain only digits, lowercase Latin letters, `.`, `_`, and `-`.

Description | Include pattern | Exclude pattern
--- | --- | ---
To restrict access to a repository | `["**"]` | `["<repository>/**"]`
To restrict access to Docker images with a specified tag | `["**"]` | `["<repository>/<tag>"]`
To restrict access to Docker images with a specified hash | `["**"]` | `["<repository>/sha256:<hash>"]`
To restrict access to Docker images with the `latest` tag | `["**"]` | `["**/latest"]`
To allow access to a Docker image | `["<Docker image>/**"]` | `[]`

## Maven {#maven}

All separator characters in the path must be replaced with `/`, e.g., use `com/example/mylib/1.0.0` instead of `com.example:mylib:1.0.0`.

Description | Include pattern | Exclude pattern
--- | --- | ---
To restrict access to a project group | `["**"]` | `["<group>/**"]`
To restrict access to an artifact | `["**"]` | `["<group>/<artifact>/**"]`
To restrict access to a version | `["**"]` | `["<group>/<artifact>/<version>/**"]`
To restrict access to a file | `["**"]` | `["<group>/<artifact>/<version>/<file>"]`
To restrict access to snapshots | `["**"]` | `["**/*-SNAPSHOT/**"]`
To grant access to two project groups only | `["<group-1>/**", "<group-2>/**"]` | `[]`

## NPM {#npm}

The patterns are applied to the path in `<package>/<file>` format, e.g., for `express@4.18.0`, the path is `express/express-4.18.0.tgz`.

Description | Include pattern | Exclude pattern
--- | --- | ---
To restrict access to a package | `["**"]` | `["<package>/**"]`
To restrict access to a version | `["**"]` | `["<package>/*-<version>.tgz"]`
To restrict access to major version 2 | `["**"]` | `["<package>/<package>-2.*.tgz"]`
To restrict access to a namespace (`scope`) | `["**"]` | `["@<namespace>/**"]`
To restrict access to a package in a namespace | `["**"]` | `["@<namespace>/<package>/**"]`
To grant access to one namespace only | `["@<namespace>/**"]` | `[]`
To grant access to two packages only | `["<package-1>/**", "<package-2>/**"]` | `[]`

## NuGet {#nuget}

The patterns are applied to the path in `<package>/<version>` format, e.g., for `Newtonsoft.Json@13.0.3`, the path is `newtonsoft.json/13.0.3`. The path does not include the `.nupkg` file name: the name is found separately (`<package>.<version>.nupkg`) at the storage level. This is why filtering works with version-level, not individual file-level granularity.

{% note warning %}

NuGet forces the path to lowercase, e.g., a package named `Newtonsoft.Json` becomes `newtonsoft.json`. Therefore, you should use `newtonsoft.json/**` instead of `Newtonsoft.Json/**`.

{% endnote %}

Description | Include pattern | Exclude pattern
--- | --- | ---
To restrict access to a package | `["**"]` | `["<package>/**"]`
To restrict access to a version | `["**"]` | `["<package>/<version>"]`
To restrict access to major versions 2 | `["**"]` | `["<package>/2.*"]`
To grant access to two packages only | `["<package-1>/**", "<package-2>/**"]` | `[]`

## PyPI {#pypi}

The patterns are applied to the path in `<package>/<version>/<file>` format, e.g., `requests/2.31.0/requests-2.31.0.tar.gz`.

Description | Include pattern | Exclude pattern
--- | --- | ---
To restrict access to a package | `["**"]` | `["<package>/**"]`
To restrict access to a version | `["**"]` | `["<package>/<version>/**"]`
To restrict access to a file | `["**"]` | `["<package>/<version>/<file>"]`
To restrict access to major versions 2 | `["**"]` | `["<package>/2.*/**"]`
To grant access to two packages only | `["<package-1>/**", "<package-2>/**"]` | `[]`

## Binary {#binary}

The patterns are applied to the path in `<package>/<version>/<file> format`. `<package>` may contain several segments, e.g., `tools/cli`.

{% note info %}

`<package>` may contain the `/` character; therefore, `<namespace>/**` restricts access to all packages under this prefix. For example, the `tools/**` pattern restricts access to `tools/cli/...`, `tools/utils/...`, and so on.

{% endnote %}

Description | Include pattern | Exclude pattern
--- | --- | ---
To restrict access to a package | `["**"]` | `["<package>/**"]`
To restrict access to a version | `["**"]` | `["<package>/<version>/**"]`
Prohibiting file download | `["**"]` | `["<package>/<version>/<file>"]`
To restrict access to a namespace | `["**"]` | `["<namespace>/**"]`
To grant access to two packages only | `["<package-1>/**", "<package-2>/**"]` | `[]`

## Go {#go}

The patterns are applied to the path in `<module>/<version>/<file>` format.

Specifics:

* The version prefix, `v`, gets removed, i.e., `v1.5.2` becomes `1.5.2`, so you should use `foo/bar/1.5.2/**` instead of `foo/bar/v1.5.2/**`.
* The suffixes of the module's major versions get removed (`/v2`, `/v3`, and so on). For the `registry.yandex.cloud.net/foo/bar/v2@v2.1.0` module, the path should be `foo/bar/2.1.0`.
* The path does not include the `{{ cloud-registry }}` prefix.

Description | Include pattern | Exclude pattern
--- | --- | ---
To restrict access to a module | `["**"]` | `["<module>/**"]`
To restrict access to a version | `["**"]` | `["<module>/<version>/**"]`
To restrict access to a file | `["**"]` | `["<module>/<version>/<file>"]`
To restrict access to major version 2.x.x | `["**"]` | `["<module>/2.*/**"]`
To restrict access to pre-release versions | `["**"]` | `["<module>/*-*/**"]`
To restrict access to namespaces, e.g., `myorg/cli` and `myorg/server` | `["**"]` | `["myorg/**"]`
To grant access to two modules only | `["<module-1>/**", "<module-2>/**"]` | `[]`

## Debian {#debian}

A Debian registry stores artifacts in three independent namespaces:

* `pool/`: Binary packages (.deb), with paths formatted as `pool/<component>/<architecture>/<package_name_first_letter>/<package>/<version>/<package>_<version>_<architecture>.deb`, e.g., `pool/main/amd64/n/nginx/1.18.0-6.1/nginx_1.18.0-6.1_amd64.deb`.
* `dists/`: Repository metadata, e.g., `dists/<distribution>/Release`, `dists/<distribution>/InRelease`, `dists/<distribution>/<component>/binary-<arch>/Packages`, etc.
* `uploads/`: Buffer for the files you are uploading before they reach `pool/`. The path is `uploads/<file>`.

The patterns apply to the storage path which is not always the same as the URL.

{% note warning %}

`pool/` and `dists/` are independent of each other. `.deb` in `pool/` is not linked to any particular distribution: the relationship is maintained by the package index in `dists/<distribution>/<component>/binary-<architecture>/`. To completely restrict access to a distribution or component, block both the index in `dists/` and the corresponding packages in `pool/`. Otherwise, while not finding the packages by index, the user will still be able to make a direct query using `pool/...`.

{% endnote %}

Description | Include pattern | Exclude pattern
--- | --- | ---
To restrict access to a distribution | `["**"]` | `["dists/<distribution>/**"]`
To restrict access to a `non-free` component | `["**"]` | `["pool/non-free/**", "dists/*/non-free/**"]`
To restrict access to an `i386` architecture | `["**"]` | `["pool/*/i386/**", "dists/*/*/binary-i386/**"]`
To restrict access to a package | `["**"]` | `["pool/*/*/*/<package>/**"]`
To restrict access to a version | `["**"]` | `["pool/*/*/*/<package>/<version>/**"]`
