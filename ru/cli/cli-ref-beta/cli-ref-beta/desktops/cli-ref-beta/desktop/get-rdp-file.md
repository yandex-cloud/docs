---
editable: false
noIndex: true
sourcePath: en/_cli-ref-beta/cli-ref-beta/desktops/cli-ref-beta/desktop/get-rdp-file.md
---

# yc beta desktops desktop get-rdp-file

Returns a RDP file for the specified desktop.

#### Command Usage

Syntax: 

`yc beta desktops desktop get-rdp-file <DESKTOP-ID>`

#### Flags

| Flag | Description |
|----|----|
|`--desktop-id`|<b>`string`</b><br/>ID of the desktop resource to return.<br/><br/>To get the desktop ID use a [DesktopService.List] request.|
|`--user`|<b>`shorthand/json`</b><br/>User of the desktop.<br/><br/>Example:|
|`--user`|<b>`subject-id=value,`</b><br/>subject-type=value<br/><br/>Shorthand Syntax:<br/>{subject-id=str, subject-type=str}<br/>Fields:<br/>subject-id    string  required  — Identity of the access binding.<br/>subject-type  string  required  — Type of the access binding, e.g. userAccount, serviceAccount, system.|

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
