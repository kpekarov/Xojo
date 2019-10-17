#tag Class
Protected Class CacheEngine
Inherits Timer
	#tag Event
		Sub Run()
		  // Removes expired entries from the cache.
		  
		  Sweep()
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor(SweepIntervalSecs As Integer = 300)
		  Cache = New Dictionary
		  
		  Self.SweepIntervalSecs = SweepIntervalSecs
		  
		  Period = SweepIntervalSecs * 1000
		  
		  me.RunMode = RunModes.Multiple
		  
		  //Mode = Timer.ModeMultiple
		  
		  
		  
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Delete(Name As String)
		  // Deletes an object from the cache.
		  
		  
		  // If the value is in the cache...
		  If Cache.HasKey(Name) Then
		    
		    // Remove the expired cache entry.
		    Cache.Remove(Name)
		    
		  End If
		  
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Get(Name As String) As Dictionary
		  // Gets an object from the cache, and checks its expiration date.
		  // If the object is found, but it has expired, it is deleted from the cache.
		  
		  
		  If Cache.HasKey(Name) Then
		    Dim CacheEntry As Dictionary = Cache.Value(Name)
		    
		    Dim Expiration As DateTime
		    
		    Expiration = CacheEntry.Value("Expiration")
		    
		    Dim Now As DateTime
		    
		    Now = New DateTime(DateTime.Now)
		    
		    If Expiration > Now Then
		      Return CacheEntry
		      
		    Else
		      Cache.Remove(Name)
		      
		      Return Nil
		    End If
		  End If
		  
		  
		  
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Put(Name As String, Content As Variant, ExpirationSecs As Integer)
		  // Puts an object into the cache, and sets its expiration date.
		  
		  
		  Dim Expiration As DateTime
		  Dim Now As DateTime 
		  Dim CacheEntry As Dictionary
		  
		  
		  Expiration = new DateTime(DateTime.Now)
		  Expiration = Expiration.AddInterval(0, 0, 0, 0, 0, ExpirationSecs, 0)
		  
		  Now = new DateTime(DateTime.Now)
		  
		  CacheEntry = new Dictionary()
		  
		  CacheEntry.Value("Content")    = Content
		  CacheEntry.Value("Expiration") = Expiration
		  CacheEntry.Value("Entered")    = Now
		  
		  Cache.Value(Name) = CacheEntry
		  
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Reset()
		  
		  
		  Cache = New Dictionary() // Resets the cache.
		  
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Sweep()
		  // Removes expired objects from the cache.
		  // This prevents the cache from growing unnecessarily due to orphaned objects.
		  
		  
		  Dim Now                 As DateTime
		  Dim ExpiredCacheNames() As String // This is an array of the cache names that have expired.
		  Dim Expiration          As DateTime  
		  
		  
		  Now = new DateTime(DateTime.Now)
		  
		  For Each Key As Variant in Cache.Keys
		    Dim CacheEntry As Dictionary = Cache.Value(Key)
		    
		    
		    Expiration = CacheEntry.Value("Expiration")
		    
		    If Now > Expiration Then
		      ExpiredCacheNames.AddRow(Key)
		    End If
		  Next
		  
		  For Each CacheName As String in ExpiredCacheNames
		    Cache.Remove(CacheName)
		  Next
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Cache As Dictionary
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
			InitialValue="60"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
