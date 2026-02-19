---
editable: false
noIndex: true
---

# yc beta dataproc job create

Creates a job for a cluster.

#### Command Usage

Syntax:

`yc beta dataproc job create <CLUSTER-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--cluster-id` | `string`

ID of the cluster to create a job for. ||
|| `--name` | `string`

Name of the job. ||
|| `--mapreduce-job` | `shorthand/json`

Specification for a MapReduce job.

Shorthand Syntax:

```hcl
{
  archive-uris = string,...,
  args = string,...,
  driver = main-class=string | main-jar-file-uri=string,
  file-uris = string,...,
  jar-file-uris = string,...,
  properties = {key=string, key=...}
}
```

JSON Syntax:

```json
{
  "archive-uris": [
    "string", ...
  ],
  "args": [
    "string", ...
  ],
  "driver": {
    "main-class": "string",
    "main-jar-file-uri": "string"
  },
  "file-uris": [
    "string", ...
  ],
  "jar-file-uris": [
    "string", ...
  ],
  "properties": {
    "<key>": "string", ...
  }
}
```

Fields:

```
archive-uris -> ([]string)
  URIs of archives to be extracted to the working directory of Yandex Data Processing drivers and tasks.
args -> ([]string)
  Optional arguments to pass to the driver.
file-uris -> ([]string)
  URIs of resource files to be copied to the working directory of Yandex Data Processing drivers and distributed Hadoop tasks.
jar-file-uris -> ([]string)
  JAR file URIs to add to CLASSPATH of the Yandex Data Processing driver and each task.
properties -> (map[string,string])
  Property names and values, used to configure Yandex Data Processing and MapReduce.
driver -> (oneof<main-class|main-jar-file-uri>)
  Oneof driver field
  main-jar-file-uri -> (string)
    HCFS URI of the .jar file containing the driver class.
  main-class -> (string)
    The name of the driver class.
``` ||
|| `--spark-job` | `shorthand/json`

Specification for a Spark job.

Shorthand Syntax:

```hcl
{
  archive-uris = string,...,
  args = string,...,
  exclude-packages = string,...,
  file-uris = string,...,
  jar-file-uris = string,...,
  main-class = string,
  main-jar-file-uri = string,
  packages = string,...,
  properties = {key=string, key=...},
  repositories = string,...
}
```

JSON Syntax:

```json
{
  "archive-uris": [
    "string", ...
  ],
  "args": [
    "string", ...
  ],
  "exclude-packages": [
    "string", ...
  ],
  "file-uris": [
    "string", ...
  ],
  "jar-file-uris": [
    "string", ...
  ],
  "main-class": "string",
  "main-jar-file-uri": "string",
  "packages": [
    "string", ...
  ],
  "properties": {
    "<key>": "string", ...
  },
  "repositories": [
    "string", ...
  ]
}
```

Fields:

```
archive-uris -> ([]string)
  URIs of archives to be extracted to the working directory of Yandex Data Processing drivers and tasks.
args -> ([]string)
  Optional arguments to pass to the driver.
exclude-packages -> ([]string)
  List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts.
file-uris -> ([]string)
  URIs of resource files to be copied to the working directory of Yandex Data Processing drivers and distributed Hadoop tasks.
jar-file-uris -> ([]string)
  JAR file URIs to add to CLASSPATH of the Yandex Data Processing driver and each task.
main-class -> (string)
  The name of the driver class.
main-jar-file-uri -> (string)
  The HCFS URI of the JAR file containing the 'main' class for the job.
packages -> ([]string)
  List of maven coordinates of jars to include on the driver and executor classpaths.
properties -> (map[string,string])
  Property names and values, used to configure Yandex Data Processing and Spark.
repositories -> ([]string)
  List of additional remote repositories to search for the maven coordinates given with --packages.
``` ||
|| `--pyspark-job` | `shorthand/json`

Specification for a PySpark job.

Shorthand Syntax:

```hcl
{
  archive-uris = string,...,
  args = string,...,
  exclude-packages = string,...,
  file-uris = string,...,
  jar-file-uris = string,...,
  main-python-file-uri = string,
  packages = string,...,
  properties = {key=string, key=...},
  python-file-uris = string,...,
  repositories = string,...
}
```

JSON Syntax:

```json
{
  "archive-uris": [
    "string", ...
  ],
  "args": [
    "string", ...
  ],
  "exclude-packages": [
    "string", ...
  ],
  "file-uris": [
    "string", ...
  ],
  "jar-file-uris": [
    "string", ...
  ],
  "main-python-file-uri": "string",
  "packages": [
    "string", ...
  ],
  "properties": {
    "<key>": "string", ...
  },
  "python-file-uris": [
    "string", ...
  ],
  "repositories": [
    "string", ...
  ]
}
```

Fields:

```
archive-uris -> ([]string)
  URIs of archives to be extracted to the working directory of Yandex Data Processing drivers and tasks.
args -> ([]string)
  Optional arguments to pass to the driver.
exclude-packages -> ([]string)
  List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts.
file-uris -> ([]string)
  URIs of resource files to be copied to the working directory of Yandex Data Processing drivers and distributed Hadoop tasks.
jar-file-uris -> ([]string)
  JAR file URIs to add to CLASSPATH of the Yandex Data Processing driver and each task.
main-python-file-uri -> (string)
  URI of the file with the driver code. Must be a .py file.
packages -> ([]string)
  List of maven coordinates of jars to include on the driver and executor classpaths.
properties -> (map[string,string])
  Property names and values, used to configure Yandex Data Processing and PySpark.
python-file-uris -> ([]string)
  URIs of Python files to pass to the PySpark framework.
repositories -> ([]string)
  List of additional remote repositories to search for the maven coordinates given with --packages.
``` ||
|| `--hive-job` | `shorthand/json`

Specification for a Hive job.

Shorthand Syntax:

```hcl
{
  continue-on-failure = boolean,
  jar-file-uris = string,...,
  properties = {key=string, key=...},
  query-type = query-file-uri=string | query-list={
    queries = string,...
  },
  script-variables = {key=string, key=...}
}
```

JSON Syntax:

```json
{
  "continue-on-failure": "boolean",
  "jar-file-uris": [
    "string", ...
  ],
  "properties": {
    "<key>": "string", ...
  },
  "query-type": {
    "query-file-uri": "string",
    "query-list": {
      "queries": [
        "string", ...
      ]
    }
  },
  "script-variables": {
    "<key>": "string", ...
  }
}
```

Fields:

```
continue-on-failure -> (boolean)
  Flag indicating whether a job should continue to run if a query fails.
jar-file-uris -> ([]string)
  JAR file URIs to add to CLASSPATH of the Hive driver and each task.
properties -> (map[string,string])
  Property names and values, used to configure Yandex Data Processing and Hive.
script-variables -> (map[string,string])
  Query variables and their values.
query-type -> (oneof<query-file-uri|query-list>)
  Oneof query-type field
  query-file-uri -> (string)
    URI of the script with all the necessary Hive queries.
  query-list -> (struct)
    List of Hive queries to be used in the job.
    queries -> ([]string)
      List of Hive queries.
``` ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#