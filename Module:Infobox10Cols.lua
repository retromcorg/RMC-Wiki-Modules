local check_for_unknown_parameters = require("Module:Check for unknown parameters")._check

--[ Based on InfoBox3cols and modified by Thecow275 for use in RetroMC Wiki]--
--[ THIS IS NOT MEANT FOR USE IN OTHER WIKIS AND THUS IS NOT GUARANTEED TO WORK ]--

local p = {}
local args = {}
local origArgs = {}
local root
local lists = {
	plainlist_t = {
		patterns = {
			'^plainlist$',
			'%splainlist$',
			'^plainlist%s',
			'%splainlist%s'
		},
		found = false,
		styles = 'Plainlist/styles.css'
	},
	hlist_t = {
		patterns = {
			'^hlist$',
			'%shlist$',
			'^hlist%s',
			'%shlist%s'
		},
		found = false,
		styles = 'Hlist/styles.css'
	}
}

local function has_list_class(args_to_check)
	for _, list in pairs(lists) do
		if not list.found then
			for _, arg in pairs(args_to_check) do
				for _, pattern in ipairs(list.patterns) do
					if mw.ustring.find(arg or '', pattern) then
						list.found = true
						break
					end
				end
				if list.found then break end
			end
		end
	end
end

-- Returns the union of the values of two tables, as a sequence.
local function union(t1, t2)

	local vals = {}
	for k, v in pairs(t1) do
		vals[v] = true
	end
	for k, v in pairs(t2) do
		vals[v] = true
	end
	local ret = {}
	for k, v in pairs(vals) do
		table.insert(ret, k)
	end
	return ret
end

-- Returns a table containing the numbers of the arguments that exist
-- for the specified prefix. For example, if the prefix was 'data', and
-- 'data1', 'data2', and 'data5' exist, it would return {1, 2, 5}.
local function getArgNums(prefix, suffix)
	local nums = {}
	for k, v in pairs(args) do
		local num = tostring(k):match('^' .. prefix .. '([0-9]%d*)' .. suffix .. '$')
		if num then table.insert(nums, tonumber(num)) end
	end
	table.sort(nums)
	return nums
end

