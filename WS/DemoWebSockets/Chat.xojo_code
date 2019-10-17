#tag Class
Protected Class Chat
	#tag Method, Flags = &h0
		Sub Constructor(Request As AloeExpress.Request)
		  // Store the request.
		  Self.Request = Request
		  
		  // If this is a request from an active WebSocket connection...
		  If Request.WSStatus = "Active" Then
		    // Process the payload.
		    PayloadProcess
		  Else
		    // Process the connection request with an opening handshake.
		    Request.WSHandshake
		  End If
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub JoinProcess()
		  
		  // Get the username.
		  Dim NewUsername As String = AloeExpress.URLDecode(Payload.Lookup("username", ""))
		  
		  // Associate the username with the socket.
		  Request.Custom.Value("username") = NewUsername
		  
		  // Get the names of the other users that are online...
		  Dim Usernames() As String
		  For Each WebSockets As AloeExpress.Request In Request.Server.WebSockets
		    Dim Username As String = WebSockets.Custom.Lookup("username", "")
		    If Username <> NewUsername Then
		      Usernames.AddRow(AloeExpress.URLEncode(username))
		    End If
		  Next
		  
		  // If this is the first user in the chat...
		  If Usernames.LastRowIndex = -1 Then
		    
		    // Return the list.
		    Dim ResponseJSON As New JSONItem
		    ResponseJSON.Value("type") = "message"
		    ResponseJSON.Value("username") = "Server"
		    ResponseJSON.Value("message") = "Welcome, " + AloeExpress.URLEncode(NewUsername) + ". You are the first user in the chat."
		    Request.WSMessageSend(ResponseJSON.ToString)
		    
		  Else
		    
		    // Return the list of users.
		    Dim ResponseJSON As New JSONItem
		    ResponseJSON.Value("type") = "message"
		    ResponseJSON.Value("username") = "Server"
		    ResponseJSON.Value("message") = "Welcome, " + AloeExpress.URLEncode(NewUsername) + ". You are joining " + Join(Usernames, ", ") + " in the chat."
		    Request.WSMessageSend(ResponseJSON.ToString)
		    
		    // Broadcast a message announcing the new user.
		    ResponseJSON = New JSONItem
		    ResponseJSON.Value("type") = "message"
		    ResponseJSON.Value("username") = "Server"
		    ResponseJSON.Value("message") = AloeExpress.URLEncode(NewUsername + " has joined the chat.")
		    Request.Server.WSMessageBroadcast(ResponseJSON.ToString)
		    
		  End If
		  
		  
		  
		  
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LeaveProcess()
		  
		  // Close the connection.
		  Request.WSConnectionClose
		  
		  // Get the username.
		  Dim Username As String = AloeExpress.URLDecode(Payload.Lookup("username", ""))
		  
		  // Broadcast a message announcing the departure of the user.
		  Dim ResponseJSON As New JSONItem
		  ResponseJSON.Value("type") = "message"
		  ResponseJSON.Value("username") = "Server"
		  ResponseJSON.Value("message") = AloeExpress.URLEncode(Username) + " has left the chat."
		  Request.Server.WSMessageBroadcast(ResponseJSON.ToString)
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MessageProcess()
		  // Broadcasts a message.
		  
		  // If the message isn't blank...
		  If Request.Body <> "" Then
		    Request.Server.WSMessageBroadcast(Request.Body)
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PayloadProcess()
		  // Processes a request.
		  
		  
		  // Try to convert the request body (the payload) to JSON.
		  Try
		    Payload = New JSONItem(AloeExpress.URLDecode(Request.Body))
		  Catch e As JSONException
		    // Ignore the payload.
		    Return
		  End Try
		  
		  // Get the payload type.
		  Dim PayloadType As String = Payload.Lookup("type", "message")
		  
		  // Process the request...
		  Select Case PayloadType
		  Case "join"
		    JoinProcess
		  Case "leave"
		    LeaveProcess
		  Case "who"
		    WhoProcess
		  Else
		    MessageProcess
		  End Select
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WhoProcess()
		  // If this is a request to get a list of users...
		  
		  // Get the names of the users that are online...
		  Dim Usernames() As String
		  For Each Request As AloeExpress.Request In Request.Server.WebSockets
		    Dim Username As String = Request.Custom.Lookup("username", "")
		    If Username <> "" Then
		      Usernames.AddRow(AloeExpress.URLEncode(username))
		    End If
		  Next
		  
		  // Return the list.
		  Dim ResponseJSON As New JSONItem
		  ResponseJSON.Value("type") = "message"
		  ResponseJSON.Value("username") = "Server"
		  ResponseJSON.Value("message") ="These users are currently online: " + Join(Usernames, ", ")
		  Request.WSMessageSend(ResponseJSON.ToString)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Payload As JSONItem
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
