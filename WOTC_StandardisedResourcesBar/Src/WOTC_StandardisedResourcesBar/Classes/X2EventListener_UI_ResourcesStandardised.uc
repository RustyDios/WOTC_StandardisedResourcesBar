//*******************************************************************************************
//  FILE:   Standard Resource Bar                                 
//  
//	File created	25/07/20    21:00
//	LAST UPDATED    18/01/21	15:15
//
// updates the resource display based upon the screen being shown;  Therefore, we need to create a listener which listens 
// for the Community Highlander event 'UpdateResources', so we can set up the resource display ourself.
//
//	FROM REDDOBES GRIM HORIZON FIX/ DARK EVENTS LIST WITH A TOUCH OF MAGIC FROM ABB
//
//	ABB:TLE - should add it's stuff to the end of the bars here
//	LAGOS INSIGHT RESEARCH - will also add it's stuff to the end of the bars here
//  FORCE LEVEL DISPLAY - will also add it's stuff to the end of the bars here
//
//*******************************************************************************************
class X2EventListener_UI_ResourcesStandardised extends X2EventListener config (StandardResourcesBar);

struct ModResource
{
    var name TemplateName;
    var string DisplayString;

        structdefaultproperties
        {
            TemplateName = none;
            DisplayString = "";
        }
};

var config array <ModResource> ModResources;
var config bool bEnableLog_SRB;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateListenerTemplate_UIResStandardised());
	
	return Templates; 
}

static function CHEventListenerTemplate CreateListenerTemplate_UIResStandardised()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'UIResStandardised');

	Template.RegisterInTactical = false;
	Template.RegisterInStrategy = true;

	Template.AddCHEvent('UpdateResources', OnUIResStandardised_Pre, ELD_Immediate, 69); //priority set for -before- show class counts, so the two don't clash, default is 50
		//Template.AddCHEvent('UpdateResources', OtherModListeners, ELD_Immediate, 50);	//this means other mods do thier stuff after this mod in most cases
	Template.AddCHEvent('UpdateResources', OnUIResStandardised_Post,ELD_Immediate, 42); //priority set for -after- PexM, so the two don't clash, default is 50

	return Template;
}