-- Adds a row to the infobox, with either a header cell
-- or a label/data cell combination.
local function addRow(rowArgs)
	if rowArgs.header then
		has_list_class({rowArgs.rowclass, rowArgs.class, args.headerclass})
		root
			:tag('tr')
				:addClass(rowArgs.rowclass)
				:cssText(rowArgs.rowstyle)
				:tag('th')
					:attr('colspan', '11')
					:addClass('infobox-header')
					:addClass(rowArgs.class)
					:addClass(args.headerclass)
					-- @deprecated next; target .infobox-<name> .infobox-header
					:cssText(args.headerstyle)
					:cssText(rowArgs.rowcellstyle)
					:cssText(args.extracellstyles[rowArgs.num .. 'k'])
					:wikitext(rowArgs.header)
	elseif rowArgs.label then
		if rowArgs.data then
			has_list_class({rowArgs.rowclass, rowArgs.class})
			local row = root:tag('tr')
			row:addClass(rowArgs.rowclass)
			row:cssText(rowArgs.rowstyle)
			row
				:tag('th')
					:attr('scope', 'row')
					:addClass('infobox-label')
					:cssText(args.labelstyle)
					:cssText(rowArgs.rowcellstyle)
					:cssText(args.extracellstyles[rowArgs.num .. 'l'])
					:wikitext(rowArgs.label)
					:done()

			local dataCell = row:tag('td')
			dataCell
				:attr('colspan', '10')
				:addClass('infobox-data')
				:addClass(rowArgs.class)
				-- @deprecated next; target .infobox-<name> .infobox-data
				:cssText(rowArgs.datastyle)
				:cssText(rowArgs.rowcellstyle)
				:cssText(args.extracellstyles[rowArgs.num])
				:newline()
				:wikitext(rowArgs.data)
		elseif rowArgs.dataa or rowArgs.datab or rowArgs.datac or rowArgs.datad or rowArgs.datae or rowArgs.dataf or rowArgs.datag or rowArgs.datah or rowArgs.dataci or rowArgs.dataj then
			has_list_class({rowArgs.rowclass, rowArgs.classa})
			local row = root:tag('tr')
			row:addClass(rowArgs.rowclass)
			row:cssText(rowArgs.rowstyle)
			row
				:tag('th')
					:attr('scope', 'row')
					:addClass('infobox-label')
					:cssText(args.labelstyle)
					:cssText(rowArgs.rowcellstyle)
					:cssText(args.extracellstyles[rowArgs.num .. 'l'])
					:wikitext(rowArgs.label)
					:done()

			local dataCella = row:tag('td')
			dataCella
				:addClass('infobox-data infobox-data-a')
				:addClass(rowArgs.classa)
				-- @deprecated next; target .infobox-<name> .infobox-data-a
				:cssText(rowArgs.dataastyle)
				:cssText(rowArgs.rowcellstyle)
				:cssText(args.extracellstyles[rowArgs.num .. 'a'])
				:newline()
				:wikitext(rowArgs.dataa)
			if rowArgs.renderb then
				has_list_class({rowArgs.classb})
				local dataCellb = row:tag('td')
				dataCellb
					:addClass('infobox-data infobox-data-b')
					:addClass(rowArgs.classb)
					-- @deprecated next; target .infobox-<name> .infobox-data-b
					:cssText(rowArgs.databstyle)
					:cssText(rowArgs.rowcellstyle)
					:cssText(args.extracellstyles[rowArgs.num .. 'b'])
					:newline()
					:wikitext(rowArgs.datab)
			end
			if rowArgs.renderc then
				has_list_class({rowArgs.classc})
				local dataCellc = row:tag('td')
				dataCellc
					:addClass('infobox-data infobox-data-c')
					:addClass(rowArgs.classc)
					-- @deprecated next; target .infobox-<name> .infobox-data-c
					:cssText(rowArgs.datacstyle)
					:cssText(rowArgs.rowcellstyle)
					:cssText(args.extracellstyles[rowArgs.num .. 'c'])
					:newline()
					:wikitext(rowArgs.datac)
			end
			if rowArgs.renderd then
				has_list_class({rowArgs.classd})
				local dataCelld = row:tag('td')
				dataCelld
					:addClass('infobox-data infobox-data-d')
					:addClass(rowArgs.classd)
					-- @deprecated next; target .infobox-<name> .infobox-data-d
					:cssText(rowArgs.datadstyle)
					:cssText(rowArgs.rowcellstyle)
					:cssText(args.extracellstyles[rowArgs.num .. 'd'])
					:newline()
					:wikitext(rowArgs.datad)
			end
			if rowArgs.rendere then
				has_list_class({rowArgs.classe})
				local dataCelle = row:tag('td')
				dataCelle
					:addClass('infobox-data infobox-data-e')
					:addClass(rowArgs.classe)
					-- @deprecated next; target .infobox-<name> .infobox-data-e
					:cssText(rowArgs.dataestyle)
					:cssText(rowArgs.rowcellstyle)
					:cssText(args.extracellstyles[rowArgs.num .. 'e'])
					:newline()
					:wikitext(rowArgs.datae)
			end
			if rowArgs.renderf then
				has_list_class({rowArgs.classf})
				local dataCellf = row:tag('td')
				dataCellf
					:addClass('infobox-data infobox-data-f')
					:addClass(rowArgs.classf)
					-- @deprecated next; target .infobox-<name> .infobox-data-f
					:cssText(rowArgs.datafstyle)
					:cssText(rowArgs.rowcellstyle)
					:cssText(args.extracellstyles[rowArgs.num .. 'f'])
					:newline()
					:wikitext(rowArgs.dataf)
			end
			if rowArgs.renderg then
				has_list_class({rowArgs.classg})
				local dataCellg = row:tag('td')
				dataCellg
					:addClass('infobox-data infobox-data-g')
					:addClass(rowArgs.classg)
					-- @deprecated next; target .infobox-<name> .infobox-data-g
					:cssText(rowArgs.datagstyle)
					:cssText(rowArgs.rowcellstyle)
					:cssText(args.extracellstyles[rowArgs.num .. 'g'])
					:newline()
					:wikitext(rowArgs.datag)
			end
			if rowArgs.renderh then
				has_list_class({rowArgs.classh})
				local dataCellh = row:tag('td')
				dataCellh
					:addClass('infobox-data infobox-data-h')
					:addClass(rowArgs.classh)
					-- @deprecated next; target .infobox-<name> .infobox-data-h
					:cssText(rowArgs.datahstyle)
					:cssText(rowArgs.rowcellstyle)
					:cssText(args.extracellstyles[rowArgs.num .. 'h'])
					:newline()
					:wikitext(rowArgs.datah)
			end
			if rowArgs.renderi then
				has_list_class({rowArgs.classi})
				local dataCelli = row:tag('td')
				dataCelli
					:addClass('infobox-data infobox-data-i')
					:addClass(rowArgs.classi)
					-- @deprecated next; target .infobox-<name> .infobox-data-i
					:cssText(rowArgs.dataistyle)
					:cssText(rowArgs.rowcellstyle)
					:cssText(args.extracellstyles[rowArgs.num .. 'i'])
					:newline()
					:wikitext(rowArgs.datai)
			end
			if rowArgs.renderj then
				has_list_class({rowArgs.classj})
				local dataCellj = row:tag('td')
				dataCellj
					:addClass('infobox-data infobox-data-j')
					:addClass(rowArgs.classj)
					-- @deprecated next; target .infobox-<name> .infobox-data-j
					:cssText(rowArgs.datajstyle)
					:cssText(rowArgs.rowcellstyle)
					:cssText(args.extracellstyles[rowArgs.num .. 'j'])
					:newline()
					:wikitext(rowArgs.dataj)
			end

		end
	elseif rowArgs.data then
		has_list_class({rowArgs.rowclass, rowArgs.class})
		local row = root:tag('tr')
		row:addClass(rowArgs.rowclass)
		row:cssText(rowArgs.rowstyle)

		local dataCell = row:tag('td')
		dataCell
			:attr('colspan', '11')
			:addClass('infobox-full-data')
			:addClass(rowArgs.class)
			-- @deprecated next; target .infobox-<name> .infobox-full-data
			:cssText(rowArgs.datastyle)
			:cssText(rowArgs.rowcellstyle)
			:cssText(args.extracellstyles[rowArgs.num])
			:newline()
			:wikitext(rowArgs.data)
	end
