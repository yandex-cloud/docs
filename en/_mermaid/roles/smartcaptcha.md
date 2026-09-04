```mermaid
%%{init: {"flowchart": {'defaultRenderer': 'elk'}} }%%
flowchart BT
    smart-captcha.editor --> smart-captcha.admin
    smart-captcha.viewer --> smart-captcha.editor
    smart-captcha.auditor --> smart-captcha.viewer
```
