# Building and managing C# function dependencies

{{ sf-name }} supports two ways to manage dependencies for a C# function: automatic installation using `nuget` and manual delivery of dependencies with the source code.

## NuGet

[NuGet](https://docs.microsoft.com/en-us/nuget/what-is-nuget) is a package management system for `.net`.

To install dependencies using `nuget`, add a link to the required package to the `*.csproj` project file. No other actions are required. You can do this using the [.NET Core CLI](https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-add-package).

## Manual delivery of dependencies

To configure dependencies manually, place the compiled project with all dependencies in the project archive root.
You can do this using the [.NET Core CLI](https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-publish) `publish` command
This does not require you to add the source code or project files to the archive.

The process of installing dependencies has resource and execution time limits. For more information, see [{#T}](../../concepts/limits.md). You can view the dependency installation log using the link that appears in the list of operations.