end

local function renderTitle()
	if not args.title then return end
	has_list_class({args.titleclass})

	root
		:tag('caption')
			:addClass('infobox-title')
			:addClass(args.titleclass)
			-- @deprecated next; target .infobox-<name> .infobox-title
			:cssText(args.titlestyle)
			:wikitext(args.title)
end

local function renderAboveRow()
	if not args.above then return end
	has_list_class({args.aboveclass})

	root
		:tag('tr')
			:tag('th')
				:attr('colspan', '11')
				:addClass('infobox-above')
				:addClass(args.aboveclass)
				-- @deprecated next; target .infobox-<name> .infobox-above
				:cssText(args.abovestyle)
				:wikitext(args.above)
end

local function renderBelowRow()
	if not args.below then return end
	has_list_class({args.belowclass})

	root
		:tag('tr')
			:tag('td')
				:attr('colspan', '11')
				:addClass('infobox-below')
				:addClass(args.belowclass)
				-- @deprecated next; target .infobox-<name> .infobox-below
				:cssText(args.belowstyle)
				:newline()
				:wikitext(args.below)
end

local function addSubheaderRow(subheaderArgs)
	if not subheaderArgs.data then return end

	has_list_class({subheaderArgs.rowclass, subheaderArgs.class})
	local row = root:tag('tr')
	row:addClass(subheaderArgs.rowclass)

	local dataCell = row:tag('td')
	dataCell
		:attr('colspan', '11')
		:addClass('infobox-subheader')
		:addClass(subheaderArgs.class)
		:cssText(subheaderArgs.datastyle)
		:cssText(subheaderArgs.rowcellstyle)
		:newline()
		:wikitext(subheaderArgs.data)
