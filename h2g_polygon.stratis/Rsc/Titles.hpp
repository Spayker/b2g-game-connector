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

	titles[] = {RscOverlay};

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
};