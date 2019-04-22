; ��װ�����ʼ���峣��
!define FILE_NAME "WinLogon"
!define FILE_VERSION "0.0.0.2"
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
Icon "D:\Users\ͼ��\�����ico\X.ico"
RequestExecutionLevel user
SetCompressor lzma
BrandingText "Nekori"

;�������
Var Dialog
Var Label1
Var Button1
Var Button2

;�����Զ������
Page custom nsDialogs "" "WinLogon"

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
FunctionEnd
Function B2
	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "AutoAdminLogon" "0"
	Quit
FunctionEnd

;ע�����
;	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "AutoAdminLogon" "1"
;	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "DefaultUserName" "USERNAME"
;	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "DefaultDomainName" "COMPUTERNAME"
;	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "Defaultpassword" "password"