<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="utf-8" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDB" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>

<!--#include virtual="~/site/CRM/SQLAccess/Connection.aspx.vb"-->


<script runat="server">
Sub Page_Load(Src As Object, E As EventArgs)

			dim q as string = request.QueryString("q")
		
			dim conn as OleDbConnection = Connection.getConnection()
			dim cmd as new OleDbCommand()
		
			cmd.connection = conn
			cmd.commandText = String.Format("SELECT  Top 5 CustName FROM Customer WHERE inStr(CustName,'{0}') = 1",q)
			conn.open
			'SELECT  Top 5 CustName FROM Customer where CustName like '%" & q & "%'
			
			
			dim reader as OleDbDataReader = cmd.executeReader()
			
			while reader.read
            Response.Write("<li onselect= this.setText('" & reader.Item("CustName") & "')>")
	                            '這裡的onselect和setText方法都是只有在這個JS檔才有的,原本的html是沒有的
            Response.Write(reader.Item("CustName"))
			response.write("</li>")
			End While
			
        	conn.Close()
End Sub
</script>
</head>
<body>
</body>
</html>
