local data = mw.loadData('Module:MCColor/data')
local p = {}

--[ Thecow275's MC-Color Module V2]--

-- Trim whitespace from args, and treat blank args as nil
local function preprocessArg(s)
    if not s then
        return nil
    end
    s = s:match('^%s*(.-)%s*$') -- trim whitespace
    if s == '' then
        return nil
    else
        return s
    end
end

function p.main(frame)
    local args = frame.args
    local mccolor = preprocessArg(args[1])

    -- Check for blank mccolor arguments
    if not mccolor then
        return ''
    end

    -- Get the data for the specified mccolor
    local MCColorData = data[mccolor]
    if not MCColorData then
        return ''
    else
           return MCColorData.wikicolor or ''
end
end

return p
