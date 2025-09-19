---
title: Java artifacts in {{ cloud-registry-full-name }}
description: A Java artifact is a file containing compiled Java code and relevant information. Artifacts are used to distribute libraries, frameworks, and other components you can add to Java projects.
---

# Java artifact

A _Java artifact_ is a file containing compiled [Java](https://en.wikipedia.org/wiki/Java_(programming_language)) code and relevant information. [Artifacts](artifacts.md) are used to distribute libraries, frameworks, and other components you can add to Java projects.

## Maven {#maven-inf}

[Maven](https://maven.apache.org/) is a project build automation tool and a project management system. To manage project artifacts, it relies on the dependency concept. Dependencies are described in the main project configuration file named `pom.xml`.

In Maven, artifacts are [ZIP files](https://en.wikipedia.org/wiki/ZIP_(file_format)) with specific content which are used as dependencies in other projects. Examples of artifacts: 
* [JAR (Java Archive)](https://en.wikipedia.org/wiki/JAR_(file_format))
* [WAR (Web Application Archive)](https://en.wikipedia.org/wiki/WAR_(file_format)).

For more information about Maven, see [this documentation](https://maven.apache.org/guides/index.html).

#### See also {#see-also}

* [Docker image](./docker-image.md)
* [{#T}](./art-nodejs.md)
* [{#T}](./art-nuget.md)
* [{#T}](./art-python.md)