local data = mw.loadData('Module:RankColor/data')
local p = {}

--[ Thecow275's RankColor Module V3]--

local RankColor_Template = [[
* Rank: %s
* RankColor: %d
* BracketColor: %d
* RankPlusColor: %d
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
    local rank = preprocessArg(args[1])
    local rankcolor = preprocessArg(args[2])
    local bracketcolor = preprocessArg(args[3]) --[ Bracket Color stuff ]–-
    local rankpluscolor = preprocessArg(args[4]) --[ The rank color stuff for the + on rank+ ranks. ]--


    -- Check for blank rank arguments
    if not rank then
        return ''
    end

    -- Get the data for the specified rank
    local rankData = data[rank]
    if not rankData then
        return ''
    end
       if rankcolor then
           -- User specified a rankcolor, so return it
           return rankData[rankcolor] or ''
    end
      if rankpluscolor then
           -- User specified a rankpluscolor, so return it
           return rankData[rankpluscolor] or ''
    end
       if bracketcolor then  --[ Bracket Color stuff ]--
           -- User specified a bracketcolor, so return it
           return rankData[bracketcolor] or ''
    else
        -- Return the rankcolor template with all the ranks in it
        return string(
            RankColor_Template,
            rankData.rank,
            rankData.rankcolor,
            rankData.bracketcolor,
            rankData.rankpluscolor
        )
    end
end

return p