end

local function renderSubheaders()
	if args.subheader then
		args.subheader1 = args.subheader
	end
	if args.subheaderrowclass then
		args.subheaderrowclass1 = args.subheaderrowclass
	end
	local subheadernums = getArgNums('subheader','')
	for k, num in ipairs(subheadernums) do
		addSubheaderRow({
			data = args['subheader' .. tostring(num)],
			-- @deprecated next; target .infobox-<name> .infobox-subheader
			datastyle = args.subheaderstyle,
			rowcellstyle = args['subheaderstyle' .. tostring(num)],
			class = args.subheaderclass,
			rowclass = args['subheaderrowclass' .. tostring(num)]
		})
	end
end

local function addImageRow(imageArgs)
	if not imageArgs.data then return end

	has_list_class({imageArgs.rowclass, imageArgs.class})
	local row = root:tag('tr')
	row:addClass(imageArgs.rowclass)

	local dataCell = row:tag('td')
	dataCell
		:attr('colspan', '11')
		:addClass('infobox-image')
		:addClass(imageArgs.class)
		:cssText(imageArgs.datastyle)
		:newline()
		:wikitext(imageArgs.data)
end

local function renderImages()
	if args.image then
		args.image1 = args.image
	end
	if args.caption then
		args.caption1 = args.caption
	end
	local imagenums = getArgNums('image','')
	for k, num in ipairs(imagenums) do
		local caption = args['caption' .. tostring(num)]
		local data = mw.html.create():wikitext(args['image' .. tostring(num)])
		if caption then
			data
				:tag('div')
					:addClass('infobox-caption')
					-- @deprecated next; target .infobox-<name> .infobox-caption
					:cssText(args.captionstyle)
					:wikitext(caption)
		end
		addImageRow({
			data = tostring(data),
			-- @deprecated next; target .infobox-<name> .infobox-image
			datastyle = args.imagestyle,
			class = args.imageclass,
			rowclass = args['imagerowclass' .. tostring(num)]
		})
	end
end

