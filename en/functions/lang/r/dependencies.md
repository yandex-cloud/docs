# Building and managing R function dependencies

## Pre-installed packages {#pre-inst-pack}

The R function runtime has the following set of pre-installed packages that can be used in the function code:
`httr`, `logging`, `data.table`, `dplyr`, `paws`, `rjson`, `stringr`, `BiocManager`, `ggplot2`, `plotly`, `devtools`, `Rcpp`, `tidyr`, `lubridate`, `e1071`, `caret`, `mongolite`, `Rsamtools`.

## Installing additional packages {#inst-addit-pack}

When creating a new [function version](../../operations/function/version-manage.md), {{ sf-name }} lets you install dependencies required for the function to run. To do this, place a file named `packages.R` that describes the installation process into the project root.

The service also supports manual delivery of dependencies along with the source code.

## packages.R {#pack-r}

This script is executed once when creating a function version.

Example `packages.R` package install:

```R
install.packages("purrr", repo="http://cran.r-project.org")
```

## Manual delivery of dependencies {#man-del-of-dep}

To configure dependencies manually, place the compiled packages in the `usr/library/` subdirectory of the project archive.

The process of installing dependencies has resource and execution time limits. For more information, see [{#T}](../../concepts/limits.md). You can view the dependency installation log using the link that appears in the list of operations.
