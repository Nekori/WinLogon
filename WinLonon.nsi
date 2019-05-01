; ��װ�����ʼ���峣��
!define FILE_NAME "WinLogon"
!define FILE_VERSION "1.0.0.3"
!define PRODUCT_NAME "Windows Automatic Logon"
!define /date PRODUCT_VERSION "1.0.%y.%m%d"
!define PRODUCT_PUBLISHER "Nekori"
!include nsDialogs.nsh
!include LogicLib.nsh
!include "x64.nsh"
!include "InstallOptions.nsh"

;��װ����İ汾��Ϣ
VIProductVersion "${FILE_VERSION}"	;�汾�ţ���ʽΪ X.X.X.X (��ʹ����������)
VIAddVersionKey /LANG=2052 ProductName "${PRODUCT_NAME} ${PRODUCT_VERSION}"	;��Ʒ����
VIAddVersionKey /LANG=2052 ProductVersion "${PRODUCT_VERSION}"	;��Ʒ�汾
VIAddVersionKey /LANG=2052 Comments "${PRODUCT_NAME}${PRODUCT_VERSION}"	;��ע
VIAddVersionKey /LANG=2052 LegalCopyright "Copyright (C) ${PRODUCT_PUBLISHER}"	;�Ϸ���Ȩ
VIAddVersionKey /LANG=2052 FileDescription "${PRODUCT_NAME}"	;�ļ�����(��׼��Ϣ)
VIAddVersionKey /LANG=2052 FileVersion "${FILE_VERSION}"	;�ļ��汾(��׼��Ϣ)
;VIAddVersionKey /LANG=2052 CompanyName "${PRODUCT_PUBLISHER}"	;��˾��
;VIAddVersionKey /LANG=2052 LegalTrademarks "${PRODUCT_PUBLISHER}"		;�Ϸ��̱�

Name "${PRODUCT_NAME} ${FILE_VERSION}"
OutFile "${FILE_NAME} v${FILE_VERSION}.exe"
InstallDir "$PLUGINSDIR"
Icon "G:\ICON\�����ico\X.ico"
RequestExecutionLevel admin
SetCompressor lzma
BrandingText /TRIMright "Nekori��https://github.com/Nekori/WinLogon"

;�������
Var Dialog
Var Label1
Var Button1
Var Button2
Var Button3
Var Buttonhttp
Var Text

;�����Զ������
Page custom nsDialogs "" "WinLogon"

Section -Post
	SetOutPath "$PLUGINSDIR"
	File "README.md"
SectionEnd

;��������
Function nsDialogs
	${If} ${RunningX64}
	      SetRegView 64
	${Else}
	       SetRegView 32
	${EndIf}
	
	nsDialogs::Create /NOUNLOAD 1018
	Pop $Dialog
		${If} $Dialog == error
			Abort
		${EndIf}
	Pop $Label1
	${NSD_CreateLabel} 5% 5% 100% 10% "�����뵱ǰ�û�����"
	
	${NSD_CreateText} 10% 20% 80% 20% ""
	Pop $Text
	${NSD_OnChange} $Text nsDialogsPageTextChange
	
	${NSD_CreateButton} 10% 45% 35% 20% "�����Զ���¼"
	Pop $Button1
	${NSD_OnClick} $Button1 B1

	${NSD_CreateButton} 55% 45% 35% 20% "�ر��Զ���¼"
	Pop $Button2
	${NSD_OnClick} $Button2 B2

	${NSD_CreateButton} 10% 70% 80% 20% "���µ�ַ"
	Pop $Buttonhttp
	${NSD_OnClick} $Buttonhttp Bhttp

	nsDialogs::Show
FunctionEnd
Function B1
	ReadEnvStr $R1 USERNAME
	ReadEnvStr $R2 COMPUTERNAME
	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "AutoAdminLogon" "1"
	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "DefaultUserName" "$R1"
	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "DefaultDomainName" "$R2"
	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "Defaultpassword" "$0"
	SendMessage $HWNDPARENT ${WM_CLOSE} 0 0
FunctionEnd
Function B2
	DeleteRegValue HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "AutoAdminLogon"
	DeleteRegValue HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "DefaultUserName"
	DeleteRegValue HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "DefaultDomainName"
	DeleteRegValue HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "Defaultpassword"
	SendMessage $HWNDPARENT ${WM_CLOSE} 0 0
FunctionEnd
Function nsDialogsPageTextChange
	Pop $1 # $1 == $ Text
	${NSD_GetText} $Text $0
FunctionEnd
Function Bhttp
	 ExecShell open "https://github.com/Nekori/WinLogon/releases"
FunctionEnd
