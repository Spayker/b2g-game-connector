class WF_Client {
    tag = "WFCL";

    class ClientFunctions {
        file = "Client";
        class remoteExecServer {};
    };

    class Gui {
        file = "Client\Player\GUI";
        class clearCurrentCutDisplay {};
    };

    class PlayerInit {
        file = "Client\Player\Init";
        class initClient {};
    };

};

class TER
{
	class VASS
	{
		file = "Client\Player\GUI\GearMenu\fnc";
		class shop {
			preInit = 1;
			postInit = 1;
		};
		class getItemValues {};
		class VASShandler {};
		class addShopCargo {};
		class addShop {};
		class callShop {};
		class resetTimer {};
		class cleanGearData {};
	};
};

class WF_Common {
    tag = "WFCO";

    class Common {
        file = "Common";
        class initCommon {};
    };

    class Array{
        file = "Common\Array";
        class arrayDiffers {};
        class arrayShift {};
        class arrayShuffle {};
        class arrayToLower {};
    };

    class Log {
        file = "Common\Logging";
        class logContent {};
    };

    class ModuleCipher {
        file = "Common\Module\Cipher";
        class compareString {};
        class reverseArray {};
        class sortArray {};
        class sortArrayIndex {};
        class swapArray {};
    };

    class Object {
        file = "Common\Object";
        class getSideFromID {};
        class getSideID {};
    };

    class ObjectGear {
        file = "Common\Object\Gear";
        class convertGearToFlat {};
        class equipBackpack {};
        class equipContainerBackpack {};
        class equipContainerUniform {};
        class equipContainerVest {};
        class getGearItemCost {};
        class proccedLoadOutForSide {};
    };

    class ObjectUnit {
        file = "Common\Object\Unit";
        class equipUnit {};
        class getUnitLoadout {};
    };

    class UtilConfig {
        file = "Common\Utils\Config";
        class getConfigInfo {};
        class getConfigType {};
        class getConfigEntry {};
        class getUnitConfigGear {};
    };

};