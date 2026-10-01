```mermaid
%%{
  init: {
    "flowchart": { "defaultRenderer": "elk" },
    "elk": { "nodePlacementStrategy": "NETWORK_SIMPLEX" }
  }
}%%
flowchart BT
    logging.viewer --> logging.editor
    logging.viewer --> logging.reader
    logging.viewer --> logging.writer

    logging.editor --> logging.admin
    logging.reader --> logging.admin
    logging.writer --> logging.admin
```
