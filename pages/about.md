---
title : Glossary, List Types, Collections
description:

---
# Make File

* sort_by
* theme
* base_path
* data_url

## Entities
A unit of content. Entities can be documents, media, feed items. Just about anything can be an entity.

## Collection
A Collection is a collection of entities sometimes called a content repository or database. Collections provide a way to define a collection of entities.

Examples:

* Instagram Photos
* Facebook Posts
* Twitter Posts
* Github Content Repo
* Dropbox Folder

## View
A view is a list of entities filtered and sometimes modified based on a collection. The collection is filtered based on `must`, `must_not`, and `should` statements. Essentially a query against a collection.
: A specific set of filters used to filter down the collection. The list returns ID's the represent entity documents. This defines a query against a database.

Fields:

* collection
* must
* must_not
* should
* layout_default
* theme_default
* group_by

## Status
A filtered view based on the flags that have been applied to an entity.

### Added
This returns view entities that HAVE been specifically `added`.

    http://list.cape.io/{{username}}/{{list}}/added-{{size}}.json

### Removed
This returns view entities that HAVE been specifically `removed`.

    http://list.cape.io/{{username}}/{{list}}/removed-{{size}}.json

### Pending
This returns view entities that have NOT been `added` or `removed` from a list.

    http://list.cape.io/{{username}}/{{list}}/pending-{{size}}.json

### Stream
This returns items that have NOT been `removed` from a list.

    http://list.cape.io/{{username}}/{{list}}/stream-{{size}}.json

## Render
Instructions on what list to use and what to do with it. Optionally makes pages.

Fields:

* name
* list (The list of content to pass to the compiler.)
* theme_default
* layout_default
* uri - (is page if has permalink. Create as many pages as necessary based on the mustache)
* summary_lines
* latest
* items_per (Qty of items per page.)
* groups_per
* paginator (This info should be available all the time.)
* priority

## Layout
Defines mustache theme file that the entities are passed through. Theme layout files can depend on other theme files and other rendered lists.
