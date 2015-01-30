<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="utf-8" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDB" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>

<style type="text/css">

body,td,th{
	font-family:Arial, Helvetica, sans-serif;
	font-size:100%
}
.bubble{background-color:#c3d9ff}

table {
/*	width: 100%;
*/	color: #212424;
	margin: 0 0 0 0;	
	font: 90%/200% "Lucida Grande", "Lucida Sans Unicode", "Lucida Sans", Lucida, Helvetica, sans-serif;
}
table, tr, th, td {
	margin: 0;
	padding: 0;
	border-spacing: 0;
	border-collapse: collapse;
}

#Content{
	width:100%;
	/*background:#CCFF00;*/
	
	clear:both;
}

#Content_Left{
	
	float:none;
	width:46%;
	margin:0px 0px 15px 30px;
	padding:5px 0px 0px 0px;
	border-top:1px solid #ccc;
	border-right:2px solid #bbb;
	border-bottom:2px solid #888;
	border-left:1px solid #bbb;
}

#Content_Right{
	
	float:right;
	width:46%;
	margin:0px 0px 15px 30px;
	padding:5px 0px 0px 0px;
	border-top:1px solid #ccc;
	border-right:2px solid #bbb;
	border-bottom:2px solid #888;
	border-left:1px solid #bbb;
}


/* HEADER */

thead {
	background: #524123;
}
thead tr th {
	padding: 1em 0;
	text-align: center;
	color: #FAF7D4;
	border-bottom: 3px solid #A5D768;
}


tbody tr th:hover {
	background: #D0EBA6;
}

.myFileSet {
	    
	height: 200px;
	width: 600px;
}

</style>

<!--#include virtual="~/site/CRM/SQLAccess/Connection.aspx.vb" -->

<script runat="server">
Sub Page_Load(Src As Object, E As EventArgs)
	
	
        'response.write("tt" & Session("Ds"))

        
	
End Sub


Private Class AddreLabel
	Private CustAddress As string 
	Private CustName As String
	
	public function getCustAddress()As String
		return me.CustAddress
	End Function
	
	public sub setCustAddress(Byval CustAddress As String)
		IF String.IsNullOrEmpty(CustAddress) THEN
			me.CustAddress = String.Empty
		Else
			me.CustAddress = CustAddress

		END IF
	End Sub
	
	public function getCustName()As String
		return me.CustName
	End Function
	
	public sub setCustName(Byval CustName As String)
		IF String.IsNullOrEmpty(CustName) THEN
			me.CustName = String.Empty
		Else
			me.CustName = CustName

		END IF
	End Sub
	
End Class

</script>

</head>
<body>

<form runat="server">

            
        <%
		Dim ret As New Collection
		Dim sql As String = ""
		'Dim CustIdGroup As String = Session("CustIds")
		IF NOT Session("CustIds")IS NOTHING THEN
			sql = Session("CustIds")
		ELSE
			sql = "SELECT  * FROM Customer"
		END IF
		
		
        Dim conn As OleDbConnection = Connection.getConnection
        Dim cmd As New OleDbCommand
		'Dim sql As String = "select * from Customer Where CustId In( " & CustIdGroup & ")"
        cmd.CommandText = sql
        cmd.Connection = conn
        conn.Open()
		
		Dim reader As OleDbDataReader = cmd.ExecuteReader
		
		
		
	
	Using conn
	
	
	While reader.read
			
       	Dim lbl As New AddreLabel
			lbl.setCustAddress(reader.Item("CustAddress"))
            lbl.setCustName(reader.Item("CustName")) 
			ret.Add(lbl)
            
	End While
	End Using
       			
    Response.write("<table border=1 width=600>")
	   	 		
 	For i As Integer = 1 To ret.Count -1
		Response.write("<tr>")
		Response.write("<td>&nbsp;&nbsp;" & Ctype(ret.Item(i),AddreLabel).getCustAddress)
		Response.write("<p>")
		Response.write("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" &  Ctype(ret.Item(i),AddreLabel).getCustName & "收</td>")
		
		Response.write("<td>&nbsp;&nbsp;" &  Ctype(ret.Item(i+1),AddreLabel).getCustAddress)
		Response.write("<p>")
		Response.write("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" & Ctype(ret.Item(i+1),AddreLabel).getCustName & "收</td>")
		
		Response.write("</tr>")
	Next
   
	Response.write("</table>")
	%>
    
    <%  
	 

        
			 'reader.read() %>
   <!--  <div id="Content_Right"> 
   <div  class="PubNoteContentArea">-->
   			
     <%'=reader.Item("CustAddress")%><!--<p>-->
        <%'=reader.Item("CustName")%><!--&nbsp;&nbsp;啟-->
       	  
   <!--	
    </div>
    </div>	-->
	 	
	<%
	
	
		'End While
		
	
		'End Using
	%>
</form>
</body>
</html>
