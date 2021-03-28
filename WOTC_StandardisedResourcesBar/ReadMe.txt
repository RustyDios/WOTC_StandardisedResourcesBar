You created an XCOM 2 Mod Project!

WOTC_StandardisedResourcesBar
Basically makes the resources bar show some more stuff, in the same order for multiple screens, requested by TeslaRage

works by event listener from CHL

has two triggered events, one at priority 69 (runs before other mods) and one at priority 42 (runs after other mods)
priority groups as so as to not clash with listeners running at the -same- time ... due to using switch(case) and not if()

Tested working with:

https://steamcommunity.com/sharedfiles/filedetails/?id=2167235854 GTS Show ALL Class Counts
https://steamcommunity.com/sharedfiles/filedetails/?id=2078307522 Grim Horizon Fix
https://steamcommunity.com/sharedfiles/filedetails/?id=1916761361 Force Level Display
https://steamcommunity.com/sharedfiles/filedetails/?id=2222545926 Psionics Ex Machina
CI 
should work with ABB too but untested

================================================================================================
STEAM DESC		https://steamcommunity.com/sharedfiles/filedetails/?id=2276175904
================================================================================================
[h1] What is this mod? [/h1]
The aim of this mod is to re-organise, sort and standardise the resource bar across all screens, showing resources that make sense for the screen.

[h1] Config [/h1]
Config now exists for other mod users to add a simple line to my config array for adding thier own resources to the bar. 
Please see the [b]XComStandardResourcesBar.ini[/b] for more information.

[h1] Compatibility [/h1]
I had this running and working with [list]
[*][url=https://steamcommunity.com/sharedfiles/filedetails/?id=2167235854] Show ALL Class Counts [/url] 
[*][url=https://steamcommunity.com/sharedfiles/filedetails/?id=2078307522] Grim Horizon Fix [/url]
[*][url=https://steamcommunity.com/sharedfiles/filedetails/?id=1916761361] Force Level Display [/url]
[*][url=https://steamcommunity.com/sharedfiles/filedetails/?id=2222545926] Psionics Ex Machina and Meld [/url]
[*][url=https://steamcommunity.com/sharedfiles/filedetails/?id=2307111535] Lago's Reworked Research [/url]
[/list]
And although untested by me it should also work with [url=https://steamcommunity.com/sharedfiles/filedetails/?id=1537675645] ABB:TLE [/url] and [b] Covert Infiltration [/b]

May clash with other mods that try to adjust the resource bar by the CHL event, but I don't know of any others than the above.

[h1] Credits and Thanks [/h1]
[b]TeslaRage[/b] for asking me to make this mod.
[b]Kdm2k6[/b] and [b]RedDobe[/b] for showing me initially how to use this hook.
[b]DerBK[/b] for the "add resource" function I adapted from [url=https://steamcommunity.com/sharedfiles/filedetails/?id=1537675645] ABB:TLE [/url]
All the good people that work on the Community Highlander and the XCOM2 Modders Discord.

~ Enjoy [b]!![/b] and please buy me a [url=https://www.buymeacoffee.com/RustyDios] Cuppa Tea [/url]
