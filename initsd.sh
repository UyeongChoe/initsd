#!/usr/bin/env bash
#hello
SDCARD_PATH=/media/user/bootfs
CONFIG_TXT=config.CONFIGTXT
CMDLINE_TXT=cmdline.txt

# sd카드를 인식한다
function detectSD(){
	while true;do
		if [ -d "${SDCARD_PATH}" ];then
			echo "SD 카드가 발견됨!"
			return
		fi
		sleep 1
	done	
}
# 1
echo before detectSD
detectSD
echo after detectSD

# find config.txt cmdlin.txt
function detectCMDLINE(){
	sleep 1
	if [ -f "${SDCARD_PATH}/${CMDLINE_TXT}" ];then
		#echo -n "cmdline.txt가 발견됨!"
		echo 0 # find
	else 
		echo 1 # no found
	fi
}


#2 cmdline.txt 파일을 찾는다.
isCMDLINE=`detectCMDLINE`
IPADDR=192.168.111.1
if [ $isCMDLINE -eq 0 ]; then
	# find 192.168.111.1 and modify
	sed -i "s/${IPADDR}/111.111.111.111/" "${SDCARD_PATH}/${CMDLINE_TXT}"
	if [ $? -eq 0 ]; then
		echo "${CMDLINE_TXT} 문서가 수정되었습니다. 성공"
	else 
		echo "${CMDLINE_TXT} 문서를 수정하지 못하였습니다. 실패"
	fi
fi

# unmount /media/user/bootfs
umount /media/user/bootfs
echo "SC 카드를 분리하셔도 됩니다."
