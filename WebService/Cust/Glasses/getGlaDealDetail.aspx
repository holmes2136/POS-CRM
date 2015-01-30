<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="utf-8" %>
<%@ Register TagPrefix="MM" Namespace="DreamweaverCtrls" Assembly="DreamweaverCtrls,version=1.0.0.0,publicKeyToken=836f606ede05d46a,culture=neutral" %>
<%@ Import Namespace="System.Data.OleDB" %>




<script runat="server">
Sub Page_Load(Src As Object, E As EventArgs)

	Dim connStr As String = ConfigurationManager.Appsettings("MM_CONNECTION_STRING_linkC001")
	
	Dim conn As New OleDBConnection
	
	conn.ConnectionString = connStr
	
	Dim cmd As New OleDBCommand
	
	cmd.CommandText = "select * From 日報表1 Where Serial = ?  "
	
	cmd.Parameters.Add("@Serial",OleDBType.Varchar).Value =  IIf((Request.QueryString("Serial") <> Nothing), Request.QueryString("Serial"),Session("FirstCustId")) 
	
	cmd.Connection = conn
	
	conn.open
	
	
	Dim reader As OleDBDataReader = cmd.ExecuteReader
		
	Context.Response.ContentType = "text/xml"		
			response.write("<result>")

Using conn
IF reader.HasRows THEN


While reader.read
response.write("<CustInfo>")
response.write("<Serial>" &  SetBasicValue(Cstr(reader.Item("Serial")))  &  "</Serial>")		
response.write("<BillNumber>" &  SetBasicValue(reader.Item("BillNumber"))  &  "</BillNumber>")
response.write("<ProductName>" &  SetBasicValue(reader.Item("Barcode"))  &  "</ProductName>")

response.write("<RightDegrees>" &  SetBasicValue(reader.Item("RightDegrees"))  &  "</RightDegrees>")
response.write("<LeftDegrees>" &  SetBasicValue(reader.Item("LeftDegrees"))  &  "</LeftDegrees>")
response.write("<PinClass>" &  SetBasicValue(reader.Item("PinClass"))  &  "</PinClass>")

response.write("<PinManufacturerR>" &  SetBasicValue(reader.Item("PinManufacturerR"))  &  "</PinManufacturerR>")

response.write("<FarOrNear>" &  SetBasicValue(reader.Item("FarOrNear"))  &  "</FarOrNear>")
response.write("<SalesMan>" &  SetBasicValue(reader.Item("SalesMan"))  &  "</SalesMan>")
response.write("<PublishDay>" &  SetBasicValue(reader.Item("PublishDay"))  &  "</PublishDay>")
response.write("<SellPrice>" &  SetBasicValue(Cstr(reader.Item("SellPrice")))  &  "</SellPrice>")
response.write("<Balance>" &  SetBasicValue(Cstr(reader.Item("Balance")))  &  "</Balance>")

'response.write("<SystemTime>" &  SetBasicValue(reader.Item("PublishDay"))  &  "</SystemTime>")
response.write("<Contect>" &  SetBasicValue(reader.Item("Contect"))  &  "</Contect>")
response.write("</CustInfo>")


End While

	
Else
		
response.write("<CustInfo>")
response.write("<Serial>" & "NoData" &  "</Serial>")
response.write("<BillNumber>" &  "NoData"  &  "</BillNumber>")
response.write("<ProductName>" &  "NoData" &  "</ProductName>")

response.write("<RightDegrees>" &  "NoData" &  "</RightDegrees>")
response.write("<LeftDegrees>" &  "NoData" &  "</LeftDegrees>")		
response.write("<PinClass>" &  "NoData"  &  "</PinClass>")

response.write("<PinManufacturerR>" &  "NoData"  &  "</PinManufacturerR>")

response.write("<FarOrNear>" &  "NoData"  &  "</FarOrNear>")
response.write("<SalesMan>" &  "NoData"  &  "</SalesMan>")
response.write("<PublishDay>" &  "NoData"  &  "</PublishDay>")
response.write("<SellPrice>" & "NoData" &  "</SellPrice>")
response.write("<Balance>" & "NoData" &  "</Balance>")

'response.write("<SystemTime>" & "NoData" &  "</SystemTime>")
response.write("<Contect>" &  "NoData"  &  "</Contect>")
response.write("</CustInfo>")
END IF					
					
		
						
		
		response.write("</result>")
	End Using    

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

Protected Sub Page_Error(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Error
        
        Dim exc As Exception = Server.GetLastError

       
        Response.Write("<h2>getCustGlassesRecord Page Error</h2>")
       
      
        Server.Transfer("~/site/AppraiseBillPlatfom/Error.aspx", True)


     

     

    End Sub
</script>

