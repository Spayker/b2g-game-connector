/* Titles */

#define usflag "\ca\ca_e\data\flag_us_co.paa"
#define ruflag "\ca\data\flag_rus_co.paa"

#ifndef usflag
	#define usflag "\ca\ca_e\data\flag_us_co.paa"
	#define ruflag "\ca\ca_e\data\flag_tkg_co.paa"
#endif

#define height (safeZoneH * 0.05)
#define width (height * 4)
#define startX (safeZoneX + safeZoneW - height)
#define startY (safeZoneY + safeZoneH - height)

class RscTitles {

	titles[] = {RscOverlay,CaptureBar,OptionsAvailable,EndOfGameStats};
	class b2zgroup
	{
		idd=-2;
		movingEnable=0;
		duration=8;
		name="b2zgroup";
		controls[]={"b2zgroup"};
	};

    class RscOverlay
	{
		idd=10200;
		movingEnable = 0;
		duration=15000;
		name="gps";
		controls[]={"txt_dwn","txt_crw","OptionsIcon0","OptionsIcon1","OptionsIcon2","OptionsIcon3","OptionsIcon4","OptionsIcon5","OptionsIcon6"};
		onload="uiNamespace setVariable['GUI',_this select 0];";

		class txt_dwn:RscStructuredTextB
		{
			idc=6003;
			w=0.275;
			h=0.036;
			x = 0.824 * safezoneW + safezoneX;
			y = 0.790000 * safezoneH + safezoneY;
			colorText[]={0.95,0.95,0.95,1};
		};
		class txt_crw:txt_dwn
		{
			idc=6004;
			w=0.25;
			h=0.55;
			colorBackground[]={0,0,0,0};

		};
		class OptionsImageAspectRatio: RscPicture
		{
			w = 0.078431;
			h = 0.104575;
			style = "0x30+0x800";
		};

		class OptionsIcon0: OptionsImageAspectRatio
		{
			IDC = 6005;
			x = "(SafeZoneW + SafeZoneX) - (0.0392157)";
			y = 0.3;
			w = 0.039216;
			h = 0.052288;
			colortext[] = {1, 1, 1, 0.400000};
			text = "";
		};

		class OptionsIcon1: OptionsIcon0
		{
			IDC = 6006;
			y = "0.3+(0.0522876*1)";
		};

		class OptionsIcon2: OptionsIcon0
		{
			IDC = 6007;
			y = "0.3+(0.0522876*2)";
		};

		class OptionsIcon3: OptionsIcon0
		{
			IDC = 6008;
			y = "0.3+(0.0522876*3)";
		};

		class OptionsIcon4: OptionsIcon0
		{
			IDC = 6009;
			y = "0.3+(0.0522876*4)";
		};

		class OptionsIcon5: OptionsIcon0
		{
			IDC = 6010;
			y = "0.3+(0.0522876*5)";
		};
		class OptionsIcon6: OptionsIcon0
		{
			IDC = 6011;
			y = "0.3+(0.0522876*6)";
		};

	};

	class CaptureBar {
		idd = 600100;
		duration = 15000;
		name = "Capture Bar";
		onLoad = "uiNamespace setVariable ['wf_title_capture', _this select 0]";
		onUnload = "uiNamespace setVariable ['wf_title_capture', displayNull]";

		class controls {
			class CA_Progress_Bar_Background : RscText {
				style = ST_TEXT_BG;
				idc = 601000;
				x = 0.3;
				y = "((SafeZoneH + SafeZoneY) - (1 + 0.02))*-1";
				w = 0.4;
				h = 0.06;
				colorBackground[] = {0,0,0,0.001};
			};

			class CA_Progress_Bar : CA_Progress_Bar_Background {
				idc = 601001;
				x = 0.31;
				y = "((SafeZoneH + SafeZoneY) - (1 + 0.03))*-1";
				w = 0.38;
				h = 0.04;
			};

			class CA_Progress_Label : RscText {
				idc = 601002;
				style = ST_CENTER;
				colorText[] = {1,1,1,0.8};
				shadow = 2;
				x = 0.31;
				w = 0.38;
				y = "((SafeZoneH + SafeZoneY) - (1 + 0.032))*-1";
			};
		};
	};

