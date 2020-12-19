# Building and managing dependencies

## Pre-installed packages

The runtime has the following set of pre-installed packages that can be used from the function code:
`httr`, `logging`, `data.table`, `dplyr`, `paws`, `rjson`, `stringr`, `BiocManager`, `ggplot2`, `plotly`, `devtools`, `Rcpp`, `tidyr`, `lubridate`, `e1071`, `caret`, `mongolite`, and `Rsamtools`.

## Installing additional packages

When creating a new [function version](../../operations/function/version-manage.md#func-version-create), {{ sf-name }} lets you install dependencies required for the function to run. To do this, upload a file named `packages.R` to the project root with a description of the package installation process.

The service also supports manual delivery of dependencies along with the source code.

## packages.R

This script is executed once when creating a function version.

Example of installing a package via `packages.R`:

```R
install.packages("purrr", repo="http://cran.r-project.org")
```

## Manual delivery of dependencies

To configure dependencies manually, place the compiled packages in the `usr/library/` subdirectory of the project archive.

The process of installing dependencies has resource and execution time limits. For more information, see [{#T}](../../concepts/limits.md). You can view the dependency installation log using the link that appears in the list of operations.