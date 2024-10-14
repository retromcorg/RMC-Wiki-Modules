local p  =  {}
local capiunto = require 'capiunto'


--[ Thecow275's Profile Infobox Updater Module V1 ]

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
               
                
               
                local rank = 'nul'
                local bracketstyle = 'icr-t-a icr-data'
                local rankstyle = 'icr-t-a icr-data'
                local plusstyle = 'icr-t-4 icr-data'
                local plus = ''
                

                if userdata.groups then                                               -- RANKLIST START --
                    if string.find(userdata.groups, "admin") then  --ADMIN
                     rank = 'Admin'
                     bracketstyle = 'icr-t-f icr-data'
                     rankstyle = 'icr-t-4 icr-data'
                    end
                  if string.find(userdata.groups, "trial") then  -- Trial Helper
                      rank = 'Trial Helper' 
                      bracketstyle = 'icr-t-f icr-data'
                      rankstyle = 'icr-t-a icr-data'
                    end
                  if string.find(userdata.groups, "moderator") then -- Moderator
                      rank = 'Moderator'
                      bracketstyle = 'icr-t-f icr-data'
                      rankstyle = 'icr-t-6 icr-data'
                  end
                  if string.find(userdata.groups, "helper") then -- Helper
                      rank = 'Helper'
                      bracketstyle = 'icr-t-f icr-data'
                      rankstyle = 'icr-t-3 icr-data'
                  end
                  if string.find(userdata.groups, "developer") then -- Developer
                      rank = 'Developer'
                      bracketstyle = 'icr-t-f icr-data'
                      rankstyle = 'icr-t-c icr-data'
                  end
                  if string.find(userdata.groups, "diamondcitizen") then -- Diamond Citizen
                      rank = 'Diamond Citizen'
                      bracketstyle = 'icr-t-b icr-data'
                      rankstyle = 'icr-t-a icr-data'
                  end
                  if string.find(userdata.groups, "citizen") then -- Citizen
                      rank = 'Citizen'
                      bracketstyle = 'icr-t-f icr-data'
                      rankstyle = 'icr-t-a icr-data'
                  end
                  if string.find(userdata.groups, "trusted") then -- Gold Citizen
                      rank = 'Gold Citizen'
                      bracketstyle = 'icr-t-6 icr-data'
                      rankstyle = 'icr-t-a icr-data'
                  end
                  if string.find(userdata.groups, "hero") then -- Hero
                      rank = 'Hero'
                      bracketstyle = 'icr-t-f icr-data'
                      rankstyle = 'icr-t-2 icr-data'
                  end
                  if string.find(userdata.groups, "legend") then -- Legend
                      rank = 'Legend'
                      bracketstyle = 'icr-t-f icr-data'
                      rankstyle = 'icr-t-9 icr-data'
                  end
                  if string.find(userdata.groups, "mystic") then -- Mystic
                      rank = 'Mystic'
                      bracketstyle = 'icr-t-f icr-data'
                      rankstyle = 'icr-t-b icr-data'
                  end
                  if string.find(userdata.groups, "donator") then -- Donator
                      rank = 'Donator'
                      bracketstyle = 'icr-t-8 icr-data'
                      rankstyle = 'icr-t-c icr-data'
                  end
                  if string.find(userdata.groups, "donatorplus") then -- Donator+
                      rank = 'Donator'
                      bracketstyle = 'icr-t-8 icr-data'
                      rankstyle = 'icr-t-c icr-data'
                      plus = '+'
                  end
                  if string.find(userdata.groups, "donatorplusplus") then -- Donator++
                      rank = 'Donator'
                      bracketstyle = 'icr-t-8 icr-data'
                      rankstyle = 'icr-t-c icr-data'
                      plus = '++'
                  end
                  if string.find(userdata.groups, "trooper") then -- Trooper
                      rank = 'Trooper'
                      bracketstyle = 'icr-t-f icr-data'
                      rankstyle = 'icr-t-d icr-data'
                  end
                  if string.find(userdata.groups, "infrastructure") then -- Infrastructure (not used)
                      rank = 'Infrastructure'
                      bracketstyle = 'icr-t-f icr-data'
                      rankstyle = 'icr-t-6 icr-data'
                  end
                                                                        -- RANKLIST END --
                  
              else
                  rank = 'Wanderer'
                  bracketstyle = 'icr-t-a icr-data'
              end

              local formattedrank = string.format('<span class="%s">[</span><span class="%s">%s</span><span class="%s">%s</span><span class="%s">]</span>', bracketstyle,rankstyle,rank,plusstyle,plus,bracketstyle)
              
              local styletop = 'background:#cfc;'

              if username == 'JohnyMuffin' then
                styletop = 'background:#5555FF; color:#FFFFFF;'
              else
                styletop = 'background:#cfc;'
              end


                if datatype == 'infobox' then
                    
                    
                        local args = frame:getParent().args
                      
                        local retval = capiunto.create({
                           
                            top = username,
                            
                            topStyle = styletop
                            
                        })
                        
                        
                       
                        --:addImage( args.image, args.caption )
                        :addImage('https://minotar.net/armor/bust/'..username..'.png','Player Bust','icr-hack')
                        --:addHeader(username, 'icr-title')
                        :addRow('','')
                        
                        --:addWikitext('File:https://minotar.net/armor/bust'..username..'.png')
                        :addRow( 'Username', username, 'icr-f', 'icr-f icr-data' )
                        :addRow( 'Rank', formattedrank, 'icr-7 icr-data', 'icr-7' )
                        :addRow( 'UUID', data.uuid, 'icr-data' )
                        :addRow( 'Balance', string.format("%.2f", userdata.balance),'icr-data icr-7', 'icr-7')
                        :addHeader( 'Miscellaneous Stats', 'icr-header' )
                        :addRow( 'Join Count', userdata.joins, 'icr-data' )
	                    :addRow( 'Trust Level', userdata.trustlevel, 'icr-data icr-7', 'icr-7')
	                    :addRow( 'Player Kills', userdata.pkilled, 'icr-data' )
                        :addRow( 'Mob Kills', userdata.creatureskilled, 'icr-data icr-7', 'icr-7' )
                        :addRow( 'Deaths', userdata.deaths, 'icr-data' )
                        :addRow( 'Blocks Traveled', userdata.traveled, 'icr-data icr-7', 'icr-7' )
                        :addRow( 'Blocks Placed', userdata.blocksplaced, 'icr-data' )
                        :addRow( 'Items Dropped', userdata.itemsdropped, 'icr-data icr-7', 'icr-7' )
                        :addRow( 'Blocks Broken', userdata.blocksdestroyed, 'icr-data')
                        
	                    return retval
                        
                        
                        


                 end

               
     end
      
    end
else 
    return 'something went horribly wrong'
 end

end

return p
