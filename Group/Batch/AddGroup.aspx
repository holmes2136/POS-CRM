<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="utf-8" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<link href="../../main.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.bubble{background-color:#c3d9ff}
</style>
<script runat="server">
Sub Page_Load(Src As Object, E As EventArgs)
	
	
	
End Sub



Protected Sub btn_Cancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Cancel.Click

		
		
		Response.Redirect("BatchGroup.aspx")
		

End Sub
 



 Protected Sub btn_Send_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Send.Click

		
		Dim groupName As String = txt_GroupName.Text
		Dim contect As String = txt_Contect.Text
		
dim Url as string = String.Format("AddGroup_do.aspx?{0}{1}", _
		IIf(groupName <> "", "groupName=" & groupName, ""), _
		IIf( contect <> "", "&contect=" & contect, ""))

		Response.Redirect(Url)
		

 End Sub
	
	

</script>
</head>
<body>

<div id="Title"  class="bubble"><h3>新增群組</h3></div>
<br />
<form runat="server">

	<table width="50%" border="1" cellspacing="0" cellpadding="0">
  
    <tr>
      
      <td width="10%">群組</td>
      <td>內容</td>
   
     
    </tr>
    <tr>
      
      <td width="10%"><asp:TextBox ID="txt_GroupName" runat="server" /></td>
      <td><asp:TextBox ID="txt_Contect" runat="server" /></td>
   
     
    </tr>
    
  </table>
  
  <br />
  <asp:Button ID="btn_Send" runat="server" Text="送出" />
  <asp:Button ID="btn_Cancel" runat="server" Text="取消" />

</form>
</body>
</html>
