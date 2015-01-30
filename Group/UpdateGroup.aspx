<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="utf-8" %>
<%@ Register TagPrefix="MM" Namespace="DreamweaverCtrls" Assembly="DreamweaverCtrls,version=1.0.0.0,publicKeyToken=836f606ede05d46a,culture=neutral" %>





<MM:DataSet 
id="DataSet1"
runat="Server"
IsStoredProcedure="false"
ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_STRING_linkC001") %>'
DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_DATABASETYPE_linkC001") %>'
CommandText='<%# "SELECT GroupName FROM 客戶類別資料庫 WHERE Serial = ?" %>'
Debug="true"
>
  <Parameters>
  
    <Parameter  Name="@識別碼"  Value='<%# IIf((Request.QueryString("Serial") <> Nothing), Request.QueryString("Serial"), "") %>'  Type="Integer"   />  
  </Parameters>
</MM:DataSet>
<MM:PageBind runat="server" PostBackBind="true" />


<MM:Update
runat="server"
CommandText='<%# "UPDATE  客戶類別資料庫 Set GroupName = ? Where Serial = ? " %>'
ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_STRING_linkC001") %>'
DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_DATABASETYPE_linkC001") %>'
Expression='<%# Request.Form("MM_insert") = "form1" %>'
CreateDataSet="false"
SuccessURL='<%# "default.aspx" %>'
Debug="true"
>
  <Parameters>
    <Parameter Name="@群組" Value='<%# IIf((Request.Form("txt_GroupName") <> Nothing), Request.Form("txt_GroupName"), "") %>' Type="WChar" />
    <Parameter Name="@Serial" Value='<%# IIf((request.QueryString("Serial") <> Nothing),request.QueryString("Serial"), "")%>' Type="Integer" />
  </Parameters>
</MM:Update>


<script runat="server">
Sub Page_Load(Src As Object, E As EventArgs)
		
End Sub



 Protected Sub btn_Cancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Cancel.Click

		
		
		Response.Redirect("default.aspx")
		

 End Sub
 
 
 Protected Sub btn_Send_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Send.Click

		
		
		
		

 End Sub
 
</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>

<style type="text/css">

.bubble{
background-color:#c3d9ff;
width:100%;
		}
body {
	margin-left: 10px;
	margin-top: 10px;
	margin-right: 10px;
	margin-bottom: 10px;
}
</style>
</head>


<body onLoad="form1.txt_GroupName.select()">



<form name='form1' method='POST' runat='server' id="form1">
<fieldset>
	<legend class="bubble"><b>重新命名</b></legend>
    <table>
    	<tr>
        	<td>群組名稱</td>
             <td><asp:textbox ID="txt_GroupName" runat="server" Text='<%# DataSet1.FieldValue("GroupName", Container) %>'/></td>
        </tr>
    </table>
    <br />
<asp:Button ID="btn_Send" Text="送出" runat="server"/>
<asp:Button ID="btn_Cancel" Text="取消" runat="server"/>

</fieldset>
  <input type="hidden" name="MM_insert" value="form1">
</form>


</body>
</html>
