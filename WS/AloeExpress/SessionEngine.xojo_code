#tag Class
Protected Class SessionEngine
Inherits Timer
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target32Bit or Target64Bit ) )
	#tag Event
		Sub Run()
		  SessionsSweep()
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(SweepIntervalSecs As Integer = 300)
		  Sessions = New Dictionary()
		  
		  Self.SweepIntervalSecs = SweepIntervalSecs
		  
		  
		  me.Period  = SweepIntervalSecs * 1000
		  me.RunMode = RunModes.Multiple
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SessionGet(Request As AloeExpress.Request, AssignNewID As Boolean=True) As Dictionary
		  // Returns a session for the request.
		  // If an existing session is available, then it is returned.
		  // Otherwise a new session is created and returned.
		  
		  
		  Dim Session              As Dictionary
		  Dim NewSessionID         As String // This will be used if a new SessionID is assigned.
		  Dim Now                  As DateTime
		  Dim OriginalSessionID    As String
		  Dim LastRequestTimestamp As DateTime
		  Dim TimeElapsed          As Double
		  Dim CookieExpiration     As DateTime
		  
		  
		  Now = new DateTime(DateTime.Now)
		  
		  OriginalSessionID = Request.Cookies.Lookup("SessionID", "")
		  
		  
		  If OriginalSessionID <> "" Then
		    If Sessions.HasKey(OriginalSessionID) = True Then
		      Session = Sessions.Value(OriginalSessionID)
		      
		      LastRequestTimestamp = Session.Value("LastRequestTimestamp")
		      
		      TimeElapsed = Now.SecondsFrom1970 - LastRequestTimestamp.SecondsFrom1970 // Determine the time that has elapsed since the last request.
		      
		      If TimeElapsed > SessionsTimeOutSecs Then
		        Sessions.Remove(OriginalSessionID)
		        
		        Session = Nil
		      End If
		    End If
		  End If
		  
		  
		  If Session <> Nil Then
		    Session.Value("LastRequestTimestamp") = Now
		    
		    Session.Value("RequestCount") = Session.Value("RequestCount") + 1
		    
		    If AssignNewID = False Then
		      Return Session
		    End If
		    
		    NewSessionID = UUIDGenerate
		    
		    Session.Value("SessionID") = NewSessionID
		    
		    Sessions.Value(NewSessionID) = Session
		    
		    Sessions.Remove(OriginalSessionID)
		    
		  Else
		    NewSessionID = UUIDGenerate // We were unable to re-use an existing session, so create a new one...
		    
		    Session = New Dictionary()
		    
		    Session.Value("SessionID")            = NewSessionID
		    Session.Value("LastRequestTimestamp") = Now
		    Session.Value("RemoteAddress")        = Request.RemoteAddress
		    Session.Value("UserAgent")            = Request.Headers.Lookup("User-Agent", "")
		    Session.Value("RequestCount")         = 1
		    Session.Value("Authenticated")        = False
		  End If
		  
		  
		  Sessions.Value(NewSessionID) = Session
		  
		  
		  CookieExpiration = New DateTime(DateTime.Now)
		  CookieExpiration = CookieExpiration.AddInterval(0, 0, 0, 0, 0, SessionsTimeOutSecs, 0)
		  
		  
		  Request.Response.CookieSet("SessionID", NewSessionID, CookieExpiration) // Drop the SessionID cookie.
		  
		  
		  Return Session
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SessionsSweep()
		  // Removes any expired sessions from the Sessions array.
		  // This prevents the array from growing unnecessarily due to orphaned sessions.
		  
		  
		  Dim Now                  As DateTime
		  Dim Session              As Dictionary 
		  Dim LastRequestTimestamp As DateTime
		  Dim TimeElapsedSecs      As Double
		  Dim ExpiredSessionIDs()  As String
		  
		  
		  Now = new DateTime(DateTime.Now)
		  
		  For Each Key As Variant in Sessions.Keys
		    Session = Sessions.Value(Key)
		    
		    LastRequestTimestamp = Session.Value("LastRequestTimestamp")
		    
		    TimeElapsedSecs = Now.SecondsFrom1970 - LastRequestTimestamp.SecondsFrom1970 // Determine the time that has elapsed since the last request.
		    
		    If TimeElapsedSecs > SessionsTimeOutSecs Then
		      ExpiredSessionIDs.AddRow(Key)
		    End If
		  Next
		  
		  For Each SessionID As String in ExpiredSessionIDs
		    Sessions.Remove(SessionID)
		  Next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SessionTerminate(Session As Dictionary)
		  // Terminates a given session.
		  
		  If Sessions.HasKey(Session.Value("SessionID")) Then
		    Sessions.Remove(Session.Value("SessionID"))
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Sessions As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		SessionsTimeOutSecs As Integer = 600
	#tag EndProperty

	#tag Property, Flags = &h0
		SweepIntervalSecs As Integer = 300
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="RunMode"
			Visible=true
			Group="Behavior"
			InitialValue="2"
			Type="RunModes"
			EditorType="Enum"
			#tag EnumValues
				"0 - Off"
				"1 - Single"
				"2 - Multiple"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Period"
			Visible=true
			Group="Behavior"
			InitialValue="1000"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
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
			InitialValue="-2147483648"
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
			Name="SweepIntervalSecs"
			Visible=false
			Group="Behavior"
			InitialValue="300"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SessionsTimeOutSecs"
			Visible=false
			Group="Behavior"
			InitialValue="600"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
