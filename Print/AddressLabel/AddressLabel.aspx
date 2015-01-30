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
	width: 100%;
	color: #212424;
	margin: 0 0 0 0;	
	font: 120%/200% "Lucida Grande", "Lucida Sans Unicode", "Lucida Sans", Lucida, Helvetica, sans-serif;
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


</script>

</head>
<body>

<form runat="server">
<table>
        	<tr>
            <td  class="bubble" colspan="4"  style="padding: 3px 0pt; font-family: arial; text-align: left; font-weight: bold; font-size: 100%;">客戶資料
             </td>
            </tr>
 </table>
 
	   <div  id="Content">
			  

            
        <%
		
		Dim sql As String = ""
		'Dim CustIdGroup As String = Session("CustIds")
		IF NOT Session("CustDataSet")IS NOTHING THEN
			sql = Session("CustDataSet")
		ELSE
			sql = "SELECT  * FROM Customer"
		END IF
		
		Dim dt As New DataTable
        Dim conn As OleDbConnection = Connection.getConnection
        Dim cmd As New OleDbCommand
		'Dim sql As String = "select * from Customer Where CustId In( " & CustIdGroup & ")"
        cmd.CommandText = sql
        cmd.Connection = conn
        conn.Open()
		
		Dim reader As OleDbDataReader = cmd.ExecuteReader
		
		
		
	
	Using conn
	
	
	While reader.read
			%>
             <div id="Content_Left"> 
   <div  class="PubNoteContentArea">
   			
       

            	<%=reader.Item("CustAddress")%><p>
                
       			<%=reader.Item("CustName")%>&nbsp;&nbsp;啟
       	 
   	
    </div>
   
   </div>
    <%
		End While
	End Using
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
	 
    </div>	
	<%
	
	
		'End While
		
	
		'End Using
	%>
</form>
</body>
</html>
