1. [Install Java](https://www.oracle.com/java/technologies/downloads/).
1. [Install Apache Maven](https://maven.apache.org/install.html) to build your project.
1. [Create a project](https://docs.aws.amazon.com/sdk-for-java/latest/developer-guide/get-started.html#get-started-projectsetup) as described in the AWS guide.
    
    Below is the structure of the created project:

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

1. [Edit the project code](https://docs.aws.amazon.com/sdk-for-java/latest/developer-guide/get-started.html#get-started-code) as described in the AWS guide.