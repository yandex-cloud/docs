# Building and managing Java function dependencies

{{ sf-name }} supports two ways to manage dependencies for a Java function: automatic installation from the source code using `Maven` and adding dependencies manually to a project archive. However, you cannot configure dependencies using both methods at the same time.

### Maven {#maven}

[Maven](https://maven.apache.org/) is a system for managing dependencies in `Java`.

To deliver dependencies using `Maven`, just upload your own `Maven` project by configuring dependencies in `pom.xml`. No other actions, including project compilation, are required.

If you want to set the order of loading dependencies, upload a file named `classpath.txt` to the project root. This file lists the dependencies one by one in the required order.

{% note warning %}

Make sure the project archive root contains the `pom.xml` file.

{% endnote %}

### Manual delivery of dependencies {#man-del-of-dep}

To configure dependencies manually, place the `jar` archives of the necessary libraries in the root of the project archive. Example:

```
build.zip
+--org
+----package
+------Main.java
+--dependency.jar
```

The process of installing dependencies has resource and execution time limits. For more information, see [{#T}](../../concepts/limits.md). You can view the dependency installation log using the link that appears in the list of operations.

### Recommended versions of Java libraries {#recommended-libraries}

#|
||                  | **Java 11**       | **Java 17, Java 21** ||
|| Spring Boot      | 2.3.4.RELEASE     | 2.5.14               ||
|| Spring Framework | 5.2.9.RELEASE     | 5.3.24               ||
|| javax.servlet    | 4.0.1             | 4.0.1                ||
|#

{% note warning %}

Functions are not guaranteed to work correctly with other versions of the libraries.

{% endnote %}