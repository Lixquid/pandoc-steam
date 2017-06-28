# Pandoc Steam Filter

This is a small script to output Steam compatible BBCode.

Note that not all BBCode elements are supported everywhere. For example, tables
are not supported in Workshop Item descriptions.

## Usage

`pandoc <input file> -t steam.lua`

## Extended Note

Spoilers can be created by attaching the `spoiler` class to a `Span`. For
example, in HTML / Markdown this is achieved with
`<span class="spoiler">Hidden Text</span>`.
