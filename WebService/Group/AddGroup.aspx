<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="utf-8" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDB" %>

<!--#include virtual="~/site/CRM/SQLAccess/Connection.aspx.vb"-->


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>


<script runat="server">
Sub Page_Load(Src As Object, E As EventArgs)


	
			Dim groupName As String =request.QueryString("groupName")
			
			'IE還是不行輸出正確中文,其他可
			'Response.Charset="UTF-8"
			'response.ContentType = "text/xml;charset=UTF-8"
			   'response.write(groupName)
			   
				dim conn as OleDbConnection = Connection.getConnection()
					dim cmd as new OleDbCommand
					conn.open
					cmd.connection = conn
'		
				
				dim sqlcmd as new StringBuilder("")
					with sqlcmd
						.append("INSERT INTO 類別群組(群組)VALUES( " )
						.append("'" & groupName & "')")
					End With
			
				
				cmd.commandText = sqlcmd.ToString()

					using conn
						
							Dim reader As OleDbDataReader = cmd.ExecuteReader()

		
					end using
					
End Sub
</script>
</head>
<body>
</body>
</html>
