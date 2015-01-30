<%@ Page Language="VB" ContentType="text/html" MasterPageFile="~/MasterPage.master" ResponseEncoding="utf-8" %>
<%@ Register Src="Group/MyControl/Group.ascx" TagName="Group" TagPrefix="ccl" %> 
<%@ Register TagPrefix="MM" Namespace="DreamweaverCtrls" Assembly="DreamweaverCtrls,version=1.0.0.0,publicKeyToken=836f606ede05d46a,culture=neutral" %>
<%@ Register TagPrefix="MM" Namespace="DreamweaverCtrls" Assembly="DreamweaverCtrls,version=1.0.0.0,publicKeyToken=836f606ede05d46a,culture=neutral" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDB" %>
<%@ Register Assembly="CollectionPager" Namespace="SiteUtils" TagPrefix="cc1" %>




<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
    <script src="scripts/jquery.pagination.js" type="text/javascript"></script>
    <link href="main.css" rel="stylesheet" type="text/css" />
    <link href="css/index.css" rel="stylesheet" type="text/css" />
    <link href="css/SpryTabbedPanels.css" rel="stylesheet" type="text/css" />
    <link href="css/SpryMenuBarHorizontal.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="css/pagination.css" />


</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<MM:DataSet 
id="DataSet1"
runat="Server"
IsStoredProcedure="false"
ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_STRING_linkC001") %>'
DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_DATABASETYPE_linkC001") %>'
CommandText='<%# "SELECT Serial,CustId,CustName,CustTelPhone,CustMobile,CustEmail,CustAddress  FROM 客戶資料表  WHERE CustId like ? and CustName like ? and CustTelPhone like ? and CustMobile like ? and CustAddress like ?  ORDER BY Serial DESC" %>'
CurrentPage='<%# IIf((Request.QueryString("DataSet1_CurrentPage") <> Nothing), Request.QueryString("DataSet1_CurrentPage"), 0)   %>'
PageSize="20"
Debug="true"
><Parameters>
  <Parameter  Name="@CustId"  Value='<%# IIf((Request.Form("ctl00$ContentPlaceHolder1$txt_CustId")+"%" <> Nothing), Request.Form("ctl00$ContentPlaceHolder1$txt_CustId")+"%", "%") %>'  Type="WChar"   />  
  <Parameter  Name="@CustName"  Value='<%# IIf(( Request.Form("ctl00_ContentPlaceHolder1_txt_CustName")+"%" <> Nothing), Request.Form("ctl00_ContentPlaceHolder1_txt_CustName")+"%", "%") %>'  Type="WChar"   />  
  <Parameter  Name="@CustTelPhone"  Value='<%# IIf(( Request.Form("ctl00$ContentPlaceHolder1$txt_CustTelPhone")+"%" <> Nothing), Request.Form("ctl00$ContentPlaceHolder1$txt_CustTelPhone")+"%", "%") %>'  Type="WChar"   />  
  <Parameter  Name="@CustMobile"  Value='<%# IIf(( Request.Form("ctl00$ContentPlaceHolder1$txt_CustMobile")+"%" <> Nothing), Request.Form("ctl00$ContentPlaceHolder1$txt_CustMobile")+"%", "%") %>'  Type="WChar"   />  
  <Parameter  Name="@CustAddress"  Value='<%# IIf(( Request.Form("ctl00$ContentPlaceHolder1$txt_CustAddress")+"%" <> Nothing), Request.Form("ctl00$ContentPlaceHolder1$txt_CustAddress")+"%", "%") %>'  Type="WChar"   />
</Parameters></MM:DataSet>
<MM:PageBind runat="server" PostBackBind="true" />





<script runat="server">

'預設頁面
Dim MainUrl As String = "Customer/Detail/CustDetail.aspx" 

Public Const MasterDetailState As Integer = 1 'MasterDetail狀態
Public Const AllCustState As Integer = 2 '所有客戶狀態
Public  IsShowState As Integer
    Public lang As String
 
    
Sub Page_Load(Src As Object, E As EventArgs)
	
      
        Page.MaintainScrollPositionOnPostBack = True
	
        
        lbl_QCustID.Text = Resources.zh.CustID
        lbl_QCustName.Text = Resources.zh.CustName
        lbl_QCustTel.Text = Resources.zh.CustTel
        lbl_QCustMobile.Text = Resources.zh.CustMobile
        lbl_QCustAddr.Text = Resources.zh.CustAddr
        

        If Not IsPostBack Then
            '預設一開始為主要詳細介面(Master-Detail)
            ViewState("IsShowState") = MasterDetailState
            Me.MultiView1.ActiveViewIndex = 0
		
            'response.write(ViewState("IsShowState"))
        End If
	
        '///////////////////////////////預設客戶頁面,取得DataSet1資料集第一個客戶資料
        'getCustInfoBySerial DataSet預設若Request.Form("hid_CustId")沒有值,就取得Session(FirstCustId)
        Session("FirstCustId") = DataSet1.FieldValue("CustId", Nothing)
    
        Dim script As String = "window.onload=function(){init('" + Session("FirstCustId") + "');}"
        
        ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "alert", script, True)
	
	
	
        '以搜尋鈕為一開始的焦點
        SetFocus(btn_Search)
				

    End Sub






