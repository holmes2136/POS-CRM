<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="utf-8" %>
<%@ Register TagPrefix="MM" Namespace="DreamweaverCtrls" Assembly="DreamweaverCtrls,version=1.0.0.0,publicKeyToken=836f606ede05d46a,culture=neutral" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDB" %>



<MM:DataSet 
id="getRoadByTown"
runat="Server"
IsStoredProcedure="false"
ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_STRING_gov") %>'
DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_DATABASETYPE_gov") %>'
CommandText='<%# "SELECT road FROM Address WHERE MID(town,4,6) = ?" %>'
Debug="true"
>
  <Parameters>
    <Parameter  Name="@town"  Value='<%# IIf((Request.QueryString("town") <> Nothing), Request.QueryString("town"), "中正區") %>'  Type="WChar"   />
  </Parameters>
</MM:DataSet>
<MM:PageBind runat="server" PostBackBind="true" />




<script runat="server">
Sub Page_Load(Src As Object, E As EventArgs)
		
			dim conn as New OleDbConnection 
			conn.ConnectionString = ConfigurationManager.Appsettings("MM_CONNECTION_STRING_link4")
			dim cmd as new OleDbCommand
			conn.open
			cmd.connection = conn								
'		
				
				dim sqlcmd as new StringBuilder("")
				
				sqlcmd.append("SELECT road FROM Address WHERE MID(town,4,6) = ?" )
				
				
					
				cmd.commandText = sqlcmd.ToString()
				dim town as String = IIF(Not Request.QueryString("town") Is Nothing,request.QueryString("town"),"")
				
				cmd.Parameters.Add("@town",OleDBType.Varchar).Value = town

			Context.Response.ContentType = "text/xml"		
			response.write("<result>")
			response.write("<Road>")

				Dim reader As OleDbDataReader = cmd.ExecuteReader()
					using conn
						while reader.read
							
						response.write("<roadname>" & reader.item("road") & "</roadname>")
						
						End while
						
					
					end using
			
		
		
						
		response.write("</Road>")
		response.write("</result>")

End Sub
</script>