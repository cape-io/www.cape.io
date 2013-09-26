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
A unit of content. Entities can be documents, media, feed items. Just about anything can be an entity. Each entity has a list of views that the entity shows up in.

The required arguments for each entity:

* provider
* index
* id

## View
A view is a list of filtered (and sometimes modified) entities based on a collection. The collection is filtered based on `must`, `must_not`, and `should` statements. Essentially a query against a collection. Normally it is a field and value are specified and it must match exactly. In other cases special methods are enabled for more advanced comparisons. The field value is passed through the method and the result is then compared to the value in the view.

Methods:

* basename
* dirname
* ext 

A specific set of filters used to filter down the collection. The list returns ID's the represent entity documents. This defines a query against a database.

The most basic type of filter is applied to the id. The filter is a regular expression string or an array of exact match id strings. The array must contain one or more values.

Fields:

* collection
* must
* must_not
* should
* layout_default
* theme_default
* group_by


## Collection
A Collection is a source of content. Sometimes called a content repository or database. Defining a collection subscribes to the provider and listens for updates.

Examples:

* Github Repository
* Instagram Photos
* Facebook Posts
* Twitter Posts
* Dropbox Folder


## List
View entities filtered based on the flag (added or removed) that has been applied to an entity.

### Added
This returns view entities that HAVE been flagged `added`.

    http://list.cape.io/{{username}}/{{list}}/added-{{size}}.json

### Removed
This returns view entities that HAVE been flagged `removed`.

    http://list.cape.io/{{username}}/{{list}}/removed-{{size}}.json

### Pending
This returns view entities that have NOT been flagged `added` or `removed`.

    http://list.cape.io/{{username}}/{{list}}/pending-{{size}}.json

### Stream
This returns items that have NOT been flagged `removed`.

    http://list.cape.io/{{username}}/{{list}}/stream-{{size}}.json

## Render
Instructions on what status to use and what to do with it. Optionally makes pages.

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
