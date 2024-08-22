# Building and managing Kotlin function dependencies

{{ sf-name }} supports two ways to manage Kotlin function dependencies: automatic installation from the source code using Gradle and adding dependencies manually to a project archive. However, you cannot configure dependencies using both methods at the same time.

Installing dependencies has resource and execution time limits. For more information, see [{#T}](../../concepts/limits.md). You can view the dependency installation log using the link that appears in the list of operations.

## Gradle {#gradle}

[Gradle](https://gradle.com/) is a system for managing dependencies in Kotlin. {{ sf-name }} uses Gradle 8.7 to build code.

To deliver dependencies, configure them in the `build.gradle` or `build.gradle.kts` file. No other actions, including project compilation, are required.

If you want to use the [SDK](sdk.md) for your functions in Kotlin, configure the Gradle dependencies for the SDK.

{% cut "Examples of files for delivering dependencies" %}

`build.gradle.kts`:

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

`src/main/kotlin/somepackage/Handler.kt` (entry point: `somepackage.Handler`):

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

## Manual delivery of dependencies {#man-del-of-dep}

To configure dependencies manually, place the JAR archives of the required libraries in the project archive root. Example:

```text
build.zip
+--org
+----package
+------Handler.kt
+--dependency.jar
```
