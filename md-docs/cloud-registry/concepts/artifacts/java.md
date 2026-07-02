[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Registry](../../index.md) > [Концепции](../index.md) > [Артефакты](index.md) > Java-артефакт

# Java-артефакт

_Java-артефакт_ — это файл скомпилированного кода на языке [Java](https://ru.wikipedia.org/wiki/Java) и информация о нем. [Артефакты](index.md) используются для распространения библиотек, фреймворков и других компонентов, которые можно включить в проекты на Java.

## Maven {#maven-inf}

[Maven](https://maven.apache.org/) — это инструмент автоматизации сборки и система управления проектами. Для управления артефактами проекта Maven использует концепцию «зависимостей». Зависимости описываются в основном файле конфигурации проекта — `pom.xml` .

Артефакты в Maven это [ZIP-файлы](https://ru.wikipedia.org/wiki/.ZIP) со специальным содержимым, которые используются как зависимости в других проектах. Примеры артефактов: 
* [JAR (Java Archive)](https://ru.wikipedia.org/wiki/JAR);
* [WAR (Web Application Archive)](https://ru.wikipedia.org/wiki/WAR_(тип_файла)).

Подробнее о Maven читайте в [документации](https://maven.apache.org/guides/index.html).

#### Полезные ссылки {#see-also}

[Поддерживаемые типы артефактов](index.md#artifacts)