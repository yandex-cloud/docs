# Java artifact

A _Java artifact_ is a file containing compiled [Java](https://en.wikipedia.org/wiki/Java_(programming_language)) code and relevant information. [Artifacts](artifacts.md) are used to distribute libraries, frameworks, and other components you can add to Java projects.

[Maven](https://maven.apache.org/) is a project build automation tool. It utilizes the concept of _dependencies_ to manage project artifacts. Dependencies are described in the `pom.xml` file, which is the main file of a Maven project.

There are different types of artifacts in Maven: [JAR (Java archive)](https://en.wikipedia.org/wiki/JAR_(file_format)), [WAR (web application archive)](https://en.wikipedia.org/wiki/WAR_(file_format)), and others. Essentially, these are [ZIP files](https://en.wikipedia.org/wiki/ZIP_(file_format)) with specific content that allows you to use them as dependencies in other projects.
