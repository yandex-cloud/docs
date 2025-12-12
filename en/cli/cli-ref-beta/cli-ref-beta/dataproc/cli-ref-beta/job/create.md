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
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--cluster-id`|<b>`string`</b><br/>ID of the cluster to create a job for.|
|`--name`|<b>`string`</b><br/>Name of the job.|
|`--mapreduce-job`|<b>`shorthand/json`</b><br/>Specification for a MapReduce job.<br/>Shorthand Syntax:<br/>{<br/>archive-uris = str,...,<br/>args = str,...,<br/>driver = main-class=str \| main-jar-file-uri=str,<br/>file-uris = str,...,<br/>jar-file-uris = str,...,<br/>properties = {key=str, key=...}<br/>}<br/>JSON Syntax:<br/>"{<br/>"archive-uris": [<br/>"str", ...<br/>],<br/>"args": [<br/>"str", ...<br/>],<br/>"driver": {<br/>"main-class": "str",<br/>"main-jar-file-uri": "str"<br/>},<br/>"file-uris": [<br/>"str", ...<br/>],<br/>"jar-file-uris": [<br/>"str", ...<br/>],<br/>"properties": {<br/>"\<key\>": "str", ...<br/>}<br/>}"<br/>Fields:<br/>archive-uris -> ([]string)<br/>URIs of archives to be extracted to the working directory of Yandex Data Processing drivers and tasks.<br/>args -> ([]string)<br/>Optional arguments to pass to the driver.<br/>file-uris -> ([]string)<br/>URIs of resource files to be copied to the working directory of Yandex Data Processing drivers and distributed Hadoop tasks.<br/>jar-file-uris -> ([]string)<br/>JAR file URIs to add to CLASSPATH of the Yandex Data Processing driver and each task.<br/>properties -> (map[string,string])<br/>Property names and values, used to configure Yandex Data Processing and MapReduce.<br/>driver -> (oneof<main-class\|main-jar-file-uri>)<br/>Oneof driver field<br/>main-jar-file-uri -> (string)<br/>HCFS URI of the .jar file containing the driver class.<br/>main-class -> (string)<br/>The name of the driver class.|
|`--spark-job`|<b>`shorthand/json`</b><br/>Specification for a Spark job.<br/>Shorthand Syntax:<br/>{<br/>archive-uris = str,...,<br/>args = str,...,<br/>exclude-packages = str,...,<br/>file-uris = str,...,<br/>jar-file-uris = str,...,<br/>main-class = str,<br/>main-jar-file-uri = str,<br/>packages = str,...,<br/>properties = {key=str, key=...},<br/>repositories = str,...<br/>}<br/>JSON Syntax:<br/>"{<br/>"archive-uris": [<br/>"str", ...<br/>],<br/>"args": [<br/>"str", ...<br/>],<br/>"exclude-packages": [<br/>"str", ...<br/>],<br/>"file-uris": [<br/>"str", ...<br/>],<br/>"jar-file-uris": [<br/>"str", ...<br/>],<br/>"main-class": "str",<br/>"main-jar-file-uri": "str",<br/>"packages": [<br/>"str", ...<br/>],<br/>"properties": {<br/>"\<key\>": "str", ...<br/>},<br/>"repositories": [<br/>"str", ...<br/>]<br/>}"<br/>Fields:<br/>archive-uris -> ([]string)<br/>URIs of archives to be extracted to the working directory of Yandex Data Processing drivers and tasks.<br/>args -> ([]string)<br/>Optional arguments to pass to the driver.<br/>exclude-packages -> ([]string)<br/>List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts.<br/>file-uris -> ([]string)<br/>URIs of resource files to be copied to the working directory of Yandex Data Processing drivers and distributed Hadoop tasks.<br/>jar-file-uris -> ([]string)<br/>JAR file URIs to add to CLASSPATH of the Yandex Data Processing driver and each task.<br/>main-class -> (string)<br/>The name of the driver class.<br/>main-jar-file-uri -> (string)<br/>The HCFS URI of the JAR file containing the 'main' class for the job.<br/>packages -> ([]string)<br/>List of maven coordinates of jars to include on the driver and executor classpaths.<br/>properties -> (map[string,string])<br/>Property names and values, used to configure Yandex Data Processing and Spark.<br/>repositories -> ([]string)<br/>List of additional remote repositories to search for the maven coordinates given with --packages.|
|`--pyspark-job`|<b>`shorthand/json`</b><br/>Specification for a PySpark job.<br/>Shorthand Syntax:<br/>{<br/>archive-uris = str,...,<br/>args = str,...,<br/>exclude-packages = str,...,<br/>file-uris = str,...,<br/>jar-file-uris = str,...,<br/>main-python-file-uri = str,<br/>packages = str,...,<br/>properties = {key=str, key=...},<br/>python-file-uris = str,...,<br/>repositories = str,...<br/>}<br/>JSON Syntax:<br/>"{<br/>"archive-uris": [<br/>"str", ...<br/>],<br/>"args": [<br/>"str", ...<br/>],<br/>"exclude-packages": [<br/>"str", ...<br/>],<br/>"file-uris": [<br/>"str", ...<br/>],<br/>"jar-file-uris": [<br/>"str", ...<br/>],<br/>"main-python-file-uri": "str",<br/>"packages": [<br/>"str", ...<br/>],<br/>"properties": {<br/>"\<key\>": "str", ...<br/>},<br/>"python-file-uris": [<br/>"str", ...<br/>],<br/>"repositories": [<br/>"str", ...<br/>]<br/>}"<br/>Fields:<br/>archive-uris -> ([]string)<br/>URIs of archives to be extracted to the working directory of Yandex Data Processing drivers and tasks.<br/>args -> ([]string)<br/>Optional arguments to pass to the driver.<br/>exclude-packages -> ([]string)<br/>List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts.<br/>file-uris -> ([]string)<br/>URIs of resource files to be copied to the working directory of Yandex Data Processing drivers and distributed Hadoop tasks.<br/>jar-file-uris -> ([]string)<br/>JAR file URIs to add to CLASSPATH of the Yandex Data Processing driver and each task.<br/>main-python-file-uri -> (string)<br/>URI of the file with the driver code. Must be a .py file.<br/>packages -> ([]string)<br/>List of maven coordinates of jars to include on the driver and executor classpaths.<br/>properties -> (map[string,string])<br/>Property names and values, used to configure Yandex Data Processing and PySpark.<br/>python-file-uris -> ([]string)<br/>URIs of Python files to pass to the PySpark framework.<br/>repositories -> ([]string)<br/>List of additional remote repositories to search for the maven coordinates given with --packages.|
|`--hive-job`|<b>`shorthand/json`</b><br/>Specification for a Hive job.<br/>Shorthand Syntax:<br/>{<br/>continue-on-failure = bool,<br/>jar-file-uris = str,...,<br/>properties = {key=str, key=...},<br/>query-type = query-file-uri=str \| query-list={<br/>queries = str,...<br/>},<br/>script-variables = {key=str, key=...}<br/>}<br/>JSON Syntax:<br/>"{<br/>"continue-on-failure": "bool",<br/>"jar-file-uris": [<br/>"str", ...<br/>],<br/>"properties": {<br/>"\<key\>": "str", ...<br/>},<br/>"query-type": {<br/>"query-file-uri": "str",<br/>"query-list": {<br/>"queries": [<br/>"str", ...<br/>]<br/>}<br/>},<br/>"script-variables": {<br/>"\<key\>": "str", ...<br/>}<br/>}"<br/>Fields:<br/>continue-on-failure -> (bool)<br/>Flag indicating whether a job should continue to run if a query fails.<br/>jar-file-uris -> ([]string)<br/>JAR file URIs to add to CLASSPATH of the Hive driver and each task.<br/>properties -> (map[string,string])<br/>Property names and values, used to configure Yandex Data Processing and Hive.<br/>script-variables -> (map[string,string])<br/>Query variables and their values.<br/>query-type -> (oneof<query-file-uri\|query-list>)<br/>Oneof query-type field<br/>query-file-uri -> (string)<br/>URI of the script with all the necessary Hive queries.<br/>query-list -> (struct)<br/>List of Hive queries to be used in the job.<br/>queries -> ([]string)<br/>List of Hive queries.|
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
