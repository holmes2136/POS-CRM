<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="utf-8" %>
<%@ Register TagPrefix="MM" Namespace="DreamweaverCtrls" Assembly="DreamweaverCtrls,version=1.0.0.0,publicKeyToken=836f606ede05d46a,culture=neutral" %>
<%@ Import Namespace="System.Data.OleDB" %>



<script runat="server">
Sub Page_Load(Src As Object, E As EventArgs)

	Dim connStr As String = ConfigurationManager.Appsettings("MM_CONNECTION_STRING_linkC001")
	
	Dim conn As New OleDBConnection
	
	conn.ConnectionString = connStr
	
	Dim cmd As New OleDBCommand
	
	cmd.CommandText = "SELECT * FROM 客戶通訊資料庫 WHERE Serial = ?"
	
	cmd.Parameters.Add("@Serial",OleDBType.Varchar).Value =  IIf((Request.QueryString("Serial") <> Nothing), Request.QueryString("Serial"), "") 
	
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
		
response.write("<Content>" &  SetBasicValue(reader.Item("Content"))  &  "</Content>")
		


response.write("</CustInfo>")

End While


ELSE
response.write("<CustInfo>")
			
	response.write("<Serial>" & "NoData"  &  "</Serial>")
		
response.write("<Content>" &  "NoData"  &  "</Content>")
		


response.write("</CustInfo>")
END IF
response.write("</result>")
				
End Using		
						
					
		
						
		
		    

End Sub


Protected Sub Page_Error(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Error
        
        Dim exc As Exception = Server.GetLastError

       
        Response.Write("<h2>getCustComm Page Error</h2>")
       
      
        Server.Transfer("~/site/AppraiseBillPlatfom/Error.aspx", True)


     

     

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

