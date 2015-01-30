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
using System.Data.OleDb;
using VO;


public partial class index : System.Web.UI.Page
{
    //public const int MasterDetailState  = 1;

    public int _pageSize = 20;
    public int PageIndex = 1;


    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["IsAuthority"] == "") {
            Response.Redirect("login.aspx");
        }
        
        InitEnviroment();

        if(!IsPostBack){

            GetData(PageIndex);
        
        }
	
        //以搜尋鈕為一開始的焦點
        SetFocus(btn_Search);

    }

    private void InitEnviroment() { 
     
        Page.MaintainScrollPositionOnPostBack = true;

        lbl_QCustID.Text = Resources.zh_tw.CustID;
        lbl_QCustName.Text = Resources.zh_tw.CustName;
        lbl_QCustTel.Text = Resources.zh_tw.CustTel;
        lbl_QCustMobile.Text = Resources.zh_tw.CustMobile;
        lbl_QCustAddr.Text = Resources.zh_tw.CustAddr;

    }

    private void GetData(int pageindex) {

        string cust_id = this.txt_CustId.Text.Trim();
        string cust_name = this.txt_CustName.Text.Trim();
        string cust_mobile = this.txt_CustMobile.Text.Trim();
        string cust_addr = this.txt_CustAddress.Text.Trim();
        string cust_tel = this.txt_CustTelPhone.Text.Trim();
      

        DataTable dt = Customer.CustList(pageindex,this._pageSize,cust_id,cust_name,cust_tel,cust_mobile,cust_addr);

        int intRowStart = (pageindex * this._pageSize) - this._pageSize;
        int intRowEnd = (pageindex * this._pageSize) + 1;
        //DataRow[] row = dt.Select(string.Format("RowSort > {0} and RowSort < {1}", intRowStart, intRowEnd));
        //DataTable dt2 = dt.Clone();

        //foreach (DataRow dr in row)
        //{
        //    dt2.ImportRow(dr);
        //}

        this.R1.DataSource = dt;
        this.R1.DataBind();

        wUctlPagebar1.PageTotal = GetPageTotal(dt);
        wUctlPagebar1.GeneratePagebar();


        if(dt.Rows.Count > 0){

            Session["FirstCustId"] =dt.Rows[0]["CustId"].ToString();
    
            string script  = "window.onload=function(){init('" + Session["FirstCustId"] + "');}";

            ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "alert", script, true);

        }

    }

    private void GetDetail(DataTable dt) {

        //DataTable dt2 = dt.Clone();
        //DataRow dr = dt.Rows[0];
        //dt2.ImportRow(dr);

        //this.R2.DataSource = dt2;
        //this.R2.DataBind();
    }


    protected void R1_ItemDataBound(object sender, RepeaterItemEventArgs e) {

        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRowView drv = (DataRowView)e.Item.DataItem;
            string Cust_Id = drv["CustID"].ToString();
            string Cust_Name = drv["CustName"].ToString();
            string CustTelPhone = drv["CustTelPhone"].ToString();
            string CustMobile = drv["CustMobile"].ToString();

            HyperLink update = ((HyperLink)e.Item.FindControl("hy_Update"));
            HyperLink delete = ((HyperLink)e.Item.FindControl("hy_Delete"));
            LinkButton lnk_custName = ((LinkButton)e.Item.FindControl("linkBtn_CustName"));
            Label lbl_CustId = ((Label)e.Item.FindControl("lbl_CustId"));
            Label lbl_CustMobile = ((Label)e.Item.FindControl("lbl_CustMobile"));

            //update.ImageUrl = "javascript:void(0)";
            update.Text = "更新";
            update.Attributes.Add("onclick", 
                                string.Format("window.open('Customer/UpdateCust.aspx?CustId={0}",Cust_Id));

            //delete.ImageUrl = "javascript:void(0)";
            delete.Text = "刪除";
            delete.Attributes.Add("onclick",
                                string.Format("confirm1('{0}')", Cust_Id));

            lnk_custName.ToolTip = Cust_Id;
            lnk_custName.Text =  Cust_Name;

            lbl_CustId.ToolTip = Cust_Id;
            lbl_CustId.Text = CustTelPhone;

            lbl_CustMobile.Text = CustMobile;

        }
    }

    protected void R2_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {

        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRowView drv = (DataRowView)e.Item.DataItem;
            string Cust_Id = drv["CustID"].ToString();
            string Cust_Name = drv["CustName"].ToString();
            string CustTelPhone = drv["CustTelPhone"].ToString();
            string CustMobile = drv["CustMobile"].ToString();
            string CustEmail = drv["CustEmail"].ToString();
            string CustAddr = drv["CustAddress"].ToString();

            Label custinfo_custid = ((Label)e.Item.FindControl("Label1"));
            custinfo_custid.ToolTip = Cust_Id;
            custinfo_custid.Text = Cust_Id;
            //ctl00_ContentPlaceHolder1_R1_ctl01_lbl_CustId
            Label custinfo_custname = ((Label)e.Item.FindControl("lbl_CustInfo_CustName"));
            custinfo_custname.Text = Cust_Name;

            Label custinfo_custtelphone = ((Label)e.Item.FindControl("lbl_CustInfo_CustTelPhone"));
            custinfo_custtelphone.Text = CustTelPhone;


            Label custinfo_custmobile = ((Label)e.Item.FindControl("lbl_CustInfo_CustMobile"));
            custinfo_custmobile.Text = CustMobile;

            HyperLink custinfo_custemail = ((HyperLink)e.Item.FindControl("hy_CustInfo_CustEmail"));
            custinfo_custemail.NavigateUrl = string.Format("mailto:{0}", CustEmail);


            Label custinfo_custaddr = ((Label)e.Item.FindControl("lbl_CustInfo_CustAddr"));
            custinfo_custaddr.Text = CustAddr;
 

        }
    }


    protected void pbPage_PageIndex_Changed(object sender, EventArgs e)
    {
        Response.Write(wUctlPagebar1.PageIndex);
        this.GetData(wUctlPagebar1.PageIndex);
    }


    private int GetPageTotal(DataTable dt)
    {
        int RowCount = dt.Rows.Count;

        wUctlPagebar1.Visible = true;

        if (RowCount == 0)
        {
            wUctlPagebar1.Visible = false;
            return 0;
        }
        else if (RowCount < this._pageSize)
        {
            wUctlPagebar1.Visible = false;
            return 1;
        }
        else
            return Convert.ToInt32(Math.Ceiling(Convert.ToDouble(RowCount) / Convert.ToDouble(this._pageSize)));

    }


}
