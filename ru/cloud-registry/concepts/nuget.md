---
title: NuGet-артефакт в {{ cloud-registry-full-name }}
description: NuGet-артефакт – это пакет, который содержит код, метаданные, зависимости и другие ресурсы. Пакеты NuGet используются для распространения библиотек, инструментов и компонентов для проектов на C#, F#, VB.NET, C++ и других языках платформы .NET. Артефакты из NuGet-реестра могут использоваться с Visual Studio, dotnet CLI, MSBuild и другими инструментами.
---

# NuGet-артефакт

_Артефакт [NuGet](https://ru.wikipedia.org/wiki/NuGet)_ — это файл пакета `*.nupkg`, содержащий скомпилированный код, метаданные, зависимости и другие ресурсы, хранящийся в формате [NuGet](https://www.nuget.org/) реестра. [Артефакты](artifacts.md) используются для распространения библиотек, инструментов и компонентов, которые можно интегрировать в проекты на различных языках и платформах экосистемы .NET.

Артефакты из NuGet-реестра могут использоваться с различными инструментами разработки: [Visual Studio](https://visualstudio.microsoft.com/), [dotnet CLI](https://learn.microsoft.com/dotnet/core/tools/), [MSBuild](https://learn.microsoft.com/visualstudio/msbuild/msbuild), [Paket](https://fsprojects.github.io/Paket/) и другими.

NuGet-артефакты поддерживают не только проекты на C#, но и проекты на других языках платформы .NET, включая:
* [C#](https://learn.microsoft.com/dotnet/csharp/) — основной язык платформы .NET
* [F#](https://fsharp.org/) — функциональный язык программирования для .NET
* [VB.NET](https://learn.microsoft.com/dotnet/visual-basic/) — объектно-ориентированный язык программирования
* [C++/CLI](https://learn.microsoft.com/cpp/dotnet/) — расширение C++ для работы с .NET
* Другие языки и технологии экосистемы .NET

## Инструменты разработки {#development-tools}

Артефакты из NuGet-реестра могут использоваться с различными инструментами разработки:

### Visual Studio {#visual-studio-inf}

[Visual Studio](https://visualstudio.microsoft.com/) — это интегрированная среда разработки (IDE) от Microsoft, которая предоставляет встроенную поддержку NuGet-пакетов. Visual Studio позволяет устанавливать, обновлять и управлять NuGet-пакетами через графический интерфейс или через Package Manager Console.

Для управления артефактами проекта Visual Studio использует файлы `*.csproj`, `*.vbproj` или `*.fsproj`, в которых описываются зависимости проекта.

### dotnet CLI {#dotnet-cli-inf}

[dotnet CLI](https://learn.microsoft.com/dotnet/core/tools/) — это кроссплатформенный инструмент командной строки для разработки .NET-приложений. dotnet CLI включает команды для работы с NuGet-пакетами: `dotnet add package`, `dotnet remove package`, `dotnet restore` и другие.

dotnet CLI использует файлы проекта (`*.csproj`, `*.vbproj`, `*.fsproj`) для описания зависимостей и автоматически восстанавливает пакеты из NuGet-реестров.

### MSBuild {#msbuild-inf}

[MSBuild](https://learn.microsoft.com/visualstudio/msbuild/msbuild) — это платформа сборки от Microsoft, которая используется для компиляции и сборки проектов. MSBuild интегрирован с NuGet и автоматически восстанавливает пакеты из NuGet-реестров при сборке проекта.

MSBuild читает зависимости из файлов проекта и файла `packages.config` (для старых форматов проектов) или из файлов `*.csproj` (для новых форматов проектов).

### Paket {#paket-inf}

[Paket](https://fsprojects.github.io/Paket/) — это альтернативный менеджер зависимостей для .NET, который также поддерживает работу с NuGet-реестрами. Paket обеспечивает более строгий контроль версий зависимостей и может работать с несколькими NuGet-источниками одновременно.

Paket использует файл `paket.dependencies` для описания зависимостей и файл `paket.lock` для фиксации точных версий.

## Формат артефактов {#artifact-format}

Артефакты в NuGet — это пакеты в формате `*.nupkg`, которые представляют собой ZIP-архивы со специальной структурой. Каждый пакет содержит:

* Скомпилированный код (например, DLL-файлы для .NET)
* Метаданные пакета (файл `*.nuspec` или информация в файле проекта)
* Зависимости от других пакетов
* Дополнительные ресурсы (файлы конфигурации, документация и т.д.)

Примеры типов артефактов:
* Библиотеки — сборки с кодом для использования в других проектах
* Инструменты — утилиты командной строки
* Шаблоны проектов — шаблоны для создания новых проектов
* Метапакеты — пакеты, которые содержат только зависимости от других пакетов

Подробнее об инструментах разработки читайте в документации:
* [NuGet](https://learn.microsoft.com/nuget/)
* [Visual Studio](https://learn.microsoft.com/visualstudio/)
* [.NET CLI](https://learn.microsoft.com/dotnet/core/tools/)
* [Paket](https://fsprojects.github.io/Paket/)

#### См. также {#see-also}
{% include [artifact-list](../../_includes/cloud-registry/artifacts-list.md) %}