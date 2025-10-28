```mermaid
flowchart BT
    logging.viewer --> logging.editor
    logging.viewer --> logging.reader
    logging.viewer --> logging.writer

    logging.editor --> logging.admin
    logging.reader --> logging.admin
    logging.writer --> logging.admin
```