Protected Sub R1_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles R1.ItemDataBound
		
End Sub



Protected Sub R1_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles R1.Load

	

    End Sub

Protected Sub btn_ViewCustDetail_Click(ByVal sender As Object, ByVal e As System.EventArgs)
     		
		ViewState("IsShowState") = MasterdetailState 
		Me.MultiView1.ActiveViewIndex = 0
  			

End Sub


	
'計算客戶實際年齡
Private Sub CountRealAge(Byval CustBirthDay As String) 

		Dim regex As New Regex("^\d{4}\-\d{1,2}\-\d{2}$", RegexOptions.Singleline)
 
        Dim ma As Match = regex.Match(CustBirthDay.Trim)


    
		
		Dim Age As Integer
		
		
		Dim ci As New System.Globalization.CultureInfo("zh-TW")

        ci.DateTimeFormat.Calendar = New System.Globalization.TaiwanCalendar()

        System.Threading.Thread.CurrentThread.CurrentCulture = ci


'Dim d2 As DateTime = New DateTime(Year(Datetime.Now), Month(Datetime.Now), Day(Datetime.Now))
		
		'若不是NULL或者Empty
		IF Not String.IsNullOrEmpty(CustBirthDay) THEN
				'若是符合日期格式
				IF ma.Success THEN
Dim d1 As DateTime = DateTime.ParseExact(CustBirthDay, "yyyy-mm-dd", System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.AllowWhiteSpaces)

					
					Dim CustBirthYear As Integer = Year(d1)
					
					Dim NowYear As Integer = Year(DateTime.Now)
					
					Age = NowYear - CustBirthYear
					
				END IF
		End IF 
		
	
		
		IF Age <> 0 THEN
			lbl_RealAge.Text = Age
		ELSE
			lbl_RealAge.Text = "NoData"
		END IF
		
		
End Sub

'傳回中文性別
Private Function FriendlyGender(Byval orgin As String)As String
		Dim gender As String = ""
		
		SELECT CASE orgin
		
			CASE "male" 
				gender = "男"
			CASE "female"
				gender = "女"
		CASE ElSE
				gender = "NoData"
				
		END SELECT
		
		RETURN gender
		
End Function



Protected Sub btn_Search_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Search.Click
 
     
  			Dim CustDs As New StringBuilder("")
	

		   CustDs.Append("SELECT top 200 *   FROM 客戶資料表 WHERE ")
        CustDs.Append("CustId like '" & Request.Form("txt_CustId") & "%' And ")
        CustDs.Append("CustName like '" & Request.Form("txt_CustName") & "%' And ")
        CustDs.Append("CustTelPhone like '" & Request.Form("txt_CustTelPhone") & "%' And ")
        CustDs.Append("CustMobile like '" & Request.Form("txt_CustMobile") & "%' And ")
        CustDs.Append("CustAddress like '" & Request.Form("txt_CustAddress") & "%'")
		   CustDs.Append("Order By Serial desc")
          	
		   Session("CustIds") = CustDs.ToString()
		   
		   '預設getCustInfoBySerial會去取用hid_CustId的CustId,若沒有值則去取用FirstCustId Session
		   '若是按下搜尋,則輕空hidden的CustId,讓getCustInfoBySerial會去取用FirstCustId Session
		   hid_CustId.Value = ""
    	   Session("FirstCustId") = DataSet1.FieldValue("CustId",Nothing)
		   'Session("CustId") = Request.Form("txt_CustId")
		 

End Sub



'匯出電話文字檔
Protected Sub btn_ExportCustTelPhoneNote_Click(ByVal sender As Object, ByVal e As System.EventArgs)Handles btn_ExportCustTelPhoneNote.Click 

				'IF Session("CustIds")
				Response.Redirect("Export/ExportTelPhoneNote.aspx?type=choose")
		
End Sub

'匯出Email文字檔
Protected Sub btn_ExportCustEmailNote_Click(ByVal sender As Object, ByVal e As System.EventArgs)Handles btn_ExportCustEmailNote.Click 


				Response.Redirect("Export/ExportCustEmailNote.aspx?type=choose")
		
End Sub

 Protected Sub linkBtn_CustName_Click(ByVal sender As Object, ByVal e As System.EventArgs)
 
 
		'SetTabState
		
		
 End Sub


Protected Sub btn_NextPage_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) 
        
	Dim mypostbackoptions As New PostBackOptions(CType(sender, LinkButton))


	mypostbackoptions.ActionUrl = "http://www.yahoo.com.tw"

    mypostbackoptions.RequiresJavaScriptProtocol = false

 	mypostbackoptions.PerformValidation = false
	
    'Ctype(sender,LinkButton).PostBackUrl = Page.ClientScript.GetPostBackEventReference(mypostbackoptions)
	

