**Connecting:**

```bash
mvn clean package && \
  java -jar target/app-0.1.0-jar-with-dependencies.jar
```

If the connection to the cluster and the test query are successful, the `bar` string is output.

