function Doc( body )
	return body .. "\n"
end

local function id( s ) return s end
local function literal( val )
	return function() return val end
end
local function tag( tag )
	return function( s )
		return "[" .. tag .. "]" .. s .. "[/" .. tag .. "]"
	end
end

Blocksep = literal "\n"
Str = id
Space = literal " "
SoftBreak = literal " "
LineBreak = literal "\n"
Emph = tag "i"
Strong = tag "b"
Subscript = id
Superscript = id
SmallCaps = id
Strikeout = tag "strike"
function Link( s, src )
	return "[url=" .. src .. "]" .. s .. "[/url]"
end
function Image( _, src )
	return "[img]" .. src .. "[/img]"
end
Code = tag "u"
InlineMath = id
DisplayMath = id
Note = id
function Span( s, c )
	if string.find( c.class or "", "%f[%a]spoiler%f[%A]" ) then
		return "[spoiler]" .. s.. "[/spoiler]"
	else
		return s
	end
end
function Header( _, s )
	return "[h1]" .. s .. "[/h1]"
end
RawInline = id
Cite = id
Plain = id
Para = id
BlockQuote = tag "quote"
HorizontalRule = literal ""
LineBlock = id
CodeBlock = tag "code"
function BulletList( tab )
	local b = {}
	table.insert( b, "[list]" )
	for _, v in ipairs( tab ) do
		table.insert( b, "[*]" .. v )
	end
	table.insert( b, "[/list]" )
	return table.concat( b, "\n" )
end
function OrderedList( tab )
	local b = {}
	table.insert( b, "[olist]" )
	for _, v in ipairs( tab ) do
		table.insert( b, "[*]" .. v )
	end
	table.insert( b, "[/olist]" )
	return table.concat( b, "\n" )
end
DefinitionList = literal ""
CaptionedImage = Image
function Table( _, _, _, headers, rows )
	local b = {}
	table.insert( b, "[table]" )

	if #headers > 0 then
		table.insert( b, "[tr]" )
		for _, v in ipairs( headers ) do
			table.insert( b, "[th]" .. v .. "[/th]" )
		end
		table.insert( b, "[/tr]" )
	end

	for _, r in ipairs( rows ) do
		table.insert( b, "[tr]" )
		for _, c in ipairs( r ) do
			table.insert( b, "[td]" .. v .. "[/td]" )
		end
		table.insert( b, "[/tr]" )
	end

	table.insert( b, "[/table]" )
	return table.concat( b, "\n" )
end
RawBlock = id
Div = id

local meta = {}
meta.__index =
  function(_, key)
    io.stderr:write(string.format("WARNING: Undefined function '%s'\n",key))
    return function() return "" end
  end
setmetatable(_G, meta)
