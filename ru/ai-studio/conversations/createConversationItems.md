---
editable: false
---

# REST: Create items

Create items in a conversation with the given ID.

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/conversations/{conversation_id}/items
```

## Path parameters

#|
||Field | Description ||
|| conversation_id | **string**

Required field. The ID of the conversation to add the item to. ||
|#

## Query parameters

#|
||Field | Description ||
|| include[] | **enum**

[CURRENTLY NOT SUPPORTED] Additional fields to include in the response.

[CURRENTLY NOT SUPPORTED]

- `file_search_call.results`
- `web_search_call.results`
- `web_search_call.action.sources`
- `message.input_image.image_url`
- `computer_call_output.output.image_url`
- `code_interpreter_call.outputs`
- `reasoning.encrypted_content`
- `message.output_text.logprobs` ||
|#

## Body parameters

**Request schema: application/json**

```json
{
  "items": [
    {
      "<anyOf>": [
        {
          "role": "string",
          "content": "unknown",
          "type": "string"
        },
        {
          "<anyOf>": [
            {
              "type": "string",
              "role": "string",
              "status": "string",
              "content": [
                {
                  "<anyOf>": [
                    {
                      "type": "string",
                      "text": "string"
                    },
                    {
                      "type": "string",
                      "image_url": "unknown",
                      "file_id": "unknown",
                      "detail": "string"
                    },
                    {
                      "type": "string",
                      "file_id": "unknown",
                      "filename": "string",
                      "file_url": "string",
                      "file_data": "string"
                    }
                  ]
                }
              ]
            },
            {
              "id": "string",
              "type": "string",
              "role": "string",
              "content": [
                {
                  "<anyOf>": [
                    {
                      "type": "string",
                      "text": "string",
                      "annotations": [
                        {
                          "<anyOf>": [
                            {
                              "type": "string",
                              "file_id": "string",
                              "index": "integer",
                              "filename": "string"
                            },
                            {
                              "type": "string",
                              "url": "string",
                              "start_index": "integer",
                              "end_index": "integer",
                              "title": "string"
                            },
                            {
                              "type": "string",
                              "container_id": "string",
                              "file_id": "string",
                              "start_index": "integer",
                              "end_index": "integer",
                              "filename": "string"
                            },
                            {
                              "type": "string",
                              "file_id": "string",
                              "index": "integer"
                            }
                          ]
                        }
                      ],
                      "logprobs": [
                        {
                          "token": "string",
                          "logprob": "number",
                          "bytes": [
                            "integer"
                          ],
                          "top_logprobs": [
                            {
                              "token": "string",
                              "logprob": "number",
                              "bytes": [
                                "integer"
                              ]
                            }
                          ]
                        }
                      ]
                    },
                    {
                      "type": "string",
                      "refusal": "string"
                    }
                  ]
                }
              ],
              "status": "string"
            },
            {
              "id": "string",
              "type": "string",
              "status": "string",
              "queries": [
                "string"
              ],
              "results": "unknown"
            },
            {
              "type": "string",
              "id": "string",
              "call_id": "string",
              "action": "unknown",
              "pending_safety_checks": [
                {
                  "id": "string",
                  "code": "unknown",
                  "message": "unknown"
                }
              ],
              "status": "string"
            },
            {
              "id": "unknown",
              "call_id": "string",
              "type": "string",
              "output": {
                "type": "string",
                "image_url": "string",
                "file_id": "string"
              },
              "acknowledged_safety_checks": "unknown",
              "status": "unknown"
            },
            {
              "id": "string",
              "type": "string",
              "status": "string",
              "action": {
                "<anyOf>": [
                  {
                    "type": "string",
                    "query": "string",
                    "sources": [
                      {
                        "type": "string",
                        "url": "string"
                      }
                    ]
                  },
                  {
                    "type": "string",
                    "url": "string"
                  },
                  {
                    "type": "string",
                    "url": "string",
                    "pattern": "string"
                  }
                ]
              }
            },
            {
              "id": "string",
              "type": "string",
              "call_id": "string",
              "name": "string",
              "arguments": "string",
              "status": "string"
            },
            {
              "id": "unknown",
              "call_id": "string",
              "type": "string",
              "output": "unknown",
              "status": "unknown"
            },
            {
              "type": "string",
              "id": "string",
              "encrypted_content": "unknown",
              "summary": [
                {
                  "type": "string",
                  "text": "string"
                }
              ],
              "content": [
                {
                  "type": "string",
                  "text": "string"
                }
              ],
              "status": "string"
            },
            {
              "id": "unknown",
              "type": "string",
              "encrypted_content": "string"
            },
            {
              "type": "string",
              "id": "string",
              "status": "string",
              "result": "unknown"
            },
            {
              "type": "string",
              "id": "string",
              "status": "string",
              "container_id": "string",
              "code": "unknown",
              "outputs": "unknown"
            },
            {
              "type": "string",
              "id": "string",
              "call_id": "string",
              "action": {
                "type": "string",
                "command": [
                  "string"
                ],
                "timeout_ms": "unknown",
                "working_directory": "unknown",
                "env": {
                  "string": "string"
                },
                "user": "unknown"
              },
              "status": "string"
            },
            {
              "type": "string",
              "id": "string",
              "output": "string",
              "status": "unknown"
            },
            {
              "id": "unknown",
              "call_id": "string",
              "type": "string",
              "action": {
                "commands": [
                  "string"
                ],
                "timeout_ms": "unknown",
                "max_output_length": "unknown"
              },
              "status": "unknown"
            },
            {
              "id": "unknown",
              "call_id": "string",
              "type": "string",
              "output": [
                {
                  "stdout": "string",
                  "stderr": "string",
                  "outcome": "unknown"
                }
              ],
              "max_output_length": "unknown"
            },
            {
              "type": "string",
              "id": "unknown",
              "call_id": "string",
              "status": "string",
              "operation": "unknown"
            },
            {
              "type": "string",
              "id": "unknown",
              "call_id": "string",
              "status": "string",
              "output": "unknown"
            },
            {
              "type": "string",
              "id": "string",
              "server_label": "string",
              "tools": [
                {
                  "name": "string",
                  "description": "unknown",
                  "input_schema": {},
                  "annotations": "unknown"
                }
              ],
              "error": "unknown"
            },
            {
              "type": "string",
              "id": "string",
              "server_label": "string",
              "name": "string",
              "arguments": "string"
            },
            {
              "type": "string",
              "id": "unknown",
              "approval_request_id": "string",
              "approve": "boolean",
              "reason": "unknown"
            },
            {
              "type": "string",
              "id": "string",
              "server_label": "string",
              "name": "string",
              "arguments": "string",
              "output": "unknown",
              "error": "unknown",
              "status": "string",
              "approval_request_id": "unknown"
            },
            {
              "type": "string",
              "id": "string",
              "call_id": "string",
              "output": "unknown"
            },
            {
              "type": "string",
              "id": "string",
              "call_id": "string",
              "name": "string",
              "input": "string"
            }
          ]
        },
        {
          "type": "unknown",
          "id": "string"
        }
      ]
    }
  ]
}
```

#|
||Field | Description ||
|| items[] | **unknown**

Required field.  ||
|#

## Response {#200}

**HTTP Code: 200**

OK

**Response schema: application/json**

```json
{
  "object": "list",
  "data": [
    {
      "<anyOf>": [
        {
          "type": "string",
          "id": "string",
          "status": "string",
          "role": "string",
          "content": [
            {
              "<anyOf>": [
                {
                  "type": "string",
                  "text": "string"
                },
                {
                  "type": "string",
                  "text": "string",
                  "annotations": [
                    {
                      "<anyOf>": [
                        {
                          "type": "string",
                          "file_id": "string",
                          "index": "integer",
                          "filename": "string"
                        },
                        {
                          "type": "string",
                          "url": "string",
                          "start_index": "integer",
                          "end_index": "integer",
                          "title": "string"
                        },
                        {
                          "type": "string",
                          "container_id": "string",
                          "file_id": "string",
                          "start_index": "integer",
                          "end_index": "integer",
                          "filename": "string"
                        },
                        {
                          "type": "string",
                          "file_id": "string",
                          "index": "integer"
                        }
                      ]
                    }
                  ],
                  "logprobs": [
                    {
                      "token": "string",
                      "logprob": "number",
                      "bytes": [
                        "integer"
                      ],
                      "top_logprobs": [
                        {
                          "token": "string",
                          "logprob": "number",
                          "bytes": [
                            "integer"
                          ]
                        }
                      ]
                    }
                  ]
                },
                {
                  "type": "string",
                  "text": "string"
                },
                {
                  "type": "string",
                  "text": "string"
                },
                {
                  "type": "string",
                  "text": "string"
                },
                {
                  "type": "string",
                  "refusal": "string"
                },
                {
                  "type": "string",
                  "image_url": "unknown",
                  "file_id": "unknown",
                  "detail": "string"
                },
                {
                  "type": "string",
                  "image_url": "unknown",
                  "file_id": "unknown"
                },
                {
                  "type": "string",
                  "file_id": "unknown",
                  "filename": "string",
                  "file_url": "string",
                  "file_data": "string"
                }
              ]
            }
          ]
        },
        "unknown",
        "unknown",
        {
          "id": "string",
          "type": "string",
          "status": "string",
          "queries": [
            "string"
          ],
          "results": "unknown"
        },
        {
          "id": "string",
          "type": "string",
          "status": "string",
          "action": {
            "<anyOf>": [
              {
                "type": "string",
                "query": "string",
                "sources": [
                  {
                    "type": "string",
                    "url": "string"
                  }
                ]
              },
              {
                "type": "string",
                "url": "string"
              },
              {
                "type": "string",
                "url": "string",
                "pattern": "string"
              }
            ]
          }
        },
        {
          "type": "string",
          "id": "string",
          "status": "string",
          "result": "unknown"
        },
        {
          "type": "string",
          "id": "string",
          "call_id": "string",
          "action": "unknown",
          "pending_safety_checks": [
            {
              "id": "string",
              "code": "unknown",
              "message": "unknown"
            }
          ],
          "status": "string"
        },
        "unknown",
        {
          "type": "string",
          "id": "string",
          "encrypted_content": "unknown",
          "summary": [
            {
              "type": "string",
              "text": "string"
            }
          ],
          "content": [
            {
              "type": "string",
              "text": "string"
            }
          ],
          "status": "string"
        },
        {
          "type": "string",
          "id": "string",
          "status": "string",
          "container_id": "string",
          "code": "unknown",
          "outputs": "unknown"
        },
        {
          "type": "string",
          "id": "string",
          "call_id": "string",
          "action": {
            "type": "string",
            "command": [
              "string"
            ],
            "timeout_ms": "unknown",
            "working_directory": "unknown",
            "env": {
              "string": "string"
            },
            "user": "unknown"
          },
          "status": "string"
        },
        {
          "type": "string",
          "id": "string",
          "output": "string",
          "status": "unknown"
        },
        {
          "type": "string",
          "id": "string",
          "call_id": "string",
          "action": {
            "commands": [
              "string"
            ],
            "timeout_ms": "unknown",
            "max_output_length": "unknown"
          },
          "status": "string",
          "created_by": "string"
        },
        {
          "type": "string",
          "id": "string",
          "call_id": "string",
          "output": [
            {
              "stdout": "string",
              "stderr": "string",
              "outcome": "unknown",
              "created_by": "string"
            }
          ],
          "max_output_length": "unknown",
          "created_by": "string"
        },
        {
          "type": "string",
          "id": "string",
          "call_id": "string",
          "status": "string",
          "operation": "unknown",
          "created_by": "string"
        },
        {
          "type": "string",
          "id": "string",
          "call_id": "string",
          "status": "string",
          "output": "unknown",
          "created_by": "string"
        },
        {
          "type": "string",
          "id": "string",
          "server_label": "string",
          "tools": [
            {
              "name": "string",
              "description": "unknown",
              "input_schema": {},
              "annotations": "unknown"
            }
          ],
          "error": "unknown"
        },
        {
          "type": "string",
          "id": "string",
          "server_label": "string",
          "name": "string",
          "arguments": "string"
        },
        {
          "type": "string",
          "id": "string",
          "approval_request_id": "string",
          "approve": "boolean",
          "reason": "unknown"
        },
        {
          "type": "string",
          "id": "string",
          "server_label": "string",
          "name": "string",
          "arguments": "string",
          "output": "unknown",
          "error": "unknown",
          "status": "string",
          "approval_request_id": "unknown"
        },
        {
          "type": "string",
          "id": "string",
          "call_id": "string",
          "name": "string",
          "input": "string"
        },
        {
          "type": "string",
          "id": "string",
          "call_id": "string",
          "output": "unknown"
        }
      ]
    }
  ],
  "has_more": "boolean",
  "first_id": "string",
  "last_id": "string"
}
```

A list of Conversation items.

#|
||Field | Description ||
|| object | **list** (const)

Required field. The type of object returned, must be `list`. ||
|| data[] | **unknown**

Required field. A single item within a conversation. The set of possible types are the same as the `output` type of a Response object. ||
|| has_more | **boolean**

Required field. Whether there are more items available. ||
|| first_id | **string**

Required field. The ID of the first item in the list. ||
|| last_id | **string**

Required field. The ID of the last item in the list. ||
|#