<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="utf-8" %>
<%@ Import Namespace="System.Data.OleDB" %>


<script runat="server">

Sub Page_Load(Src As Object, E As EventArgs)
	


	Dim connStr As String = ConfigurationManager.Appsettings("MM_CONNECTION_STRING_linkC001")
	
	Dim conn As New OleDBConnection
	
	conn.ConnectionString = connStr
	
	Dim cmd As New OleDBCommand
	
	cmd.Connection = conn

cmd.CommandText = "SELECT * FROM 客服記錄 WHERE Serial = ?"
	
	cmd.Parameters.Add("@Serial",OleDBType.Varchar).Value =  IIf((Request.QueryString("Serial") <> Nothing), Request.QueryString("Serial"),"") 

	
	
	conn.open
	
	Dim reader As OleDBDataReader = cmd.ExecuteReader
	
Context.Response.ContentType = "text/xml"		
response.write("<result>")

Using conn			
IF reader.HasRows THEN	

While reader.read
response.write("<CustInfo>")
			
response.write("<Serial>" &  SetBasicValue(Cstr(reader.Item("Serial")))  &  "</Serial>")			
response.write("<UnderTaker>" &  SetBasicValue(reader.Item("UnderTaker"))  &  "</UnderTaker>")
response.write("<SystemTime>" &  SetBasicValue(reader.Item("SystemTime"))  &  "</SystemTime>")
response.write("<ServiceContent>" &  SetBasicValue(reader.Item("ServiceContent"))  &  "</ServiceContent>")

response.write("</CustInfo>")

End While

ELSE
response.write("<CustInfo>")
			
response.write("<Serial>" &   "NoData"  &  "</Serial>")			
response.write("<UnderTaker>" &   "NoData"  &  "</UnderTaker>")
response.write("<SystemTime>" &   "NoData"  &  "</SystemTime>")
response.write("<ServiceContent>" &   "NoData"  &  "</ServiceContent>")

response.write("</CustInfo>")


END IF	
	response.write("</result>")
End Using
	
	'RESPONSE.Redirect("default.aspx?CustId=" & Request.QueryString("CustId"))

End Sub


Private Function SetBasicValue(Byval Str As object)As String
		Dim returnObj As String = "NoData"
		
		IF ISDBNULL(Str) THEN
				return returnObj
		Else IF String.IsNullOrEmpty(Str)
				return returnObj
		Else
				return Str.Trim
		END IF
End Function
						
					



</script>

