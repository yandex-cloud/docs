# Building and managing dependencies

{{ sf-name }} supports two ways to manage dependencies: automatic installation using `NuGet` and manual delivery of dependencies with the source code.

## NuGet

[NuGet](https://docs.microsoft.com/en-us/nuget/what-is-nuget) is a package management system for `.NET`.

To install dependencies using `NuGet`, add a link to the required package to the `*.csproj` project file. No other actions are required. You can do this using the [.NET Core CLI](https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-add-package).

## Manual delivery of dependencies

To configure dependencies manually, place the compiled project with all dependencies in the root of the project archive.
You can do this using the command `publish` [.in the NET Core CLI](https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-publish)
В этом случает не нужно добавлять исходный код и файлы проекта в архив.

The process of installing dependencies has resource and execution time limits. For more information, see [{#T}](../../concepts/limits.md). You can view the dependency installation log using the link that appears in the list of operations.