-- Gets the union of the header and data argument numbers,
-- and renders them all in order
local function renderRows()
	local rownums = union(getArgNums('header',''), getArgNums('data','[abcdefghij]?'))
	local datab_count = #(getArgNums('data','b'))
	local datac_count = #(getArgNums('data','c'))
	local datad_count = #(getArgNums('data','d'))
	local datae_count = #(getArgNums('data','e'))
	local dataf_count = #(getArgNums('data','f'))
	local datag_count = #(getArgNums('data','g'))
	local datah_count = #(getArgNums('data','h'))
	local datai_count = #(getArgNums('data','i'))
	local dataj_count = #(getArgNums('data','j'))
	table.sort(rownums)
	for k, num in ipairs(rownums) do
		addRow({
			num = tostring(num),
			renderb = datab_count > 0,
			renderc = datac_count > 0,
			renderd = datad_count > 0,
			rendere = datae_count > 0,
			renderf = dataf_count > 0,
			renderg = datag_count > 0,
			renderh = datah_count > 0,
			renderi = datai_count > 0,
			renderj = dataj_count > 0,
			header = args['header' .. tostring(num)],
			label = args['label' .. tostring(num)],
			data = args['data' .. tostring(num)],
			datastyle = args.datastyle,
			class = args['class' .. tostring(num)],
			dataa = args['data' .. tostring(num) .. 'a'],
			dataastyle = args.datastylea,
			classa = args['class' .. tostring(num) .. 'a'],
			datab = args['data' .. tostring(num) .. 'b'],
			databstyle = args.datastyleb,
			classb = args['class' .. tostring(num) .. 'b'],
			datac = args['data' .. tostring(num) .. 'c'],
			datacstyle = args.datastylec,
			classc = args['class' .. tostring(num) .. 'c'],
			datad = args['data' .. tostring(num) .. 'd'],
			datadstyle = args.datastyled,
			classd = args['class' .. tostring(num) .. 'd'],
			datae = args['data' .. tostring(num) .. 'e'],
			dataestyle = args.datastylee,
			classe = args['class' .. tostring(num) .. 'e'],
			dataf = args['data' .. tostring(num) .. 'f'],
			datafstyle = args.datastylef,
			classf = args['class' .. tostring(num) .. 'f'],
			datag = args['data' .. tostring(num) .. 'g'],
			datagstyle = args.datastyleg,
			classg = args['class' .. tostring(num) .. 'g'],
			datah = args['data' .. tostring(num) .. 'h'],
			datahstyle = args.datastyleh,
			classh = args['class' .. tostring(num) .. 'h'],
			datai = args['data' .. tostring(num) .. 'i'],
			dataistyle = args.datastylei,
			classi = args['class' .. tostring(num) .. 'i'],
			dataj = args['data' .. tostring(num) .. 'j'],
			datajstyle = args.datastylej,
			classj = args['class' .. tostring(num) .. 'j'],
			rowclass = args['rowclass' .. tostring(num)],
			-- @deprecated next; target .infobox-<name> rowclass
			rowstyle = args['rowstyle' .. tostring(num)],
			rowcellstyle = args['rowcellstyle' .. tostring(num)],
		})
	end
end

local function renderNavBar()
	if not args.name then return end

	root
		:tag('tr')
			:tag('td')
				:attr('colspan', '10')
				:addClass('infobox-navbar')
				:wikitext(require('Module:Navbar')._navbar{
					args.name,
					mini = 1,
				})
end

local function renderItalicTitle()
	local italicTitle = args['italic title'] and mw.ustring.lower(args['italic title'])
	if italicTitle == '' or italicTitle == 'force' or italicTitle == 'yes' then
		root:wikitext(require('Module:Italic title')._main({}))
	end
end

-- Render tracking categories. args.decat == turns off tracking categories.
local function renderTrackingCategories()
	local title = mw.title.getCurrentTitle()
	if args.decat == 'yes' then return end

	if #(getArgNums('data','[abcdefghij]?')) == 0 and title.namespace == 0 then
		root:wikitext('[[Category:Articles using infobox templates with no data rows]]')
	end

	root:wikitext(check_for_unknown_parameters({
		checkpositional = "y",
		ignoreblank = "y",
		regexp1 = "header[%d]+",
		regexp2 = "label[%d]+",
		regexp3 = "data[%d]+[abcdefghij]?",
		regexp4 = "class[%d]+[abcdefghij]?",
		regexp5 = "rowclass[%d]+",
		regexp6 = "rowstyle[%d]+",
		regexp7 = "rowcellstyle[%d]+",
		unknown = "[[Category:Pages using infobox10cols with undocumented parameters|_VALUE_" .. title.text .. "]]",
		"above", "aboveclass", "aboverowclass", "abovestyle", "below", "belowclass",
		"belowrowclass", "belowstyle", "bodyclass", "bodystyle", "caption", "caption1",
		"caption2", "captionstyle", "child", "datastyle", "datastylea", "datastyleb",
		"datastylec", "datastyled", "datastylee", "datastylef", "datastyleg", "datastyleh",
		"datastylei", "datastylej", "extracellstyles", "headerstyle", "image", "image1", "image2",
		"imageclass", "imagerowclass1", "imagerowclass2", "imagestyle", "labelstyle",
		"name", "subbox", "subheader", "subheader2", "subheaderclass",
		"subheaderrowclass1", "subheaderrowclass2", "subheaderstyle", "templatestyles",
		"title", "titleclass", "titlestyle",
	}, origArgs))

	if origArgs.header0 or origArgs.label0 or origArgs.data0 or origArgs.data0a
		or origArgs.data0b or origArgs.data0c or origArgs.data0d or origArgs.data0e or origArgs.data0f or origArgs.data0g or origArgs.data0h or origArgs.data0i or origArgs.data0j or origArgs.class0 or origArgs.rowclass0 then
			root:wikitext("[[Category:Pages using infobox10cols with header0 or label0 or data0]]")
	end

	if title.namespace == 10 and mw.ustring.sub(title.text, 1, 7) == "Infobox" then
		root:wikitext("[[Category:Infobox templates|" .. mw.ustring.sub(title.text, 9) .. "]]")
	end
