---
editable: false
---

# REST: conversation.item.added

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/realtime/server-events/conversation.item.added
```

## Body parameters

**Request schema: application/json**

```json
{
  "type": "string",
  "event_id": "string",
  "item": "unknown",
  "previous_item_id": "string"
}
```

Returned when a conversation item is added (created/inserted).

#|
||Field | Description ||
|| type | **enum**

Required field. The event type. Always `conversation.item.added`.

- `conversation.item.added` ||
|| event_id | **string**

Required field.  ||
|| item | Any of **[Message](#Message)** \| **unknown** \| **unknown** \| **[FileSearchToolCall](#FileSearchToolCall)** \| **[WebSearchToolCall](#WebSearchToolCall)** \| **[ImageGenToolCall](#ImageGenToolCall)** \| **[ComputerToolCall](#ComputerToolCall)** \| **unknown** \| **[ReasoningItem](#ReasoningItem)** \| **[CodeInterpreterToolCall](#CodeInterpreterToolCall)** \| **[LocalShellToolCall](#LocalShellToolCall)** \| **[LocalShellToolCallOutput](#LocalShellToolCallOutput)** \| **[FunctionShellCall](#FunctionShellCall)** \| **[FunctionShellCallOutput](#FunctionShellCallOutput)** \| **[ApplyPatchToolCall](#ApplyPatchToolCall)** \| **[ApplyPatchToolCallOutput](#ApplyPatchToolCallOutput)** \| **[MCPListTools](#MCPListTools)** \| **[MCPApprovalRequest](#MCPApprovalRequest)** \| **[MCPApprovalResponseResource](#MCPApprovalResponseResource)** \| **[MCPToolCall](#MCPToolCall)** \| **[CustomToolCall](#CustomToolCall)** \| **[CustomToolCallOutput](#CustomToolCallOutput)** ||
|| previous_item_id | **string** ||
|#

## Message {#Message}

A message to or from the model.

#|
||Field | Description ||
|| type | **enum**

Required field. The type of the message. Always set to `message`.

- `message` ||
|| id | **string**

Required field. The unique ID of the message. ||
|| status | **enum**

Required field. 

- `in_progress`
- `completed`
- `incomplete` ||
|| role | **enum**

Required field. 

- `unknown`
- `user`
- `assistant`
- `system`
- `critic`
- `discriminator`
- `developer`
- `tool` ||
|| content[] | **unknown**

Required field.  ||
|#

## FileSearchToolCall {#FileSearchToolCall}

The results of a file search tool call.

#|
||Field | Description ||
|| id | **string**

Required field. The unique ID of the file search tool call. 
 ||
|| type | **enum**

Required field. The type of the file search tool call. Always `file_search_call`. 


- `file_search_call` ||
|| status | **enum**

Required field. The status of the file search tool call. One of `in_progress`,
`searching`, `incomplete` or `failed`, 


- `in_progress`
- `searching`
- `completed`
- `incomplete`
- `failed` ||
|| queries[] | **string**

Required field.  ||
|| results | Any of **[0Item](#0Item)** \| **null** ||
|#

## 0Item {#0Item}

#|
||Field | Description ||
|| file_id | **string**

The unique ID of the file. ||
|| text | **string**

The text that was retrieved from the file. ||
|| filename | **string**

The name of the file. ||
|| attributes | Any of **object** (map<**string**, **string**>) \| **null** ||
|| score | **number** (float)

The relevance score of the file - a value between 0 and 1. ||
|#

## WebSearchToolCall {#WebSearchToolCall}

The results of a web search tool call.

#|
||Field | Description ||
|| id | **string**

Required field. The unique ID of the web search tool call. 
 ||
|| type | **enum**

Required field. The type of the web search tool call. Always `web_search_call`. 


- `web_search_call` ||
|| status | **enum**

Required field. The status of the web search tool call. 


- `in_progress`
- `searching`
- `completed`
- `failed` ||
|| action | Any of **[WebSearchActionSearch](#WebSearchActionSearch)** \| **[WebSearchActionOpenPage](#WebSearchActionOpenPage)** \| **[WebSearchActionFind](#WebSearchActionFind)** ||
|#

## WebSearchActionSearch {#WebSearchActionSearch}

Action type "search" - Performs a web search query. 


#|
||Field | Description ||
|| type | **enum**

Required field. The action type. 


- `search` ||
|| query | **string**

Required field. The search query. 
 ||
|| sources[] | **[SourcesItem](#SourcesItem)**

Required field. A source used in the search. ||
|#

## SourcesItem {#SourcesItem}

A source used in the search.

#|
||Field | Description ||
|| type | **enum**

Required field. The type of source. Always `url`.'

- `url` ||
|| url | **string**

Required field. The URL of the source. ||
|#

## WebSearchActionOpenPage {#WebSearchActionOpenPage}

Action type "open_page" - Opens a specific URL from search results. 


#|
||Field | Description ||
|| type | **enum**

Required field. The action type. 


- `open_page` ||
|| url | **string** (uri)

Required field. The URL opened by the model. 
 ||
|#

## WebSearchActionFind {#WebSearchActionFind}

Action type "find": Searches for a pattern within a loaded page. 


#|
||Field | Description ||
|| type | **enum**

Required field. The action type. 


- `find` ||
|| url | **string** (uri)

Required field. The URL of the page searched for the pattern. 
 ||
|| pattern | **string**

Required field. The pattern or text to search for within the page. 
 ||
|#

## ImageGenToolCall {#ImageGenToolCall}

An image generation request made by the model. 


#|
||Field | Description ||
|| type | **enum**

Required field. The type of the image generation call. Always `image_generation_call`. 


- `image_generation_call` ||
|| id | **string**

Required field. The unique ID of the image generation call. 
 ||
|| status | **enum**

Required field. The status of the image generation call. 


- `in_progress`
- `completed`
- `generating`
- `failed` ||
|| result | Any of **string** \| **null** ||
|#

## ComputerToolCall {#ComputerToolCall}

CURRENTLY NOT SUPPORTED

#|
||Field | Description ||
|| type | **enum**

Required field. The type of the computer call. Always `computer_call`.

- `computer_call` ||
|| id | **string**

Required field. The unique ID of the computer call. ||
|| call_id | **string**

Required field. An identifier used when responding to the tool call with output. 
 ||
|| action | Any of **[ClickParam](#ClickParam)** \| **[DoubleClickAction](#DoubleClickAction)** \| **[Drag](#Drag)** \| **[KeyPressAction](#KeyPressAction)** \| **[Move](#Move)** \| **[Screenshot](#Screenshot)** \| **[Scroll](#Scroll)** \| **[Type](#Type)** \| **[Wait](#Wait)** ||
|| pending_safety_checks[] | **[ComputerCallSafetyCheckParam](#ComputerCallSafetyCheckParam)**

Required field. A pending safety check for the computer call. ||
|| status | **enum**

Required field. The status of the item. One of `in_progress`, `completed`, or
`incomplete`. Populated when items are returned via API. 


- `in_progress`
- `completed`
- `incomplete` ||
|#

## ClickParam {#ClickParam}

A click action.

#|
||Field | Description ||
|| type | **enum**

Required field. Specifies the event type. For a click action, this property is always `click`.

- `click` ||
|| button | **enum**

Required field. 

- `left`
- `right`
- `wheel`
- `back`
- `forward` ||
|| x | **integer**

Required field. The x-coordinate where the click occurred. ||
|| y | **integer**

Required field. The y-coordinate where the click occurred. ||
|#

## DoubleClickAction {#DoubleClickAction}

A double click action.

#|
||Field | Description ||
|| type | **enum**

Required field. Specifies the event type. For a double click action, this property is always set to `double_click`.

- `double_click` ||
|| x | **integer**

Required field. The x-coordinate where the double click occurred. ||
|| y | **integer**

Required field. The y-coordinate where the double click occurred. ||
|#

## Drag {#Drag}

A drag action. 


#|
||Field | Description ||
|| type | **enum**

Required field. Specifies the event type. For a drag action, this property is 
always set to `drag`.


- `drag` ||
|| path[] | **[DragPoint](#DragPoint)**

Required field. An x/y coordinate pair, e.g. `{ x: 100, y: 200 }`
 ||
|#

## DragPoint {#DragPoint}

An x/y coordinate pair, e.g. `{ x: 100, y: 200 }`


#|
||Field | Description ||
|| x | **integer**

Required field. The x-coordinate. ||
|| y | **integer**

Required field. The y-coordinate. ||
|#

## KeyPressAction {#KeyPressAction}

A collection of keypresses the model would like to perform.

#|
||Field | Description ||
|| type | **enum**

Required field. Specifies the event type. For a keypress action, this property is always set to `keypress`.

- `keypress` ||
|| keys[] | **string**

Required field. One of the keys the model is requesting to be pressed. ||
|#

## Move {#Move}

A mouse move action. 


#|
||Field | Description ||
|| type | **enum**

Required field. Specifies the event type. For a move action, this property is 
always set to `move`.


- `move` ||
|| x | **integer**

Required field. The x-coordinate to move to. 
 ||
|| y | **integer**

Required field. The y-coordinate to move to. 
 ||
|#

## Screenshot {#Screenshot}

A screenshot action. 


#|
||Field | Description ||
|| type | **enum**

Required field. Specifies the event type. For a screenshot action, this property is 
always set to `screenshot`.


- `screenshot` ||
|#

## Scroll {#Scroll}

A scroll action. 


#|
||Field | Description ||
|| type | **enum**

Required field. Specifies the event type. For a scroll action, this property is 
always set to `scroll`.


- `scroll` ||
|| x | **integer**

Required field. The x-coordinate where the scroll occurred. 
 ||
|| y | **integer**

Required field. The y-coordinate where the scroll occurred. 
 ||
|| scroll_x | **integer**

Required field. The horizontal scroll distance. 
 ||
|| scroll_y | **integer**

Required field. The vertical scroll distance. 
 ||
|#

## Type {#Type}

An action to type in text. 


#|
||Field | Description ||
|| type | **enum**

Required field. Specifies the event type. For a type action, this property is 
always set to `type`.


- `type` ||
|| text | **string**

Required field. The text to type. 
 ||
|#

## Wait {#Wait}

A wait action. 


#|
||Field | Description ||
|| type | **enum**

Required field. Specifies the event type. For a wait action, this property is 
always set to `wait`.


- `wait` ||
|#

## ComputerCallSafetyCheckParam {#ComputerCallSafetyCheckParam}

A pending safety check for the computer call.

#|
||Field | Description ||
|| id | **string**

Required field. The ID of the pending safety check. ||
|| code | Any of **string** \| **null** ||
|| message | Any of **string** \| **null** ||
|#

## ReasoningItem {#ReasoningItem}

A description of the chain of thought used by a reasoning model while generating a response. ''
'

#|
||Field | Description ||
|| type | **enum**

Required field. The type of the object. Always `reasoning`. 


- `reasoning` ||
|| id | **string**

Required field. The unique identifier of the reasoning content. 
 ||
|| encrypted_content | Any of **string** \| **null** ||
|| summary[] | **[Summary](#Summary)**

Required field. A summary text from the model. ||
|| content[] | **[ReasoningTextContent](#ReasoningTextContent)**

Required field. Reasoning text from the model. ||
|| status | **enum**

The status of the item. One of `in_progress`, `completed`, or
`incomplete`. Populated when items are returned via API. 


- `in_progress`
- `completed`
- `incomplete` ||
|#

## Summary {#Summary}

A summary text from the model.

#|
||Field | Description ||
|| type | **enum**

Required field. The type of the object. Always `summary_text`.

- `summary_text` ||
|| text | **string**

Required field. A summary of the reasoning output from the model so far. ||
|#

## ReasoningTextContent {#ReasoningTextContent}

Reasoning text from the model.

#|
||Field | Description ||
|| type | **enum**

Required field. The type of the reasoning text. Always `reasoning_text`.

- `reasoning_text` ||
|| text | **string**

Required field. The reasoning text from the model. ||
|#

## CodeInterpreterToolCall {#CodeInterpreterToolCall}

A tool call to run code. 


#|
||Field | Description ||
|| type | **enum**

Required field. The type of the code interpreter tool call. Always `code_interpreter_call`. 


- `code_interpreter_call` ||
|| id | **string**

Required field. The unique ID of the code interpreter tool call. 
 ||
|| status | **enum**

Required field. The status of the code interpreter tool call. Valid values are `in_progress`, `completed`, `incomplete`, `interpreting`, and `failed`. 


- `in_progress`
- `completed`
- `incomplete`
- `interpreting`
- `failed` ||
|| container_id | **string**

Required field. The ID of the container used to run the code. 
 ||
|| code | Any of **string** \| **null** ||
|| outputs | Any of **unknown** \| **null** ||
|#

## LocalShellToolCall {#LocalShellToolCall}

A tool call to run a command on the local shell. 


#|
||Field | Description ||
|| type | **enum**

Required field. The type of the local shell call. Always `local_shell_call`. 


- `local_shell_call` ||
|| id | **string**

Required field. The unique ID of the local shell call. 
 ||
|| call_id | **string**

Required field. The unique ID of the local shell tool call generated by the model. 
 ||
|| action | **[LocalShellExecAction](#LocalShellExecAction)**

Required field. Execute a shell command on the server. ||
|| status | **enum**

Required field. The status of the local shell call. 


- `in_progress`
- `completed`
- `incomplete` ||
|#

## LocalShellExecAction {#LocalShellExecAction}

Execute a shell command on the server.

#|
||Field | Description ||
|| type | **enum**

Required field. The type of the local shell action. Always `exec`.

- `exec` ||
|| command[] | **string**

Required field.  ||
|| timeout_ms | Any of **integer** \| **null** ||
|| working_directory | Any of **string** \| **null** ||
|| env | **object** (map<**string**, **string**>)

Required field.  ||
|| user | Any of **string** \| **null** ||
|#

## LocalShellToolCallOutput {#LocalShellToolCallOutput}

The output of a local shell tool call. 


#|
||Field | Description ||
|| type | **enum**

Required field. The type of the local shell tool call output. Always `local_shell_call_output`. 


- `local_shell_call_output` ||
|| id | **string**

Required field. The unique ID of the local shell tool call generated by the model. 
 ||
|| output | **string**

Required field. A JSON string of the output of the local shell tool call. 
 ||
|| status | Any of **enum** \| **null** ||
|#

## FunctionShellCall {#FunctionShellCall}

A tool call that executes one or more shell commands in a managed environment.

#|
||Field | Description ||
|| type | **enum**

Required field. The type of the item. Always `shell_call`.

- `shell_call` ||
|| id | **string**

Required field. The unique ID of the shell tool call. Populated when this item is returned via API. ||
|| call_id | **string**

Required field. The unique ID of the shell tool call generated by the model. ||
|| action | **[FunctionShellAction](#FunctionShellAction)**

Required field. Execute a shell command. ||
|| status | **enum**

Required field. 

- `in_progress`
- `completed`
- `incomplete` ||
|| created_by | **string**

The ID of the entity that created this tool call. ||
|#

## FunctionShellAction {#FunctionShellAction}

Execute a shell command.

#|
||Field | Description ||
|| commands[] | **string**

Required field. A list of commands to run. ||
|| timeout_ms | Any of **integer** \| **null** ||
|| max_output_length | Any of **integer** \| **null** ||
|#

## FunctionShellCallOutput {#FunctionShellCallOutput}

The output of a shell tool call.

#|
||Field | Description ||
|| type | **enum**

Required field. The type of the shell call output. Always `shell_call_output`.

- `shell_call_output` ||
|| id | **string**

Required field. The unique ID of the shell call output. Populated when this item is returned via API. ||
|| call_id | **string**

Required field. The unique ID of the shell tool call generated by the model. ||
|| output[] | **[FunctionShellCallOutputContent](#FunctionShellCallOutputContent)**

Required field. The content of a shell call output. ||
|| max_output_length | Any of **integer** \| **null** ||
|| created_by | **string** ||
|#

## FunctionShellCallOutputContent {#FunctionShellCallOutputContent}

The content of a shell call output.

#|
||Field | Description ||
|| stdout | **string**

Required field.  ||
|| stderr | **string**

Required field.  ||
|| outcome | Any of **[FunctionShellCallOutputTimeoutOutcome](#FunctionShellCallOutputTimeoutOutcome)** \| **[FunctionShellCallOutputExitOutcome](#FunctionShellCallOutputExitOutcome)** ||
|| created_by | **string** ||
|#

## FunctionShellCallOutputTimeoutOutcome {#FunctionShellCallOutputTimeoutOutcome}

Indicates that the shell call exceeded its configured time limit.

#|
||Field | Description ||
|| type | **enum**

Required field. The outcome type. Always `timeout`.

- `timeout` ||
|#

## FunctionShellCallOutputExitOutcome {#FunctionShellCallOutputExitOutcome}

Indicates that the shell commands finished and returned an exit code.

#|
||Field | Description ||
|| type | **enum**

Required field. The outcome type. Always `exit`.

- `exit` ||
|| exit_code | **integer**

Required field. Exit code from the shell process. ||
|#

## ApplyPatchToolCall {#ApplyPatchToolCall}

A tool call that applies file diffs by creating, deleting, or updating files.

#|
||Field | Description ||
|| type | **enum**

Required field. The type of the item. Always `apply_patch_call`.

- `apply_patch_call` ||
|| id | **string**

Required field. The unique ID of the apply patch tool call. Populated when this item is returned via API. ||
|| call_id | **string**

Required field. The unique ID of the apply patch tool call generated by the model. ||
|| status | **enum**

Required field. 

- `in_progress`
- `completed` ||
|| operation | Any of **[ApplyPatchCreateFileOperation](#ApplyPatchCreateFileOperation)** \| **[ApplyPatchDeleteFileOperation](#ApplyPatchDeleteFileOperation)** \| **[ApplyPatchUpdateFileOperation](#ApplyPatchUpdateFileOperation)** ||
|| created_by | **string**

The ID of the entity that created this tool call. ||
|#

## ApplyPatchCreateFileOperation {#ApplyPatchCreateFileOperation}

Instruction describing how to create a file via the apply_patch tool.

#|
||Field | Description ||
|| type | **enum**

Required field. Create a new file with the provided diff.

- `create_file` ||
|| path | **string**

Required field. Path of the file to create. ||
|| diff | **string**

Required field. Diff to apply. ||
|#

## ApplyPatchDeleteFileOperation {#ApplyPatchDeleteFileOperation}

Instruction describing how to delete a file via the apply_patch tool.

#|
||Field | Description ||
|| type | **enum**

Required field. Delete the specified file.

- `delete_file` ||
|| path | **string**

Required field. Path of the file to delete. ||
|#

## ApplyPatchUpdateFileOperation {#ApplyPatchUpdateFileOperation}

Instruction describing how to update a file via the apply_patch tool.

#|
||Field | Description ||
|| type | **enum**

Required field. Update an existing file with the provided diff.

- `update_file` ||
|| path | **string**

Required field. Path of the file to update. ||
|| diff | **string**

Required field. Diff to apply. ||
|#

## ApplyPatchToolCallOutput {#ApplyPatchToolCallOutput}

The output emitted by an apply patch tool call.

#|
||Field | Description ||
|| type | **enum**

Required field. The type of the item. Always `apply_patch_call_output`.

- `apply_patch_call_output` ||
|| id | **string**

Required field. The unique ID of the apply patch tool call output. Populated when this item is returned via API. ||
|| call_id | **string**

Required field. The unique ID of the apply patch tool call generated by the model. ||
|| status | **enum**

Required field. 

- `completed`
- `failed` ||
|| output | Any of **string** \| **null** ||
|| created_by | **string**

The ID of the entity that created this tool call output. ||
|#

## MCPListTools {#MCPListTools}

A list of tools available on an MCP server. 


#|
||Field | Description ||
|| type | **enum**

Required field. The type of the item. Always `mcp_list_tools`. 


- `mcp_list_tools` ||
|| id | **string**

Required field. The unique ID of the list. 
 ||
|| server_label | **string**

Required field. The label of the MCP server. 
 ||
|| tools[] | **[MCPListToolsTool](#MCPListToolsTool)**

Required field. A tool available on an MCP server. 
 ||
|| error | Any of **string** \| **null** ||
|#

## MCPListToolsTool {#MCPListToolsTool}

A tool available on an MCP server. 


#|
||Field | Description ||
|| name | **string**

Required field. The name of the tool. 
 ||
|| description | Any of **string** \| **null** ||
|| input_schema | **[InputSchema](#null)**

Required field. The JSON schema describing the tool''s input. 
 ||
|| annotations | Any of **[Annotations0](#null)** \| **null** ||
|#

## MCPApprovalRequest {#MCPApprovalRequest}

A request for human approval of a tool invocation. 


#|
||Field | Description ||
|| type | **enum**

Required field. The type of the item. Always `mcp_approval_request`. 


- `mcp_approval_request` ||
|| id | **string**

Required field. The unique ID of the approval request. 
 ||
|| server_label | **string**

Required field. The label of the MCP server making the request. 
 ||
|| name | **string**

Required field. The name of the tool to run. 
 ||
|| arguments | **string**

Required field. A JSON string of arguments for the tool. 
 ||
|#

## MCPApprovalResponseResource {#MCPApprovalResponseResource}

A response to an MCP approval request. 


#|
||Field | Description ||
|| type | **enum**

Required field. The type of the item. Always `mcp_approval_response`. 


- `mcp_approval_response` ||
|| id | **string**

Required field. The unique ID of the approval response 
 ||
|| approval_request_id | **string**

Required field. The ID of the approval request being answered. 
 ||
|| approve | **boolean**

Required field. Whether the request was approved. 
 ||
|| reason | Any of **string** \| **null** ||
|#

## MCPToolCall {#MCPToolCall}

An invocation of a tool on an MCP server. 


#|
||Field | Description ||
|| type | **enum**

Required field. The type of the item. Always `mcp_call`. 


- `mcp_call` ||
|| id | **string**

Required field. The unique ID of the tool call. 
 ||
|| server_label | **string**

Required field. The label of the MCP server running the tool. 
 ||
|| name | **string**

Required field. The name of the tool that was run. 
 ||
|| arguments | **string**

Required field. A JSON string of the arguments passed to the tool. 
 ||
|| output | Any of **string** \| **null** ||
|| error | Any of **string** \| **null** ||
|| status | **enum**

- `in_progress`
- `completed`
- `incomplete`
- `calling`
- `failed` ||
|| approval_request_id | Any of **string** \| **null** ||
|#

## CustomToolCall {#CustomToolCall}

A call to a custom tool created by the model.

#|
||Field | Description ||
|| type | **enum**

Required field. The type of the custom tool call. Always `custom_tool_call`.

- `custom_tool_call` ||
|| id | **string**

The unique ID of the custom tool call in the Yandex Cloud AI Studio platform. ||
|| call_id | **string**

Required field. An identifier used to map this custom tool call to a tool call output. ||
|| name | **string**

Required field. The name of the custom tool being called. ||
|| input | **string**

Required field. The input for the custom tool call generated by the model. ||
|#

## CustomToolCallOutput {#CustomToolCallOutput}

The output of a custom tool call from your code, being sent back to the model.

#|
||Field | Description ||
|| type | **enum**

Required field. The type of the custom tool call output. Always `custom_tool_call_output`.

- `custom_tool_call_output` ||
|| id | **string**

The unique ID of the custom tool call output in the Yandex Cloud AI Studio platform. ||
|| call_id | **string**

Required field. The call ID, used to map this custom tool call output to a custom tool call. ||
|| output | Any of **string** \| **unknown** ||
|#

## Response {#200}

**HTTP Code: 200**

OK