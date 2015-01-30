<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="utf-8" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDB" %>





<script runat="server">
Sub Page_Load(Src As Object, E As EventArgs)
		
				
					
			Dim connStr As String = ConfigurationManager.Appsettings("MM_CONNECTION_STRING_linkC001")
		
		
			dim conn as New OleDbConnection
			conn.connectionstring = connStr
			dim cmd as new OleDbCommand
			conn.open
			cmd.connection = conn								
'		
				
				dim sqlcmd as new StringBuilder("")
				
				sqlcmd.append(" Select  GroupName From 客戶類別資料庫 Order By SystemTime Desc" )
				
				
					
					
				cmd.commandText = sqlcmd.ToString()
			
			Context.Response.ContentType = "text/xml"		
			response.write("<result>")
			

				Dim reader As OleDbDataReader = cmd.ExecuteReader()
					using conn
						while reader.read
							
						response.write("<name>" & reader.item("GroupName") & "</name>")
						
						End while
						
					
					end using
			
		
		
						
	
		
		response.write("</result>")

End Sub
</script>




