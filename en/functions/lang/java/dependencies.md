# Building and managing Java function dependencies

Сервис {{ sf-name }} поддерживает два способа управления зависимостями функции на Java — автоматическую установку через `maven` из исходного кода и ручное добавление зависимостей в архив с собранным проектом. При этом настроить зависимости одновременно двумя способами нельзя.

{{ sf-name }} supports two ways to manage dependencies for a Java function: automatic installation using `maven` from source code and manual dependency bundling along with the compiled code. However, you can't configure dependencies using both methods at the same time.

### Maven

[Maven](https://maven.apache.org/) is a system for managing dependencies in `Java`.

To deliver dependencies using `maven`, just upload your own `maven` project by configuring dependencies in `pom.xml`. No other actions are required (including project compilation).

If you want to set the order of loading dependencies, upload a file named `classpath.txt` to the project root. This file lists the dependencies one by one in the required order.

{% note warning %}

Make sure the project archive root contains the `pom.xml` file.

{% endnote %}

### Manual delivery of dependencies

To configure dependencies manually, place the `jar` archives of the necessary libraries in the root of the compiled project archive. Example:

```
build.zip
+--org
+----package
+------Main.class
+--dependency.jar
```

The process of installing dependencies has resource and execution time limits. For more information, see [{#T}](../../concepts/limits.md). You can view the dependency installation log using the link that appears in the list of operations.
