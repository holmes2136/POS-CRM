using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

/// <summary>
/// LiquidOrders 的摘要描述
/// </summary>
public class LiquidOrders
{
    private int Serial ;
    private string _SalesMan;
    private string _ProductName;
    private string _Price;
    private string _Balance;
    private string _SystemTime;


    public string SalesMan
    {

        get
        {
            if (string.IsNullOrEmpty(_SalesMan))
                return "NoData";
            else
                return this._SalesMan;
        }

        set { this._SalesMan = value; }
    }

    public string ProductName
    {

        get
        {
            if (string.IsNullOrEmpty(_ProductName))
                return "NoData";
            else
                return this._ProductName;
        }

        set { this._ProductName = value; }
    }

    public string Price
    {

        get
        {
            if (string.IsNullOrEmpty(_Price))
                return "NoData";
            else
                return this._Price;
        }

        set { this._Price = value; }
    }

    public string Balance
    {

        get
        {
            if (string.IsNullOrEmpty(_Balance))
                return "NoData";
            else
                return this._Balance;
        }

        set { this._Balance = value; }
    }

    public string SystemTime
    {

        get
        {
            if (string.IsNullOrEmpty(_SystemTime))
                return "NoData";
            else
                return this._SystemTime;
        }

        set { this._SystemTime = value; }
    }


	public LiquidOrders()
	{
		
	}

    public static DataTable getLiquidOrders(string CustId)
    {

        return DataAccessLayer.DataAccessHelper.getDataAccess().getLiquidOrders(CustId);

    }


}
