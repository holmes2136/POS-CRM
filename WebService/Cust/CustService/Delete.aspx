<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="utf-8" %>
<%@ Register TagPrefix="MM" Namespace="DreamweaverCtrls" Assembly="DreamweaverCtrls,version=1.0.0.0,publicKeyToken=836f606ede05d46a,culture=neutral" %>
<%@ Import Namespace="System.Data.OleDB" %>


<script runat="server">
Sub Page_Load(Src As Object, E As EventArgs)



	Dim connStr As String = ConfigurationManager.Appsettings("MM_CONNECTION_STRING_linkC001")
	
	Dim conn As New OleDBConnection
	
	conn.ConnectionString = connStr
	
	Dim cmd As New OleDBCommand
	
	cmd.CommandText = "DELETE  FROM 客服記錄 WHERE Serial = ?"
	
	cmd.Parameters.Add("@Serial",OleDBType.Varchar).Value =  IIf((Request.QueryString("Serial") <> Nothing), Request.QueryString("Serial"),"") 
	
	
	
	
	cmd.Connection = conn
	
	conn.open
	
	'Dim reader As OleDBDataReader = cmd.ExecuteReader

	
Using conn			
	cmd.ExecuteReader
End USING

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

