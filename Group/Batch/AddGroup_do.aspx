<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="utf-8" %>
<%@ Register TagPrefix="MM" Namespace="DreamweaverCtrls" Assembly="DreamweaverCtrls,version=1.0.0.0,publicKeyToken=836f606ede05d46a,culture=neutral" %>


<MM:Insert
runat="server"
CommandText='<%# "INSERT INTO 類別群組(群組,Contect) VALUES (?,?)" %>'
ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_STRING_linkC001") %>'
DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_DATABASETYPE_linkC001") %>'
CreateDataSet="false" 
Debug="true" 
SuccessURL='<%# "BatchGroup.aspx"%>'
>

  <Parameters>
    <Parameter Name="@groupName" Value='<%# IIf((request.QueryString("groupName") <> Nothing),request.QueryString("groupName"), "")%>' Type="WChar" />
       <Parameter Name="@Contect" Value='<%# IIf((request.QueryString("Contect") <> Nothing),request.QueryString("Contect"), "")%>' Type="WChar" />
     
     
  </Parameters>
</MM:Insert>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>

<script runat="server">
Sub Page_Load(Src As Object, E As EventArgs)
		'response.write(request.QueryString("groupName"))
'		response.write(request.QueryString("content"))
End Sub
</script>
</head>
<body>
</body>
</html>
