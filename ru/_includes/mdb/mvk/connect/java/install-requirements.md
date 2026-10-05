**Перед подключением:**

1. Установите зависимости:

    ```bash
    sudo apt update && sudo apt install --yes default-jdk maven
    ```

1. Создайте директорию для проекта Maven:

    ```bash
    cd ~/ && mkdir --parents project/src/java/com/example && cd project/
    ```

1. Создайте конфигурационный файл для Maven:

    {% cut "pom.xml" %}

    ```xml
    <?xml version="1.0" encoding="utf-8"?>
    <project xmlns="http://maven.apache.org/POM/4.0.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">

      <modelVersion>4.0.0</modelVersion>
      <groupId>com.example</groupId>
      <artifactId>app</artifactId>
      <packaging>jar</packaging>
      <version>0.1.0</version>
      <properties>
        <maven.compiler.source>1.8</maven.compiler.source>
        <maven.compiler.target>1.8</maven.compiler.target>
      </properties>
      <dependencies>
        <dependency>
          <groupId>redis.clients</groupId>
          <artifactId>jedis</artifactId>
          <version>3.7.0</version>
        </dependency>
        <dependency>
          <groupId>org.slf4j</groupId>
          <artifactId>slf4j-simple</artifactId>
          <version>1.7.30</version>
        </dependency>
      </dependencies>
      <build>
        <finalName>${project.artifactId}-${project.version}</finalName>
        <sourceDirectory>src</sourceDirectory>
        <resources>
          <resource>
            <directory>src</directory>
          </resource>
        </resources>
        <plugins>
          <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-assembly-plugin</artifactId>
            <executions>
              <execution>
                <goals>
                  <goal>attached</goal>
                </goals>
                <phase>package</phase>
                <configuration>
                  <descriptorRefs>
                    <descriptorRef>
                    jar-with-dependencies</descriptorRef>
                  </descriptorRefs>
                  <archive>
                    <manifest>
                      <mainClass>com.example.App</mainClass>
                    </manifest>
                  </archive>
                </configuration>
              </execution>
            </executions>
          </plugin>
          <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-jar-plugin</artifactId>
            <version>3.1.0</version>
            <configuration>
              <archive>
                <manifest>
                  <mainClass>com.example.App</mainClass>
                </manifest>
              </archive>
            </configuration>
          </plugin>
        </plugins>
      </build>
    </project>
    ```

    {% endcut %}

    Актуальные версии зависимостей для Maven:

    * [jedis](https://mvnrepository.com/artifact/redis.clients/jedis)
    * [slf4j-simple](https://mvnrepository.com/artifact/org.slf4j/slf4j-simple)

1. Для подключения с SSL:

    1. [Получите SSL-сертификат](../../../../../managed-valkey/operations/connect/index.md#get-ssl-cert).
    1. Создайте защищенное хранилище сертификатов:

        {% list tabs group=operating_system %}

        - Linux (Bash) {#linux}

          ```bash
          awk '/-----BEGIN CERTIFICATE-----/ {n++} n {print > "YandexInternalRootCA-" n ".crt"}' \
            < ~/.redis/{{ crt-local-file }}

          for cert in YandexInternalRootCA-*.crt; do
            alias=$(
              openssl x509 -noout -text -in "${cert}" |
              perl -ne 'next unless /Subject:/; s/.*(CN=|CN = )//; print'
            )

            year=$(openssl x509 -noout -enddate -in "${cert}" | awk '{print $(NF-1)}')

            echo "Importing ${alias}-${year}"

            keytool -importcert \
                    -alias "${alias}-${year}" \
                    -file "${cert}" \
                    -keystore ~/.redis/YATrustStore \
                    -storepass <пароль_защищенного_хранилища> \
                    -noprompt

            rm "${cert}"
          done

          chmod 0655 ~/.redis/YATrustStore
          ```

        - macOS (Zsh) {#macos}

          ```bash
          split -p "-----BEGIN CERTIFICATE-----" \
            ~/.redis/{{ crt-local-file }} \
            YandexInternalRootCA-

          for cert in YandexInternalRootCA-*; do
            alias=$(
              openssl x509 -noout -text -in "${cert}" |
              perl -ne 'next unless /Subject:/; s/.*(CN=|CN = )//; print'
            )

            year=$(openssl x509 -noout -enddate -in "${cert}" | awk '{print $(NF-1)}')

            echo "Importing ${alias}-${year}"

            keytool -importcert \
                    -alias "${alias}-${year}" \
                    -file "${cert}" \
                    -keystore ~/.redis/YATrustStore \
                    -storepass <пароль_защищенного_хранилища> \
                    -noprompt

            rm "${cert}"
          done

          chmod 0655 ~/.redis/YATrustStore
          ```

        {% endlist %}

        Где `-storepass` — пароль хранилища сертификатов. Пароль должен содержать не менее 6 символов.
