1. [Установите Java](https://www.oracle.com/java/technologies/downloads/).
1. [Установите Apache Maven](https://maven.apache.org/install.html) для сборки проекта.
1. [Создайте проект](https://docs.aws.amazon.com/sdk-for-java/latest/developer-guide/get-started.html#get-started-projectsetup) согласно инструкции из документации AWS.
    
    Ниже приведена структура созданного проекта:

    ```text
    getstarted
    ├── README.md
    ├── pom.xml
    └── src
        ├── main
        │   ├── java
        │   │   └── org
        │   │       └── example
        │   │           ├── App.java
        │   │           ├── DependencyFactory.java
        │   │           └── Handler.java
        │   └── resources
        │       └── simplelogger.properties
        └── test
            └── java
                └── org
                    └── example
                        └── HandlerTest.java

    10 directories, 7 files
    ```

1. [Внесите изменения в код проекта](https://docs.aws.amazon.com/sdk-for-java/latest/developer-guide/get-started.html#get-started-code) согласно инструкции из документации AWS.