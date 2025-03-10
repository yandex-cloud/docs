# Dictionaries for dialog tags

A _dictionary_ is a collection of key phrases for [dictionary tags](tags.md#dictionary-tags). If a {{ speechsense-name }} dialog contains a phrase from a dictionary, a tag mapped to that dictionary is assigned to such a dialog.

Dictionaries allow you to reuse a group of keywords in multiple tags. This way, you can list the required words once and manage them as a single dictionary. If the user updates keywords in a dictionary, such updates will automatically apply to all tags associated with that dictionary. If a tag contains multiple dictionaries, their contents are joined as if by the logical OR operator.

{{ speechsense-name }} has three dictionary groups:

* _System dictionaries_: Preset dictionaries. Each project has the same system dictionaries. You can only change their activation status. You cannot create, edit, or delete system dictionaries.
* _Space dictionaries_: Dictionaries the user creates and configures at the space level. If activated, such dictionaries are available in all projects within the space.
* _Project dictionaries_: Dictionaries the user creates and configures at the project level. Different projects can have different dictionaries.

System dictionaries can be viewed by all users. To view space and project dictionaries, users need the `{{ roles-speechsense-viewer }}` role or higher in a space or project.

To create, edit, or delete dictionaries, follow [this guide](../operations/index.md#dictionary).
