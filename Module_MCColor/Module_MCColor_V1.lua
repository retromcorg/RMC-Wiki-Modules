local data = mw.loadData('Module:MCColor/data')
local p = {}

--[ Thecow275's MC-Color Module V1]--

local MCColor_Template = [[
* MCColor: %s
* WikiColor: %d

]]

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
    local wikicolor = preprocessArg(args[2])
   -- local bracketcolor = preprocessArg(args[3]) --[ Bracket Color stuff ]–-
   -- local rankpluscolor = preprocessArg(args[4]) --[ The mccolor stuff for the + on rank+ ranks. ]--


    -- Check for blank mccolor arguments
    if not mccolor then
        return ''
    end

    -- Get the data for the specified mccolor
    local MCColorData = data[mccolor]
    if not MCColorData then
        return ''
    end
       if wikicolor then
           -- User specified a wikicolor, so return it
           return MCColorData[wikicolor] or ''
    else
        -- Return the MC-Color template with all the ranks in it
        return string(
            MCColor_Template,
            MCColorData.mccolor,
            MCColorData.wikicolor
           
        )
end
end

return p
