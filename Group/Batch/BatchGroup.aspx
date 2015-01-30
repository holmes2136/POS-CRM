<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="utf-8"  EnableEventValidation="false" %>
<%@ Register TagPrefix="MM" Namespace="DreamweaverCtrls" Assembly="DreamweaverCtrls,version=1.0.0.0,publicKeyToken=836f606ede05d46a,culture=neutral" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDB" %>

<MM:DataSet 
id="AllGroup"
runat="Server"
IsStoredProcedure="false"
ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_STRING_linkC001") %>'
DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_DATABASETYPE_linkC001") %>'
CommandText='<%# "SELECT  群組,Count(CustId)As Counts,識別碼,a.Contect FROM (類別群組 a LEFT JOIN Customer b On  a.群組 = b.CustGroup) GROUP BY 群組,識別碼,a.Contect " %>'
CurrentPage='<%# IIf((Request.QueryString("AllGroup_CurrentPage") <> Nothing), Request.QueryString("AllGroup_CurrentPage"), 0) %>'
PageSize="15"
Debug="true"
></MM:DataSet>
<MM:PageBind runat="server" PostBackBind="false" />


<MM:DataSet 
id="noGroup"
runat="Server"
IsStoredProcedure="false"
ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_STRING_linkC001") %>'
DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_DATABASETYPE_linkC001") %>'
CommandText='<%# "SELECT   Count(CustId)As Counts  FROM Customer WHERE CustGroup Is NULL" %>'
CurrentPage='<%# IIf((Request.QueryString("AllGroup_CurrentPage") <> Nothing), Request.QueryString("AllGroup_CurrentPage"), 0)      %>'
PageSize="20"
Debug="true"
></MM:DataSet>
<MM:PageBind runat="server" PostBackBind="false" />


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>群組清單</title>
<link href="../../main.css" rel="stylesheet" type="text/css" />

<style type="text/css">

.bubble{background-color:#c3d9ff}

</style>



<!--#include virtual="~/site/CRM/SQLAccess/Connection.aspx.vb" -->


<script runat="server">
Sub Page_Load(Src As Object, E As EventArgs)


		
End Sub


'刪除群組
Protected Sub btn_Delete_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs)

				
		Dim Serial As String = e.CommandArgument
				
Dim Url as String = String.Format("DeleteGroup.aspx?{0}",IIf(Serial  <> "", "Serial=" & Serial, ""))		
		
		Response.Redirect(Url)
		'response.write(Url)
		

End Sub

'重新命名群組
Protected Sub btn_ReName_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs)

		Dim Serial As String = e.CommandArgument
				
Dim Url as String = String.Format("UpdateGroup.aspx?{0}",IIf(Serial  <> "", "Serial=" & Serial, ""))		
		
		Response.Redirect(Url)
		

End Sub




'右上方功能下拉選單
	 Protected Sub drop_Function_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drop_Function.SelectedIndexChanged
		
	
		dim control As DropDownList = Ctype(sender,DropDownList)
		Dim Url As String = ""
		
		'避免POSTBACK後標籤又回復原始
		'control.SelectedIndex = control.Items.IndexOf(control.Items.FindByValue(Request.Form("drop_Function")))
		
		IF control.SelectedValue = "AddGroup" THEN
			
			Response.redirect("AddGroup.aspx")		
		
			
		END IF
	
    End Sub



  
    Protected Sub btn_Send_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Send.Click
		 
		 Dim GetChoosedItem As String = Session("CustIds")
		 
		 GetChoosedGroup()
			
		 	
		 'Response.write("Group" & ViewState("Group"))
		 
		 IF Not String.IsNullOrEmpty(ViewState("Group")) THEN
		 	UpdateBatchGroup(GetChoosedItem,ViewState("Group"))
		 END IF
		 
    End Sub



 'Protected Sub btn_Cancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Cancel.Click
'			
'			Response.Redirect("../default.aspx")
'
' End Sub



'批次更新群組:
'1.確認session(CustIds)has value or not
'2.資料庫動作
Private Sub UpdateBatchGroup(Byval CustIds As String,Byval group As String)
		
		'Dim custIds As String = Session("CustIds")
		
			'CustIds = CustIds.Replace("'","")
			
			'Response.write(CustIds & "<br>")
'			Response.write(group & "<br>")
			
			Dim conn As OleDBConnection = Connection.getConnection()
			
			Dim cmd As New OleDBCommand 
			
			Dim sql As String = "Update Customer Set CustGroup = ? Where CustId In (" & CustIds & ")"
			
			cmd.CommandText = sql
			cmd.Parameters.Add("@CustGroup",OleDBType.Varchar,50).Value = group
			'cmd.Parameters.Add("@CustId",OleDBType.Varchar,255).Value = CustIds

			cmd.Connection = conn
			
			conn.Open
			
			Using conn
				cmd.ExecuteReader()
			End Using
				
	
End Sub

'取得選取的群組(則一)
 Private Function GetChoosedGroup()As Boolean
 		Dim lbl_paramGroup As Label
		Dim CustIds As New StringBuilder("")
		Dim rc As RepeaterItemCollection = R1.Items
		Dim myCheckBox As CheckBox
		Dim flag As Boolean
	
		For Each Item As RepeaterItem In rc
			myCheckBox = Ctype(Item.FindControl("chk_IsCheck"),CheckBox)
			lbl_paramGroup = Ctype(Item.FindControl("lbl_Group"),Label)
			
				
		If myCheckBox.Checked = True Then
			
