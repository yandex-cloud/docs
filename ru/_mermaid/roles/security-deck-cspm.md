```mermaid
%%{init: {"flowchart": {'defaultRenderer': 'elk'}} }%%
flowchart BT
    cspm.admin --> security-deck.admin
    cspm.editor --> cspm.admin
    cspm.viewer --> cspm.editor
    cspm.auditor --> cspm.viewer

    cspm.editor --> security-deck.editor
    cspm.viewer --> security-deck.viewer
    cspm.auditor --> security-deck.auditor
    cspm.worker --> security-deck.worker

    security-deck.auditor --> security-deck.viewer
    security-deck.viewer --> security-deck.editor
    security-deck.editor --> security-deck.admin

    security-deck.auditor ~~~ security-deck.admin
```
