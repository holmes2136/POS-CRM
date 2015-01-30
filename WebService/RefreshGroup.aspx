<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>

<script runat="server">
Sub Page_Load(Src As Object, E As EventArgs)
		
		response.write("<? xml version=1.0 encoding=utf-8 ?>")
		response.write("<result>")
			response.write("<Group>")
				
		response.write("<name>" & request.QueryString("group") & "</name>")
'		response.write("<serial>" & request.QueryString("Serial") & "</serial>")
			response.write("</Group>")
		response.write("</result>")

End Sub
</script>
</head>
<body>
</body>
</html>
