# RMC-Modules

List of Modules

Module:RankColor V:3.0 : Originally created by thecow275 (Evil Gabe)  -Deprecated use Module:MC-Color instead

Module:MC-Color V:1.0 : Originally created by thecow275 (Evil Gabe)

Module:ProfileInfoboxUpdater V:1.0 : Originally created by thecow275 (Evil Gabe) -Deprecated use Module:WikiStats2_UserInfobox instead

Module:WikiStats2_UserInfobox : Originally created by thecow275 (Evil Gabe)

## How to use these modules

### Requirements
   
    Mediawiki 1.43+
   
#### You also need the following extensions to be installed in your mediawiki instance to use these modules
   
	Scribunto https://www.mediawiki.org/wiki/Extension:Scribunto
	External Data https://www.mediawiki.org/wiki/Extension:External_Data
	Capiunto https://www.mediawiki.org/wiki/Extension:Capiunto
	TemplateStyles https://www.mediawiki.org/wiki/Extension:TemplateStyles
   



## How to install the Modules
  
  .lua files contents go to the Module: Subspace in the wiki
  
  the contents of data.lua files in the folder that is simply has the name of the Module without Module_ go to Module:<"modulename">/data
  
  .css files contents go into Template:<"templatename">/styles.css






## Invoking the Modules
 
 replace <"templatename"> with the name of the template you are going to use to invoke the module and <"modulename"> with the name that you chose to save the module as in the Module: subspace.
#### WikiStats2_UserInfobox and ProfileInfoboxUpdater
	<templatestyles src="Template:<"templatename">/styles.css" />{{#invoke:<"modulename">|main|{{{1}}}|infobox}}
   
#### MC-Color
##### invocation Template for coloring text with {{<"templatename">|<"colorcode">|TEXT}}
	
    <span style="color:{{#invoke:<"modulename">|main|{{{1|mccolor}}}}}"><!---->{{{2|text}}}<!----></span>
		
		
##### invocation Template for the raw color code you get with  {{"templatename">|<"colorcode">}}
	
	{{#invoke:<"modulename">|main|{{{1|mccolor}}}}}
		
#### RankColor
		
	most likely was 
	{{<"modulename">|<"rank">}}
	and most likely gave the whole colored output for the rank including the brackets and the + if the rank was a + rank