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
|`--example-json`|Generates a JSON template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-json > request.json<br/>2. Edit the template: vim request.json<br/>3. Run with template: yc beta compute instance create -r request.json|
|`--example-yaml`|Generates a YAML template of the request.<br/>The template can be customized and used as input for the command.<br/>Usage example:<br/><br/>1. Generate template: yc beta compute instance create --example-yaml > request.yaml<br/>2. Edit the template: vim request.yaml<br/>3. Run with template: yc beta compute instance create -r request.yaml|
|`--cluster-id`|<b>`string`</b><br/>ID of the cluster to create Spark job in.|
|`--name`|<b>`string`</b><br/>Optional. Name of the job.|
|`--service-account-id`|<b>`string`</b><br/>Service account used to access Cloud resources.|
|`--spark-job`|<b>`shorthand/json`</b><br/><br/>Shorthand Syntax:<br/>{<br/>archive-uris = str,...,<br/>args = str,...,<br/>exclude-packages = str,...,<br/>file-uris = str,...,<br/>jar-file-uris = str,...,<br/>main-class = str,<br/>main-jar-file-uri = str,<br/>packages = str,...,<br/>properties = {key=str, key=...},<br/>repositories = str,...<br/>}<br/>JSON Syntax:<br/>"{<br/>"archive-uris": [<br/>"str", ...<br/>],<br/>"args": [<br/>"str", ...<br/>],<br/>"exclude-packages": [<br/>"str", ...<br/>],<br/>"file-uris": [<br/>"str", ...<br/>],<br/>"jar-file-uris": [<br/>"str", ...<br/>],<br/>"main-class": "str",<br/>"main-jar-file-uri": "str",<br/>"packages": [<br/>"str", ...<br/>],<br/>"properties": {<br/>"\<key\>": "str", ...<br/>},<br/>"repositories": [<br/>"str", ...<br/>]<br/>}"<br/>Fields:<br/>archive-uris -> ([]string)<br/>URIs of archives to be extracted in the working directory of Spark drivers and tasks.<br/>args -> ([]string)<br/>Optional arguments to pass to the driver.<br/>exclude-packages -> ([]string)<br/>List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts.<br/>file-uris -> ([]string)<br/>URIs of files to be copied to the working directory of Spark drivers and distributed tasks.<br/>jar-file-uris -> ([]string)<br/>Jar file URIs to add to the CLASSPATHs of the Spark driver and tasks.<br/>main-class -> (string)<br/>The name of the driver's main class.<br/>main-jar-file-uri -> (string)<br/>URI of the jar file containing the main class.<br/>packages -> ([]string)<br/>List of maven coordinates of jars to include on the driver and executor classpaths.<br/>properties -> (map[string,string])<br/>A mapping of property names to values, used to configure Spark.<br/>repositories -> ([]string)<br/>List of additional remote repositories to search for the maven coordinates given with --packages.|
|`--pyspark-job`|<b>`shorthand/json`</b><br/><br/>Shorthand Syntax:<br/>{<br/>archive-uris = str,...,<br/>args = str,...,<br/>exclude-packages = str,...,<br/>file-uris = str,...,<br/>jar-file-uris = str,...,<br/>main-python-file-uri = str,<br/>packages = str,...,<br/>properties = {key=str, key=...},<br/>python-file-uris = str,...,<br/>repositories = str,...<br/>}<br/>JSON Syntax:<br/>"{<br/>"archive-uris": [<br/>"str", ...<br/>],<br/>"args": [<br/>"str", ...<br/>],<br/>"exclude-packages": [<br/>"str", ...<br/>],<br/>"file-uris": [<br/>"str", ...<br/>],<br/>"jar-file-uris": [<br/>"str", ...<br/>],<br/>"main-python-file-uri": "str",<br/>"packages": [<br/>"str", ...<br/>],<br/>"properties": {<br/>"\<key\>": "str", ...<br/>},<br/>"python-file-uris": [<br/>"str", ...<br/>],<br/>"repositories": [<br/>"str", ...<br/>]<br/>}"<br/>Fields:<br/>archive-uris -> ([]string)<br/>URIs of archives to be extracted in the working directory of Spark drivers and tasks.<br/>args -> ([]string)<br/>Optional arguments to pass to the driver.<br/>exclude-packages -> ([]string)<br/>List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts.<br/>file-uris -> ([]string)<br/>URIs of files to be copied to the working directory of Spark drivers and distributed tasks.<br/>jar-file-uris -> ([]string)<br/>Jar file URIs to add to the CLASSPATHs of the Spark driver and tasks.<br/>main-python-file-uri -> (string)<br/>URI of the main Python file to use as the driver. Must be a .py file.<br/>packages -> ([]string)<br/>List of maven coordinates of jars to include on the driver and executor classpaths.<br/>properties -> (map[string,string])<br/>A mapping of property names to values, used to configure Spark.<br/>python-file-uris -> ([]string)<br/>URIs of Python files to pass to the PySpark framework.<br/>repositories -> ([]string)<br/>List of additional remote repositories to search for the maven coordinates given with --packages.|
|`--spark-connect-job`|<b>`shorthand/json`</b><br/><br/>Shorthand Syntax:<br/>{<br/>archive-uris = str,...,<br/>exclude-packages = str,...,<br/>file-uris = str,...,<br/>jar-file-uris = str,...,<br/>packages = str,...,<br/>properties = {key=str, key=...},<br/>repositories = str,...<br/>}<br/>JSON Syntax:<br/>"{<br/>"archive-uris": [<br/>"str", ...<br/>],<br/>"exclude-packages": [<br/>"str", ...<br/>],<br/>"file-uris": [<br/>"str", ...<br/>],<br/>"jar-file-uris": [<br/>"str", ...<br/>],<br/>"packages": [<br/>"str", ...<br/>],<br/>"properties": {<br/>"\<key\>": "str", ...<br/>},<br/>"repositories": [<br/>"str", ...<br/>]<br/>}"<br/>Fields:<br/>archive-uris -> ([]string)<br/>URIs of archives to be extracted in the working directory of Spark drivers and tasks.<br/>exclude-packages -> ([]string)<br/>List of groupId:artifactId, to exclude while resolving the dependencies provided in --packages to avoid dependency conflicts.<br/>file-uris -> ([]string)<br/>URIs of files to be copied to the working directory of Spark drivers and distributed tasks.<br/>jar-file-uris -> ([]string)<br/>Jar file URIs to add to the CLASSPATHs of the Spark driver and tasks.<br/>packages -> ([]string)<br/>List of maven coordinates of jars to include on the driver and executor classpaths.<br/>properties -> (map[string,string])<br/>A mapping of property names to values, used to configure Spark.<br/>repositories -> ([]string)<br/>List of additional remote repositories to search for the maven coordinates given with --packages.|
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
