<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="utf-8" %>
<%@ Register TagPrefix="MM" Namespace="DreamweaverCtrls" Assembly="DreamweaverCtrls,version=1.0.0.0,publicKeyToken=836f606ede05d46a,culture=neutral" %>
<MM:Update
runat="server"
CommandText='<%# "UPDATE 客戶資料表 SET CustTelPhone=?, CustEmail=?, CustName=?, CustId=?, CustAddress=?, Contect=?, CustMobile=? WHERE Serial=?" %>'
ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_STRING_linkC001") %>'
DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_DATABASETYPE_linkC001") %>'
CreateDataSet="false"
Debug="true"
>
  <Parameters>
    <Parameter Name="@CustTelPhone" Value='<%# IIf((Request.QueryString("CustTelPhone") <> Nothing), Request.QueryString("CustTelPhone"), "") %>' Type="WChar" />
    <Parameter Name="@CustEmail" Value='<%# IIf((Request.QueryString("CustEmail") <> Nothing), Request.QueryString("CustEmail"), "") %>' Type="WChar" />
    <Parameter Name="@CustName" Value='<%# IIf((Request.QueryString("CustName") <> Nothing), Request.QueryString("CustName"), "") %>' Type="WChar" />
    <Parameter Name="@CustId" Value='<%# IIf((Request.QueryString("CustId") <> Nothing), Request.QueryString("CustId"), "") %>' Type="WChar" />
    <Parameter Name="@CustAddress" Value='<%# IIf((Request.QueryString("CustAddress") <> Nothing), Request.QueryString("CustAddress"), "") %>' Type="WChar" />
    <Parameter Name="@Contect" Value='<%# IIf((Session("Contect") <> Nothing), Session("Contect"), "") %>' Type="WChar" />
    <Parameter Name="@CustMobile" Value='<%# IIf((Request.QueryString("CustMobile") <> Nothing), Request.QueryString("CustMobile"), "") %>' Type="WChar" />
    <Parameter Name="@Serial" Value='<%# IIf((Request.QueryString("Serial") <> Nothing), Request.QueryString("Serial"), "") %>' Type="Integer" />
  </Parameters>
</MM:Update>
<MM:DataSet 
id="DataSet1"
runat="Server"
IsStoredProcedure="false"
ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_STRING_linkC001") %>'
DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_DATABASETYPE_linkC001") %>'
CommandText='<%# "SELECT * FROM 客戶資料表" %>'
Debug="true"
></MM:DataSet>
<MM:PageBind runat="server" PostBackBind="true" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>
<body>
<%
   Dim Url As String

   Url="default.aspx" 
   
   response.Redirect(Url)

%>
</body>
</html>
