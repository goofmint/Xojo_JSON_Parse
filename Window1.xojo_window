#tag Window
Begin Window Window1
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Compatibility   =   ""
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   400
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   714764287
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   True
   Title           =   "名称未設定"
   Visible         =   True
   Width           =   600
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Dim json as JSONItem = new JSONItem(swagger)
		  Dim str() as String
		  
		  OutputJSON(json, str)
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub OutputJSON(json as JSONItem, parentKeys() as String)
		  If json.IsArray Then
		    // 配列の場合
		    For i as Integer = 0 To json.Count - 1
		      OutputValue(i.ToText, json(i), parentKeys)
		    Next
		  Else
		    // オブジェクトの場合
		    For Each key as String in json.Names
		      OutputValue(key, json.Value(key), parentKeys)
		    Next
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub OutputValue(key as String, json as variant , parentKeys() as String)
		  // キー
		  Dim keyString as String = If(Ubound(parentKeys) = -1, "", Join(parentKeys, ".") + ".") + key
		  Select Case Xojo.Introspection.GetType(json)
		  Case GetTypeInfo(String)
		    // 文字列として取り出せる場合
		    System.DebugLog(keyString)
		    Dim str as String = json
		    System.DebugLog(" => (string) " + str)
		  Case GetTypeInfo(Double)
		    // 数値として取り出せる場合
		    Dim num as Integer = json
		    System.DebugLog(" => (number) " + num.ToText)
		  Case GetTypeInfo(Boolean)
		    // 真偽値として取り出せる場合
		    Dim bol as String = If(json, "True", "False")
		    System.DebugLog(keyString)
		    System.DebugLog(" => (boolean)" + bol)
		  Else
		    // それ以外の場合はJSONItemに展開
		    Dim childKeys() as String
		    For i as Integer = 0 To UBound(parentKeys)
		      childKeys.Append(parentKeys(i))
		    Next
		    
		    childKeys.Append(key)
		    OutputJSON(json, childKeys)
		  End Select
		End Sub
	#tag EndMethod


#tag EndWindowCode

