---
title: Go artifact in {{ cloud-registry-full-name }}
description: A Go artifact is a module containing Go source code, metadata, and dependencies. These modules are used to distribute libraries and other components that can be integrated into Go projects.
---

# Go artifact

A _Go artifact_ is a [ZIP archive](https://go.dev/ref/mod#zip-files) containing the source code of a [Go](https://en.wikipedia.org/wiki/Go_(programming_language)) [module](https://go.dev/ref/mod) with a fixed version. [Artifacts](index.md) are used to distribute libraries and other components that can be integrated into Go projects.

## Go Modules {#go-modules-inf}

[Go Modules](https://go.dev/ref/mod) is a standard dependency management system for Go, included in the standard distribution and available via the `go` command. The module is described in the `go.mod` file located in the project root.

For more information about Go modules, see [this Go Modules reference](https://go.dev/ref/mod).

#### See also {#see-also}

* [Supported artifact types](./index.md#artifacts)
* [{#T}](../../operations/go/pull.md)
* [{#T}](../../operations/go/push.md)
* [{#T}](../registry.md)