End Sub
       


Protected Sub btn_AddCustService_Click(ByVal sender As Object, ByVal e As System.EventArgs)Handles btn_AddCustService.Click
 		IF  ISPOSTBACK THEN
Dim connStr As String = ConfigurationManager.Appsettings("MM_CONNECTION_STRING_linkC001")


Dim conn As New OleDBConnection
conn.connectionString = connStr

Dim cmd As New OleDBCommand 

cmd.Connection = conn
			
cmd.CommandText = "Insert Into 客服記錄(CustId,UnderTaker,ServiceContent,PublishDay)Values(?,?,?,?)"
			
cmd.parameters.add("@CustId",OleDBType.WChar).Value = Request.Form("lbl_CustId")
cmd.parameters.add("@UnderTaker",OleDBType.WChar).Value = Request.Form("txt_CustServicUnderTaker")
cmd.parameters.add("@ServiceContent",OleDBType.WChar).Value = Request.Form("txt_CustServiceContent") 
cmd.parameters.add("@PublishDay",OleDBType.WChar).Value = getPublishDay()
	
	
	conn.open
	
	Using conn
		cmd.ExecuteReader()
	End Using

	txt_CustServicUnderTaker.Text = ""
	txt_CustServiceContent.Text = ""

	END IF	
	
 End Sub


Protected Sub btn_AddCustComm_Click(ByVal sender As Object, ByVal e As System.EventArgs)Handles btn_AddCustComm.Click
     		
	 		
Dim connStr As String = ConfigurationManager.Appsettings("MM_CONNECTION_STRING_linkC001")


Dim conn As New OleDBConnection
conn.connectionString = connStr

Dim cmd As New OleDBCommand 

cmd.Connection = conn
			
cmd.CommandText = "Insert Into 客戶通訊資料庫(CustId,Content,PublishDay)Values(?,?,?)"
			
cmd.parameters.add("@CustId",OleDBType.WChar).Value = Request.Form("lbl_CustId")
cmd.parameters.add("@Content",OleDBType.WChar).Value = Request.Form("txt_Comm")
cmd.parameters.add("@PublishDay",OleDBType.WChar).Value = getPublishDay()
	
	
	conn.open
	
	Using conn
		cmd.ExecuteReader()
	End Using

	txt_Comm.Text = ""	

End Sub




  '取得今天的日期傳回格式為 ex:2011-02-28
  Private Function getPublishDay() As String

 		Dim d1 As DateTime = DateTime.Now

        Return Now.Year & "-" & FilterMonth(Month(d1)) & "-" & FilterMonth(Day(d1)) 'update

    End Function
	
	
Private Function FilterMonth(ByVal month As String) As String

If month.Length = 1 Then

	month = String.Format("0{0}", month)

End If

Return month

End Function


	
	
'儲存使用者剛觀看過的頁籤
Private Sub SetTabState()
	
Page.ClientScript.RegisterStartupScript(Me.GetType(), "SetTabState2", "window.onload = function SetTabState2(){var TabbedPanels1 = new Spry.Widget.TabbedPanels('TabbedPanels1');TabbedPanels1.showPanel('tab3');}", True)


Page.ClientScript.RegisterStartupScript(Me.GetType(), "SetTabState", "function SetTabState(tab){document.getElementById('hid_CurrentTab').value = tab.id;}", True)

        For i As Integer = 1 To 8

            Dim obj As HtmlGenericControl = CType(Page.FindControl("tab" & i), Web.UI.HtmlControls.HtmlGenericControl)


            If Not obj Is Nothing Then

                obj.Attributes.Add("onclick", "SetTabState(this)")

            End If

        Next
		
		ViewState("CurrentTab") = hid_CurrentTab.Value
		
	
	'var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1");
'			TabbedPanels1.showPanel('tab3');
		
End Sub


</script>
<script src="scripts/SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>
<script src="scripts/SpryAssets/SpryMenuBar.js" type="text/javascript"></script>

<script type="text/javascript">


<!--
function MM_showHideLayers() { //v9.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) 
  with (document) if (getElementById && ((obj=getElementById(args[i]))!=null)) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
    obj.visibility=v; }
}
function MM_goToURL() { //v3.0
  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
}
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->
</script>




<body >


<div id="apDiv12">
<div style="background:#c3d9ff; height:30px; padding:5px">
<div id="Title" style="float:left; color:#0033FF">更新群組</div>

</div>

<fieldset class="formContainer">


<div class="rowContainer">
    <label>群組名稱</label>
 	<asp:DropDownList ID="drop_Group"  runat="server"/>

    	<br />
        <br />
        <br />
        <br />
    <input type="button" id="btn_UpdateGroup" value="送出" onclick="UpdateGroup2()"/>
     <input type="button" id="btn_CancelGroup" value="取消"  onclick="MM_showHideLayers('apDiv12','','hide')"/>
            <input type="hidden" id="hid_GroupSerial2"/>

</div> 


