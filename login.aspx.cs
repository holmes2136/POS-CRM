using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using VO;

public partial class login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        
    }

    protected void btn_SignIn_OnClick(object sender, EventArgs e) {

        

        string account = this.txt_Account.Text.Trim();
        string pwd = this.txt_Pwd.Text.Trim();

        object[] user = VO.User.getUser(account, pwd);

        if (Convert.ToBoolean(user[0])) {
            Session["IsAuthority"] = true;
            Session["User"] = (User)user[1];
            Response.Redirect("index.aspx");
        }
        
        
        
    }
}
