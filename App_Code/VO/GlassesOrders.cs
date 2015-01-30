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
/// GlassesOrders 的摘要描述
/// </summary>
public class GlassesOrders
{

    private int _Serial2;
    private int _Serial;
    private string _BillNumber;
    private string _SalesMan;
    private string _ProductName;
    private string _SellPrice;
    private string _Balance;
    private string _SystemTime;
    private string _RightDegrees;
    private string _LeftDegrees;
    private string _PinClass;
    private string _PinManufacturerR;
    private string _FarOrNear;
    private string _PublishDay;
    private string _Contect; 

    public string BillNumber {

        get {
            if (string.IsNullOrEmpty(_BillNumber))
                return "NoData";
            else
                return this._BillNumber;
        }

        set { this._BillNumber = value; }
    }

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

    public string SellPrice
    {

        get
        {
            if (string.IsNullOrEmpty(_SellPrice))
                return "NoData";
            else
                return this._SellPrice;
        }

        set { this._SellPrice = value; }
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

    public string RightDegrees
    {

        get
        {
            if (string.IsNullOrEmpty(_RightDegrees))
                return "NoData";
            else
                return this._RightDegrees;
        }

        set { this._RightDegrees = value; }
    }

    public string LeftDegrees
    {

        get
        {
            if (string.IsNullOrEmpty(_LeftDegrees))
                return "NoData";
            else
                return this._LeftDegrees;
        }

        set { this._LeftDegrees = value; }
    }

    public string PinClass
    {

        get
        {
            if (string.IsNullOrEmpty(_PinClass))
                return "NoData";
            else
                return this._PinClass;
        }

        set { this._PinClass = value; }
    }

    public string PinManufacturerR
    {

        get
        {
            if (string.IsNullOrEmpty(_PinManufacturerR))
                return "NoData";
            else
                return this._PinManufacturerR;
        }

        set { this._PinManufacturerR = value; }
    }

    public string PublishDay
    {

        get
        {
            if (string.IsNullOrEmpty(_PublishDay))
                return "NoData";
            else
                return this._PublishDay;
        }

        set { this._PublishDay = value; }
    }

    public string Contect
    {

        get
        {
            if (string.IsNullOrEmpty(_Contect))
                return "NoData";
            else
                return this._Contect;
        }

        set { this._Contect = value; }
    }

    public string FarOrNear
    {

        get
        {
            if (string.IsNullOrEmpty(_FarOrNear))
                return "NoData";
            else
                return this._FarOrNear;
        }

        set { this._FarOrNear = value; }
    }


	public GlassesOrders()
	{
		
	}


    public static DataTable getGlassesOrders(string CustId) {

        return DataAccessLayer.DataAccessHelper.getDataAccess().getGlassesOrders(CustId);

    }

    public static GlassesOrders getLatestGlassesOrders(string CustId)
    {

        return DataAccessLayer.DataAccessHelper.getDataAccess().getLatestGlassesOrders(CustId);

    }
}