<div id="apDiv11">
<div style="background:#c3d9ff; height:30px; padding:5px">
<div id="Title" style="float:left; color:#0033FF">新增群組</div>

</div>

<fieldset class="formContainer">


<div class="rowContainer">
    <label>群組名稱</label>
 	<asp:TextBox ID="txt_Group"  Width="120" CssClass="idleField" runat="server"/>

    	
    
</div> 

      
  <br /> 
    <input type="button" id="btn_AddGroup"  value="送出"  onclick="AddGroup()"/>
    <input type="button" ID="btn_CancelGroup" onclick="MM_showHideLayers('apDiv11','','hide')"  value="取消" size="8"/ >         
       <input type="hidden" id="hid_GroupSerial"/>
 </fieldset>
</div>


<div id="apDiv9">
<div style="background:#c3d9ff; height:30px; padding:5px">
<div id="Title" style="float:left; color:#0033FF">更新嗜好</div>

</div>

<fieldset class="formContainer">


<div class="rowContainer">
    <label>內容</label>
 	<asp:TextBox id="txt_Habbit"  AutoPostBack="false" Width="120px" runat="server" />
    
</div> 

      
  <br /> 
    <input type="button" id="btn_UpdateHabbit"  value="送出" onclick="UpdateCustHabbit2()"/>
    <input type="button" ID="btn_CancelService" onclick="MM_showHideLayers('apDiv9','','hide')"  value="取消" size="8"/ >         
       <input type="hidden" id="hid_HabbitSerial"/>
 </fieldset>
</div>


<div id="apDiv10">
<div style="background:#c3d9ff; height:30px; padding:5px">
<div id="Title" style="float:left; color:#0033FF">更新嗜好</div>

</div>

<fieldset class="formContainer">


<div class="rowContainer">
    <label>內容</label>
 	<asp:TextBox id="txt_Interest"  AutoPostBack="false" Width="120px" runat="server" />
    
</div> 

      
  <br /> 
    <input type="button" id="btn_UpdateInterest"  value="送出" onclick="UpdateCustInterest2()"/>
    <input type="button" ID="btn_CancelInterest" onclick="MM_showHideLayers('apDiv10','','hide')"  value="取消" size="8"/ >         
       <input type="hidden" id="hid_InterestSerial"/>
 </fieldset>
</div>

<div id="apDiv3">
<div style="background:#c3d9ff; height:30px; padding:5px">
<div id="Title" style="float:left; color:#0033FF">新增客服記錄</div>

</div>

<fieldset class="formContainer">


<div class="rowContainer">
    <label>經手人</label>
 	<asp:TextBox id="txt_CustServicUnderTaker"  AutoPostBack="false" Width="120px" runat="server" />
    
</div> 

<div class="rowContainer">
    <label>內容</label>
 	   <asp:TextBox  ID="txt_CustServiceContent"  AutoPostBack="false" Width="120px" runat="server" />
    
</div> 
      
  <br /> 
     <asp:Button runat="server" ID="btn_AddCustService" Text="送出"/> 
    <input type="button" ID="btn_CancelService" onclick="MM_showHideLayers('apDiv3','','hide')"  value="取消" size="8"/ >         
 </fieldset>
</div>

</div>
<div id="apDiv4">
 <div style="background:#c3d9ff; height:30px; padding:5px">
<div id="Title" style="float:left; color:#0033FF">新增通訊記錄</div>
<div style="float:right"><a href="#" onclick="MM_showHideLayers('apDiv4','','hide')" >關閉</a></div>
</div>

<fieldset class="formContainer">


<div class="rowContainer">
    <label>內容</label>
 	<asp:TextBox ID="txt_Comm" Width="120px" runat="server" />
    
</div> 
      
  <br /> 
 <br /> 
       <asp:Button runat="server"  ID="btn_AddCustComm"   AutoPostBack="false"  Text="送出"/>

    <input type="button" ID="btn_CancelService" onclick="MM_showHideLayers('apDiv4','','hide')"  value="取消" size="8"/ >                </td>

 </fieldset>
</div>




<div id="apDiv8">
 <table width="100%" border="1" bgcolor="#FFFFFF">
    
    <tr>
    
    <td colspan="3" bgcolor="#c3d9ff" align="right"><a href="#" onclick="MM_showHideLayers('apDiv8','','hide')">關閉</a></td>
    </tr>
    <tr>
        	<td>列印類型</td>
            <td>系統</td>
            
    </tr>
    	<tr>
        	<td>地址名條</td>
            <td><input type="button" id="btn_PrintAddressLabel" onclick="MM_openBrWindow('Print/AddressLabel/AddressLabel3.aspx','PrintAddressLabel','toolbar=yes,location=yes,status=yes,menubar=yes,scrollbars=yes,resizable=yes,width=400,height=300')" value="列印"/></td>
            
        </tr>
        <tr>
        	<td>客戶資料</td>
            <td><input type="button" id="btn_PrintCustInfo" onclick="MM_openBrWindow('Print/PrintCustInfo/BatchPrint.aspx','PrintCustInfo','toolbar=yes,location=yes,status=yes,menubar=yes,scrollbars=yes,resizable=yes,width=400,height=300')" value="列印"/></td>
         
        </tr>
        
  </table>
