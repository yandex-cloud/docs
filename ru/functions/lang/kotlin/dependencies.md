# Сборка и управление зависимостями функции на Kotlin

Сервис {{ sf-name }} поддерживает два способа управления зависимостями функции на Kotlin — автоматическую установку через Gradle из исходного кода и ручное добавление зависимостей в архив с проектом. При этом настроить зависимости одновременно двумя способами нельзя.

Установка зависимостей имеет ограничения по ресурсам и времени исполнения. Подробнее об этом читайте в разделе [{#T}](../../concepts/limits.md). Ознакомиться с журналом установки зависимостей можно по ссылке, которая отображается в списке операций.

## Gradle {#gradle}

[Gradle](https://gradle.com/) — система управления зависимостями, которую поддерживает язык Kotlin. В {{ sf-name }} используется Gradle 8.7 для сборки кода.

Для поставки зависимостей настройте их в файле `build.gradle` или `build.gradle.kts`. Никаких дополнительных действий, в том числе компиляции проекта, не требуется.

Если вы хотите использовать [SDK](sdk.md) для своих функций на Kotlin, настройте зависимости Gradle для SDK.

{% cut "Примеры файлов для поставки зависимостей" %}

Файл `build.gradle.kts`:

```kotlin
plugins {
    kotlin("jvm") version "2.0.0"
}

repositories {
    mavenCentral()
}

dependencies {
    implementation("io.insert-koin:koin-core:3.5.6")
}
```

Файл `src/main/kotlin/somepackage/Handler.kt` (точка входа — `somepackage.Handler`):

```kotlin
package somepackage

import org.koin.core.component.KoinComponent
import org.koin.core.component.inject
import org.koin.core.context.startKoin
import org.koin.dsl.module

class Repository {
    val greeting = "Hello, world!"
}

val koinModule = module {
    single { Repository() }
}

fun handle(request: String): String {
    startKoin {
        modules(koinModule)
    }
    val component = object : KoinComponent {
        val repository: Repository by inject()
    }
    return component.repository.greeting
}
```

{% endcut %}

## Ручная поставка зависимостей {#man-del-of-dep}

Чтобы настроить зависимости вручную, положите JAR-архивы нужных библиотек в корень архива с проектом. Пример:

```text
build.zip
+--org
+----package
+------Handler.kt
+--dependency.jar
```
