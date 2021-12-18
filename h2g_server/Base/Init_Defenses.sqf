/* Structures */
missionNamespace setVariable ['WF_NEURODEF_BARRACKS_WALLS',[
	['Land_HBarrier_large',[8,0,0],90],
	['Land_HBarrier_large',[8,10,0],90],
	['Land_HBarrier_large',[8,-7.5,0],90],
	['Land_HBarrier_large',[5,-11,0],180],
	['Land_HBarrier_large',[0.5,-11,0],180],
	['Land_HBarrier_large',[-6,-11,0],180],
	['Land_HBarrier_large',[-9.5,-7.5,0],90],
	['Land_HBarrier_large',[-9.5,2.5,0],90],
	['Land_HBarrier_large',[5,13,0],180],
	['Land_HBarrier_large',[0.5,13,0],180],
	['Land_HBarrier_large',[-6,13,0],180],
	['Land_HBarrier_large',[-9.5,9.5,0],90]
]];

missionNamespace setVariable ['WF_NEURODEF_LIGHT_WALLS',[
	['Land_HBarrier_large',[10,-1,0],90],
	['Land_HBarrier_large',[10,9,0],-90],
	['Land_HBarrier_large',[10,-8.5,0],90],
	['Land_HBarrier_large',[7,-12,0],180],
	['Land_HBarrier_large',[0,-12,0],180],
	['Land_HBarrier_large',[-7,-12,0],180],
	['Land_HBarrier_large',[7,12,0],180],
	['Land_HBarrier_large',[0,12,0],180],
	['Land_HBarrier_large',[-7,12,0],180],
	['Land_HBarrier_large',[-11,-9,0],90],
	['Land_HBarrier_large',[-11,-1.5,0],90],
	['Land_HBarrier_large',[-11,6,0],90],
	['Land_HBarrier_large',[-11,9,0],90]
]];

missionNamespace setVariable ['WF_NEURODEF_COMMANDCENTER_WALLS',[
	['Land_HBarrier_large',[4,-3.5,0],90],
	['Land_HBarrier_large',[4,4,0],90],
	['Land_HBarrier_large',[1,7.5,0],180],
	['Land_HBarrier_large',[-2.5,7.5,0],180],
	['Land_HBarrier_large',[-5.5,4,0],90],
	['Land_HBarrier_large',[-5.5,-3.5,0],90],
	['Land_HBarrier5',[4,-6.5,0],180]
]];

missionNamespace setVariable ['WF_NEURODEF_SERVICEPOINT_WALLS',[
	['Land_HBarrier_large',[4,-3.5,0],90],
	['Land_HBarrier_large',[4,4,0],90],
	['Land_HBarrier_large',[1,7.5,0],180],
	['Land_HBarrier_large',[-2.5,7.5,0],180],
	['Land_HBarrier_large',[-5.5,4,0],90],
	['Land_HBarrier_large',[-5.5,-3.5,0],90],
	['Land_HBarrier5',[4,-6.5,0],180]
]];

missionNamespace setVariable ['WF_NEURODEF_HEAVY_WALLS',[
	['Land_HBarrier_large',[14,-1,0],90],
	['Land_HBarrier_large',[14,9,0],-90],
	['Land_HBarrier_large',[14,-8.5,0],90],
	['Land_HBarrier_large',[14,-11,0],90],
	['Land_HBarrier_large',[11,-14.5,0],180],
	['Land_HBarrier_large',[4.5,-14.5,0],180],
	['Land_HBarrier_large',[-3,-14.5,0],180],
	['Land_HBarrier_large',[-10.5,-14.5,0],180],
	['Land_HBarrier_large',[-14,-11,0],90],
	['Land_HBarrier_large',[-14,-3.5,0],90],
	['Land_HBarrier_large',[-14,4,0],90],
	['Land_HBarrier_large',[-14,9.5,0],90],
	['Land_HBarrier_large',[11,13,0],180],
	['Land_HBarrier_large',[3.5,13,0],180],
	['Land_HBarrier_large',[-4,13,0],180],
	['Land_HBarrier_large',[-11,13,0],-180]
]];

missionNamespace setVariable ['WF_NEURODEF_AIRCRAFT_WALLS',[
	['Land_HBarrier_large',[10,-1,0],90],
	['Land_HBarrier_large',[10,9,0],-90],
	['Land_HBarrier_large',[10,-8.5,0],90],
	['Land_HBarrier_large',[7,-12,0],180],
	['Land_HBarrier_large',[0,-12,0],180],
	['Land_HBarrier_large',[-7,-12,0],180],
	['Land_HBarrier_large',[7,12,0],180],
	['Land_HBarrier_large',[0,12,0],180],
	['Land_HBarrier_large',[-7,12,0],180],
	['Land_HBarrier_large',[-11,-9,0],90],
	['Land_HBarrier_large',[-11,-1.5,0],90],
	['Land_HBarrier_large',[-11,6,0],90],
	['Land_HBarrier_large',[-11,9,0],90]
]];

