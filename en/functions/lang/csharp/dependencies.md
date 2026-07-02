# Building and managing .NET Core function dependencies

{{ sf-name }} supports two methods of managing .NET Core function dependencies: automatic installation via `nuget` and adding dependencies manually together with the source code.

## NuGet

[NuGet](https://docs.microsoft.com/en-us/nuget/what-is-nuget) is a package management system for `.net`.

To install dependencies using `nuget`, add a link to the required package to the `*.csproj` project file. No further steps are required. You can do this using the [.NET Core CLI](https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-add-package).

## Manual delivery of dependencies

To configure dependencies manually, place the compiled project with all the dependencies in the project archive root.
You can do this using the [.NET Core CLI](https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-publish) `publish` command.
In this case, you do not need to add the source code or project files to the archive.

Dependency installation is limited in terms of resources and execution time. For more information, see [{#T}](../../concepts/limits.md). You can view the dependency installation log via the link displayed in the list of operations.
