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
/// Comm 的摘要描述
/// </summary>
[Serializable]
public class Comm
{

    public int Serial;
    public string _Content;

    public string Content {
        get {
            if (string.IsNullOrEmpty(_Content))
                return "NoData";
            else
                return this._Content; 
        }
        set { this._Content = value; }
    }

	public Comm(){}


    public static Comm CommInfo(string CustId){

        return DataAccessLayer.DataAccessHelper.getDataAccess().CommInfo(CustId);

    }


}
