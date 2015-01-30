<%@ Control Language="C#" AutoEventWireup="true" CodeFile="wUctlPagebar.ascx.cs" Inherits="UserControls_wUctlPagebar" %>
  
<asp:Panel ID="pnlPage"  runat="server">
        <!-- 頁碼 -->        
        <div class="pager">
            <asp:LinkButton ID="lbPrev" CssClass="prev" runat="server" ToolTip="上一頁" onclick="lbPrev_Click"><asp:Image ID="Image2" ImageUrl="~/images/pagePrev.png" ToolTip="New" runat="server" /></asp:LinkButton>
            <asp:LinkButton ID="lbPrevTens" CssClass="STYLE02" runat="server" ToolTip="上10頁" onclick="lbPage_Click">...</asp:LinkButton>
            <asp:LinkButton ID="lbPage1" runat="server" onclick="lbPage_Click">1</asp:LinkButton>
            <asp:LinkButton ID="lbPage2" runat="server" onclick="lbPage_Click" Visible="false">2</asp:LinkButton>
            <asp:LinkButton ID="lbPage3" runat="server" onclick="lbPage_Click" Visible="false">3</asp:LinkButton>
            <asp:LinkButton ID="lbPage4" runat="server" onclick="lbPage_Click" Visible="false">4</asp:LinkButton>
            <asp:LinkButton ID="lbPage5" runat="server" onclick="lbPage_Click" Visible="false">5</asp:LinkButton>
            <asp:LinkButton ID="lbPage6" runat="server" onclick="lbPage_Click" Visible="false">6</asp:LinkButton>
            <asp:LinkButton ID="lbPage7" runat="server" onclick="lbPage_Click" Visible="false">7</asp:LinkButton>
            <asp:LinkButton ID="lbPage8" runat="server" onclick="lbPage_Click" Visible="false">8</asp:LinkButton>
            <asp:LinkButton ID="lbPage9" runat="server" onclick="lbPage_Click" Visible="false">9</asp:LinkButton>
            <asp:LinkButton ID="lbPage10" runat="server" onclick="lbPage_Click" Visible="false">10</asp:LinkButton>
            <asp:LinkButton ID="lbNextTens" CssClass="STYLE02" runat="server" ToolTip="下10頁" onclick="lbPage_Click">...</asp:LinkButton>
            <asp:LinkButton ID="lbNext" CssClass="next" runat="server" ToolTip="下一頁" onclick="lbNext_Click"><asp:Image ID="Image1" ImageUrl="~/images/pageNext.png" ToolTip="New" runat="server" /></asp:LinkButton>
        </div>
</asp:Panel>