</div>

<div id="apDiv7">
<div style="background:#c3d9ff; height:30px; padding:5px;">
<div id="Title" style="float:left; color:#0033FF">修改客戶通訊</div>

</div>

<fieldset class="formContainer">


<div class="rowContainer">
    <label>內容</label>
 	<asp:TextBox ID="txt_CommContent" Width="120px" runat="server" />
</div> 


          
<br/>
<br/>

       <input type="button"  id="btn_UpdateComm" value="送出"  onclick="UpdateComm2()"/>
       <input type="hidden" id="hid_CommSerial"/>
       <input type="button" ID="btn_CancelService" onclick="MM_showHideLayers('apDiv7','','hide')"  value="取消" size="8"/ >  
 </fieldset>
</div>

<div id="apDiv5">

<div style="background:#c3d9ff; height:30px; padding:5px">
<div id="Title" style="float:left; color:#0033FF">修改客服記錄</div>

</div>

<fieldset class="formContainer">


<div class="rowContainer">
    <label>經手人</label>
 	<asp:TextBox ID="txt_CSUnderTaker" Width="120px" runat="server" />
</div> 

<div class="rowContainer">
    <label>內容</label>
 	<asp:TextBox ID="txt_CSContent"  Width="120px" runat="server"/>
</div>          
  <br /> 
        <input type="button"  onclick="UpdateCS2()" id="btn_UpdateCs" value="更新"/>
	 <input type="button"  onclick="Cancel()" id="btn_UpdateCs" value="取消"/>
<input type="hidden" id="hid_CSSerial"/>

 </fieldset>
 
</div>


<div id="apDiv1">
	 <br />
    
    <table width="100%"  border="1" bgcolor="#FFFFFF">
    
    <tr>
    
    <td colspan="3"  bgcolor="#c3d9ff" align="right"><a href="#" onclick="MM_showHideLayers('apDiv1','','hide')">關閉</a></td>
    </tr>
    <tr>
        	<td>匯出類型</td>
            <td>系統</td>
            <td>說明</td>
      </tr>
    	<!--<tr>
        	<td>Excel</td>
            <td><asp:Button ID="btn_ExportExcell" runat="server" Text="匯出"/></td>
            <td>將客戶清單匯出成Excel</td>
        </tr>-->
        <tr>
        	<td>文字檔</td>
            <td><asp:Button ID="btn_ExportCustTelPhoneNote" runat="server" Text="匯出"/></td>
            <td>匯出客戶手機文字檔</td>
        </tr>
        <tr>
        	<td>文字檔</td>
            <td><asp:Button ID="btn_ExportCustEmailNote" runat="server" Text="匯出"/></td>
            <td>匯出客戶Email文字檔</td>
        </tr>
    </table>
</div>

<table width="100%" height="700" border="1" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC">
    <br />
     <br />
    <tr>
      <td height="30px" colspan="2"  style="margin:0; padding:0;">
      
      <table  width="100%" border="1" >
    	
   	  <tr >
        
        <td bgcolor="#0099FF" align="center"><font color="#FFFFFF">搜尋</font></td>
        <td>
        <div id="Div_Search">

        <asp:Label runat="server" ID="lbl_QCustID" Text="客戶編號" /> &nbsp;
        <asp:TextBox ID="txt_CustId"  Width="60px" runat="server"/>

        <asp:Label runat="server" ID="lbl_QCustName" Text="姓名" /> &nbsp;    
        <asp:TextBox ID="txt_CustName"   Width="60px" runat="server"/>

        <asp:Label runat="server" ID="lbl_QCustTel" Text="電話" />  &nbsp;        
        <asp:TextBox ID="txt_CustTelPhone"   Width="60px" runat="server"/>
	
        
        <asp:Label runat="server" ID="lbl_QCustMobile" Text="手機" /> &nbsp;  
        <asp:TextBox ID="txt_CustMobile"   Width="60px" runat="server"/>
        
        <asp:Label runat="server" ID="lbl_QCustAddr" Text="客戶地址" />  &nbsp; 
        <asp:TextBox ID="txt_CustAddress"   Width="100px" runat="server"/>

         &nbsp;
     
        <asp:Button ID="btn_Search"  class="btn-navbar"  Text="查詢"  runat="server" /></div>        </td>
    
    </table>      
    
    </td>
    </tr>
    <tr>
    	<td  id="TD_Tool" height="15px" colspan="12">
<div id="Top">        
     <div id="Top_LEFT">       
     

