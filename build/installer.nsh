!macro customInit
  ; Override default installation directory to be directly in LocalAppData
  StrCpy $INSTDIR "$LOCALAPPDATA\SideAI"
  
  ; Forcefully kill the app if it's running to prevent installation failure
  nsExec::ExecToStack 'taskkill /F /IM "SideAI.exe"'
!macroend
