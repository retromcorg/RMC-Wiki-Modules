local p  =  {}
local capiunto = require 'capiunto'
local RankData = mw.loadData('Module:WikiStats2/data') --[ MAKE SURE THIS IS SET TO THE ACTUAL ONE FOR THIS MODULE ]--

--[ Thecow275's WikiStats 2 1.0.0 formerly Thecow275's Profile Infobox Updater Module V1 ]

local function preprocessArg(s)
if not s then
    return nil 
end
s = s:match('^%s*(.-)%s*$') --trim whitespace
if s == '' then
    return nil
else
    return s
    end

end



function p.main(frame)
    local args = frame.args
    local username = preprocessArg(args[1])
    local datatype = preprocessArg(args[2]) -- currently unused will be used whenever I implement more datatypes
  --  local secretcreators = false

    if not username then -- check for blank username
        return 'USERNAME NOT VALID OR API ERROR'
    end

    if username == '' then
        return 'NO USERNAME INPUT'
    end

    if username == '{{{username}}}' then
        return 'TEMPLATE NOTICED'
    end

    if username == '{{{1}}}' then
        username = 'thecow275'
    end
    
    -- if username == 'thecow275_secret' then --[[or 'alephcake_secret' ]] 
  --     secretcreators = true
   --     username = 'thecow275'
  --  else
    --    secretcreators = false
  --  end

    if username then
    local data = mw.ext.externalData.getExternalData({
        url = "https://api.ashcon.app/mojang/v2/user/" .. username,
        format = 'json'
    })
    


     if not data.uuid then --check for blank uuid (if this happens hell has broken lose)
        return 'NO VALID UUID FOUND'
     end
     

     if data.uuid then --if uuid is valid then get data from johnymuffin jstats api
        local userdata = mw.ext.externalData.getExternalData({
            url = "https://statistics.johnymuffin.com/api/v1/getUser?serverID=0&uuid=" .. data.uuid,
            data = {deaths='playerDeaths',pkilled='playersKilled',joins='joinCount',traveled='metersTraveled',blocksplaced='blocksPlaced',itemsdropped='itemsDropped',trustlevel='trustLevel',blocksdestroyed='blocksDestroyed',groups = 'Groups', creatureskilled = 'creaturesKilled', balance='money'},
            format = 'json'
      })

            if userdata then -- if this doesn't trigger something has gone terribly wrong
               
                
               
                local rank = 'Wanderer'
                local bracketstyle = 'icr-t-8 icr-data'
                local rankstyle = 'icr-t-7 icr-data'
                local plusstyle = 'icr-t-4 icr-data'
                local plus = ''
                local backgroundstyle = 'icr-WandererBodyStyle'

                if userdata.groups then
                    local RankCSS = RankData[userdata.groups] --[ Warning Will break if jperms gets multiple ranks on one user support !!! ]--
                    if not RankCSS then
                        return 'ERROR: no data.lua,malformed data.lua or rank is missing from data.lua'
                    else
                        if RankCSS.rank == nil then
                            return 'ERROR: Rank does not exist in data.lua, data.lua does not exist or is malformed'
                        else
                        rank = RankCSS.rank
                        bracketstyle = RankCSS.bracketstyle
                        rankstyle = RankCSS.rankstyle
                        backgroundstyle = RankCSS.backgroundstyle
                        plus = RankCSS.plus
                        plusstyle = RankCSS.plusstyle
                        end
                    end
                                                                        -- RANKLIST END --
                  
              else
                  rank = 'Wanderer'
                  bracketstyle = 'icr-t-8 icr-data'
                  rankstyle = 'irc-t-7 icr-data'
                  backgroundstyle = 'icr-WandererBodyStyle'
              end

              local formattedrank = string.format('<span class="%s">[</span><span class="%s">%s</span><span class="%s">%s</span><span class="%s">]</span>', bracketstyle,rankstyle,rank,plusstyle,plus,bracketstyle)
              
              local styletop = 'background:#cfc;'

              --if username == 'JohnyMuffin' then  --[[ Johny Muffin Easter EGG]]
             --   styletop = 'background:#5555FF; color:#FFFFFF;'
             -- else
             -- styletop = 'background:#cfc;'
             -- end


                if datatype == 'infobox' then
                 --   local bypassluajank = 'icr-title'
                   -- if secretcreators then
                   --    bypassluajank = 'icr-title_easteregg'
                  --  else
                   --    bypassluajank = 'icr-title'
                    --end
                    
                        local args = frame:getParent().args
                      
                        local retval = capiunto.create({
                           
                            top = username,
                            bodyClass = backgroundstyle, -- DO NOT EDIT HERE SEE THE if userdate.groups section for the values (Hint: they are css classes)
                            --[[ AUTOMATE THIS WITH A LOCAL YOU CHANGE ABOVE IN THE if userdata.groups section 
                            
                            -- Add rank specific gradients to infobox_capiunto_recode.css

                            -- make sure to have a default value for the bodyClass to prevent errors and page breakage

                            -- { Custom Gradient Colors are being worked on by alephcake}

                            --< THANK YOU alephcake for providing some of the color stuff for the infobox stuff >

                            --maybe we should add a easter egg when you input username as alephcake
                            
                            --fix Johny Muffin easter egg <-- REMOVED
                            --]]
                            
                            topClass = 'icr-title'
                            
                            --bodyStyle = 'background-color: #e67373; background-image: linear-gradient(160deg, #12c8f5 , rgb(255, 0, 221)); border: 2px solid #000; border-radius: 25px; padding: 10px; margin: 5px; box-shadow: 2px 2px 5px #AAAAAA;',
                            --topStyle = styletop

                            
                        })
                        
                        
                       
                        --:addImage( args.image, args.caption )
                        retval:addImage('https://minotar.net/armor/bust/'..username..'.png','','icr-data icr-transparency2')
                        
                        --:addHeader(username, 'icr-title')
                        --retval:addRow('','')
                        
                        --:addWikitext('File:https://minotar.net/armor/bust'..username..'.png')
                        
                        retval:addRow( 'Username', username, '', 'icr-transparency1 icr-data' )
                        retval:addRow( 'UUID', data.uuid,'', 'icr-data icr-transparency2' )
                        retval:addHeader('General Stats', 'icr-header')
                        --if rank == 'Wanderer' then
                        --    retval:addRow('Rank', formattedrank, 'icr-w', 'icr-wanderer')
                        --else
                        
                        retval:addRow( 'Rank', formattedrank, '', 'icr-data icr-transparency1' )
                        --end
                        
                        retval:addRow( 'Balance', string.format("%.2f", userdata.balance),'','icr-data icr-transparency2')
                        retval:addHeader( 'Miscellaneous Stats', 'icr-header' )
                        retval:addRow( 'Join Count', userdata.joins,'', 'icr-transparency1 icr-data' )
	                    retval:addRow( 'Trust Level', userdata.trustlevel, '', 'icr-data icr-transparency2')
	                    retval:addRow( 'Player Kills', userdata.pkilled,'', 'icr-transparency1 icr-data' )
                        retval:addRow( 'Mob Kills', userdata.creatureskilled, '', 'icr-data icr-transparency2' )
                        retval:addRow( 'Deaths', userdata.deaths,'', 'icr-transparency1 icr-data' )
                        retval:addRow( 'Blocks Traveled', userdata.traveled, '', 'icr-data icr-transparency2' )
                        retval:addRow( 'Blocks Placed', userdata.blocksplaced,'', 'icr-transparency1 icr-data' )
                        retval:addRow( 'Items Dropped', userdata.itemsdropped, '', 'icr-transparency2 icr-data' )
                        retval:addRow( 'Blocks Broken', userdata.blocksdestroyed,'', 'icr-transparency1 icr-data')
                        
	                    return retval
                        
                        
                        


                 end

               
     end
      
    end
else 
    return 'something went horribly wrong'
 end

end

return p