<input  type="button" id="btn_AddCust" onclick="MM_openBrWindow('Customer/AddCust.aspx','AddCust','toolbar=yes,location=yes,status=yes,menubar=yes,scrollbars=yes,resizable=yes,width=400,height=300')"   value="新增客戶資料"/>
<input  type="button" id="btn_ShowExportType" onclick="MM_showHideLayers('apDiv1','','show')" value="匯出"/>
<input  type="button" id="btn_PrintCust" onclick="MM_showHideLayers('apDiv8','','show')"   value="列印"/>
     </div>
     
<div id="Top_RIGHT"></div>
</div>        </td>
    </tr>
    <tr>
    
      <td width="23%" height="280" rowspan="3" valign="baseline">
   


<br />

       <div id="lbl_GroupPanel">客戶清單</div>
    
   		 <div id="GroupPanel" title="群組">
         
   
            <table  border="1" cellpadding="0" cellspacing="0" width="100%">
            	
               
               

                
                 
 <ASP:Repeater runat="server" ID="R1" DataSource='<%# DataSet1.DefaultView %>'>
 <HeaderTemplate>
<tr>
<td><asp:HyperLink   ID="System" runat="server"  Target="_self" Text="系統"   /></td>

<td><asp:HyperLink   ID="CustNameSort" runat="server"  Target="_self" Text="姓名" /></td>
<td><asp:HyperLink   ID="CustTelPhoneSort" runat="server"  Target="_self" Text="電話" /></td>
<td><asp:HyperLink   ID="CustMobileSort" runat="server"  Target="_self" Text="手機" /></td>
</tr> 
</HeaderTemplate>
<ItemTemplate>
<tr onMouseOver="this.style.backgroundColor='#FFFF99';" onMouseOut="this.style.backgroundColor='';" >
<td>
<a href="javascript: void(0)" onclick="window.open('Customer/UpdateCust.aspx?CustId=<%#DataSet1.FieldValue("CustId",Container) %>','更新',config='height=400,width=600,resizable=yes,scrollbars=yes,location=yes')">更新</a> 
<a href="javascript: void(0)"  onclick="confirm1('<%#DataSet1.FieldValue("Serial",Container)%>')">刪除</a>
</td>
<td>
<asp:LinkButton runat="server"  ID="linkBtn_CustName" 
OnClick="linkBtn_CustName_Click"  usesubmitbehavior="true"   
ToolTip='<%#DataSet1.FieldValue("CustId",Container)%>'  
OnClientClick="getCustId(this);return false;"><%# DataSet1.FieldValue("CustName", Container) %>
</asp:LinkButton>
</td>
<td>
<asp:Label ID="lbl_CustId"  ToolTip='<%#DataSet1.FieldValue("CustId",Container)%>' runat="server" Text='<%# DataSet1.FieldValue("CustTelPhone", Container) %>'></asp:Label></td>
<td><%# DataSet1.FieldValue("CustMobile", Container) %></td>
</tr>
</ItemTemplate>
</asp:Repeater>
</table>
           <!--  <CC1:COLLECTIONPAGER  id="CollectionPager1"   runat="server" PageSize="10" ResultsLocation="Bottom"  FirstText="第一筆" BackText="上一筆"   LastText="最後一筆" NextText="下一筆"  ControlCssClass="pager" ResultsFormat="顯示 {0}-{1}筆" ResultsStyle="width:100px" PageNumbersSeparator="&amp;nbsp;" >
  </cc1:CollectionPager> -->  
  <br />
  <br />
   	  </div>      </td>
    
       
      
    
    </tr>
	<!--調整右欄上方面板-->
    <tr><td valign="top"  height="400px" style="padding-top:4px;margin:0px;">
    <!--<asp:Button runat="server" ID="btn_IsShow" Text="<"/>-->
    <asp:MultiView ID="MultiView1" runat="server"><!-- right -->
 <asp:View ID="MasterDetailView" runat="server">
 
