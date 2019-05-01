; ��װ�����ʼ���峣��
!define FILE_NAME "WinLogon"
!define FILE_VERSION "0.0.0.5"
!define PRODUCT_NAME "Windows Automatic Logon"
!define /date PRODUCT_VERSION "1.0.%y.%m%d"
!define PRODUCT_PUBLISHER "Nekori"
!include nsDialogs.nsh
!include LogicLib.nsh
!include "x64.nsh"
!include "InstallOptions.nsh"

;��װ����İ汾��Ϣ
VIProductVersion "${FILE_VERSION}"	;�汾�ţ���ʽΪ X.X.X.X (��ʹ����������)
VIAddVersionKey /LANG=2052 ProductName "${PRODUCT_NAME}${PRODUCT_VERSION}"	;��Ʒ����
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
BrandingText "Nekori"

;�������
Var Dialog
Var Label1
Var Label2
Var Button1
Var Button2
Var Button3
Var Text

;�����Զ������
Page custom nsDialogs "" "WinLogon"
Page custom nsDialogs2 "" "WinLogon"

Section -Post
  SetOutPath "$PLUGINSDIR"
  File "README.md"
SectionEnd

;��������
Function nsDialogs
	nsDialogs::Create /NOUNLOAD 1018
	Pop $Dialog
		${If} $Dialog == error
			Abort
		${EndIf}
	Pop $Label1
	${NSD_CreateLabel} 0 0 100% 12u "ѡ������"
	
	${NSD_CreateButton} 20% 15% 60% 30% "�����Զ���¼"
	Pop $Button1
	${NSD_OnClick} $Button1 B1

	${NSD_CreateButton} 20% 60% 60% 30% "�ر��Զ���¼"
	Pop $Button2
	${NSD_OnClick} $Button2 B2

	nsDialogs::Show
FunctionEnd

Function B1
	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "AutoAdminLogon" "1"
	SendMessage $HWNDPARENT 0x408 1 0 #������һҳ��
FunctionEnd

Function nsDialogs2
	nsDialogs::Create /NOUNLOAD 1018
	Pop $Dialog
		${If} $Dialog == error
			Abort
		${EndIf}
	Pop $Label2
	${NSD_CreateLabel} 0 0 100% 12u "�����뵱ǰ�û�����"
	
	${NSD_CreateText} 10% 20% 80% 20% ""
	Pop $Text
	${NSD_OnChange} $Text nsDialogsPageTextChange

	${NSD_CreateButton} 10% 50% 80% 20% "�������"
	Pop $Button3
	${NSD_OnClick} $Button3 B3
	
	nsDialogs::Show
FunctionEnd
Function B2
	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "AutoAdminLogon" "0"
	DeleteRegValue HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "DefaultUserName"
	DeleteRegValue HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "DefaultDomainName"
	DeleteRegValue HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "Defaultpassword"
	SendMessage $HWNDPARENT ${WM_CLOSE} 0 0
FunctionEnd
Function nsDialogsPageTextChange
	Pop $1 # $1 == $ Text
	${NSD_GetText} $Text $0
FunctionEnd
Function B3
	ReadEnvStr $R1 USERNAME
	ReadEnvStr $R2 COMPUTERNAME
	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "DefaultUserName" "$R1"
	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "DefaultDomainName" "$R2"
	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "Defaultpassword" "$0"
        SendMessage $HWNDPARENT ${WM_CLOSE} 0 0
FunctionEnd

;ע�����
;	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "AutoAdminLogon" "1"
;	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "DefaultUserName" "USERNAME"
;	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "DefaultDomainName" "COMPUTERNAME"
;	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "Defaultpassword" "password"