	class OptionsAvailable {
		idd = 10300;
		movingEnable = 0;
		objects[] = {};
		duration = 15000;
		name = "OptionsAvailable";
		onLoad = "_this call WFCL_fnc_setCurrentCutDisplay";
		//onUnload = "_this call WFCL_fnc_clearCurrentCutDisplay";
        controls[] = {"BGHUD","HealthHUD","SideSlot1","SideSlotValue1","SideSlot3","SideSlot2","SideSlotValue2","RelationMark1","RelationMark2","SideSlotValue3","MoneyHUD","MoneyValHUD","SupplyHUD","SupplyValHUD","TownsHUD",
        "statblue","score_blue","statred","score_red","OptionsIcon0", "OptionsIcon1", "OptionsIcon2", "OptionsIcon3", "OptionsIcon4", "OptionsIcon5", "OptionsIcon6", "OptionsIcon7", "OptionsIcon8",
        "OptionsIcon9", "OptionsIcon10", "OptionsIcon11", "OptionsIcon12", "OptionsIcon13", "OptionsIcon14", "OptionsIcon15", "OptionsIcon16"};
		controlsBackground[] = {};

		class BGHUD: RscStructuredText
        {
        	idc = 1099;

        	x = 0.65 * safezoneW + safezoneX;
			y = 0.9 * safezoneH + safezoneY;
        	w = width * 3.66;
        	h = height * 3.5;
        };

        class HealthHUD: RscStructuredText
		{
			idc = 1100;

			x = 0.66 * safezoneW + safezoneX;
			y = 0.9135 * safezoneH + safezoneY;
			w = 0.4 * safezoneW;
			h = 0.0375 * safezoneH;
			colorBackground[] = {0,0,0,0};
		};

		class SideSlot1: RscStructuredText
		{
            idc = 1112;
			
            x = 0.895 * safezoneW + safezoneX;
            y = 0.935 * safezoneH + safezoneY;
			w = 0.0625 * safezoneW;
			h = 0.04 * safezoneH;
			colorBackground[] = {0,0,0,0};
		};

        class SideSlotValue1: RscStructuredText
		{
            idc = 1113;

            x = 0.8975 * safezoneW + safezoneX;
            y = 0.937 * safezoneH + safezoneY;
            w = 0.035 * safezoneW;
            h = 0.0375 * safezoneH;
            colorBackground[] = {0,0,0,0};
        };
			
		class RelationMark1: RscStructuredText
        {
            idc = 1111;
            x = 0.914 * safezoneW + safezoneX;
			y = 0.935 * safezoneH + safezoneY;
			w = 0.0625 * safezoneW;
			h = 0.04 * safezoneH;
			colorBackground[] = {0,0,0,0};
		};

		class SideSlot2: RscStructuredText
		{
			idc = 1101;
			
			x = 0.9325 * safezoneW + safezoneX;
			y = 0.935 * safezoneH + safezoneY;
			w = 0.0625 * safezoneW;
			h = 0.04 * safezoneH;
			colorBackground[] = {0,0,0,0};
		};

		class SideSlotValue2: RscStructuredText
        {
        	idc = 1103;

        	x = 0.935 * safezoneW + safezoneX;
        	y = 0.937 * safezoneH + safezoneY;
        	w = 0.035 * safezoneW;
        	h = 0.0375 * safezoneH;
        	colorBackground[] = {0,0,0,0};
        };

        class RelationMark2: RscStructuredText
        {
            idc = 1110;

            x = 0.953 * safezoneW + safezoneX;
            y = 0.935 * safezoneH + safezoneY;
            w = 0.0625 * safezoneW;
            h = 0.04 * safezoneH;
            colorBackground[] = {0,0,0,0};
        };

		class SideSlot3: RscStructuredText
		{
			idc = 1102;

			x = 0.9725 * safezoneW + safezoneX;
			y = 0.935 * safezoneH + safezoneY;
			w = 0.0625 * safezoneW;
			h = 0.04 * safezoneH;
			colorBackground[] = {0,0,0,0};
		};
        class SideSlotValue3: RscStructuredText
        {
        	idc = 1104;