<table width="100%"  border="1" cellspacing="2" cellpadding="2">
    
    <tr>
      <td>客戶編號</td>
      <td width="20%">姓名</td>
      <td>連絡電話</td>
      <td>個人手機</td>
      	<td>電子郵件</td>
     </tr>
   		
       
    
     <tr>
          <td><asp:TextBox BorderStyle="None" runat="server" ID="lbl_CustId"/></td>
          <td width="20%"><asp:Label  runat="server" ID="lbl_CustName"/></td>
          <td><asp:Label  runat="server" ID="lbl_CustTelPhone"/></td>
          <td><asp:Label  runat="server" ID="lbl_CustMobile"/></td>
          <td><asp:Label  runat="server" ID="lbl_CustEmail"/></td>
        </tr>
   </table>      
   <br />
       <table border="1" width="50%">
 			  <tr>
        	<td width="25%">個人地址</td>
            <td><asp:Label  runat="server" ID="lbl_CustAddress"/></td>
            </tr>
       </table><p>
  		<table border="1" width="50%">

 			  <tr>
        	<td width="25%">備註</td>
            <td><asp:Label  runat="server" ID="lbl_Contect"/></td>
            </tr>
       </table>
  
  
  <br />
  <div id="TabbedPanels1" class="TabbedPanels">
    <ul class="TabbedPanelsTabGroup" >
    	<li runat="server" id="tab1" class="TabbedPanelsTab" tabindex="0" onmouseover="TabbedPanels1.showPanel(this);">鏡框交易紀錄</li>
        <li runat="server" id="tab2" class="TabbedPanelsTab" tabindex="1" onmouseover="TabbedPanels1.showPanel(this);">藥水交易紀錄</li>
        <li runat="server" id="tab3" class="TabbedPanelsTab" tabindex="2" onmouseover="TabbedPanels1.showPanel(this);">客服紀錄</li>
        <li runat="server" id="tab4" class="TabbedPanelsTab" tabindex="3" onmouseover="TabbedPanels1.showPanel(this);">通訊</li>
        <li runat="server" id="tab5" class="TabbedPanelsTab" tabindex="4" onmouseover="TabbedPanels1.showPanel(this);">基本資料</li>
        <li runat="server" id="tab6" class="TabbedPanelsTab" tabindex="5" onmouseover="TabbedPanels1.showPanel(this);">嗜好</li>
        <li runat="server" id="tab7" class="TabbedPanelsTab" tabindex="6" onmouseover="TabbedPanels1.showPanel(this);">興趣</li>
        <li runat="server" id="tab8" class="TabbedPanelsTab" tabindex="7" onmouseover="TabbedPanels1.showPanel(this);">群組</li>
    </ul>
    <div class="TabbedPanelsContentGroup">
    
    <div class="TabbedPanelsContent"><!-- GlassesRecord -->
      <div id="Div_GlassesRecord"></div>
	<div id="Pagination"></div>
     
      </div><!-- GlassesRecord -->
      
      
      <div class="TabbedPanelsContent"><!-- LiquidRecord -->
	
<div id="Div_LiquidRecord"></div>
       
      </div><!-- LiquidRecord -->
      
         <div class="TabbedPanelsContent"><!--CustService-->
         

		 	<div id="DIV_CustService"></div>
	<br/>
<div><input type="button" class="idleField" onclick="MM_showHideLayers('apDiv3','','show')" value="新增"/>
         </div>

         	
         </div><!--CustService-->
      
      <div class="TabbedPanelsContent"> <!-- Comm -->
      	
	<div id="Div_Comm"></div>
<br/>
<div><input type="button" class="idleField" onclick="MM_showHideLayers('apDiv4','','show')" value="新增"/></div>

      </div> <!-- Comm -->
      
      <div class="TabbedPanelsContent"><!--BasicInfo-->
      
         
      
      <table id="tbl_BasicInfo"  width="100%" border="1" cellspacing="0" cellpadding="0">
               
                <tr>
                <td>性別</td>
                <!--<td>身分證</td>-->
                
                <td>年齡</td>
                <td>出生日期</td>
                
                  <td>身高</td>
                
                  <td>體重</td>
               
                  <td>血型</td>
                </tr>
               
                
                <tr>
                	<td><asp:Label  runat="server" ID="lbl_CustGender"/></td>
                	
                     <td><asp:Label ID="lbl_RealAge" runat="server"/></td>
                <td><asp:Label runat="server"  ID="lbl_CustBirth"/></td>
                
                  <td><asp:Label  runat="server" ID="lbl_Height"/></td>
                
                  <td><asp:Label  runat="server" ID="lbl_Weight"/></td>
               
                  <td><asp:Label  runat="server" ID="lbl_BloodType"/></td>
      </tr>
  			</table>
	<br/>
  	
	<table  width="50%" border="1" cellspacing="0" cellpadding="0">
	<tr>
			  <td>星座</td>
                <td>職稱</td>
                
                  <td>月收入</td>
		</tr>
		<tr>
		   <td><asp:Label  runat="server" ID="lbl_Constellation"/></td>
                <td><asp:Label  runat="server" ID="lbl_JobTitle"/></td>
                
                  <td><asp:Label  runat="server" ID="lbl_MonthIncome"/></td>
		</tr>
	</table>
      </div><!--BasicInfo-->
      
             <div class="TabbedPanelsContent"><!--Habit-->
              
         		<table width="100%" border="1">
                	<tr>
                    	<td>嗜好</td>
                    </tr>
                	<tr>
                    <td><asp:Label  runat="server" ID="lbl_Habbit"/></td>
                    </tr>
                </table>
                
                <br />
               

         	</div><!--Habit-->
             <div class="TabbedPanelsContent"><!-- Interest-->
         			<table width="100%" border="1">
                	<tr>
                    	<td>興趣</td>
                    </tr>
                	<tr>
                    <td><asp:Label  runat="server" ID="lbl_Interest"/></td>
                    </tr>
                </table>
         	</div><!--Interest-->
            
            <div class="TabbedPanelsContent"><!-- Grouop-->
         		<table width="100%" border="1">
                	<tr>
                    	<td>群組</td>
                    </tr>
                	<tr>
                    <td><asp:Label  runat="server" ID="lbl_CustGroup"/></td>
                    </tr>
                </table>
                <br />
                <div><input type="button" class="idleField" onclick="MM_showHideLayers('apDiv11','','show')" value="新增群組"/>
         </div>

                
         	</div><!--Group-->
    </div>
  </div>
 </asp:View>
 
   
     		

