using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Text.RegularExpressions;
using System.Drawing;

public partial class UserControls_wUctlPagebar : System.Web.UI.UserControl
{

    /// <summary>
    /// Panel css
    /// </summary>
    private string _PanelCss = "LIST_NUMBER02";
    public string PanelCss
    {
        set
        {
            _PanelCss = value;
        }
    }
    /// <summary>
    /// 總頁數
    /// </summary>
    public int PageTotal
    {
        set
        {
            ViewState["PageTotal"] = value;
        }
        get
        {
            return Convert.ToInt32(ViewState["PageTotal"]);
        }
    }
    /// <summary>
    /// 現在頁數
    /// </summary>
    public int PageIndex
    {
        set
        {
            ViewState["PageIndex"] = value;
        }
        get
        {
            return Convert.ToInt32(ViewState["PageIndex"]);
        }
    }

    #region 【Page Events】
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            pnlPage.CssClass = _PanelCss;
        }
    }
    #endregion

    #region 【Events】
    public delegate void PageIndex_ChangedEventHandler(object sender, System.EventArgs e);
    public event PageIndex_ChangedEventHandler PageIndex_Changed;
    #endregion

    protected void lbPrev_Click(object sender, EventArgs e)
    {
        PageIndex--;

        if (PageIndex_Changed != null)
            PageIndex_Changed(sender, e);

        GeneratePagebar();
    }
    protected void lbNext_Click(object sender, EventArgs e)
    {
        PageIndex++;

        if (PageIndex_Changed != null)
            PageIndex_Changed(sender, e);

        GeneratePagebar();
    }
    protected void lbPage_Click(object sender, EventArgs e)
    {
        if (((LinkButton)sender).ID == "lbPrevTens")
            PageIndex = Convert.ToInt32(lbPage1.Text) - 10;
        else if (((LinkButton)sender).ID == "lbNextTens")
            PageIndex = Convert.ToInt32(lbPage1.Text) + 10;
        else
            PageIndex = Convert.ToInt32(((LinkButton)sender).Text);

        if (PageIndex_Changed != null)
            PageIndex_Changed(sender, e);

        GeneratePagebar();
    }
    public void GeneratePagebar()
    {
        if (PageTotal == 0)
            pnlPage.Visible = false;
        else
            pnlPage.Visible = true;

        if (PageIndex == 1)
            lbPrev.Visible = false;
        else
            lbPrev.Visible = true;

        if (PageIndex == PageTotal)
            lbNext.Visible = false;
        else
            lbNext.Visible = true;

        if (PageIndex <= 10)
            lbPrevTens.Visible = false;
        else
            lbPrevTens.Visible = true;

        int intTens = (PageIndex - 1) / 10;
        int intTens_Total = (PageTotal - 1) / 10;
        int intTo = 0;

        if (intTens_Total > intTens)
        {
            lbNextTens.Visible = true;
            intTo = 10;
        }
        else
        {
            lbNextTens.Visible = false;
            intTo = (PageTotal % 10);

            if (intTo == 0)
                intTo = 10;
        }

        for (int i = 1; i <= intTo; i++)
        {
            LinkButton lb = ((LinkButton)this.FindControl("lbPage" + i.ToString()));

            lb.Text = Convert.ToString((intTens * 10) + i);
            lb.CssClass = "";
            lb.Visible = true;

            if (((intTens * 10) + i) == Convert.ToInt32(ViewState["PageIndex"]))
            {
                //lb.ForeColor = Color.Blue;
                lb.Attributes["onclick"] = "return false;";
                lb.CssClass = "current";
            }
            else
            {
                //lb.ForeColor = c;
                lb.Attributes["onclick"] = "return true;";
            }


            //if (i == (PageIndex % 10))
            //    lb.CssClass = "STYLE01";
            //else if ((PageIndex % 10) == 0)
            //    ((LinkButton)this.FindControl("lbPage10")).CssClass = "STYLE01";


        }

        for (int j = 10; j > intTo; j--)
        {
            LinkButton lb = ((LinkButton)this.FindControl("lbPage" + j.ToString()));
            lb.Visible = false;
        }
    }
}