        	x = 0.975 * safezoneW + safezoneX;
        	y = 0.937 * safezoneH + safezoneY;
        	w = 0.035 * safezoneW;
        	h = 0.0375 * safezoneH;
        	colorBackground[] = {0,0,0,0};
        };
		class MoneyHUD: RscStructuredText
		{
			idc = 1105;
			
			x = 0.66 * safezoneW + safezoneX;
			y = 0.9565 * safezoneH + safezoneY;
			w = 0.035 * safezoneW;
			h = 0.045 * safezoneH;
			colorBackground[] = {0,0,0,0};
		};
		class MoneyValHUD: RscStructuredText
		{
			idc = 1106;
			
			x = 0.6825 * safezoneW + safezoneX;
			y = 0.946 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.06 * safezoneH;
			colorBackground[] = {0,0,0,0};
		};
		class SupplyHUD: RscStructuredText
		{
			idc = 1107;
			
			x = 0.73 * safezoneW + safezoneX;
			y = 0.952 * safezoneH + safezoneY;
			w = 0.05 * safezoneW;
			h = 0.06 * safezoneH;
			colorBackground[] = {0,0,0,0};
		};
		class SupplyValHUD: RscStructuredText
		{
			idc = 1108;
			
			x = 0.75775 * safezoneW + safezoneX;
			y = 0.946 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.06 * safezoneH;
			colorBackground[] = {0,0,0,0};
		};
		class TownsHUD: RscStructuredText
		{
			idc = 1109;
			
			x = 0.805 * safezoneW + safezoneX;
			y = 0.9565 * safezoneH + safezoneY;
			w = 0.275 * safezoneW;
			h = 0.0375 * safezoneH;
			colorBackground[] = {0,0,0,0};
		};

		class statblue:RscPicture
		{
			idc=1362;
			x = 0.830 * safezoneW + safezoneX;
			y = 0.354000 * safezoneH + safezoneY;
			w=0.064;
			h = 0.036;
			text="";
		};	
		class score_blue:RscText
		{
			idc=1364;
			w = 0.175 * safezoneW;
			h=0.030 * safezoneH;
			x = 0.832 * safezoneW + safezoneX;
			y = 0.349500 * safezoneH + safezoneY;
			colorText[]={0.95,0.95,0.95,1};
			text="";
		};
		
		class statred:RscPicture
		{
			idc=1365;
			x = 0.830 * safezoneW + safezoneX;
			y = 0.378000 * safezoneH + safezoneY;
			w=0.064;
			h = 0.036;
			text="";
		};
		class score_red:RscText
		{
			idc=1367;
			w = 0.175 * safezoneW;
			h=0.030 * safezoneH;
			x = 0.832 * safezoneW + safezoneX;
			y = 0.373500 * safezoneH + safezoneY;
			colorText[]={0.95,0.95,0.95,1};
			text="";
		};
		
		//Original
		class OptionsImageAspectRatio : RscPicture {
			w = 0.0784314;
			h = 0.104575;
			style = 0x30+0x800;
		};

		class OptionsIcon0 : OptionsImageAspectRatio {
			idc = 3500;
			x = "(SafeZoneW + SafeZoneX) - (0.0392157)";
			y = 0+(0.0510876*20);
			w = 0.0392157;
			h = 0.0522876;
			colorText[] = WF_OA_Icon;
			text = "";
		};

		class OptionsIcon1 : OptionsIcon0 {
			idc = 3500 + 1;
			y = 0+(0.0510876*19);
		};

		class OptionsIcon2 : OptionsIcon0 {
			idc = 3500 + 2;
			y = 0+(0.0510876*18);
		};

		class OptionsIcon3 : OptionsIcon0 {
			idc = 3500 + 3;
			y = 0+(0.0510876*17);
		};

		class OptionsIcon4 : OptionsIcon0 {
			idc = 3500 + 4;
			y = 0+(0.0510876*16);
		};

		class OptionsIcon5 : OptionsIcon0 {
			idc = 3500 + 5;
			y = 0+(0.0510876*15);
		};

		class OptionsIcon6 : OptionsIcon0 {
			idc = 3500 + 6;
			x = "(SafeZoneW + SafeZoneX) - (0.0392157 * 2)";
			y = 0+(0.0510876*20);
		};