<asp:View ID="AllCustView" runat="server">
      

<table width="100%" border="1"  cellspacing="0" cellpadding="0">
  
      <tr>
      <td>客戶編號</td>
      <td width="10%">姓名</td>
      <td>連絡電話</td>
      <td>個人手機</td>
      <td>電子郵件</td>
      <td>個人地址</td>
    </tr>
    <asp:Repeater ID="R2" runat="server" DataSource='<%# DataSet1.DefaultView %>'>
    <itemtemplate>
     <tr>
       
          <td ><asp:Label runat="server"  ToolTip='<%#DataSet1.FieldValue("CustId",Container)%>'><%# DataSet1.FieldValue("CustID", Container) %></asp:Label></td>
          <td><%# DataSet1.FieldValue("CustName", Container) %></td>
          <td><%# DataSet1.FieldValue("CustTelPhone", Container) %></td>
          <td><%# DataSet1.FieldValue("CustMobile", Container) %></td>
          <td><a href="mailto:<%#DataSet1.FieldValue("CustEmail",Container)%>"><%# DataSet1.FieldValue("CustEmail", Container) %></a></td>
          <td ><%# DataSet1.FieldValue("CustAddress", Container) %></td>
        </tr>
      </itemtemplate>
    </asp:Repeater>
  </table>
         </asp:view>
     </asp:MultiView></td>
    </tr><tr>
    <!--交易明細-->
      <td  valign="top">
     	
	  <!--	<div id="GlassesDetail">-->
        	<div id="glassesRecentRecord"></div>
       <!-- </div>-->
        
         <!--交易明細-->  
	    <!-- right -->      
   
       </td>
    
   
    </tr>
    
    
    <tr>
      <td height="30" colspan="2">
      	<div style="width:500px; float:left">
      <table border="0">
        <tr>
          <td><MM:If runat="server" Expression='<%# (DataSet1.CurrentPage <> 0) %>'>
              <ContentsTemplate> <a href="#" OnClick="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions('LinkButton1', '', false, '', 'Default.aspx?DataSet1_currentPage=0',false,true))">第一頁</a> </ContentsTemplate>
            </MM:If>          </td>
          <td><MM:If runat="server" Expression='<%# (DataSet1.CurrentPage <> 0) %>'>
              <ContentsTemplate><a href="#" OnClick="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions('LinkButton1', '', false, '', 'Default.aspx?DataSet1_currentPage=<%# Math.Max(DataSet1.CurrentPage - 1, 0)%>', false, true))">前一頁</a>  </ContentsTemplate>
            </MM:If>          </td>
          <td><MM:If runat="server" Expression='<%# (DataSet1.CurrentPage < DataSet1.LastPage) %>'>
<ContentsTemplate>
<a href="#" OnClick="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions('LinkButton1', '', false, '', 'Default.aspx?DataSet1_currentPage=<%# Math.Min(DataSet1.CurrentPage + 1, DataSet1.LastPage)%>', false, true))">下一頁</a> </ContentsTemplate>
            </MM:If>          </td>
          <td><MM:If runat="server" Expression='<%# (DataSet1.CurrentPage < DataSet1.LastPage) %>'>
              <ContentsTemplate> 
<a href="#" OnClick="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions('LinkButton1', '', false, '', 'Default.aspx?DataSet1_currentPage=<%#DataSet1.LastPage %>', false, true))">最後一頁</a> </ContentsTemplate>
            </MM:If>          </td>
          
          <td align="right" colspan="5">&nbsp;&nbsp;<%= IIf((DataSet1.RecordCount = 0), 0, (DataSet1.StartRecord + 1)) %> 到 <%= DataSet1.EndRecord %> 總共 <%= DataSet1.RecordCount %>筆 </td>
        	
	</tr>
      </table></div> <div id="declare" style="float:right;width:350px" class="pager">Copyright &copy; 2011 by <a href="http://www.taglasses.com/web/front/bin/home.phtml">describe Sangua Ltd.</a>.</div></td>
    </tr>
  </table>
  <!--	<div id="apDiv6">
    	<a href="#" onclick="MM_showHideLayers('apDiv6','','hide','apDiv5','','show')">交易明細</a>    </div>-->
 
  <asp:HiddenField  ID="hid_CustId" runat="server" />
  <asp:HiddenField  ID="hid_CurrentTab" runat="server" />
  
	<div id="hid_Gla" style="display:none;"></div>



<script type="text/javascript">
<!--
var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1");
//var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgDown:"../../../../../SpryAssets/SpryMenuBarDownHover.gif", imgRight:"../../../../../SpryAssets/SpryMenuBarRightHover.gif"});
////-->
</script>
</body>

<script type="text/javascript" src="scripts/index.js"></script>
	

</asp:Content>


