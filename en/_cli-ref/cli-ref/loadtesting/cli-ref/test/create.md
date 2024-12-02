---
editable: false
---

# yc loadtesting test create

Create a test

#### Command Usage

Syntax: 

`yc loadtesting test create [Flags...] [Global Flags...]`

#### Flags

| Flag | Description |
|----|----|
|`--name`|<b>`string`</b><br/>A name of the load test.|
|`--description`|<b>`string`</b><br/>A descriptions of the test.|
|`--labels`|<b>`key1=value1[,key2=value2][,"key3=val3a,val3b"]`</b><br/>Labels of the test.|
|`--configuration`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Load test configuration.<br/><br/>Possible property names:<br/><ul> <li><code>id</code>:     Specifies the id of test config to use in test.</li> <li><code>agent-id</code>:     Specifies the ID of the load testing agent to run configuration.</li> <li><code>agent-by-filter</code>:     Execute test on first available agent that matches filter string. As example: --filter='id IN (&quot;1&quot;, &quot;2&quot;, &quot;3&quot;)' --filter='name contains agent AND labels.key=value1 AND labels.another-key=value2'</li> <li><code>anonymous-agent</code>:     Specifies that test will run on anonymous agent.</li> <li><code>test-data</code>:     Test data to use in configuration in format test-data=name1[,test-data=name2...]</li> </ul>|
|`--test-data`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Test data sources in format name=\<name\>,s3file=\<s3file-name\>,s3bucket=\<s3bucket-name\><br/><br/>Possible property names:<br/><ul> <li><code>name</code>:     The name of test data object.</li> <li><code>s3bucket</code>:     Specifies the object storage bucket name where test data is stored.</li> <li><code>s3file</code>:     Specifies the file name in object storage bucket.</li> </ul>|
|`--artifacts-output-bucket`|<b>`string`</b><br/>Object Storage bucket into which test artifacts will be uploaded.|
|`--artifacts-make-archive`|Upload all artifacts as a single archive.|
|`--artifacts`|<b>`PROPERTY=VALUE[,PROPERTY=VALUE...]`</b><br/>Rules defining which files should be uploaded as artifacts. Example: 'include=*,exclude=token.json,exclude=phout.log'.<br/><br/>Default: 'include=*.log,include=*.yaml,exclude=phout*.log'.<br/><br/>Possible property names:<br/><ul> <li><code>include</code>:     Filename mask specifying which files should be uploaded as artifacts.</li> <li><code>exclude</code>:     Filename mask to make exceptions from 'include' filters.</li> </ul>|
|`--wait-idle-timeout`|<b>`duration`</b><br/>The timeout to interrupt the command if test is stuck. Works only if --wait flag is set.|
|`--wait`|Wait until test is finished|
|`--async`|Display information about the operation in progress, without waiting for the operation to complete.|

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--impersonate-service-account-id`|<b>`string`</b><br/>Set the ID of the service account to impersonate.|
|`--no-browser`|Disable opening browser for authentication.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`--jq`|<b>`string`</b><br/>Query to select values from the response using jq syntax|
|`-h`,`--help`|Display help for the command.|
