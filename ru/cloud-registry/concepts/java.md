---
title: Java-артефакты в {{ cloud-registry-full-name }}
description: Java-артефакт — это файл, содержащий скомпилированный код и информацию о нем.
---

# Java-артефакт

_Java-артефакт_ — это файл скомпилированного кода и информация о нем, хранящийся в формате [Maven](https://maven.apache.org/) репозитория. [Артефакты](artifacts.md) используются для распространения библиотек, фреймворков и других компонентов, которые можно включить в проекты на различных языках и платформах.

Артефакты из Maven-репозитория могут использоваться как с инструментом сборки [Maven](https://maven.apache.org/), так и с [Gradle](https://gradle.org/), который также поддерживает работу с Maven-репозиториями.

Java-артефакты поддерживают не только проекты на Java, но и проекты на других языках и платформах, включая:
* [Java](https://ru.wikipedia.org/wiki/Java) — основной язык экосистемы
* [Kotlin](https://kotlinlang.org/) — язык программирования, компилируемый в JVM байт-код
* [Scala](https://www.scala-lang.org/) — язык программирования для JVM
* [Groovy](https://groovy-lang.org/) — динамический язык для JVM
* [Android](https://www.android.com/) — платформа для мобильных устройств
* Другие языки и платформы, поддерживаемые через плагины Maven

## Инструменты сборки {#build-tools}

Артефакты из Maven-реестра могут использоваться с различными инструментами сборки:

### Maven {#maven-inf}

[Maven](https://maven.apache.org/) — это инструмент автоматизации сборки и система управления проектами. Хотя Maven изначально создавался для проектов на Java, он поддерживает работу с различными языками программирования и технологиями через систему плагинов, включая Scala, Kotlin, Groovy, C#, C++ и другие.

Для управления артефактами проекта Maven использует концепцию «зависимостей». Зависимости описываются в основном файле конфигурации проекта — `pom.xml`.

### Gradle {#gradle-inf}

[Gradle](https://gradle.org/) — это современный инструмент автоматизации сборки, который также поддерживает работу с Maven-репозиториями. Gradle широко используется в проектах на Java, Kotlin, Scala и особенно популярен для разработки Android-приложений.

Gradle может использовать артефакты из Maven-репозиториев, читая метаданные из `pom.xml` файлов. Зависимости в Gradle описываются в файлах `build.gradle` или `build.gradle.kts`.

## Формат артефактов {#artifact-format}

Артефакты в Maven это [ZIP-файлы](https://ru.wikipedia.org/wiki/.ZIP) со специальным содержимым, которые используются как зависимости в других проектах. Примеры артефактов: 
* [JAR (Java Archive)](https://ru.wikipedia.org/wiki/JAR) — для Java и JVM-языков
* [WAR (Web Application Archive)](https://ru.wikipedia.org/wiki/WAR_(тип_файла)) — для веб-приложений
* [AAR (Android Archive)](https://developer.android.com/studio/projects/android-library) — для Android-библиотек
* Артефакты для других языков и платформ, поддерживаемых через плагины Maven

Подробнее об инструментах сборки читайте в документации:
* [Maven](https://maven.apache.org/guides/index.html)
* [Gradle](https://docs.gradle.org/)

#### См. также {#see-also}
{% include [artifact-list](../../_includes/cloud-registry/artifacts-list.md) %}
