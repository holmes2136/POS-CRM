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
	font-size:83%
}img{border:0}a:link{color:#00c}#blockedReason{margin:1em 30px;padding:1em;border:1px solid #333333;background-color:#ffffcc;color:#cc0000;font-size:100%}.PubNote{width:70%;margin:0px 0px 15px 30px;padding:5px 0px 0px 0px;border-top:1px solid #ccc;border-right:2px solid #bbb;border-bottom:2px solid #888;border-left:1px solid #bbb}.PubNoteAttributes{margin:0px 10px 5px 10px}.Labels{margin:10px 10px 5px 10px;color:#006633}.LabelHeader{color:#666666}.AttributeTitle{font-weight:bold;font-size:105%}.PubNoteContentArea{margin:5px 10px 5px 10px}.gn_bq{margin:2px 0;border-left:1px dotted #ccc;padding:0 5px}.gn_c{background-color:#e7eef2;padding:5px 10px 5px 15px;margin:5px -10px -5px -10px;border-top:1px solid #ccc;color:#444;font-size:90%}.PubSectionHeader{color:#ffffff;font-weight:bold;background-color:#7799bb;padding:2px 10px}#pubHeader{margin-bottom:20px}#pubHeaderMain{font-weight:bold;margin-bottom:10px}#pubHeaderSub{margin-bottom:10px;line-height:1.4em;color:#333}#notebookList{margin:0px 0px 10px 40px;line-height:1.4em}#SectionListHeader{font-weight:bold;margin-bottom:10px;background-color:#ddd;color:#000;padding:2px 10px}#disclaimer{margin:20px auto 30px 30px;color:#666}#pubContent{margin:20px auto 20px 30px;width:800px}#sectionList{line-height:1.2em;border-bottom:1px solid #ccc;padding-bottom:10px;margin-bottom:10px;border:1px solid #ddd}#sectionList ul{margin:0;padding:0;list-style:none}#sectionList li{margin:0px 10px 0px 20px!important;padding:0;font-size:100%!important;list-style:none;text-indent:-10px}.bubble{background-color:#c3d9ff}

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

<!--#include virtual="~/site/TodayBillPlatfom/Shop/c037/Cust/SQLAccess/Connection.aspx.vb"-->

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
 
	
            
        <%
		
		Dim sql As String = ""
		
		
		
		IF NOT Session("CustIds")IS NOTHING THEN
			sql = Session("CustIds")
		ELSE
			sql = "SELECT  top 50 * FROM 客戶資料表"
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
   <div class="PubNote"> 
   <div  class="PubNoteContentArea">
   			
       <table>
<tr>
            	<td width="20%">姓名</td>
       	<td width="80%"><%=reader.Item("CustName")%></td>
       	 </tr>
            <tr>
            	<td>連絡電話</td>
            	<td><%=reader.Item("CustTelPhone")%></td>
          	</tr>
            <tr>
            	<td>個人手機</td>
            	<td><%=reader.Item("CustMobile")%></td>
          	</tr>
            <tr>
            	   <td>電子郵件</td>
            	<td><%=reader.Item("CustEmail")%></td>
          	</tr>
            <tr>
            	 <td>個人地址</td>
            	<td><%=reader.Item("CustAddress")%></td>
          	</tr>
            
            <tr>
            	<td width="20%">遠近</td>
       	<td width="80%"></td>
       	 </tr>
            <tr>
            	<td>鏡片度數</td>
            	<td>
                </td>
          	</tr>
            <tr>
            	<td>散光</td>
            	<td></td>
          	</tr>
            <tr>
            	   <td>角度</td>
            	<td></td>
          	</tr>
            <tr>
            	 <td>視力</td>
            	<td></td>
          	</tr>
            
            
        </table>	
   	
    </div>
    </div>	
	
	<%
		End While
		End Using
	%>
</form>
</body>
</html>
