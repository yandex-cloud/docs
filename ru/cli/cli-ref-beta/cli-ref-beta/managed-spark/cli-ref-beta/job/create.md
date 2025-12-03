---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/managed-spark/cli-ref-beta/job/create.md
---

# yc beta managed-spark job create

Creates a job for Spark cluster.

#### Command Usage

Syntax: 

`yc beta managed-spark job create <CLUSTER-ID>`

#### Flags

| Flag | Description |
|----|----|
|`-r`,`--request-file`|<b>`string`</b><br/>Path to a request file.|
|`--example-json`|Generates a JSON template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/><br/>The template can be customized and used as input for the command.<br/><br/>Usage example:<br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--cluster-id`|<b>`string`</b><br/>ID of the cluster to create Spark job in.|
|`--name`|<b>`string`</b><br/>Optional. Name of the job.|
|`--service-account-id`|<b>`string`</b><br/>Service account used to access Cloud resources.|
|`--spark-job`|<b>`shorthand/json`</b><br/><br/><br/>Example:|
|`--spark-job`|<b>`archive-uris=value,`</b><br/>args=value, exclude-packages=value, file-uris=value, jar-file-uris=value, main-class=value, main-jar-file-uri=value, packages=value, properties={key=value}, repositories=value<br/><br/>Shorthand Syntax:<br/>{archive-uris=str,..., args=str,..., exclude-packages=str,..., file-uris=str,..., jar-file-uris=str,..., main-class=str, main-jar-file-uri=str, packages=str,..., properties={key=str, key=...}, repositories=str,...}<br/>Fields:<br/>archive-uris       []string            — URIs of archives to be extracted in the working directory of Spark drivers and tasks.<br/>args               []string            — Optional arguments to pass to the driver.<br/>exclude-packages   []string            — List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts.<br/>file-uris          []string            — URIs of files to be copied to the working directory of Spark drivers and distributed tasks.<br/>jar-file-uris      []string            — Jar file URIs to add to the CLASSPATHs of the Spark driver and tasks.<br/>main-class         string              — The name of the driver's main class.<br/>main-jar-file-uri  string              — URI of the jar file containing the main class.<br/>packages           []string            — List of maven coordinates of jars to include on the driver and executor classpaths.<br/>properties         map[string,string]  — A mapping of property names to values, used to configure Spark.<br/>repositories       []string            — List of additional remote repositories to search for the maven coordinates given with --packages.<br/>|
|`--pyspark-job`|<b>`shorthand/json`</b><br/><br/><br/>Example:|
|`--pyspark-job`|<b>`archive-uris=value,`</b><br/>args=value, exclude-packages=value, file-uris=value, jar-file-uris=value, main-python-file-uri=value, packages=value, properties={key=value}, python-file-uris=value, repositories=value<br/><br/>Shorthand Syntax:<br/>{archive-uris=str,..., args=str,..., exclude-packages=str,..., file-uris=str,..., jar-file-uris=str,..., main-python-file-uri=str, packages=str,..., properties={key=str, key=...}, python-file-uris=str,..., repositories=str,...}<br/>Fields:<br/>archive-uris          []string            — URIs of archives to be extracted in the working directory of Spark drivers and tasks.<br/>args                  []string            — Optional arguments to pass to the driver.<br/>exclude-packages      []string            — List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts.<br/>file-uris             []string            — URIs of files to be copied to the working directory of Spark drivers and distributed tasks.<br/>jar-file-uris         []string            — Jar file URIs to add to the CLASSPATHs of the Spark driver and tasks.<br/>main-python-file-uri  string              — URI of the main Python file to use as the driver. Must be a .py file.<br/>packages              []string            — List of maven coordinates of jars to include on the driver and executor classpaths.<br/>properties            map[string,string]  — A mapping of property names to values, used to configure Spark.<br/>python-file-uris      []string            — URIs of Python files to pass to the PySpark framework.<br/>repositories          []string            — List of additional remote repositories to search for the maven coordinates given with --packages.<br/>|
|`--spark-connect-job`|<b>`shorthand/json`</b><br/><br/><br/>Example:|
|`--spark-connect-job`|<b>`archive-uris=value,`</b><br/>exclude-packages=value, file-uris=value, jar-file-uris=value, packages=value, properties={key=value}, repositories=value<br/><br/>Shorthand Syntax:<br/>{archive-uris=str,..., exclude-packages=str,..., file-uris=str,..., jar-file-uris=str,..., packages=str,..., properties={key=str, key=...}, repositories=str,...}<br/>Fields:<br/>archive-uris      []string            — URIs of archives to be extracted in the working directory of Spark drivers and tasks.<br/>exclude-packages  []string            — List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts.<br/>file-uris         []string            — URIs of files to be copied to the working directory of Spark drivers and distributed tasks.<br/>jar-file-uris     []string            — Jar file URIs to add to the CLASSPATHs of the Spark driver and tasks.<br/>packages          []string            — List of maven coordinates of jars to include on the driver and executor classpaths.<br/>properties        map[string,string]  — A mapping of property names to values, used to configure Spark.<br/>repositories      []string            — List of additional remote repositories to search for the maven coordinates given with --packages.<br/>|
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
