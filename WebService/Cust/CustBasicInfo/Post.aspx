<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="utf-8" %>
<%@ Import Namespace="System.Data.OleDB" %>


<script runat="server">

Sub Page_Load(Src As Object, E As EventArgs)
	
	'response.write(request.QueryString("Serial"))

	Dim connStr As String = ConfigurationManager.Appsettings("MM_CONNECTION_STRING_linkC001")
	
	Dim conn As New OleDBConnection
	
	conn.ConnectionString = connStr
	
	Dim cmd As New OleDBCommand
	
	cmd.Connection = conn

cmd.CommandText = "Update 客戶資料表 Set Habbit=? Where Serial = ?"

	cmd.Parameters.Add("@Habbit",OleDBType.Varchar).Value =  IIf((Request("Habbit") <> Nothing), Request("Habbit"),"") 
	
	cmd.Parameters.Add("@Serial",OleDBType.Integer).Value =  IIf((Request("Serial") <> Nothing), Cint(Request("Serial")),"") 
	
	
	conn.open
	
	
Using conn
	
	
	cmd.ExecuteReader
	
END USING

	
	'RESPONSE.Redirect("default.aspx?CustId=" & Request.QueryString("CustId"))

End Sub


</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>


<body>
<form runat="server">

</form>

</body>

</html>
