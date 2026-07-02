---
title: How to build and manage R function dependencies in {{ sf-full-name }}
description: In this guide, you will learn how to build and manage R function dependencies in {{ sf-name }}.
---

# Building and managing R function dependencies

## Pre-installed packages {#pre-inst-pack}

The runtime of a function in R includes the following pre-installed packages available for use in function code:
`httr`, `logging`, `data.table`, `dplyr`, `paws`, `rjson`, `stringr`, `BiocManager`, `ggplot2`, `plotly`, `devtools`, `Rcpp`, `tidyr`, `lubridate`, `e1071`, `caret`, `mongolite`, `Rsamtools`.

## Installing additional packages {#inst-addit-pack}

When creating a new [function version](../../operations/function/version-manage.md), {{ sf-name }} enables you to install all dependencies required for the function. To do this, place a file named `packages.R` that describes the installation process into the project root.

This service also supports manual delivery of dependencies along with the source code.

## packages.R {#pack-r}

This script is executed once when creating a function version.

Example of installing a package via `packages.R`:

```R
install.packages("purrr", repo="http://cran.r-project.org")
```

## Manual delivery of dependencies {#man-del-of-dep}

To configure dependencies manually, place the compiled packages in the `usr/library/` subdirectory of the project archive.

Dependency installation is limited in terms of resources and execution time. For more information, see [{#T}](../../concepts/limits.md). You can view the dependency installation log via the link displayed in the list of operations.
