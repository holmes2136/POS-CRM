<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="utf-8" %>
<%@ Register TagPrefix="MM" Namespace="DreamweaverCtrls" Assembly="DreamweaverCtrls,version=1.0.0.0,publicKeyToken=836f606ede05d46a,culture=neutral" %>


<MM:DataSet 
id="getCustBasicInfo"
runat="Server"
IsStoredProcedure="false"
ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_STRING_linkC001") %>'
DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_DATABASETYPE_linkC001") %>'
CommandText='<%# "SELECT Habbit FROM 客戶資料表  WHERE Serial = ?" %>'
Debug="true"
>
  <Parameters>
<Parameter  Name="@CustId"  Value='<%# IIf((Request.QueryString("Serial") <> Nothing), Request.QueryString("Serial"),"") %>'  Type="WChar"   /></Parameters></MM:DataSet>
<MM:PageBind runat="server" PostBackBind="true" />


<script runat="server">
Sub Page_Load(Src As Object, E As EventArgs)


	Context.Response.ContentType = "text/xml"		
			response.write("<result>")
			response.write("<CustInfo>")
			
			
'response.write("<Serial>" &  SetBasicValue(getCustBasicInfo.FieldValue("Serial", Nothing))  &  "</Serial>")
response.write("<Habbit>" &  SetBasicValue(getCustBasicInfo.FieldValue("Habbit", Nothing))  &  "</Habbit>")


				
		
						
					
		
						
		response.write("</CustInfo>")
		response.write("</result>")
		    

End Sub

Private Function SetBasicValue(Byval Str As String)As String
		Dim returnObj As String = "NoData"
		
		IF String.IsNullOrEmpty(Str) THEN
				return returnObj
		Else
				return Str.Trim
		END IF
End Function
</script>