		class OptionsIcon7 : OptionsIcon0 {
			idc = 3500 + 7;
			x = "(SafeZoneW + SafeZoneX) - (0.0392157 * 3)";
            		y = 0+(0.0510876*20);
		};

		class OptionsIcon8 : OptionsIcon0 {
			idc = 3500 + 8;
			x = "(SafeZoneW + SafeZoneX) - (0.0392157 * 4)";
            		y = 0+(0.0510876*20);
		};

		class OptionsIcon9 : OptionsIcon0 {
			idc = 3500 + 9;
			x = "(SafeZoneW + SafeZoneX) - (0.0392157 * 5)";
            		y = 0+(0.0510876*20);
		};

		class OptionsIcon10 : OptionsIcon0 {
			idc = 3500 + 10;
			x = "(SafeZoneW + SafeZoneX) - (0.0392157 * 6)";
            		y = 0+(0.0510876*20);
		};

		class OptionsIcon11 : OptionsIcon0 {
			idc = 3500 + 11;
			x = "(SafeZoneW + SafeZoneX) - (0.0392157 * 7)";
            		y = 0+(0.0510876*20);
		};

		class OptionsIcon12 : OptionsIcon0 {
			idc = 3500 + 12;
			x = "(SafeZoneW + SafeZoneX) - (0.0392157 * 8)";
            		y = 0+(0.0510876*20);
		};

		class OptionsIcon13 : OptionsIcon0 {
			idc = 3500 + 13;
			x = "(SafeZoneW + SafeZoneX) - (0.0392157 * 9)";
            		y = 0+(0.0510876*20);
		};

		class OptionsIcon14 : OptionsIcon0 {
			idc = 3500 + 14;
			x = "(SafeZoneW + SafeZoneX) - (0.0392157 * 10)";
            		y = 0+(0.0510876*20);
		};

		class OptionsIcon15 : OptionsIcon0 {
			idc = 3500 + 15;
			x = "(SafeZoneW + SafeZoneX) - (0.0392157 * 11)";
            		y = 0+(0.0510876*20);
		};

		class OptionsIcon16 : OptionsIcon0 {
			idc = 3500 + 16;
			x = "(SafeZoneW + SafeZoneX) - (0.0392157 * 12)";
            		y = 0+(0.0510876*20);
		};

	};

	class EndOfGameStats {
		idd = 90000;
		duration = 15000;
		movingEnable = 0;
		objects[] = {};
		name = "EndOfGameStats";

		onLoad = "_this call WFCL_fnc_setCurrentCutDisplay";
		onUnload = "_this call WFCL_fnc_clearCurrentCutDisplay";

		controls[] = {StatsBackGroundHeader,SideWinsText,StatsBackGround,EastImage,WestImage,SoldiersRecruitedLabel,SoldiersLostLabel,VehiclesCreatedLabel,VehiclesLostLabel,
					  EastSoldiersRecruitedBar,EastSoldiersRecruitedCount,WestSoldiersRecruitedBar,WestSoldiersRecruitedCount,
					  EastSoldiersLostBar,EastSoldiersLostCount,WestSoldiersLostBar,WestSoldiersLostCount,
					  EastVehiclesCreatedBar,EastVehiclesCreatedCount,WestVehiclesCreatedBar,WestVehiclesCreatedCount,
					  EastVehiclesLostBar,EastVehiclesLostCount,WestVehiclesLostBar,WestVehiclesLostCount};

		controlsBackground[] = {};

		class StatsBackGroundHeader : RscText {
			style = 128;
			idc = 90002;
			x = 0;
			y = 0.06;
			w = 1;
			h = 0.18;
			colorBackground[] = WF_EOGS_Background;
		};

		class SideWinsText : RscText {
			idc = 90001;
			style = 2;
			sizeEx = 0.05;
			x = 0.211224;
			y = 0.1;
			w = 0.579592;
			h = 0.08;
			colorText[] = {1.0,1.0,1.0,1};
		};

		class StatsBackGround : RscText {
			style = 128;
			idc = 90003;
			x = 0;
			y = 0.24;
			w = 1;
			h = 0.62;
			colorBackground[] = WF_EOGS_Background;
		};