end

--[=[
Loads the templatestyles for the infobox.

TODO: FINISH loading base templatestyles here rather than in
MediaWiki:Common.css. There are 4-5000 pages with 'raw' infobox tables.
See [[Mediawiki_talk:Common.css/to_do#Infobox]] and/or come help :).
When we do this we should clean up the inline CSS below too.
Will have to do some bizarre conversion category like with sidebar.

]=]
local function loadTemplateStyles()
	local frame = mw.getCurrentFrame()

	local hlist_templatestyles = ''
	if lists.hlist_t.found then
		hlist_templatestyles = frame:extensionTag{
			name = 'templatestyles', args = { src = lists.hlist_t.styles }
		}
	end

	local plainlist_templatestyles = ''
	if lists.plainlist_t.found then
		plainlist_templatestyles = frame:extensionTag{
			name = 'templatestyles', args = { src = lists.plainlist_t.styles }
		}
	end

	-- See function description
	local base_templatestyles = frame:extensionTag{
		name = 'templatestyles', args = { src = 'Module:Infobox/styles.css' }
	}

	local templatestyles = ''
	if args['templatestyles'] then
		templatestyles = frame:extensionTag{
			name = 'templatestyles', args = { src = args['templatestyles'] }
		}
	end

	local child_templatestyles = ''
	if args['child templatestyles'] then
		child_templatestyles = frame:extensionTag{
			name = 'templatestyles', args = { src = args['child templatestyles'] }
		}
	end

	local grandchild_templatestyles = ''
	if args['grandchild templatestyles'] then
		grandchild_templatestyles = frame:extensionTag{
			name = 'templatestyles', args = { src = args['grandchild templatestyles'] }
		}
	end

	return table.concat({
		-- hlist -> plainlist -> base is best-effort to preserve old Common.css ordering.
		-- this ordering is not a guarantee because the rows of interest invoking
		-- each class may not be on a specific page
		hlist_templatestyles,
		plainlist_templatestyles,
		base_templatestyles,
		templatestyles,
		child_templatestyles,
		grandchild_templatestyles
	})

end

-- common functions between the child and non child cases
local function structure_infobox_common()
	renderSubheaders()
	renderImages()
--	preprocessRows()
	renderRows()
	renderBelowRow()
	renderNavBar()
	renderItalicTitle()
--	renderEmptyRowCategories()
	renderTrackingCategories()
--	cleanInfobox()
end

-- Specify the overall layout of the infobox, with special settings if the
-- infobox is used as a 'child' inside another infobox.
local function _infobox()

	root = mw.html.create('table')
	has_list_class({args.bodyclass})

	root
		:addClass((args.child == 'yes' or args.subbox == 'yes') and 'infobox-subbox' or 'infobox')
		:addClass(args.child == 'yes' and 'infobox-10cols-child' or nil)
		:addClass(args.bodyclass)
		-- @deprecated next; target .infobox-<name>
		:cssText(args.bodystyle)

	renderTitle()
	renderAboveRow()
	structure_infobox_common()

	return loadTemplateStyles() .. tostring(root)
end

-- If the argument exists and isn't blank, add it to the argument table.
-- Blank arguments are treated as nil to match the behaviour of ParserFunctions.
local function preprocessSingleArg(argName)
	if origArgs[argName] and origArgs[argName] ~= '' then
		args[argName] = origArgs[argName]
	end
end

-- Assign the parameters with the given prefixes to the args table, in order, in
-- batches of the step size specified. This is to prevent references etc. from
-- appearing in the wrong order. The prefixTable should be an array containing
-- tables, each of which has two possible fields, a "prefix" string and a
-- "depend" table. The function always parses parameters containing the "prefix"
-- string, but only parses parameters in the "depend" table if the prefix
-- parameter is present and non-blank.
local function preprocessArgs(prefixTable, step)
	if type(prefixTable) ~= 'table' then
		error("Non-table value detected for the prefix table", 2)
	end
	if type(step) ~= 'number' then
		error("Invalid step value detected", 2)
	end

	-- Get arguments without a number suffix, and check for bad input.
	for i,v in ipairs(prefixTable) do
		if type(v) ~= 'table' or type(v.prefix) ~= "string" or
			(v.depend and type(v.depend) ~= 'table') then
			error('Invalid input detected to preprocessArgs prefix table', 2)
		end
		preprocessSingleArg(v.prefix)
		-- Only parse the depend parameter if the prefix parameter is present
		-- and not blank.
		if args[v.prefix] and v.depend then
			for j, dependValue in ipairs(v.depend) do
				if type(dependValue) ~= 'string' then
					error('Invalid "depend" parameter value detected in preprocessArgs')
				end
				preprocessSingleArg(dependValue)
			end
		end
	end

	-- Get arguments with number suffixes.
	local a = 0 -- Counter variable.
	local moreArgumentsExist = true
	while moreArgumentsExist == true do
		moreArgumentsExist = false
		for i = a, a + step - 1 do
			for j,v in ipairs(prefixTable) do
				local prefixArgName = v.prefix .. tostring(i) .. (v.suffix or '')
				if origArgs[prefixArgName] then
					-- Do another loop if any arguments are found, even blank ones.
					moreArgumentsExist = true
					preprocessSingleArg(prefixArgName)
				end
				-- Process the depend table if the prefix argument is present
				-- and not blank, or we are processing "prefix1" and "prefix" is
				-- present and not blank, and if the depend table is present.
				if v.depend and (args[prefixArgName] or (i == 1 and args[v.prefix])) then
					for j,dependValue in ipairs(v.depend) do
						local dependArgName = dependValue .. tostring(i) .. (v.dependsuffix or '')
						preprocessSingleArg(dependArgName)
					end
				end
			end
		end
		a = a + step
	end
end

-- Parse the data parameters in the same order that the old {{infobox}} did, so
-- that references etc. will display in the expected places. Parameters that
-- depend on another parameter are only processed if that parameter is present,
-- to avoid phantom references appearing in article reference lists.
local function parseDataParameters()
	preprocessSingleArg('child')
	preprocessSingleArg('bodyclass')
	preprocessSingleArg('subbox')
	preprocessSingleArg('bodystyle')
	preprocessSingleArg('title')
	preprocessSingleArg('titleclass')
	preprocessSingleArg('titlestyle')
	preprocessSingleArg('above')
	preprocessSingleArg('aboveclass')
	preprocessSingleArg('abovestyle')
	preprocessArgs({
		{prefix = 'subheader', depend = {'subheaderstyle', 'subheaderrowclass'}}
	}, 10)
	preprocessSingleArg('subheaderstyle')
	preprocessSingleArg('subheaderclass')
	preprocessSingleArg('image')
	preprocessSingleArg('caption')
	preprocessArgs({
		{prefix = 'image', depend = {'caption', 'imagerowclass'}}
	}, 10)
	preprocessSingleArg('captionstyle')
	preprocessSingleArg('imagestyle')
	preprocessSingleArg('imageclass')
	preprocessArgs({
		{prefix = 'header'},
		{prefix = 'data', depend = {'label'}},
		{prefix = 'data', suffix = 'a', depend = {'label'}},
		{prefix = 'data', suffix = 'a'},
		{prefix = 'data', suffix = 'b', depend = {'label'}},
		{prefix = 'data', suffix = 'b'},
		{prefix = 'data', suffix = 'c', depend = {'label'}},
		{prefix = 'data', suffix = 'c'},
		{prefix = 'data', suffix = 'd', depend = {'label'}},
		{prefix = 'data', suffix = 'd'},
		{prefix = 'data', suffix = 'e', depend = {'label'}},
		{prefix = 'data', suffix = 'e'},
		{prefix = 'data', suffix = 'f', depend = {'label'}},
		{prefix = 'data', suffix = 'f'},
		{prefix = 'data', suffix = 'g', depend = {'label'}},
		{prefix = 'data', suffix = 'g'},
		{prefix = 'data', suffix = 'h', depend = {'label'}},
		{prefix = 'data', suffix = 'h'},
		{prefix = 'data', suffix = 'i', depend = {'label'}},
		{prefix = 'data', suffix = 'i'},
		{prefix = 'data', suffix = 'j', depend = {'label'}},
		{prefix = 'data', suffix = 'j'},
		{prefix = 'rowclass'},
		{prefix = 'rowstyle'},
		{prefix = 'rowcellstyle'},
		{prefix = 'class'}
	}, 50)
	preprocessSingleArg('headerclass')
	preprocessSingleArg('headerstyle')
	preprocessSingleArg('labelstyle')
	preprocessSingleArg('datastyle')
	preprocessSingleArg('datastylea')
	preprocessSingleArg('datastyleb')
	preprocessSingleArg('datastylec')
	preprocessSingleArg('datastyled')
	preprocessSingleArg('datastylee')
	preprocessSingleArg('datastylef')
	preprocessSingleArg('datastyleg')
	preprocessSingleArg('datastyleh')
	preprocessSingleArg('datastylei')
	preprocessSingleArg('datastylej')
	preprocessSingleArg('below')
	preprocessSingleArg('belowclass')
	preprocessSingleArg('belowstyle')
	preprocessSingleArg('name')
	-- different behaviour for italics if blank or absent
	args['italic title'] = origArgs['italic title']
	preprocessSingleArg('decat')
	preprocessSingleArg('templatestyles')
	preprocessSingleArg('child templatestyles')
	preprocessSingleArg('grandchild templatestyles')

	args['extracellstyles'] = {}
	for line in mw.text.gsplit(origArgs['extracellstyles'] or '', '\n') do
		local equals = line:find('=')
		if equals then
			for i in mw.text.gsplit(line:sub(1, equals - 1), '%s*,%s*') do
				args.extracellstyles[i] = line:sub(equals + 1)
			end
		end
	end
end

-- If called via #invoke, use the args passed into the invoking template.
-- Otherwise, for testing purposes, assume args are being passed directly in.
function p.infobox(frame)
	if frame == mw.getCurrentFrame() then
		origArgs = frame:getParent().args
	else
		origArgs = frame
	end

	parseDataParameters()

	return _infobox()
end

-- For calling via #invoke within a template
function p.infoboxTemplate(frame, extra_args)
	origArgs = extra_args or {}
	for k,v in pairs(frame.args) do origArgs[k] = mw.text.trim(v) end

	parseDataParameters()

	return _infobox()
end

-- Shortcut for making child infoboxes via #invoke.
function p.child(frame)
	return p.infoboxTemplate(frame, {child = "yes"})
end

return p
