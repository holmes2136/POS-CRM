<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="utf-8" %>
<%@ Register TagPrefix="MM" Namespace="DreamweaverCtrls" Assembly="DreamweaverCtrls,version=1.0.0.0,publicKeyToken=836f606ede05d46a,culture=neutral" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDB" %>



<MM:DataSet 
id="getTownByCity"
runat="Server"
IsStoredProcedure="false"
ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_STRING_gov") %>'
DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings("MM_CONNECTION_DATABASETYPE_gov") %>'
CommandText='<%# "SELECT MID(town,4,6)As town  FROM Address  WHERE city = ?  GROUP BY town" %>'
Debug="true"
><Parameters>
<Parameter  Name="@city"  Value='<%# IIf((Request.QueryString("city") <> Nothing), Request.QueryString("city"), "台北市") %>'  Type="WChar"   /></Parameters></MM:DataSet>
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
				
				sqlcmd.append("SELECT MID(town,4,6)As town  FROM Address  WHERE city = ?  GROUP BY town" )
				
				
					
				cmd.commandText = sqlcmd.ToString()
				cmd.Parameters.Add("@city",OleDBType.Varchar).Value = IIF(Not Request.QueryString("citye"),request.QueryString("city"),"中正區")	

			Context.Response.ContentType = "text/xml"		
			response.write("<result>")
			response.write("<Area>")

				Dim reader As OleDbDataReader = cmd.ExecuteReader()
					using conn
						while reader.read
							
						response.write("<townname>" & reader.item("town") & "</townname>")
						
						End while
						
					
					end using
			
		
		
						
		response.write("</Area>")
		response.write("</result>")

End Sub
</script>