<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="utf-8" %>
<%@ Register TagPrefix="MM" Namespace="DreamweaverCtrls" Assembly="DreamweaverCtrls,version=1.0.0.0,publicKeyToken=836f606ede05d46a,culture=neutral" %>


<MM:DataSet 
id="getCustInfoByCustId"
runat="Server"
IsStoredProcedure="false"
ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_STRING_linkC001") %>'
DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_DATABASETYPE_linkC001") %>'
CommandText='<%# "SELECT *  FROM Customer  WHERE CustId = ?" %>'
Debug="true"
>
  <Parameters>
    <Parameter  Name="@CustId"  Value='<%# IIf((Request.QueryString("CustId") <> Nothing), Request.QueryString("CustId"), "") %>'  Type="WChar"   />  
  </Parameters>
</MM:DataSet>
<MM:PageBind runat="server" PostBackBind="true" />


<MM:DataSet 
id="getNewestCustInfo"
runat="Server"
IsStoredProcedure="false"
ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_STRING_linkC001") %>'
DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_DATABASETYPE_linkC001") %>'
CommandText='<%# "SELECT Top 1 FarOrNear, LeftDegrees, RightDegrees FROM 日報表1 WHERE CustId = ? ORDER BY PublishDay DESC" %>'
Debug="true" PageSize="10" CurrentPage='<%# IIf((Request.QueryString("getNewestCustInfo_CurrentPage") <> Nothing), Request.QueryString("getNewestCustInfo_CurrentPage"), 0)  %>'
>
  <Parameters>
    <Parameter  Name="@CustId"  Value='<%# IIf((Request.QueryString("CustId") <> Nothing), Request.QueryString("CustId"), "") %>'  Type="WChar"   />  
  </Parameters>
</MM:DataSet>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>列印</title>

<style type="text/css">

body,td,th{
	font-family:Arial, Helvetica, sans-serif;
	font-size:83%
}img{border:0}a:link{color:#00c}#blockedReason{margin:1em 30px;padding:1em;border:1px solid #333333;background-color:#ffffcc;color:#cc0000;font-size:100%}.PubNote{width:70%;margin:0px 0px 15px 30px;padding:5px 0px 0px 0px;border-top:1px solid #ccc;border-right:2px solid #bbb;border-bottom:2px solid #888;border-left:1px solid #bbb}.PubNoteAttributes{margin:0px 10px 5px 10px}.Labels{margin:10px 10px 5px 10px;color:#006633}.LabelHeader{color:#666666}.AttributeTitle{font-weight:bold;font-size:105%}.PubNoteContentArea{margin:5px 10px 5px 10px}.gn_bq{margin:2px 0;border-left:1px dotted #ccc;padding:0 5px}.gn_c{background-color:#e7eef2;padding:5px 10px 5px 15px;margin:5px -10px -5px -10px;border-top:1px solid #ccc;color:#444;font-size:90%}.PubSectionHeader{color:#ffffff;font-weight:bold;background-color:#7799bb;padding:2px 10px}#pubHeader{margin-bottom:20px}#pubHeaderMain{font-weight:bold;margin-bottom:10px}#pubHeaderSub{margin-bottom:10px;line-height:1.4em;color:#333}#notebookList{margin:0px 0px 10px 40px;line-height:1.4em}#SectionListHeader{font-weight:bold;margin-bottom:10px;background-color:#ddd;color:#000;padding:2px 10px}#disclaimer{margin:20px auto 30px 30px;color:#666}#pubContent{margin:20px auto 20px 30px;width:800px}#sectionList{line-height:1.2em;border-bottom:1px solid #ccc;padding-bottom:10px;margin-bottom:10px;border:1px solid #ddd}#sectionList ul{margin:0;padding:0;list-style:none}#sectionList li{margin:0px 10px 0px 20px!important;padding:0;font-size:100%!important;list-style:none;text-indent:-10px}.bubble{background-color:#c3d9ff}

table {
	width: 100%;
	color: #212424;
	margin: 0 0 0 0;	
	font: 120%/200% "Lucida Grande", "Lucida Sans Unicode", "Lucida Sans", Lucida, Helvetica, sans-serif;
}
table, tr, th, td {
	margin: 0;
	padding: 0;
	border-spacing: 0;
	border-collapse: collapse;
}


/* HEADER */

thead {
	background: #524123;
}
thead tr th {
	padding: 1em 0;
	text-align: center;
	color: #FAF7D4;
	border-bottom: 3px solid #A5D768;
}


tbody tr th:hover {
	background: #D0EBA6;
}

.myFileSet {
	    
	height: 200px;
	width: 600px;
}

</style>


<script runat="server">
Sub Page_Load(Src As Object, E As EventArgs)
		
		
		
	
		
		
End Sub
</script>

</head>
<body >

 <table>
        	<tr>
            <td  class="bubble" colspan="4"  style="padding: 3px 0pt; font-family: arial; text-align: left; font-weight: bold; font-size: 100%;">客戶資料
             </td>
            </tr>
 </table>
 
	<div class="PubNote"> 
   <div  runat="server" class="PubNoteContentArea">
   
       <table>
<tr>
            	<td width="20%">姓名</td>
       	<td width="80%"><%#getCustInfoByCustId.FieldValue("CustName",Nothing)%></td>
       	 </tr>
            <tr>
            	<td>連絡電話</td>
            	<td><%#getCustInfoByCustId.FieldValue("CustTelPhone",Nothing)%></td>
          	</tr>
            <tr>
            	<td>個人手機</td>
            	<td><%#getCustInfoByCustId.FieldValue("CustMobile",Nothing)%></td>
          	</tr>
            <tr>
            	   <td>電子郵件</td>
            	<td><%#getCustInfoByCustId.FieldValue("CustEmail",Nothing)%></td>
          	</tr>
            <tr>
            	 <td>個人地址</td>
            	<td><%#getCustInfoByCustId.FieldValue("CustAddress",Nothing)%></td>
          	</tr>
            
            <tr>
            	<td width="20%">遠近</td>
       	<td width="80%"><%# getNewestCustInfo.FieldValue("FarOrNear", Container) %></td>
       	 </tr>
            <tr>
            	<td>鏡片度數</td>
            	<td>左眼度數:<%# getNewestCustInfo.FieldValue("LeftDegrees", Container) %>&nbsp;, &nbsp;
                	右眼度數:<%# getNewestCustInfo.FieldValue("RightDegrees", Container) %>
                </td>
          	</tr>
            <tr>
            	<td>散光</td>
            	<td></td>
          	</tr>
            <tr>
            	   <td>角度</td>
            	<td></td>
          	</tr>
            <tr>
            	 <td>視力</td>
            	<td></td>
          	</tr>
        </table>	
   
    </div>
    </div>



    
    
    
   
    
    
  
   

</body>
</html>