if (WF_Camo) then {
missionNamespace setVariable ['WF_NEURODEF_EAST_BASE',[
    ["RU_WarfareBLightFactory",[9.57227,12.7861,-0.600006],90],
    ["RU_WarfareBUAVterminal",[-8.06445,15.25,0],0],
    ["RU_WarfareBBarracks",[8.91406,-14.2578,-0.600006],0],
    ["BTR90_HQ_unfolded",[-34.4092,-30.9697,0],90],
    ["Base_WarfareBBarrier10xTall",[20.6318,6.98145,0],90],
    ["Base_WarfareBBarrier10xTall",[-23.4258,-7.65527,0],90],
    ["Base_WarfareBBarrier10xTall",[-0.323242,-30.1289,0],0],
    ["Base_WarfareBBarrier10xTall",[-0.0878906,29.1484,0],0],
    ["Land_HBarrierTower_F",[17.2803,24.665,0],180],
    ["Land_HBarrierTower_F",[16.2432,-25.417,0],90],
    ["Base_WarfareBBarrier10xTall",[20.6768,-22.3057,0],90],
    ["Base_WarfareBBarrier10xTall",[20.6768,22.2783,0],90],
    ["Land_HBarrierTower_F",[-19.0898,-24.624,0],0],
    ["Land_HBarrierTower_F",[-17.3887,26.0361,0],270],
    ["Base_WarfareBBarrier10xTall",[-23.4258,22.4785,0],90],
    ["Base_WarfareBBarrier10xTall",[-23.4258,-22.6533,0],90],
    ["Base_WarfareBBarrier10xTall",[14.6885,-30.0479,0],0],
    ["Base_WarfareBBarrier10xTall",[14.6885,29.0986,0],0],
    ["Base_WarfareBBarrier10xTall",[-15.6221,-30.1768,0],0],
    ["Base_WarfareBBarrier10xTall",[-15.415,29.1445,0],0],
    ["Land_JumpTarget_F",[-34.8984,7.93555,0],0],
    ["Land_JumpTarget_F",[-34.8984,-9.33203,0],0],
    ["Land_JumpTarget_F",[-34.8984,25.0459,0],0],
        ["Land_HelipadCircle_F",[30.91406, -60,-0.600006],0],
        ["Land_HelipadCircle_F",[60.91406, -90,-0.600006],90]
]];

    missionNamespace setVariable ['WF_NEURODEF_GUER_BASE',[
        ["Gue_WarfareBLightFactory",[9.57227,12.7861,-0.600006],90],
        ["GUE_WarfareBUAVterminal",[-8.06445,15.25,0],0],
        ["Gue_WarfareBBarracks",[8.91406,-14.2578,-0.600006],0],
    ["BRDM2_HQ_Gue_unfolded",[-34.4092,-30.9697,0],90],
        ["Land_Barricade_01_10m_F",[20.6318,6.98145,0],90],
        ["Land_Barricade_01_10m_F",[-23.4258,-7.65527,0],90],
        ["Land_Barricade_01_10m_F",[-0.323242,-30.1289,0],0],
        ["Land_Barricade_01_10m_F",[-0.0878906,29.1484,0],0],
        ["Land_Barricade_01_10m_F",[20.6768,-22.3057,0],90],
        ["Land_Barricade_01_10m_F",[20.6768,22.2783,0],90],
        ["Land_Barricade_01_10m_F",[-23.4258,22.4785,0],90],
        ["Land_Barricade_01_10m_F",[-23.4258,-22.6533,0],90],
        ["Land_Barricade_01_10m_F",[14.6885,-30.0479,0],0],
        ["Land_Barricade_01_10m_F",[14.6885,29.0986,0],0],
        ["Land_Barricade_01_10m_F",[-15.6221,-30.1768,0],0],
        ["Land_Barricade_01_10m_F",[-15.415,29.1445,0],0],
    ["Land_JumpTarget_F",[-34.8984,7.93555,0],0],
    ["Land_JumpTarget_F",[-34.8984,-9.33203,0],0],
    ["Land_JumpTarget_F",[-34.8984,25.0459,0],0],
        ["Land_HelipadCircle_F",[30.91406, -60,-0.600006],0],
        ["Land_HelipadCircle_F",[60.91406, -90,-0.600006],90]
    ]];

missionNamespace setVariable ['WF_NEURODEF_WEST_BASE',[
	["USMC_WarfareBLightFactory",[9.57227,12.7861,-0.600006],90],
    ["USMC_WarfareBUAVterminal",[-8.06445,15.25,0],0],
    ["USMC_WarfareBBarracks",[8.91406,-14.2578,-0.600006],0],
    ["LAV25_HQ_unfolded",[-34.4092,-30.9697,0],90],
    ["Base_WarfareBBarrier10xTall",[20.6318,6.98145,0],90],
    ["Base_WarfareBBarrier10xTall",[-23.4258,-7.65527,0],90],
    ["Base_WarfareBBarrier10xTall",[-0.323242,-30.1289,0],0],
    ["Base_WarfareBBarrier10xTall",[-0.0878906,29.1484,0],0],
    ["Land_HBarrierTower_F",[17.2803,24.665,0],180],
    ["Land_HBarrierTower_F",[16.2432,-25.417,0],90],
    ["Base_WarfareBBarrier10xTall",[20.6768,-22.3057,0],90],
    ["Base_WarfareBBarrier10xTall",[20.6768,22.2783,0],90],
    ["Land_HBarrierTower_F",[-19.0898,-24.624,0],0],
    ["Land_HBarrierTower_F",[-17.3887,26.0361,0],270],
    ["Base_WarfareBBarrier10xTall",[-23.4258,22.4785,0],90],
    ["Base_WarfareBBarrier10xTall",[-23.4258,-22.6533,0],90],
    ["Base_WarfareBBarrier10xTall",[14.6885,-30.0479,0],0],
    ["Base_WarfareBBarrier10xTall",[14.6885,29.0986,0],0],
    ["Base_WarfareBBarrier10xTall",[-15.6221,-30.1768,0],0],
    ["Base_WarfareBBarrier10xTall",[-15.415,29.1445,0],0],
    ["Land_JumpTarget_F",[-34.8984,7.93555,0],0],
    ["Land_JumpTarget_F",[-34.8984,-9.33203,0],0],
    ["Land_JumpTarget_F",[-34.8984,25.0459,0],0],
        ["Land_HelipadCircle_F",[30.91406, -60,-0.600006],0],
        ["Land_HelipadCircle_F",[60.91406, -90,-0.600006],90]
    ]]
} else {
    missionNamespace setVariable ['WF_NEURODEF_EAST_BASE',[
        ["TK_WarfareBLightFactory_base_EP1",[9.57227,12.7861,-0.600006],90],
        ["TK_WarfareBUAVterminal_Base_EP1",[-8.06445,15.25,0],0],
        ["TK_WarfareBBarracks_Base_EP1",[8.91406,-14.2578,-0.600006],0],
        ["BTR90_HQ_unfolded",[-34.4092,-30.9697,0],90],
        ["Base_WarfareBBarrier10xTall",[20.6318,6.98145,0],90],
        ["Base_WarfareBBarrier10xTall",[-23.4258,-7.65527,0],90],
        ["Base_WarfareBBarrier10xTall",[-0.323242,-30.1289,0],0],
        ["Base_WarfareBBarrier10xTall",[-0.0878906,29.1484,0],0],
        ["Land_HBarrierTower_F",[17.2803,24.665,0],180],
        ["Land_HBarrierTower_F",[16.2432,-25.417,0],90],
        ["Base_WarfareBBarrier10xTall",[20.6768,-22.3057,0],90],
        ["Base_WarfareBBarrier10xTall",[20.6768,22.2783,0],90],
        ["Land_HBarrierTower_F",[-19.0898,-24.624,0],0],
        ["Land_HBarrierTower_F",[-17.3887,26.0361,0],270],
        ["Base_WarfareBBarrier10xTall",[-23.4258,22.4785,0],90],
        ["Base_WarfareBBarrier10xTall",[-23.4258,-22.6533,0],90],
        ["Base_WarfareBBarrier10xTall",[14.6885,-30.0479,0],0],
        ["Base_WarfareBBarrier10xTall",[14.6885,29.0986,0],0],
        ["Base_WarfareBBarrier10xTall",[-15.6221,-30.1768,0],0],
        ["Base_WarfareBBarrier10xTall",[-15.415,29.1445,0],0],
        ["Land_JumpTarget_F",[-34.8984,7.93555,0],0],
        ["Land_JumpTarget_F",[-34.8984,-9.33203,0],0],
        ["Land_JumpTarget_F",[-34.8984,25.0459,0],0],
        ["Land_HelipadCircle_F",[30.91406, -60,-0.600006],0],
        ["Land_HelipadCircle_F",[60.91406, -90,-0.600006],90]
]];

    missionNamespace setVariable ['WF_NEURODEF_GUER_BASE',[
        ["TK_GUE_WarfareBLightFactory_base_EP1",[9.57227,12.7861,-0.600006],90],
        ["TK_GUE_WarfareBUAVterminal_Base_EP1",[-8.06445,15.25,0],0],
        ["TK_GUE_WarfareBBarracks_Base_EP1",[8.91406,-14.2578,-0.600006],0],
        ["BRDM2_HQ_TK_GUE_unfolded_Base_EP1",[-34.4092,-30.9697,0]],
        ["Fort_Barricade_EP1",[20.6318,6.98145,0],90],
        ["Fort_Barricade_EP1",[-23.4258,-7.65527,0],90],
        ["Fort_Barricade_EP1",[-0.323242,-30.1289,0],0],
        ["Fort_Barricade_EP1",[-0.0878906,29.1484,0],0],
        ["Fort_Barricade_EP1",[20.6768,-22.3057,0],90],
        ["Fort_Barricade_EP1",[20.6768,22.2783,0],90],
        ["Fort_Barricade_EP1",[-23.4258,22.4785,0],90],
        ["Fort_Barricade_EP1",[-23.4258,-22.6533,0],90],
        ["Fort_Barricade_EP1",[14.6885,-30.0479,0],0],
        ["Fort_Barricade_EP1",[14.6885,29.0986,0],0],
        ["Fort_Barricade_EP1",[-15.6221,-30.1768,0],0],
        ["Fort_Barricade_EP1",[-15.415,29.1445,0],0],
        ["Land_JumpTarget_F",[-34.8984,7.93555,0],0],
        ["Land_JumpTarget_F",[-34.8984,-9.33203,0],0],
        ["Land_JumpTarget_F",[-34.8984,25.0459,0],0],
        ["Land_HelipadCircle_F",[30.91406, -60,-0.600006],0],
        ["Land_HelipadCircle_F",[60.91406, -90,-0.600006],90]
    ]];

    missionNamespace setVariable ['WF_NEURODEF_WEST_BASE',[
        ["US_WarfareBLightFactory_base_EP1",[9.57227,12.7861,-0.600006],90],
        ["US_WarfareBUAVterminal_Base_EP1",[-8.06445,15.25,0],0],
        ["US_WarfareBBarracks_Base_EP1",[8.91406,-14.2578,-0.600006],0],
        ["LAV25_HQ_unfolded",[-34.4092,-30.9697,0],90],
        ["Base_WarfareBBarrier10xTall",[20.6318,6.98145,0],90],
        ["Base_WarfareBBarrier10xTall",[-23.4258,-7.65527,0],90],
        ["Base_WarfareBBarrier10xTall",[-0.323242,-30.1289,0],0],
        ["Base_WarfareBBarrier10xTall",[-0.0878906,29.1484,0],0],
        ["Land_HBarrierTower_F",[17.2803,24.665,0],180],
        ["Land_HBarrierTower_F",[16.2432,-25.417,0],90],
        ["Base_WarfareBBarrier10xTall",[20.6768,-22.3057,0],90],
        ["Base_WarfareBBarrier10xTall",[20.6768,22.2783,0],90],
        ["Land_HBarrierTower_F",[-19.0898,-24.624,0],0],
        ["Land_HBarrierTower_F",[-17.3887,26.0361,0],270],
        ["Base_WarfareBBarrier10xTall",[-23.4258,22.4785,0],90],
        ["Base_WarfareBBarrier10xTall",[-23.4258,-22.6533,0],90],
        ["Base_WarfareBBarrier10xTall",[14.6885,-30.0479,0],0],
        ["Base_WarfareBBarrier10xTall",[14.6885,29.0986,0],0],
        ["Base_WarfareBBarrier10xTall",[-15.6221,-30.1768,0],0],
        ["Base_WarfareBBarrier10xTall",[-15.415,29.1445,0],0],
        ["Land_JumpTarget_F",[-34.8984,7.93555,0],0],
        ["Land_JumpTarget_F",[-34.8984,-9.33203,0],0],
        ["Land_JumpTarget_F",[-34.8984,25.0459,0],0],
        ["Land_HelipadCircle_F",[30.91406, -60,-0.600006],0],
        ["Land_HelipadCircle_F",[60.91406, -90,-0.600006],90]
    ]]
}