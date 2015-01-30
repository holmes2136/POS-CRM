<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="utf-8" EnableEventValidation="false" %>
<%@ Register TagPrefix="MM" Namespace="DreamweaverCtrls" Assembly="DreamweaverCtrls,version=1.0.0.0,publicKeyToken=836f606ede05d46a,culture=neutral" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDB" %>

<MM:DataSet 
id="AllGroup"
runat="Server"
IsStoredProcedure="false"
ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_STRING_linkC001") %>'
DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_DATABASETYPE_linkC001") %>'
CommandText='<%# "SELECT GroupName,Count(CustId)As Counts,a.Contect,a.Serial  FROM (客戶類別資料庫 a LEFT JOIN 客戶資料表 b On  a.GroupName = b.CustGroup)  GROUP BY GroupName,a.Contect,a.Serial" %>'
CurrentPage='<%# IIf((Request.QueryString("AllGroup_CurrentPage") <> Nothing), Request.QueryString("AllGroup_CurrentPage"), 0)     %>'
PageSize="20"
Debug="true"
></MM:DataSet>
<MM:PageBind runat="server" PostBackBind="true" />


<MM:DataSet 
id="noGroup"
runat="Server"
IsStoredProcedure="false"
ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_STRING_linkC001") %>'
DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_DATABASETYPE_linkC001") %>'
CommandText='<%# "SELECT   Count(CustId)As Counts  FROM 客戶資料表 WHERE CustGroup Is NULL" %>'
CurrentPage='<%# IIf((Request.QueryString("AllGroup_CurrentPage") <> Nothing), Request.QueryString("AllGroup_CurrentPage"), 0)      %>'
PageSize="20"
Debug="true"
></MM:DataSet>
<MM:PageBind runat="server" PostBackBind="true" />


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>群組清單</title>
<link href="../main.css" rel="stylesheet" type="text/css" />

<style type="text/css">

.bubble{background-color:#c3d9ff}

</style>



<!--#include virtual="~/site/TodayBillPlatfom/Shop/c037/Cust/SQLAccess/Connection.aspx.vb"-->


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



  
    'Protected Sub btn_Send_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Send.Click
		'IF updateGroup.Equals("ExportChoose") THEN
			'	Dim IsSomeChecked As Boolean = GetChoosedItem()
'			
'				'Response.write(IsSomeChecked)
'				    If IsSomeChecked = True  '假如有選取才匯出
'						Response.Redirect("BatchGroup.aspx")
'					End IF
 		 'End If

    'End Sub




'批次更新\群組:
'1.確認session(CustIds)has value or not
'2.資料庫動作
Private Sub HandleBatchGroup()
		
		Dim custIds As String = Session("CustIds")
		
		
		IF Not String.IsNullOrEmpty(custIds) THEN
			
			Dim conn As OleDBConnection = Connection.getConnection()
			
			Dim cmd As New OleDBCommand 
			
			Dim sql As String = "Update 客戶資料表 Set CustGroup = '" & custIds & "'"
			
			cmd.CommandText = sql
			cmd.Connection = conn
			
			conn.Open
			
			cmd.ExecuteReader()
				
		END IF
End Sub

'取得選取的群組(則一)
' Private Function GetChoosedItem()As Boolean
' 		Dim lbl_paramCustId As Label
'		Dim CustIds As New StringBuilder("")
'		Dim rc As RepeaterItemCollection = R1.Items
'		Dim myCheckBox As CheckBox
'		Dim flag As Boolean
'	
'		For Each Item As RepeaterItem In rc
'			lbl_paramCustId = Ctype(Item.FindControl("lbl_Group"),Label)
'			myCheckBox = Ctype(Item.FindControl("chk_IsCheck"),CheckBox)
'				
'				'If myCheckBox.Checked = True Then
'			
''產生b028-11497,b028-11755的格式		
'	CustIds.Append(IIf(CustIds.ToString = "", "", ",") & "'" & CType(myCheckBox.Text, String) & "'")
'							
'				'End IF
'			
'		Next
'	'Response.write("param:" & CustIds.tostring)
'		'IF  CustIds.ToString Is Nothing Or CustIds.ToString = String.Empty Then
'			'Response.write("test:" & CustIds.Tostring)
'			'flag = False
'		'Else
'			'Response.write("test1:" & CustIds.Tostring)
'			'flag = True			
'			Session("group") = CustIds.toString
'
'		'End IF
'		
'		
'		return flag	
'		
'		
'		
'		
' End Function
	

		
		
		

 		


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
<table width="50%" border="1" cellspacing="0" cellpadding="0" >
  
    <tr>
      
      <td width="40%">群組</td>
      <td>備註</td>
   
      <td width="40%">系統</td>
      
    </tr>
    <ASP:Repeater  ID="R1" runat="server" DataSource='<%# AllGroup.DefaultView %>'>
      <ItemTemplate>
     <tr>
       
          <td ><%# AllGroup.FieldValue("GroupName", Container) %>&nbsp;<span class="pager">(<%# AllGroup.FieldValue("Counts", Container) %>名客戶)</span></td>
          
          <td><%#AllGroup.FieldValue("Contect",Container)%></td>
        
          <td>
         			            
          <asp:Button ID="btn_Delete" CommandArgument='<%# AllGroup.FieldValue("Serial", Container) %>' oncommand="btn_Delete_Command" runat="server" Text="刪除" />	
          <asp:Button ID="btn_ReName" CommandArgument='<%# AllGroup.FieldValue("Serial", Container) %>' oncommand="btn_ReName_Command" runat="server" Text="重新命名" />	
          </td>
          
        </tr>
      </ItemTemplate>
    </ASP:Repeater>
    <tr>
    	<td >未設群組客戶<span class="pager">(<%# noGroup.FieldValue("Counts", Container) %>名客戶)</span></td>
      
    </tr>
  </table>
  <br />
  
  <!--<asp:Button runat="server" ID="btn_Send"  EnableViewState="true" Text="送出"/>-->
</div>

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
