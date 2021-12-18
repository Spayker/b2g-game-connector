@echo off
echo ArmA 3 Restart Script
start /wait /high ./arma3server_x64.exe -profiles=Profiles -name=Administrator -port=2302 -bandwidthAlg=2 -limitFPS=200 -hugePages -cfg=config.cfg -config=server.cfg -malloc=system -loadMissionToMemory -world=empty "-mod=!Workshop\@CBA_A3;" -servermod="@extDB3"