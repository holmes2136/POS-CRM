<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Group.ascx.vb" Inherits="Group" %>

<table >
	<asp:Repeater runat="server" ID="R1">
    	
    <ItemTemplate>
     <tr>
       
          <td ><a  target="Content"  href="Customer/SearchCust/default.aspx?q=group&group=<%# DataBinder.Eval(Container.DataItem, "群組") %>" ><%# DataBinder.Eval(Container.DataItem, "群組") %>&nbsp;(<%# DataBinder.Eval(Container.DataItem, "Counts") %>)</a></td>
      
          
   
        </tr>
      </ItemTemplate>
    </asp:Repeater>
</table>
