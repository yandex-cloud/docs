---
title: Creating a Go module
description: Follow this guide to create a Go module for pushing to {{ cloud-registry-name }}.
---

# Creating a Go module

This guide describes how to create a Go module and prepare a ZIP archive for publishing to a {{ cloud-registry-name }}.

For more information on Go modules, see their official guides in the [Go Modules Reference](https://go.dev/ref/mod).

## Go module structure {#module-structure}

Here is an example of a project structure:

```
mymodule/                # Go module root directory
│
├── go.mod               # Defines the Go module and its dependencies
├── go.sum               # Dependency checksums
├── main.go              # Entry point (for executable Go modules)
│
├── pkg/                 # Public packages
│   └── utils/
│       └── utils.go
│
└── internal/            # Private packages (not accessible outside the Go module)
    └── config/
        └── config.go
```

## Creating your Go module {#create-module}

1. Install [Go](https://go.dev/doc/install).

1. Create a directory for your Go module and open it:

    ```bash
    mkdir mymodule && cd mymodule
    ```

1. Initialize the Go module by specifying the full path under which it will be available in the registry:

    ```bash
    go mod init registry.yandexcloud.net/go/<registry_ID>/mymodule
    ```

    In the project root, a `go.mod` file will appear:

    ```text
    module registry.yandexcloud.net/go/<registry_ID>/mymodule

    go 1.21
    ```

1. Add your Go module code; e.g., create a file named `hello.go`:

    ```bash
    cat > hello.go << 'EOF'
    package mymodule

    func Hello() string {
        return "Hello from my module!"
    }
    EOF
    ```

1. If you have external dependencies, synchronize `go.mod` and `go.sum`:

    ```bash
    go mod tidy
    ```

## Preparing a ZIP archive for publishing {#prepare-zip}

The Go CLI does not support direct module publishing. To push to {{ cloud-registry-name }}, prepare a ZIP archive whose structure complies with [Module zip files](https://go.dev/ref/mod#zip-files): every file inside the archive must be prefixed with a path of the `<full_module_path>@<version>/` format, where `<full_module_path>` matches the Go module name specified in `go.mod`.

{% note warning %}

Maximum ZIP archive size is 500 MB.

{% endnote %}

1. From the root of your Go module, build a ZIP archive, substituting your registry ID, module name, and version:

    ```bash
    find . -type f | bsdtar -a -cf ../mymodule-v1.0.0.zip \
        -s '|^\./|registry.yandexcloud.net/go/<registry_ID>/mymodule@v1.0.0/|' -T -
    ```

    {% note info %}

    The `bsdtar` utility is part of [libarchive](https://www.libarchive.org/). It is preinstalled on macOS. On Debian and Ubuntu, install the `libarchive-tools` package:

    ```bash
    sudo apt install libarchive-tools
    ```

    {% endnote %}

1. Verify the archive structure:

    ```bash
    unzip -l ../mymodule-v1.0.0.zip
    ```

    Result:

    ```text
    Archive:  ../mymodule-v1.0.0.zip
      Length      Date    Time    Name
    ---------  ---------- -----   ----
           74  2026-06-13 12:00   registry.yandexcloud.net/go/<registry_ID>/mymodule@v1.0.0/go.mod
          112  2026-06-13 12:00   registry.yandexcloud.net/go/<registry_ID>/mymodule@v1.0.0/hello.go
    ---------                     -------
          186                     2 files
    ```

## What's next {#what-is-next}

* [{#T}](push.md)
* [{#T}](pull.md)
