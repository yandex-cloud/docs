# Building and managing Java function dependencies

{{ sf-name }} supports two ways to manage Java function dependencies: automatic installation from the source code using Maven and adding dependencies manually to a project archive. However, you cannot configure dependencies using both methods at the same time.

The process of installing dependencies has resource and execution time limits. For more information, see [{#T}](../../concepts/limits.md). You can view the dependency installation log using the link that appears in the list of operations.

## Maven {#maven}

[Maven](https://maven.apache.org/) is a system for managing dependencies in Java.

To deliver dependencies, configure them in the `pom.xml` file. No other actions, including project compilation, are required.

To set the loading order for dependencies, upload a file named `classpath.txt` to the project root. This file must list the dependencies line by line in the required order.

{% note warning %}

Make sure the project archive root contains the `pom.xml` file.

{% endnote %}

## Manual delivery of dependencies {#man-del-of-dep}

To configure dependencies manually, place the JAR archives of the required libraries in the project archive root. Example:

```text
build.zip
+--org
+----package
+------Main.java
+--dependency.jar
```

## Recommended versions of Java libraries {#recommended-libraries}

#|
||                  | **Java 11**       | **Java 17, Java 21** ||
|| Spring Boot      | 2.3.4.RELEASE     | 2.5.14               ||
|| Spring Framework | 5.2.9.RELEASE     | 5.3.24               ||
|| javax.servlet    | 4.0.1             | 4.0.1                ||
|#

{% note warning %}

Functions are not guaranteed to work correctly with other versions of the libraries.

{% endnote %}