//before every other calling of this event ... like GTS class counts, Grim Horizon Dark Event Fix, FL Display ... or LW ... or CI
static function EventListenerReturn OnUIResStandardised_Pre(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
{
	local UIAvengerHUD			HUD;
    local UIScreen				CurrentScreen;
	local X2ItemTemplateManager	ItemMgr;

	HUD = `HQPRES.m_kAvengerHUD;
	CurrentScreen = `SCREENSTACK.GetCurrentScreen();
	ItemMgr = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	`LOG("ELR TRIGGERED", default.bEnableLog_SRB, 'Rusty_StandardResourceBar');

	// We are only interested when our Screen is are on the top of the screen stack.
    // We are only interested in matching cases, but other screens are included commented for completeness sake
    switch( CurrentScreen.Class.Name )
	{
        // KDM : Display the same information a normal Screen would show.
        case 'UIFacilityGrid':				        //===== STANDARD AVENGER VIEW =====//
				//HUD.UpdateDefaultResources();
            RustyDefaultResources(HUD, ItemMgr);         //also hides and clears the current
            HUD.UpdateIntel();
            HUD.UpdateScientistScore();
            HUD.UpdateEngineerScore();
            HUD.UpdateResContacts();
            HUD.UpdatePower();
            HUD.UpdateStaff();
			HUD.ShowResources();				//show the new layout
            break;
        case 'UIStrategyMap':				        //===== GEOSCAPE =====//
            RustyDefaultResources(HUD, ItemMgr);         //also hides and clears the current
            HUD.UpdateIntel();
            HUD.UpdateResContacts();
				//Mod added Force Level
			HUD.ShowResources();				//show the new layout
            break;
        case 'UIBlackMarket_Buy':				    //===== BLACK MARKET BUY =====//
            RustyDefaultResources(HUD, ItemMgr);         //also hides and clears the current
            HUD.UpdateIntel();
            HUD.UpdateScientistScore();
            HUD.UpdateEngineerScore();
			HUD.ShowResources();				//show the new layout
            break;
        /*case 'UIBlackMarket_Sell':			    //===== BLACK MARKET SELL =====//
			HUD.HideResources();				//hide resources while we tinker about with them
			HUD.ClearResources();				//reset the current display of this screen
            HUD.UpdateMonthlySupplies();
            HUD.UpdateSupplies();
			HUD.ShowResources();				//show the new layout
            break;*/
        /*case 'UIResistanceGoods':			        //===== ? COVERT OPS SCREEN ? =====//
  			HUD.HideResources();				//hide resources while we tinker about with them
			HUD.ClearResources();				//reset the current display of this screen
	        HUD.UpdateMonthlySupplies();
            HUD.UpdateSupplies();
            HUD.UpdateScientistScore();
            HUD.UpdateEngineerScore();
			HUD.ShowResources();				//show the new layout
            break;*/
        /*case 'UIAdventOperations':			    //===== DARK EVENT SCREEN =====//
        cae 'UIAdventOperations_LW':                //===== DARK EVENT SCREEN MODDED =====//
			HUD.HideResources();				//hide resources while we tinker about with them
			HUD.ClearResources();				//reset the current display of this screen
            HUD.UpdateMonthlySupplies();
            HUD.UpdateSupplies();
            HUD.UpdateIntel();
			HUD.ShowResources();				//show the new layout
            break;*/
        case 'UIChooseProject':				        //===== PROVING GROUND BUILD =====//
        case 'UIInventory_BuildItems':			    //===== ENGINEERING BUILD =====//
            RustyDefaultResources(HUD, ItemMgr);         //also hides and clears the current
            HUD.UpdateEngineerScore();
			HUD.ShowResources();				//show the new layout
            break;
        case 'UIOfficerTrainingSchool':		        //===== GTS SCREEN ABILITY SCREEN =====//
        case 'UIRecruitSoldiers':				    //===== RECRUITS BUY SCREEN =====//
        case 'UIRecruitSoldiers_ConservePool':      //===== RECRUITS CONSERVE POOL SCREEN MODDED =====//
		case 'UIRecruitSoldiers_LW':				//===== RECRUITS LW SCREEN =====//
		case 'UIRecruitSoldiers_Rusty':				//===== RECRUITS CONSERVE WITH LW STATS =====//
			HUD.HideResources();				//hide resources while we tinker about with them
			HUD.ClearResources();				//reset the current display of this screen
            HUD.UpdateMonthlySupplies();
            HUD.UpdateSupplies();
			HUD.ShowResources();				//show the new layout
            break;
        /*case 'UIBuildFacilities':			        //===== FACILITY BUILD MENU =====//
        case 'UIChooseFacility':				    //===== FACILITY ANTHILL CLOSEUP =====//
			HUD.HideResources();				//hide resources while we tinker about with them
			HUD.ClearResources();				//reset the current display of this screen
            HUD.UpdateMonthlySupplies();
            HUD.UpdateSupplies();
            HUD.UpdatePower();
			HUD.ShowResources();				//show the new layout
            break;*/
        case 'UIFacilityUpgrade':				    //===== FACILITY UPGRADE MENU =====//
        case 'UIChooseUpgrade':				        //===== FACILITY UPGRADE CLOSEUP =====//
            RustyDefaultResources(HUD, ItemMgr);         //also hides and clears the current
            HUD.UpdatePower();
			HUD.ShowResources();				//show the new layout
            break;
        case 'UIChooseResearch':				    //===== RESEARCH 'BUILD' MENU =====//
            RustyDefaultResources(HUD, ItemMgr);         //also hides and clears the current
            HUD.UpdateIntel();
            HUD.UpdateScientistScore();
			HUD.ShowResources();				//show the new layout
            break;
        /*case 'UIFacility_Labs':				    //===== LAB =====//
			HUD.HideResources();				//hide resources while we tinker about with them
			HUD.ClearResources();				//reset the current display of this screen
            HUD.UpdateScientistScore();
			HUD.ShowResources();				//show the new layout
            break;*/
        /*case 'UIFacility_PowerGenerator':	        //===== POWER RELAYS =====//
			HUD.HideResources();				//hide resources while we tinker about with them
			HUD.ClearResources();				//reset the current display of this screen
            HUD.UpdatePower();
			HUD.ShowResources();				//show the new layout
            break;*/
        /*case 'UIFacility_ResistanceComms':	    //===== RESISTANCE COMMS =====//
			HUD.HideResources();				//hide resources while we tinker about with them
			HUD.ClearResources();				//reset the current display of this screen
            HUD.UpdateResContacts();
			HUD.ShowResources();				//show the new layout
            break;*/
        /*case 'UIAlert':						    //===== ALERT SCREENS FOR COVERT ACTIONS =====//
			HUD.HideResources();				//hide resources while we tinker about with them
			HUD.ClearResources();				//reset the current display of this screen	
            if (UIAlert(CurrentScreen).eAlertName == 'eAlert_Contact')
            {
                HUD.UpdateIntel();
            }
            else if (UIAlert(CurrentScreen).eAlertName == 'eAlert_Outpost')
            {
                HUD.UpdateSupplies();
            }
            else
            {
                HUD.HideResources();
            }
			HUD.ShowResources();				//show the new layout
            break;*/
        case 'UICovertActions':				        //===== CHOOSE COVERT ACTIONS =====//
            RustyDefaultResources(HUD, ItemMgr);         //also hides and clears the current
            HUD.UpdateIntel();
            HUD.UpdateScientistScore();
            HUD.UpdateEngineerScore();
			HUD.ShowResources();				//show the new layout
            break;
		/*case 'UIChooseClass':						//===== GTS PROMOTION SCREEN =====//
		case 'UIPersonnel_CovertAction':			//===== CHOOSE PERSONNEL =====//
		case 'UIPersonnel_Armory':					//===== CHOOSE PERSONNEL =====//
		case 'UIPersonnel_TrainingCenter':			//===== CHOOSE PERSONNEL =====//
		case 'UIPersonnel_BoostSoldier':			//===== CHOOSE PERSONNEL =====//
		case 'UIPersonnel_SquadSelect':				//===== CHOOSE PERSONNEL =====//
		case 'UIPersonnel_MECTraining':				//===== CHOOSE PERSONNEL =====//
		case 'UIPersonnel_PexM':					//===== CHOOSE PERSONNEL =====//
		case 'UIChooseClass_WOTC_ChooseMyClass':	//===== SHIRE EX PROMOTION SCREEN =====//
		case 'UIChooseClass_RebuildSoldier':		//===== TESLA TC PROMOTION SCREEN =====//
			//handled by show class counts
			break;*/
        default:
			//DO NOTHING FOR SCREENS WE DON'T WANT TO CHANGE
            break;
    }

	`LOG("ELR ENDED", default.bEnableLog_SRB, 'Rusty_StandardResourceBar');

	return ELR_NoInterrupt;
}

//after PexM has done it's thing ... maybe update later to re-jig ABB screens
static function EventListenerReturn OnUIResStandardised_Post(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
{
	local UIAvengerHUD			HUD;
    local UIScreen				CurrentScreen;
	local X2ItemTemplateManager	ItemMgr;

	HUD = `HQPRES.m_kAvengerHUD;
	CurrentScreen = `SCREENSTACK.GetCurrentScreen();
	ItemMgr = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	`LOG("ELR POST TRIGGERED", default.bEnableLog_SRB, 'Rusty_StandardResourceBar');

    switch( CurrentScreen.Class.Name )
	{
		case 'UIChoosePexMProject':			        //===== PSIONICS EX MACHINA BUILD MENU =====//
		case 'UIInventory_PexM':				    //===== PSIONICS EX MACHINA INVENTORY  =====//
            RustyDefaultResources(HUD, ItemMgr);         //also hides and clears the current
			HUD.UpdateScientistScore();
			HUD.UpdateEngineerScore();
			HUD.ShowResources();				//show the new layout
			break;
        default:
			//DO NOTHING FOR SCREENS WE DON'T WANT TO CHANGE
            break;
    }

	`LOG("ELR POST ENDED", default.bEnableLog_SRB, 'Rusty_StandardResourceBar');

	return ELR_NoInterrupt;
}

//make all 'resources' screen the same standard
static function RustyDefaultResources(UIAvengerHUD HUD, X2ItemTemplateManager ItemMgr)
{
    local int i;

	HUD.HideResources();				//hide resources while we tinker about with them
	HUD.ClearResources();				//reset the current display of this screen

    HUD.UpdateMonthlySupplies();
    HUD.UpdateSupplies();
    HUD.UpdateAlienAlloys();
    HUD.UpdateEleriumCrystals();
    HUD.UpdateEleriumCores();

    for (i = 0 ; i < default.ModResources.length ; i++)
    {
        AddModResource(HUD, ItemMgr, default.ModResources[i].TemplateName, default.ModResources[i].DisplayString);	//add new resource from mod
    }
}

//PULLED from DerBK's ABB !!	USE TO ADD A NEW RESOURCE TO THE BAR ... NOW FROM CONFIG, REQUESTED BY TESLA!
//THIS ENSURES HUD RESOURCE ELEMENTS ARE ALWAYS ADDED TO THE BAR IN THE SAME ORDER FOR A PERSONS GAME
static function AddModResource(UIAvengerHUD HUD, X2ItemTemplateManager ItemMgr, name ResourceName, string DisplayStr)
{
    local X2ItemTemplate    Template;
	local int				ResourceCount;

    //find a matching resource
    Template = ItemMgr.FindItemTemplate(ResourceName);

    //check if this item actually exists in this game !! and add it to the bar
    if (Template != none)
    {
		//find out how much of this item xcom has
       	ResourceCount = `XCOMHQ.GetResourceAmount(ResourceName);

        //create or find the correct string name
        if (DisplayStr == "")
        {
            DisplayStr = Template.AbilityDescName;

            //if it still blank use item name
            if (DisplayStr == "")
            {
                DisplayStr = Template.FriendlyName;
            }
        }

        //if name is STILL blank resort to hardcode error
        if (DisplayStr == "")
        {
            DisplayStr = class'UIUtilities_Text'.static.GetColoredText("ERROR", eUIState_Bad);
        }

        //actually add the resource display
	    HUD.AddResource(DisplayStr, class'UIUtilities_Text'.static.GetColoredText(string(ResourceCount), (ResourceCount > 0) ? eUIState_Normal : eUIState_Bad));
    }
	else
	{
		//report to the log if the item isn't found
		`LOG("ERROR :: NO ITEM TEMPLATE ::" @ResourceName @" :: DISPLAY ::" @DisplayStr , default.bEnableLog_SRB, 'Rusty_StandardResourceBar');
	}
}

/*
//	FOR REFERENCE OF WHAT 'DEFAULT' WAS
simulated function UpdateDefaultResources()
{
	ClearResources();

	UpdateMonthlySupplies();
	UpdateSupplies();
	UpdateIntel();
	UpdateEleriumCrystals();
	UpdateAlienAlloys();
	UpdateScientistScore();
	UpdateEngineerScore();
	UpdateResContacts();
	UpdatePower();

	ShowResources();
}
*/