		class EastImage : RscPicture {
			style = 48 + 0x800;
			x = 0.00612286;
			y = 0.05;
			w = 0.2;
			h = 0.2;
			text = ruflag;
		};

		class WestImage:EastImage {
			x = 0.792857;
			text = usflag;
		};

		class SoldiersRecruitedLabel : RscText {
			style = 2;
			sizeEx = 0.03;
			x = 0.05;
			y = 0.25;
			w = 0.9;
			h = 0.04;
			colorText[] = {1.0,1.0,1.0,1};
			text = $STR_WF_END_Soldier_Recruited;
		};

		class SoldiersRecruitedCountBase : RscText {
			idc = 90100;
			style = 0;
			sizeEx = 0.06;
			x = 0.05;
			y = 0.3;
			w = 0.2;
			h = 0.1;
			colorText[] = {1.0,1.0,1.0,1};
		};

		class EastSoldiersRecruitedCount : SoldiersRecruitedCountBase {
			idc = 90101;
		};

		class EastSoldiersRecruitedBar : RscText {
			style = 128;
			idc = 90102;
			x = 0.05;
			y = 0.31;
			w = 0.4;
			h = 0.08;
			colorBackground[] = WF_EOGS_SRVBBar;
		};

		class WestSoldiersRecruitedCount : SoldiersRecruitedCountBase {
			idc = 90200;
			x = 0.55;
		};

		class WestSoldiersRecruitedBar : EastSoldiersRecruitedBar {
			idc = 90201;
			x = 0.55;
		};

		class SoldiersLostLabel : SoldiersRecruitedLabel {
			y = 0.4;
			text = $STR_WF_END_Soldier_Lost;
		};

		class EastSoldiersLostCount : SoldiersRecruitedCountBase {
			idc = 90103;
			y = 0.45;
		};

		class EastSoldiersLostBar : EastSoldiersRecruitedBar {
			idc = 90104;
			y = 0.46;
			colorBackground[] = WF_EOGS_SLVLBar;
		};

		class WestSoldiersLostCount : SoldiersRecruitedCountBase {
			idc = 90202;
			y = 0.45;
			x = 0.55;
		};

		class WestSoldiersLostBar : EastSoldiersLostBar	{
			idc = 90203;
			x = 0.55;
		};

		class VehiclesCreatedLabel : SoldiersRecruitedLabel {
			y = 0.55;
			text = $STR_WF_END_Vehicle_Built;
		};

		class EastVehiclesCreatedCount : SoldiersRecruitedCountBase	{
			idc = 90105;
			y = 0.6;
		};

		class EastVehiclesCreatedBar : EastSoldiersRecruitedBar	{
			idc = 90106;
			y = 0.61;
			colorBackground[] = WF_EOGS_SRVBBar;
		};

		class WestVehiclesCreatedCount : SoldiersRecruitedCountBase {
			idc = 90204;
			x = 0.55;
			y = 0.6;
		};

		class WestVehiclesCreatedBar : EastVehiclesCreatedBar {
			idc = 90205;
			x = 0.55;
		};

		class VehiclesLostLabel : SoldiersRecruitedLabel {
			y = 0.7;
			text = $STR_WF_END_Vehicle_Lost;
		};

		class EastVehiclesLostCount : SoldiersRecruitedCountBase {
			idc = 90107;
			y = 0.75;
		};

		class EastVehiclesLostBar : EastSoldiersRecruitedBar {
			idc = 90108;
			y = 0.76;
			colorBackground[] = WF_EOGS_SLVLBar;
		};

		class WestVehiclesLostCount : SoldiersRecruitedCountBase {
			idc = 90206;
			x = 0.55;
			y = 0.75;
		};

		class WestVehiclesLostBar : EastVehiclesLostBar	{
			idc = 90207;
			x = 0.55;
		};
	};

	class WF_ConstructionInterface {
		idd = 112200;
		movingEnable = 0;
		duration = 1e+011;
		name = "Construction Interface";
		onLoad = "uiNamespace setVariable ['wf_title_coin', _this select 0]";
		onUnload = "uiNamespace setVariable ['wf_title_coin', displayNull]";

