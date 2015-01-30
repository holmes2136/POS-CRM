<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="utf-8" %>
<%@ Register TagPrefix="MM" Namespace="DreamweaverCtrls" Assembly="DreamweaverCtrls,version=1.0.0.0,publicKeyToken=836f606ede05d46a,culture=neutral" %>
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
<style type="text/css">
<!--
.style1 {color: #FFFFFF}
-->
</style>
</head>
<script runat="server">
Sub Page_Load(Src As Object, E As EventArgs)
If Not IsPostBack Then
DataBind()
End If
End Sub

Sub Button1Cilck(ByVal sender As Object, ByVal e As EventArgs)

Dim Url As String

    Url="Add.aspx?CustId="+CustId.text
	
	Url=Url+"&ShopName="+Session("ShopName")
	
	Url=Url+"&CustName="+CustName.text
	
	Url=Url+"&CustTelPhone="+CustTelPhone.text
	
	Url=Url+"&CustMobile="+CustMobile.text
	
    Url=Url+"&CustEmail="+CustEmail.text
	
	Url=Url+"&CustAddress="+CustAddress.text
	
    Session("Contect")=Contect.text
	
	response.Redirect(Url)


End Sub

Sub Button2Cilck(ByVal sender As Object, ByVal e As EventArgs)

    CustId.text=""
	
	CustName.text=""
	
	CustTelPhone.text=""
	
	CustMobile.text=""
	
    CustEmail.text=""
	
	CustAddress.text=""
	
    Contect.text=""
	


End Sub

</script>
<body>
<form name='form' method='POST' runat='server'>
  <table width="423" border="1">
    <tr>
      <td colspan="2" bgcolor="#6699FF"><span class="style1">新增客戶資料</span></td>
    </tr>
    <tr>
      <td width="92">客戶編號</td>
      <td width="315"><asp:TextBox ID="CustId" runat="server" /></td>
    </tr>
    <tr>
      <td>姓名</td>
      <td><asp:TextBox ID="CustName" runat="server" /></td>
    </tr>
    <tr>
      <td>聯絡電話</td>
      <td><asp:TextBox ID="CustTelPhone" runat="server" /></td>
    </tr>
    <tr>
      <td>手機號碼</td>
      <td><asp:TextBox ID="CustMobile" runat="server" /></td>
    </tr>
    <tr>
      <td>電子郵件</td>
      <td><asp:TextBox ID="CustEmail" runat="server" /></td>
    </tr>
    <tr>
      <td>聯絡地址</td>
      <td><asp:TextBox ID="CustAddress" runat="server" /></td>
    </tr>
    <tr>
      <td>備註</td>
      <td><asp:TextBox ID="Contect" TextMode="MultiLine" runat="server" /></td>
    </tr>
  </table>
  <p>
    <asp:Button ID="Button1" runat="server" Text="新增" OnClick="Button1Cilck" />    
    <asp:Button ID="Button2" runat="server" Text="重置" OnClick="Button2Cilck" />    </p>
</form>
</body>
</html>
