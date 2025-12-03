---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/dataproc/cli-ref-beta/job/create.md
---

# yc beta dataproc job create

Creates a job for a cluster.

#### Command Usage

Syntax: 

`yc beta dataproc job create <CLUSTER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--cluster-id`|<b>`string`</b><br/>ID of the cluster to create a job for.|
|`--name`|<b>`string`</b><br/>Name of the job.|
|`--mapreduce-job`|<b>`shorthand/json`</b><br/>Specification for a MapReduce job.<br/><br/>Example:|
|`--mapreduce-job`|<b>`archive-uris=value,`</b><br/>args=value, driver={main-class=value}, file-uris=value, jar-file-uris=value, properties={key=value}<br/><br/>Shorthand Syntax:<br/>{archive-uris=str,..., args=str,..., driver={main-class=str \| main-jar-file-uri=str}, file-uris=str,..., jar-file-uris=str,..., properties={key=str, key=...}}<br/>Fields:<br/>archive-uris   []string                             — URIs of archives to be extracted to the working directory of Yandex Data Processing drivers and tasks.<br/>args           []string                             — Optional arguments to pass to the driver.<br/>file-uris      []string                             — URIs of resource files to be copied to the working directory of Yandex Data Processing drivers<br/>and distributed Hadoop tasks.<br/>jar-file-uris  []string                             — JAR file URIs to add to CLASSPATH of the Yandex Data Processing driver and each task.<br/>properties     map[string,string]                   — Property names and values, used to configure Yandex Data Processing and MapReduce.<br/>driver         oneof<main-class\|main-jar-file-uri>  — Oneof driver field<br/>main-jar-file-uri  string  — HCFS URI of the .jar file containing the driver class.<br/>main-class         string  — The name of the driver class.<br/>|
|`--spark-job`|<b>`shorthand/json`</b><br/>Specification for a Spark job.<br/><br/>Example:|
|`--spark-job`|<b>`archive-uris=value,`</b><br/>args=value, exclude-packages=value, file-uris=value, jar-file-uris=value, main-class=value, main-jar-file-uri=value, packages=value, properties={key=value}, repositories=value<br/><br/>Shorthand Syntax:<br/>{archive-uris=str,..., args=str,..., exclude-packages=str,..., file-uris=str,..., jar-file-uris=str,..., main-class=str, main-jar-file-uri=str, packages=str,..., properties={key=str, key=...}, repositories=str,...}<br/>Fields:<br/>archive-uris       []string            — URIs of archives to be extracted to the working directory of Yandex Data Processing drivers and tasks.<br/>args               []string            — Optional arguments to pass to the driver.<br/>exclude-packages   []string            — List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts.<br/>file-uris          []string            — URIs of resource files to be copied to the working directory of Yandex Data Processing drivers<br/>and distributed Hadoop tasks.<br/>jar-file-uris      []string            — JAR file URIs to add to CLASSPATH of the Yandex Data Processing driver and each task.<br/>main-class         string              — The name of the driver class.<br/>main-jar-file-uri  string              — The HCFS URI of the JAR file containing the 'main' class for the job.<br/>packages           []string            — List of maven coordinates of jars to include on the driver and executor classpaths.<br/>properties         map[string,string]  — Property names and values, used to configure Yandex Data Processing and Spark.<br/>repositories       []string            — List of additional remote repositories to search for the maven coordinates given with --packages.<br/>|
|`--pyspark-job`|<b>`shorthand/json`</b><br/>Specification for a PySpark job.<br/><br/>Example:|
|`--pyspark-job`|<b>`archive-uris=value,`</b><br/>args=value, exclude-packages=value, file-uris=value, jar-file-uris=value, main-python-file-uri=value, packages=value, properties={key=value}, python-file-uris=value, repositories=value<br/><br/>Shorthand Syntax:<br/>{archive-uris=str,..., args=str,..., exclude-packages=str,..., file-uris=str,..., jar-file-uris=str,..., main-python-file-uri=str, packages=str,..., properties={key=str, key=...}, python-file-uris=str,..., repositories=str,...}<br/>Fields:<br/>archive-uris          []string            — URIs of archives to be extracted to the working directory of Yandex Data Processing drivers and tasks.<br/>args                  []string            — Optional arguments to pass to the driver.<br/>exclude-packages      []string            — List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts.<br/>file-uris             []string            — URIs of resource files to be copied to the working directory of Yandex Data Processing drivers<br/>and distributed Hadoop tasks.<br/>jar-file-uris         []string            — JAR file URIs to add to CLASSPATH of the Yandex Data Processing driver and each task.<br/>main-python-file-uri  string              — URI of the file with the driver code. Must be a .py file.<br/>packages              []string            — List of maven coordinates of jars to include on the driver and executor classpaths.<br/>properties            map[string,string]  — Property names and values, used to configure Yandex Data Processing and PySpark.<br/>python-file-uris      []string            — URIs of Python files to pass to the PySpark framework.<br/>repositories          []string            — List of additional remote repositories to search for the maven coordinates given with --packages.<br/>|
|`--hive-job`|<b>`shorthand/json`</b><br/>Specification for a Hive job.<br/><br/>Example:|
|`--hive-job`|<b>`continue-on-failure=true,`</b><br/>jar-file-uris=value, properties={key=value}, query-type={query-file-uri=value}, script-variables={key=value}<br/><br/>Shorthand Syntax:<br/>{continue-on-failure=bool, jar-file-uris=str,..., properties={key=str, key=...}, query-type={query-file-uri=str \| query-list={queries=str,...}}, script-variables={key=str, key=...}}<br/>Fields:<br/>continue-on-failure  bool                              — Flag indicating whether a job should continue to run if a query fails.<br/>jar-file-uris        []string                          — JAR file URIs to add to CLASSPATH of the Hive driver and each task.<br/>properties           map[string,string]                — Property names and values, used to configure Yandex Data Processing and Hive.<br/>script-variables     map[string,string]                — Query variables and their values.<br/>query-type           oneof<query-file-uri\|query-list>  — Oneof query-type field<br/>query-file-uri  string  — URI of the script with all the necessary Hive queries.<br/>query-list      struct  — List of Hive queries to be used in the job.<br/>queries  []string  — List of Hive queries.<br/>|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom profile.|
|`--region`|<b>`string`</b><br/>Set the region.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--pager`|<b>`string`</b><br/>Set the custom pager.|
|`--format`|<b>`string`</b><br/>Set the output format: text, yaml, json, table, json-rest.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--timeout`|<b>`string`</b><br/>Set the timeout.|
|`--token`|<b>`string`</b><br/>Set the IAM token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--query`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