'產生b028-11497,b028-11755的格式		
			ViewState("Group") = lbl_paramGroup.Text
			flag = True
		Else
			flag = false
							
		End IF
			
		Next
	'Response.write("param:" & CustIds.tostring)
		'IF  CustIds.ToString Is Nothing Or CustIds.ToString = String.Empty Then
			'Response.write("test:" & CustIds.Tostring)
			'flag = False
		'Else
			'Response.write("test1:" & CustIds.Tostring)
			'flag = True			
			
		'End IF
		
		
		Return flag
		
		
		
		
 End Function
	

		
		
		

 		


</script>




</head>
<body>

<div id="Title"  class="bubble"><h3>群組清單</h3></div>
<br/>

<FORM runat="server">
<!--<asp:Button ID="btn_AddGroup" runat="server" Text="新增群組"/>
-->


<div id="Div_Funtion">

	<asp:DropDownList ID="drop_Function" runat="server" AutoPostBack="true">
    	<asp:ListItem>-功能-</asp:ListItem>
        <asp:ListItem Value="AddGroup">-新增群組-</asp:ListItem>
    </asp:DropDownList>
</div>
<br/>

<div  >
<table width="60%" border="1" cellspacing="0" cellpadding="0" >
  
    <tr>
      
      <td width="20%">群組</td>
     <td>備註 </td>
   
      <td width="20%">系統</td>
       <td width="10%">選取</td>
    </tr>
    <ASP:Repeater  ID="R1" runat="server" DataSource='<%# AllGroup.DefaultView %>'>
      <ItemTemplate>
     <tr>
       
          <td ><a href="../../Customer/SearchCust/default.aspx?q=group&amp;group=<%# AllGroup.FieldValue("群組", Container) %>"><%# AllGroup.FieldValue("群組", Container) %>&nbsp;<span class="pager">(<%# AllGroup.FieldValue("Counts", Container) %>名客戶)</span></a></td>
          
          
        <td width="10%"><%#AllGroup.FieldValue("Contect",Container)%></td>
          <td>
         			            
          <asp:Button ID="btn_Delete" CommandArgument='<%# AllGroup.FieldValue("識別碼", Container) %>' oncommand="btn_Delete_Command" runat="server" Text="刪除" />	
          <asp:Button ID="btn_ReName" CommandArgument='<%# AllGroup.FieldValue("識別碼", Container) %>' oncommand="btn_ReName_Command" runat="server" Text="重新命名" />	
          </td>
           <td><ASP:CheckBox ID="chk_IsCheck"  runat="server"/>
           <asp:Label ID="lbl_Group" Visible="false" runat="server" Text='<%# AllGroup.FieldValue("群組", Container) %>'></asp:Label></td>
        </tr>
      </ItemTemplate>
    </ASP:Repeater>
    <tr>
    	<td ><a href="../../Customer/SearchCust/default.aspx?q=group&amp;group=noGroup">未設群組客戶<span class="pager">(<%# noGroup.FieldValue("Counts", Container) %>名客戶)</span></a></td>
        <td></td>
        <td></td>
    </tr>
  </table>
  <br />
  
  <asp:Button runat="server" ID="btn_Send"  EnableViewState="true" Text="送出"/> &nbsp;
<!--  <asp:Button runat="server" ID="btn_Cancel"  EnableViewState="true" Text="取消"/> 
--></div>

<br />

<table border="0">
  <tr>
    <td><MM:If runat="server" Expression='<%# (AllGroup.CurrentPage <> 0) %>'>
      <ContentsTemplate> <a href="<%# Request.ServerVariables("SCRIPT_NAME") %>?AllGroup_currentPage=0">First</a> </ContentsTemplate>
    </MM:If>
    </td>
    <td><MM:If runat="server" Expression='<%# (AllGroup.CurrentPage <> 0) %>'>
      <ContentsTemplate> <a href="<%# Request.ServerVariables("SCRIPT_NAME") %>?AllGroup_currentPage=<%# Math.Max(AllGroup.CurrentPage - 1, 0) %>">Previous</a> </ContentsTemplate>
    </MM:If>
    </td>
    <td><MM:If runat="server" Expression='<%# (AllGroup.CurrentPage < AllGroup.LastPage) %>'>
      <ContentsTemplate> <a href="<%# Request.ServerVariables("SCRIPT_NAME") %>?AllGroup_currentPage=<%# Math.Min(AllGroup.CurrentPage + 1, AllGroup.LastPage) %>">Next</a> </ContentsTemplate>
    </MM:If>
    </td>
    <td><MM:If runat="server" Expression='<%# (AllGroup.CurrentPage < AllGroup.LastPage) %>'>
      <ContentsTemplate> <a href="<%# Request.ServerVariables("SCRIPT_NAME") %>?AllGroup_currentPage=<%# AllGroup.LastPage %>">Last</a> </ContentsTemplate>
    </MM:If>
    </td>
  </tr>
</table>
  
</FORM>
</body>
</html>
