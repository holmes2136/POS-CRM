<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="utf-8" %>
<%@ Register TagPrefix="MM" Namespace="DreamweaverCtrls" Assembly="DreamweaverCtrls,version=1.0.0.0,publicKeyToken=836f606ede05d46a,culture=neutral" %>
<MM:Insert
runat="server"
CommandText='<%# "INSERT INTO 客戶資料表 (ShopName, Contect, CustAddress, CustEmail, CustId, CustMobile, CustName, CustTelPhone) VALUES (?, ?, ?, ?, ?, ?, ?, ?)" %>'
ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_STRING_linkC001") %>'
DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_DATABASETYPE_linkC001") %>'
CreateDataSet="false"
Debug="true"
>
  <Parameters>
    <Parameter Name="@ShopName" Value='<%# IIf((Request.QueryString("ShopName") <> Nothing), Request.QueryString("ShopName"), "NoData") %>' Type="WChar" />
    <Parameter Name="@Contect" Value='<%# IIf((Session("Contect") <> Nothing), Session("Contect"), "NoData") %>' Type="WChar" />
    <Parameter Name="@CustAddress" Value='<%# IIf((Request.QueryString("CustAddress") <> Nothing), Request.QueryString("CustAddress"), "NoData") %>' Type="WChar" />
    <Parameter Name="@CustEmail" Value='<%# IIf((Request.QueryString("CustEmail") <> Nothing), Request.QueryString("CustEmail"), "NoData") %>' Type="WChar" />
    <Parameter Name="@CustId" Value='<%# IIf((Request.QueryString("CustId") <> Nothing), Request.QueryString("CustId"), "NoData") %>' Type="WChar" />
    <Parameter Name="@CustMobile" Value='<%# IIf((Request.QueryString("CustMobile") <> Nothing), Request.QueryString("CustMobile"), "NoData") %>' Type="WChar" />
    <Parameter Name="@CustName" Value='<%# IIf((Request.QueryString("CustName") <> Nothing), Request.QueryString("CustName"), "NoData") %>' Type="WChar" />
    <Parameter Name="@CustTelPhone" Value='<%# IIf((Request.QueryString("CustTelPhone") <> Nothing), Request.QueryString("CustTelPhone"), "NoData") %>' Type="WChar" />
  </Parameters>
</MM:Insert>
<MM:DataSet 
id="DataSet1"
runat="Server"
IsStoredProcedure="false"
ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_STRING_link4") %>'
DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_DATABASETYPE_link4") %>'
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
