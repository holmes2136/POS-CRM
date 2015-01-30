<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="utf-8" %>
<%@ Register TagPrefix="MM" Namespace="DreamweaverCtrls" Assembly="DreamweaverCtrls,version=1.0.0.0,publicKeyToken=836f606ede05d46a,culture=neutral" %>


<MM:Delete
runat="server"
CommandText='<%# "DELETE FROM 客戶類別資料庫 WHERE Serial=?" %>'
ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_STRING_linkC001") %>'
DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_DATABASETYPE_linkC001") %>'
Expression='<%# (Request.QueryString("Serial") <> Nothing) %>'
CreateDataSet="false"
SuccessURL='<%# "default.aspx" %>'
Debug="true"
>
  <Parameters>
    <Parameter Name="@Serial" Value='<%# IIf((Request.QueryString("Serial") <> Nothing), Request.QueryString("Serial"), "") %>' Type="Integer" />
  </Parameters>
</MM:Delete>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>
<body>
</body>
</html>
