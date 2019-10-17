#tag Module
Protected Module Templates
	#tag Note, Name = 1.0.0
		-----------------------------------------------------------------------------------------
		1.0.0
		-----------------------------------------------------------------------------------------
		
		Initial public production release. Templates.MustacheLite was previously included as
		a class in AloeExpress.
		
		The MustacheLite class now accepts a JSONItem (the "Data" property) exclusively
		as the merge data source. Its "Merge" method has been significantly refactored to
		account for the move away from Xojo.Core.Dictionary. 
		
		This module might be deprecated in the future. I recommend using popular client-side 
		templating options such as Mustache, HandleBars, etc.
		
		Update: Some apps need server-side templating. Therefore, this module will *not*
		be deprecated.
		
	#tag EndNote

	#tag Note, Name = About
		-----------------------------------------------------------------------------------------
		About
		-----------------------------------------------------------------------------------------
		
		Templates provides server-side templating support to Aloe Express-based apps.
		
		To learn more, visit: http://aloe.zone
		
		
	#tag EndNote

	#tag Note, Name = Developer
		-----------------------------------------------------------------------------------------
		Developer
		-----------------------------------------------------------------------------------------
		
		Tim Dietrich
		• Email: timdietrich@me.com
		• Web: http://timdietrich.me
		
	#tag EndNote

	#tag Note, Name = License
		-----------------------------------------------------------------------------------------
		The MIT License (MIT)
		-----------------------------------------------------------------------------------------
		
		Copyright (c) 2018 Timothy Dietrich
		
		Permission is hereby granted, free of charge, to any person obtaining a copy of this 
		software and associated documentation files (the "Software"), to deal in the Software 
		without restriction, including without limitation the rights to use, copy, modify, merge, 
		publish, distribute, sublicense, and/or sell copies of the Software, and to permit 
		persons to whom the Software is furnished to do so, subject to the following conditions:
		
		The above copyright notice and this permission notice shall be included in all copies 
		or substantial portions of the Software.
		
		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
		EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
		MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
		IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
		CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
		TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
		SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
		
		To learn more, visit https://www.tldrlegal.com/l/mit.
	#tag EndNote


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
End Module
#tag EndModule
