; 安装程序初始定义常量
!define FILE_NAME "WinLogon"
!define FILE_VERSION "0.0.0.2"
!define PRODUCT_NAME "Windows Automatic Logon"
!define /date PRODUCT_VERSION "1.0.%y.%m%d"
!define PRODUCT_PUBLISHER "Nekori"
!include nsDialogs.nsh
!include LogicLib.nsh
!include "x64.nsh"
!include "InstallOptions.nsh"

;安装程序的版本信息
VIProductVersion "${FILE_VERSION}"	;版本号，格式为 X.X.X.X (若使用则本条必须)
VIAddVersionKey /LANG=2052 ProductName "${PRODUCT_NAME}${PRODUCT_VERSION}"	;产品名称
VIAddVersionKey /LANG=2052 ProductVersion "${PRODUCT_VERSION}"	;产品版本
VIAddVersionKey /LANG=2052 Comments "${PRODUCT_NAME}${PRODUCT_VERSION}"	;备注
VIAddVersionKey /LANG=2052 LegalCopyright "Copyright (C) ${PRODUCT_PUBLISHER}"	;合法版权
VIAddVersionKey /LANG=2052 FileDescription "${PRODUCT_NAME}"	;文件描述(标准信息)
VIAddVersionKey /LANG=2052 FileVersion "${FILE_VERSION}"	;文件版本(标准信息)
;VIAddVersionKey /LANG=2052 CompanyName "${PRODUCT_PUBLISHER}"	;公司名
;VIAddVersionKey /LANG=2052 LegalTrademarks "${PRODUCT_PUBLISHER}"		;合法商标

Name "${PRODUCT_NAME} ${FILE_VERSION}"
OutFile "${FILE_NAME} v${FILE_VERSION}.exe"
InstallDir "$PLUGINSDIR"
Icon "D:\Users\图标\洛克人ico\X.ico"
RequestExecutionLevel user
SetCompressor lzma
BrandingText "Nekori"

;分配变量
Var Dialog
Var Label1
Var Button1
Var Button2

;创建自定义界面
Page custom nsDialogs "" "WinLogon"

Section -Post
  SetOutPath "$PLUGINSDIR"
  File "README.md"
SectionEnd

;函数区段
Function nsDialogs
	nsDialogs::Create /NOUNLOAD 1018
  Pop $Dialog
	${If} $Dialog == error
		Abort
	${EndIf}
	  
	Pop $Label1
	${NSD_CreateLabel} 0 0 100% 12u "选择内容"

	${NSD_CreateButton} 20% 15% 60% 30% "启动自动登录"
	Pop $Button1
	${NSD_OnClick} $Button1 B1

	${NSD_CreateButton} 20% 60% 60% 30% "关闭自动登录"
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

;注册表项
;	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "AutoAdminLogon" "1"
;	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "DefaultUserName" "USERNAME"
;	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "DefaultDomainName" "COMPUTERNAME"
;	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "Defaultpassword" "password"