		class controls {
			class center : RscPictureKeepAspect {
				idc = 112201;
				x = 0.4;
				y = 0.4;
				w = 0.2;
				h = 0.2;
				colorText[] = {1, 1, 1, 0.1};
				text = "RSC\Pictures\cursor_w_laserlock_gs.paa";
			};
			class descBackLeft : IGUIBack {
				idc = 112211;
				x = "SafezoneX + 0.01";
				y = "SafezoneY + SafezoneH - 0.13 + 0.01";
				w = 0.3;
				h = 0.12;
			};
			class descBackCenter : descBackLeft {
				idc = 112212;
				x = "SafezoneX + 0.01 +	0.3";
				w = "SafeZoneW - 0.02 -	0.3";
			};

			class descText : RscStructuredText {
				idc = 112214;
				x = "SafezoneX + 0.01 + 0.3";
				y = "SafezoneY + SafezoneH - 0.13 + 0.021";
				w = "SafeZoneW - 0.02 -	0.3*2";
				h = 0.11;
				size = 0.035;

				class Attributes {
					font = "PuristaMedium";
					color = "#B6F862";
					align = "left";
					shadow = true;
				};
			};

			class controlsText : descText {
				idc = 112215;
				x = "SafezoneX + SafeZoneW - 0.01 -	0.3";
				y = "SafezoneY + SafezoneH - 0.13 + 0.015";
				w = 0.3;
				h = 0.11;
			};

			class cashText : descText {
				idc = 112224;
				x = "SafezoneX + 0.012*2";
				y = "SafezoneY + SafezoneH - 0.13 + 0.02";
				w = 0.2;
				h = 0.1;
			};

			class autoOptionsText : descText {
                idc = 112225;
                x = "SafezoneX + 0.102*2";
                y = "SafezoneY + SafezoneH - 0.13 + 0.02";
                w = 0.4;
                h = 0.1;
            };

            class autoOptionsValueText : descText {
                idc = 112227;
                x = "SafezoneX + 0.210*2";
                y = "SafezoneY + SafezoneH - 0.13 + 0.02";
                w = 0.4;
                h = 0.1;
            };

			class defenseText : descText {
                idc = 112226;
                x = "SafezoneX + 0.270*2";
                y = "SafezoneY + SafezoneH - 0.13 + 0.02";
                w = 0.3;
                h = 0.1;
            };

            class MoveCameraText : descText {
                idc = 112228;
                x = "SafezoneX + 0.420*2";
                y = "SafezoneY + SafezoneH - 0.13 + 0.02";
                w = 0.6;
                h = 0.1;
            };

            class ConstructionText : descText {
                idc = 112229;
                x = "SafezoneX + 0.620*2";
                y = "SafezoneY + SafezoneH - 0.13 + 0.02";
                w = 0.6;
                h = 0.1;
            };
		};
	};

	class MSG_KillPay {
    	idd = 68791014;
    	objects[] = {};
    	movingEnable = false;
    	duration = 15000;
    	onLoad = "uiNamespace setVariable ['Display_KillPay', _this select 0]";

    	class controlsBackground {};

    	class controls {
    		class KillPaymentShow: RscStructuredText {
    			idc = 119900;
    			text = "<t align='left' color='#00ff00' valign='bottom'>+55<br />+55<br />+55<br />+55<br /></t>";
    			x = 0.700625 * safezoneW + safezoneX;
    			y = 0.6434 * safezoneH + safezoneY;
    			w = 0.34875 * safezoneW;
    			h = 0.284 * safezoneH;

    			colorBackground[] = {0,0,0,0};

    			class Attributes {
    				align = "left";
    				valign = "bottom";
    			};
    		};
    	};
    };

    class life_message_hud {

        idd = 245000;
        name = "life_message_hud";
        duration = 1e+007;
        movingEnable = 0;
        fadein = 0;
        fadeout = 0;

        onLoad = "uiNamespace setVariable ['life_message_hud', _this select 0]";
        onUnload = "uiNamespace setVariable ['life_message_hud', nil]";

        class controls {

            class MessageContainer: Life_RscControlsGroupNoScrollbars
            {
                idc = 245001;

                x = 0.8020 * safezoneW + safezoneX;
                y = 0.1560 * safezoneH + safezoneY;
                w = 0.1700 * safezoneW;
                h = 0.2375 * safezoneH;

                class controls {};
            };
        };
    };
};