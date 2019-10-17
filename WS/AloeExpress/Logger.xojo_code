#tag Class
Protected Class Logger
Inherits Thread
	#tag Event
		Sub Run()
		  
		  RequestLog() // Logs an HTTP request and response.
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  // Set the default log folder.
		  Folder = XJ.getFolderItem("").Parent.Child("logs")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RequestLog()
		  // Logs all requests, including Date/Time, Method (GET, POST, etc), the resource requested,
		  // the HTTP response status (200, 404, etc), response size, and user-agent name.
		  
		  
		  Dim CurrentDate     As DateTime
		  Dim YearFormatted   As String
		  Dim MonthFormatted  As String
		  Dim DayFormatted    As String
		  Dim DateFormatted   As String
		  Dim HourFormatted   As String
		  Dim MinuteFormatted As String
		  Dim SecondFormatted As String
		  Dim TimeFormatted   As String
		  Dim LogFileName     As String
		  Dim FI              As FolderItem
		  Dim TOS             As TextOutputStream
		  
		  
		  CurrentDate = XJ.getDateTimeNow()
		  
		  
		  // Get the current date formatted as YYYYMMDD.
		  YearFormatted   = CurrentDate.Year.ToText
		  MonthFormatted  = If (CurrentDate.Month < 10, "0" + CurrentDate.Month.ToText, CurrentDate.Month.ToText)
		  DayFormatted    = If (CurrentDate.Day < 10, "0" + CurrentDate.Day.ToText, CurrentDate.Day.ToText)
		  DateFormatted   = YearFormatted + MonthFormatted + DayFormatted
		  
		  // Get the current time formatted as HHMMSS.
		  HourFormatted   = If(CurrentDate.Hour < 10, "0" + CurrentDate.Hour.ToText, CurrentDate.Hour.ToText)
		  MinuteFormatted = If(CurrentDate.Minute < 10, "0" + CurrentDate.Minute.ToText, CurrentDate.Minute.ToText)
		  SecondFormatted = If(CurrentDate.Second < 10, "0" + CurrentDate.Second.ToText, CurrentDate.Second.ToText)
		  TimeFormatted   = HourFormatted + ":" + MinuteFormatted + ":" +  SecondFormatted
		  
		  IPAddress = If(IPAddress = "", Request.RemoteAddress, IPAddress) // If no IP address has been specified, use the default remote IP address.
		  
		  LogFileName = DateFormatted + ".log"
		  
		  FI = Folder.Child(LogFileName)
		  
		  If FI <> nil Then
		    If Not FI.exists Then
		      TOS = TextOutputStream.Create(FI)
		      
		      TOS.WriteLine("#Version: 1.0")
		      TOS.WriteLine("#Date: " + DateFormatted + " " + TimeFormatted)
		      TOS.WriteLine("time" + CHR(9) + "cs-method" + CHR(9) + "cs-uri" + CHR(9) + "sc-status" + CHR(9) + "sc-bytes" + CHR(9) + "cs-ip" + CHR(9) + "cs-user-agent" + CHR(9) + "cs-user-referrer")
		      
		    Else
		      TOS = TextOutputStream.Open(FI)
		    End If
		    
		    TOS.WriteLine(TimeFormatted + CHR(9) + Request.Method + CHR(9) + Request.Path + CHR(9) + Request.Response.Status + CHR(9) + _
		    Request.Response.Content.Length.ToText + CHR(9) + Request.Headers.Lookup("X-Forwarded-For", Request.RemoteAddress) + CHR(9) + _
		    Request.Headers.Lookup("User-Agent", "") + CHR(9) + Request.Headers.Lookup("Referer", ""))
		    
		    TOS.Close()
		  End If
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Folder As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		IPAddress As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Request As AloeExpress.Request
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Priority"
			Visible=true
			Group="Behavior"
			InitialValue="5"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StackSize"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IPAddress"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
