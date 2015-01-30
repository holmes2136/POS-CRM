imports System.Data
imports System.Data.OleDB

Partial Class Group
    Inherits System.Web.UI.UserControl


 


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


		Dim dt As DataTable = GetData()
		'Response.write(dt.rows.count)
     	R1.DataSource = dt.DefaultView
   		R1.DataBind()
	 


    End Sub
	
	
	Private Function GetData()As DataTable
		
		Dim connStr As String = ConfigurationManager.AppSettings("MM_CONNECTION_STRING_linkC001")
		
		Dim dt As DataTable
		Dim conn As New OleDBConnection
		conn.connectionString = connStr
		
	
		Dim cmd As New OleDBCommand
		
		cmd.CommandText = "SELECT  �s��,Count(CustId)As Counts,�ѧO�X FROM (���O�s�� a LEFT JOIN Customer b On  a.�s�� = b.CustGroup) GROUP BY �s��,�ѧO�X "
		
		cmd.Connection = conn
		conn.open
		
		USING conn
			dt = New DataTable
			dt.Load(cmd.ExecuteReader) 
		END USING
		
		RETURN dt
	
	
	End Function

    
End Class