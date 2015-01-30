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
/// CallCenter 的摘要描述
/// </summary>
public class CallCenter
{
    private int _Serial;
    private string _UnderTaker;
    private string _SystemTime;
    private string _ServiceContent;

    public int Serial
    {
        get
        {
            return this._Serial;
        }
        set { this._Serial = value; }
    }

    public string UnderTaker
    {
        get
        {
            if (string.IsNullOrEmpty(_UnderTaker))
                return "NoData";
            else
                return this._UnderTaker;
        }
        set { this._UnderTaker = value; }
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

    public string ServiceContent
    {
        get
        {
            if (string.IsNullOrEmpty(_ServiceContent))
                return "NoData";
            else
                return this._ServiceContent;
        }
        set { this._ServiceContent = value; }
    }



	public CallCenter()
	{
		
	}

    public static CallCenter getCallCenter(string CustId)
    {

        return DataAccessLayer.DataAccessHelper.getDataAccess().getCallCenter(CustId);

    }

}
