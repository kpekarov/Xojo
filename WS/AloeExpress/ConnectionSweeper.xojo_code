#tag Class
Protected Class ConnectionSweeper
Inherits Timer
	#tag Event
		Sub Run()
		  
		  HTTPConnSweep() // Closes any HTTP connections that have timed out.
		  
		  WSConnSweep() // Closes any WebSocket connections that have timed out.
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(Server As AloeExpress.Server)
		  Self.Server = Server
		  
		  Period = Server.ConnSweepIntervalSecs * 1000
		  
		  me.RunMode = RunModes.Multiple
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HTTPConnSweep()
		  
		  For Each Socket As AloeExpress.Request in Server.Sockets
		    If Socket.IsConnected = False Then
		      Continue
		    End If
		    
		    If Socket.LastConnectDateTime = Nil Then
		      Continue
		    End If
		    
		    If Socket.WSStatus = "Active" Then
		      Continue
		    End If
		    
		    dim NowDT      as DateTime
		    dim TimeoutDT  as DateTime
		    
		    
		    NowDT     = new DateTime(DateTime.Now)
		    TimeoutDT = Socket.LastConnectDateTime
		    //TimeoutDT.Second = TimeoutDT.Second + Server.KeepAliveTimeout // is write-only!
		    TimeoutDT = TimeoutDT.AddInterval(0, 0, 0, 0, 0, Server.KeepAliveTimeout, 0)
		    //TimeoutDT = new DateTime(TimeoutDT.Year, TimeoutDT.Month, TimeoutDT.Day, TimeoutDT.Hour, TimeoutDT.Minute, TimeoutDT.Second + Server.KeepAliveTimeout, TimeoutDT.Nanosecond, TimeoutDT.Timezone)
		    
		    
		    If NowDT > TimeoutDT then
		      Socket.LastConnectDateTime = Nil
		      
		      Socket.Close
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WSConnSweep()
		  // Closes WebSocket connections that have timed out.
		  
		  If Server.WSTimeout = 0 Then // If the server has been configured so that WebSocket connections do not timeout...
		    Return
		  End If
		  
		  For i As Integer = Server.WebSockets.LastRowIndex DownTo 0
		    Dim Socket As AloeExpress.Request = Server.WebSockets(i)
		    
		    dim NowDT     as DateTime
		    dim TimeoutDT as DateTime
		    
		    NowDT = new DateTime(DateTime.Now)
		    TimeoutDT = Socket.LastConnectDateTime
		    TimeoutDT = TimeoutDT.AddInterval(0, 0, 0, 0, 0, Server.WSTimeout, 0)
		    
		    If NowDT > TimeoutDT Then
		      Socket.LastConnectDateTime = Nil
		      
		      Socket.WSStatus = "Inactive"
		      
		      Socket.Close
		      
		      Server.WebSockets.RemoveRowAt(i)
		    End If
		    
		  Next
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Server As AloeExpress.Server
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
	#tag EndViewBehavior
End Class
#tag EndClass
